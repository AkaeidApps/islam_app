import '../../domain/entities/hijri_date.dart';
import '../../domain/entities/prayer_times.dart';
import '../../domain/repositories/prayer_repository.dart';
import '../datasources/prayer_remote_datasource.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  final PrayerRemoteDataSource _remote;
  PrayerRepositoryImpl(this._remote);

  @override
  Future<PrayerTimes> getPrayerTimes(double lat, double lng) async {
    final m = await _remote.getPrayerTimes(lat, lng);
    return m.toEntity();
  }

  @override
  Future<PrayerTimes> getPrayerTimesByCity(String city, String country, {int method = 1}) async {
    final m = await _remote.getPrayerTimesByCity(city, country, method: method);
    return m.toEntity();
  }

  @override
  Future<HijriDate> getHijriDate(String date) async {
    return _remote.getHijriDate(date);
  }
}