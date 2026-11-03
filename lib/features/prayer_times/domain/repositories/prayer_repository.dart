import '../entities/hijri_date.dart';
import '../entities/prayer_times.dart';

abstract interface class PrayerRepository {
  Future<PrayerTimes> getPrayerTimes(double lat, double lng);
  Future<PrayerTimes> getPrayerTimesByCity(String city, String country, {int method = 1});
  Future<HijriDate> getHijriDate(String date);
}