import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../data/datasources/quran_remote_datasource.dart';
import '../data/datasources/telawa_remote_datasource.dart';
import '../data/models/telawa_reciter_model.dart';
import '../data/repositories/quran_repository_impl.dart';
import '../domain/entities/ayah.dart';
import '../domain/entities/qari.dart';
import '../domain/entities/surah.dart';
import '../domain/repositories/quran_repository.dart';

final _dioProvider = Provider<Dio>((ref) => DioClient.create());

final quranRepoProvider = Provider<QuranRepository>((ref) {
  return QuranRepositoryImpl(QuranRemoteDataSourceImpl(ref.watch(_dioProvider)));
});

final reciterProvider = StateProvider<String>((ref) => ApiEndpoints.defaultReciter);

final surahListProvider = FutureProvider.autoDispose<List<Surah>>((ref) async {
  return ref.watch(quranRepoProvider).getSurahList();
});

final surahAyahsProvider = FutureProvider.autoDispose
    .family<List<Ayah>, int>((ref, surahNumber) async {
  final qari = ref.watch(selectedQariProvider);
  return ref.watch(quranRepoProvider).getSurahAyahs(surahNumber, qari.id);
});

/// Telawa API datasource provider
final telawaDatasourceProvider = Provider<TelawaRemoteDatasource>((ref) {
  return TelawaRemoteDatasource();
});

/// Combined provider: Fetches surah from Telawa (Arabic text) + translations
/// Returns Ayah entities compatible with the existing UI
final telawaSurahAyahsProvider = FutureProvider.autoDispose
    .family<List<Ayah>, int>((ref, surahNumber) async {
  final datasource = ref.watch(telawaDatasourceProvider);
  final qari = ref.watch(selectedQariProvider);

  // Fetch surah detail (Arabic ayahs) and translations in parallel
  final surahDetail = await datasource.getSurahDetail(surahNumber);
  final translations = await datasource.getTranslations(surahNumber);

  // Build translation map: ayahId -> English text
  final translationMap = <int, String>{};
  for (final t in translations) {
    if (t.language == 'en') {
      translationMap[t.ayahId] = t.text;
    }
  }

  // Convert to Ayah entities
  final ayahs = <Ayah>[];
  if (surahDetail.ayahs != null) {
    for (final ayah in surahDetail.ayahs!) {
      // Generate audio URL using the selected Qari
      final audioUrl = qari.getAudioUrl(surahNumber, ayah.ayahNumber);
      ayahs.add(Ayah(
        number: ayah.id,
        numberInSurah: ayah.ayahNumber,
        text: ayah.textAr,
        translation: translationMap[ayah.id],
        audioUrl: audioUrl,
      ));
    }
  }

  return ayahs;
});

/// Telawa surahs list provider (for surah list screen)
final telawaSurahsListProvider = FutureProvider.autoDispose<List<Surah>>((ref) async {
  final datasource = ref.watch(telawaDatasourceProvider);
  final telawaSurahs = await datasource.getSurahs();

  // Convert TelawaSurah to Surah entities
  return telawaSurahs
      .map((s) => Surah(
            number: s.id,
            name: s.nameAr,
            englishName: s.nameEn,
            englishNameTranslation: s.englishTranslation,
            numberOfAyahs: s.ayahCount,
            revelationType: s.revelationType == 'Meccan' ? 'মেக்கান' : 'মদিনান',
          ))
      .toList();
});

/// Telawa reciters provider
final telawaRecitersProvider = FutureProvider<List<TelawaReciterModel>>((ref) async {
  final datasource = ref.watch(telawaDatasourceProvider);
  return datasource.getReciters();
});

/// Random ayah from Telawa
final telawaRandomAyahProvider = FutureProvider<Ayah>((ref) async {
  final datasource = ref.watch(telawaDatasourceProvider);
  final ayah = await datasource.getRandomAyah();
  return Ayah(
    number: ayah.id,
    numberInSurah: ayah.ayahNumber,
    text: ayah.textAr,
  );
});

// --- Audio Player State ---

class AudioPlayerState {
  final bool isPlaying;
  final int currentAyahIndex;
  final double progress;
  final String currentSurahName;

  const AudioPlayerState({
    this.isPlaying = false,
    this.currentAyahIndex = 0,
    this.progress = 0.0,
    this.currentSurahName = '',
  });

  AudioPlayerState copyWith({
    bool? isPlaying,
    int? currentAyahIndex,
    double? progress,
    String? currentSurahName,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentAyahIndex: currentAyahIndex ?? this.currentAyahIndex,
      progress: progress ?? this.progress,
      currentSurahName: currentSurahName ?? this.currentSurahName,
    );
  }
}

class AudioPlayerNotifier extends StateNotifier<AudioPlayerState> {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayerNotifier() : super(const AudioPlayerState()) {
    _player.positionStream.listen((position) {
      if (_player.duration != null && _player.duration!.inMilliseconds > 0) {
        state = state.copyWith(
          progress: position.inMilliseconds / _player.duration!.inMilliseconds,
        );
      }
    });
    _player.playerStateStream.listen((playerState) {
      state = state.copyWith(isPlaying: playerState.playing);
    });
  }

  Future<void> playAyah(String url, {String? surahName}) async {
    try {
      await _player.setUrl(url);
      await _player.play();
      state = state.copyWith(
        isPlaying: true,
        currentAyahIndex: state.currentAyahIndex + 1,
        currentSurahName: surahName ?? state.currentSurahName,
      );
    } catch (e) {
      // Ignore audio errors gracefully
    }
  }

  void togglePlay() {
    if (state.isPlaying) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  void stop() {
    _player.stop();
    state = const AudioPlayerState();
  }

  void setProgress(double value) {
    if (_player.duration != null) {
      _player.seek(Duration(milliseconds: (value * _player.duration!.inMilliseconds).round()));
    }
  }

  void nextAyah() {
    state = state.copyWith(currentAyahIndex: state.currentAyahIndex + 1);
  }

  void previousAyah() {
    state = state.copyWith(currentAyahIndex: (state.currentAyahIndex - 1).clamp(0, 999));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}

final audioPlayerProvider = StateNotifierProvider<AudioPlayerNotifier, AudioPlayerState>((ref) {
  return AudioPlayerNotifier();
});

final selectedQariProvider = StateProvider<Qari>((ref) => defaultQari);