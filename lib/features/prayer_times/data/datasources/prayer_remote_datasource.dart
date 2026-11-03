import 'package:dio/dio.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/prayer_times_model.dart';
import '../../domain/entities/hijri_date.dart';

abstract interface class PrayerRemoteDataSource {
  Future<PrayerTimesModel> getPrayerTimes(double lat, double lng);
  Future<PrayerTimesModel> getPrayerTimesByCity(String city, String country, {int method = 1});
  Future<HijriDate> getHijriDate(String date);
}

class PrayerRemoteDataSourceImpl implements PrayerRemoteDataSource {
  final Dio _dio;
  PrayerRemoteDataSourceImpl(this._dio);

  @override
  Future<PrayerTimesModel> getPrayerTimes(double lat, double lng) async {
    try {
      final now = DateTime.now();
      final dateStr =
          '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
      final r = await _dio.get(
        '${ApiEndpoints.prayerBase}/timings/$dateStr',
        queryParameters: {
          'latitude': lat,
          'longitude': lng,
          'method': 1,
        },
      );
      return PrayerTimesModel.fromJson(r.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'প্রার্থনার সময় লোড ব্যর্থ');
    }
  }

  @override
  Future<PrayerTimesModel> getPrayerTimesByCity(String city, String country, {int method = 1}) async {
    try {
      final now = DateTime.now();
      final dateStr =
          '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
      final r = await _dio.get(
        '${ApiEndpoints.timingsByCity}/$dateStr',
        queryParameters: {
          'city': city,
          'country': country,
          'method': method,
        },
      );
      return PrayerTimesModel.fromJson(r.data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'প্রার্থনার সময় লোড ব্যর্থ');
    }
  }

  @override
  Future<HijriDate> getHijriDate(String date) async {
    try {
      final r = await _dio.get(
        '${ApiEndpoints.gToH}/$date',
      );
      final data = r.data['data'] as Map<String, dynamic>;
      final hijri = data['hijri'] as Map<String, dynamic>;
      return HijriDate.fromJson(hijri);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'হিজরি তারিখ লোড ব্যর্থ');
    }
  }
}