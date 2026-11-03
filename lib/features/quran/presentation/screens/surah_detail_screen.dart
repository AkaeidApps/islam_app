import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../providers/quran_providers.dart';
import '../widgets/audio_player_bar.dart';
import '../widgets/ayah_tile.dart';

class SurahDetailScreen extends ConsumerStatefulWidget {
  final int surahNumber;
  const SurahDetailScreen({super.key, required this.surahNumber});

  @override
  ConsumerState<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends ConsumerState<SurahDetailScreen> {
  int? _playingAyah;

  void _playAyah(String url, int ayahNum, String surahName) {
    final notifier = ref.read(audioPlayerProvider.notifier);
    notifier.playAyah(url, surahName: surahName);
    setState(() => _playingAyah = ayahNum);
  }

  @override
  Widget build(BuildContext context) {
    // Use Telawa API for Arabic text + English translations
    final ayahsAsync = ref.watch(telawaSurahAyahsProvider(widget.surahNumber));

    return Scaffold(
      appBar: AppBar(title: Text('সূরা ${widget.surahNumber}')),
      body: ayahsAsync.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(
          message: 'লোড ব্যর্থ: $e',
          onRetry: () => ref.invalidate(telawaSurahAyahsProvider(widget.surahNumber)),
        ),
        data: (ayahs) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: ayahs.length,
                itemBuilder: (context, i) {
                  final a = ayahs[i];
                  // Audio URL is generated from Telawa reciter data
                  final audioUrl = a.audioUrl;
                  return AyahTile(
                    ayah: a,
                    isPlaying: _playingAyah == a.numberInSurah,
                    onPlay: audioUrl != null && audioUrl.isNotEmpty
                        ? () => _playAyah(
                            audioUrl,
                            a.numberInSurah,
                            'সূরা ${widget.surahNumber}',
                          )
                        : null,
                  );
                },
              ),
            ),
            AudioPlayerBar(
              totalAyahs: ayahs.length,
              surahNumber: widget.surahNumber,
            ),
          ],
        ),
      ),
    );
  }
}