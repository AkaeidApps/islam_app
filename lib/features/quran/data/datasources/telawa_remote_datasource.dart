import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../duas/data/models/telawa_dua_model.dart';
import '../../../qibla/data/models/telawa_qibla_model.dart';
import '../models/telawa_surah_model.dart';
import '../models/telawa_ayah_model.dart';
import '../models/telawa_translation_model.dart';
import '../models/telawa_tafsir_model.dart';
import '../models/telawa_reciter_model.dart';

/// Telawa API remote datasource
class TelawaRemoteDatasource {
  final Dio _dio;

  TelawaRemoteDatasource({Dio? dio})
      : _dio = dio ?? Dio(BaseOptions(
          baseUrl: ApiEndpoints.telawaBase,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ));

  /// Get all surahs list
  Future<List<TelawaSurahModel>> getSurahs() async {
    final response = await _dio.get('/surahs');
    final List<dynamic> data = response.data['data'];
    return data.map((json) => TelawaSurahModel.fromJson(json)).toList();
  }

  /// Get surah detail with ayahs
  Future<TelawaSurahModel> getSurahDetail(int surahId) async {
    final response = await _dio.get('/surahs/$surahId');
    return TelawaSurahModel.fromJson(response.data['data']);
  }

  /// Get single ayah
  Future<TelawaAyahModel> getAyah(int surahNumber, int ayahNumber) async {
    final response = await _dio.get('/ayahs/$surahNumber/$ayahNumber');
    return TelawaAyahModel.fromJson(response.data['data']);
  }

  /// Get random ayah
  Future<TelawaAyahModel> getRandomAyah() async {
    final response = await _dio.get('/ayahs/random');
    return TelawaAyahModel.fromJson(response.data['data']);
  }

  /// Get translations for a surah
  Future<List<TelawaTranslationModel>> getTranslations(int surahId) async {
    final response = await _dio.get('/translations', queryParameters: {
      'surahId': surahId,
    });
    final List<dynamic> data = response.data['data'];
    return data.map((json) => TelawaTranslationModel.fromJson(json)).toList();
  }

  /// Get translations for a specific ayah
  Future<List<TelawaTranslationModel>> getAyahTranslations(int ayahId) async {
    final response = await _dio.get('/translations', queryParameters: {
      'ayahId': ayahId,
    });
    final List<dynamic> data = response.data['data'];
    return data.map((json) => TelawaTranslationModel.fromJson(json)).toList();
  }

  /// Get tafsir for a specific ayah
  Future<List<TelawaTafsirModel>> getTafsir(int ayahId) async {
    final response = await _dio.get('/tafsirs', queryParameters: {
      'ayahId': ayahId,
    });
    final List<dynamic> data = response.data['data'];
    return data.map((json) => TelawaTafsirModel.fromJson(json)).toList();
  }

  /// Get all available reciters
  Future<List<TelawaReciterModel>> getReciters() async {
    final response = await _dio.get('/reciters');
    final List<dynamic> data = response.data['data'];
    return data.map((json) => TelawaReciterModel.fromJson(json)).toList();
  }

  /// Get all dua categories
  Future<List<TelawaDuaCategoryModel>> getDuas() async {
    final response = await _dio.get('/duas');
    final List<dynamic> data = response.data['data'];
    return data.map((json) => TelawaDuaCategoryModel.fromJson(json)).toList();
  }

  /// Get duas in a specific category
  Future<TelawaDuaCategoryModel> getDuaById(int duaId) async {
    final response = await _dio.get('/duas/$duaId');
    return TelawaDuaCategoryModel.fromJson(response.data['data']);
  }

  /// Get Qibla direction
  Future<TelawaQiblaModel> getQibla(double lat, double lng) async {
    final response = await _dio.get('/qibla', queryParameters: {
      'lat': lat,
      'lng': lng,
    });
    return TelawaQiblaModel.fromJson(response.data['data']);
  }

  /// Search Quran
  Future<Map<String, dynamic>> search(String query) async {
    final response = await _dio.get('/search', queryParameters: {
      'q': query,
    });
    return response.data['data'];
  }
}
