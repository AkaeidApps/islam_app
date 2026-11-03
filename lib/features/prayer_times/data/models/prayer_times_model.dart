import '../../domain/entities/hijri_date.dart';
import '../../domain/entities/prayer_times.dart';

class PrayerTimesModel {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String date;
  final HijriDate? hijriDate;

  PrayerTimesModel({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.date,
    this.hijriDate,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> j) {
    final t = j['timings'] as Map<String, dynamic>;
    HijriDate? hijri;
    if (j['date'] != null && (j['date'] as Map<String, dynamic>)['hijri'] != null) {
      hijri = HijriDate.fromJson((j['date'] as Map<String, dynamic>)['hijri'] as Map<String, dynamic>);
    }
    return PrayerTimesModel(
      fajr: t['Fajr'] as String,
      dhuhr: t['Dhuhr'] as String,
      asr: t['Asr'] as String,
      maghrib: t['Maghrib'] as String,
      isha: t['Isha'] as String,
      date: j['date']['readable'] as String,
      hijriDate: hijri,
    );
  }

  PrayerTimes toEntity() => PrayerTimes(
    fajr: fajr,
    dhuhr: dhuhr,
    asr: asr,
    maghrib: maghrib,
    isha: isha,
    date: date,
    hijriDate: hijriDate,
  );
}