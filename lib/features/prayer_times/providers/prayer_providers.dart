import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/location_service.dart';
import '../data/datasources/prayer_remote_datasource.dart';
import '../data/repositories/prayer_repository_impl.dart';
import '../domain/entities/hijri_date.dart';
import '../domain/entities/prayer_times.dart';
import '../domain/repositories/prayer_repository.dart';

final _dioProvider = Provider<Dio>((ref) => DioClient.create());

final prayerRepoProvider = Provider<PrayerRepository>((ref) {
  return PrayerRepositoryImpl(PrayerRemoteDataSourceImpl(ref.watch(_dioProvider)));
});

// Location-based prayer times (existing)
final prayerTimesProvider = FutureProvider.autoDispose<PrayerTimes>((ref) async {
  final pos = await LocationService.getCurrentPosition();
  return ref.watch(prayerRepoProvider).getPrayerTimes(pos.latitude, pos.longitude);
});

// City-based prayer times (new)
final prayerTimesByCityProvider = FutureProvider.autoDispose
    .family<PrayerTimes, ({String city, String country, int method})>((ref, params) async {
  return ref
      .watch(prayerRepoProvider)
      .getPrayerTimesByCity(params.city, params.country, method: params.method);
});

// Hijri date provider (new)
final hijriDateProvider = FutureProvider.autoDispose
    .family<HijriDate, String>((ref, date) async {
  return ref.watch(prayerRepoProvider).getHijriDate(date);
});

// Default Dhaka, Bangladesh prayer times with Hijri date
final dhakaPrayerTimesProvider = FutureProvider.autoDispose<PrayerTimes>((ref) async {
  final repo = ref.watch(prayerRepoProvider);
  return repo.getPrayerTimesByCity('Dhaka', 'Bangladesh', method: 1);
});