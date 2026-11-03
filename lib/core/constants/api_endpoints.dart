abstract final class ApiEndpoints {
  // AlQuran Cloud
  static const quranBase = 'https://api.alquran.cloud/v1';
  static const audioCdn = 'https://cdn.islamic.network/quran';

  static const arabicEdition = 'quran-uthmani';
  static const bengaliEdition = 'bn.bengali';
  static const englishEdition = 'en.sahih';
  static const defaultReciter = 'ar.alafasy';
  static const audioEdition = 'ar.alafasy';
  static const bitrate = 128;

  // AlAdhan Prayer
  static const prayerBase = 'https://api.aladhan.com/v1';

  // Timings by City endpoint
  static const timingsByCity = 'https://api.aladhan.com/v1/timingsByCity';

  // Gregorian to Hijri conversion endpoint
  static const gToH = 'https://api.aladhan.com/v1/gToH';

  // Zikr e Quran (Duas)
  static const duaBase = 'https://zikrequran.com/api';

  // Telawa API - Free Quran API
  static const telawaBase = 'https://telawa.org/api/v1';
  static const telawaSurahs = '$telawaBase/surahs';
  static const telawaAyahs = '$telawaBase/ayahs';
  static const telawaTranslations = '$telawaBase/translations';
  static const telawaTafsirs = '$telawaBase/tafsirs';
  static const telawaReciters = '$telawaBase/reciters';
  static const telawaDuas = '$telawaBase/duas';
  static const telawaQibla = '$telawaBase/qibla';
  static const telawaSearch = '$telawaBase/search';

  // Common Islamic Audio Reciters
  static const reciters = <String, String>{
    'ar.alafasy': 'মিশারি আল-আফাসি',
    'ar.abdulbasitmurattal': 'আব্দুল বাসিত (মুরাত্তাল)',
    'ar.husary': 'মাহমুদ খলিল আল-হুসারি',
    'ar.minshawi': 'মুহাম্মদ সিদ্দিক আল-মিনশাবি',
    'ar.shaatree': 'আবু বকর আল-শাত্রি',
  };
}