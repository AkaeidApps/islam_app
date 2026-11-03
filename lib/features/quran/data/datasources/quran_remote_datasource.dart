import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/ayah_model.dart';
import '../models/surah_model.dart';

abstract interface class QuranRemoteDataSource {
  Future<List<SurahModel>> getSurahList();
  Future<List<AyahModel>> getSurahWithTranslation(int surahNumber, String reciter);
}

class QuranRemoteDataSourceImpl implements QuranRemoteDataSource {
  final Dio _dio;
  QuranRemoteDataSourceImpl(this._dio);

  @override
  Future<List<SurahModel>> getSurahList() async {
    try {
      final r = await _dio.get('${ApiEndpoints.quranBase}/surah');
      final list = r.data['data'] as List;
      return list.map((e) => SurahModel.fromJson(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'সূরা লিস্ট লোড ব্যর্থ');
    }
  }

  @override
  Future<List<AyahModel>> getSurahWithTranslation(int surahNumber, String reciter) async {
    try {
      // Fetch Arabic text, Bengali translation, and Audio edition together
      final editions = '${ApiEndpoints.arabicEdition},${ApiEndpoints.bengaliEdition},$reciter';
      final r = await _dio.get(
        '${ApiEndpoints.quranBase}/surah/$surahNumber/$editions',
      );

      // Response has 3 data arrays: [0]=Arabic, [1]=Bengali, [2]=Audio
      final data = r.data['data'] as List;
      final arabicList = data[0]['ayahs'] as List;
      
      String? translation;
      if (data.length > 1 && (data[1]['ayahs'] as List).isNotEmpty) {
        translation = (data[1]['ayahs'][0] as Map<String, dynamic>)['text'] as String?;
      }
      final banglaList = translation != null ? data[1]['ayahs'] as List : <dynamic>[];

      String? audio;
      if (data.length > 2 && (data[2]['ayahs'] as List).isNotEmpty) {
        audio = (data[2]['ayahs'][0] as Map<String, dynamic>)['audio'] as String?;
      }
      final audioList = audio != null ? data[2]['ayahs'] as List : <dynamic>[];

      return List.generate(arabicList.length, (i) {
        final a = arabicList[i] as Map<String, dynamic>;
        final t = banglaList.isNotEmpty ? (banglaList[i] as Map<String, dynamic>)['text'] as String? : null;
        final audioUrl = audioList.isNotEmpty ? (audioList[i] as Map<String, dynamic>)['audio'] as String? : null;
        return AyahModel(
          number: a['number'] as int,
          numberInSurah: a['numberInSurah'] as int,
          text: a['text'] as String,
          translation: t,
          audio: audioUrl,
        );
      });
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'সূরা লোড ব্যর্থ');
    }
  }
}