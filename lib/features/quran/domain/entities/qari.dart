/// Qari (reciter) data model for Quran audio
class Qari {
  final String id;
  final String name;
  final String arabicName;
  final String country;
  final List<String> serverUrls; // API server base URLs
  final String everyayahSlug; // Slug for everyayah.com audio URLs

  const Qari({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.country,
    required this.serverUrls,
    required this.everyayahSlug,
  });

  /// Get the audio URL for a specific surah and ayah using everyayah.com
  /// Format: https://everyayah.com/data/{reciter_slug}/{surah_3digits}{ayah_3digits}.mp3
  String getAudioUrl(int surahNumber, int ayahNumber) {
    final surah = surahNumber.toString().padLeft(3, '0');
    final ayah = ayahNumber.toString().padLeft(3, '0');
    return 'https://everyayah.com/data/$everyayahSlug/$surah$ayah.mp3';
  }

  /// Get the audio URL for an entire surah from mp3quran.net
  String getSurahAudioUrl(int surahNumber) {
    final surah = surahNumber.toString().padLeft(3, '0');
    return '${serverUrls.first}/$surah.mp3';
  }
}

/// List of international Qaris (reciters)
const List<Qari> availableQaris = [
  Qari(
    id: 'ar.alafasy',
    name: 'Mishary Rashid Alafasy',
    arabicName: 'مشاري راشد العفاسي',
    country: 'Kuwait',
    serverUrls: ['https://server8.mp3quran.net/alafasy/'],
    everyayahSlug: 'Alafasy',
  ),
  Qari(
    id: 'ar.abdulbasit',
    name: 'Abdul Basit Abdul Samad',
    arabicName: 'عبد الباسط عبد الصمد',
    country: 'Egypt',
    serverUrls: ['https://server7.mp3quran.net/basit/'],
    everyayahSlug: 'AbdulBaset_Murattal',
  ),
  Qari(
    id: 'ar.sudais',
    name: 'Abdurrahman As-Sudais',
    arabicName: 'عبد الرحمن السديس',
    country: 'Saudi Arabia',
    serverUrls: ['https://server11.mp3quran.net/sds/'],
    everyayahSlug: 'AbuBakr_Ash-Shaatree',
  ),
  Qari(
    id: 'ar.shuraim',
    name: 'Saud Al-Shuraim',
    arabicName: 'سعود الشريم',
    country: 'Saudi Arabia',
    serverUrls: ['https://server9.mp3quran.net/shuraim/'],
    everyayahSlug: 'Saood_Ash-Shuraym',
  ),
  Qari(
    id: 'ar.husary',
    name: 'Mahmoud Khalil Al-Husary',
    arabicName: 'محمود خليل الحصري',
    country: 'Egypt',
    serverUrls: ['https://server10.mp3quran.net/husr/'],
    everyayahSlug: 'Husary',
  ),
  Qari(
    id: 'ar.minshawi',
    name: 'Mohamed Siddiq Al-Minshawi',
    arabicName: 'محمد صديق المنشاوي',
    country: 'Egypt',
    serverUrls: ['https://server6.mp3quran.net/minsh/'],
    everyayahSlug: 'Minshawy_Murattal',
  ),
  Qari(
    id: 'ar.maabor',
    name: 'Maabor Al-Muaiqly',
    arabicName: 'ماهر المعيقلي',
    country: 'Saudi Arabia',
    serverUrls: ['https://server12.mp3quran.net/maher/'],
    everyayahSlug: 'Maher_AlMuaiqly',
  ),
  Qari(
    id: 'ar.ahmedajamy',
    name: 'Ahmed Al-Ajamy',
    arabicName: 'أحمد العجمي',
    country: 'Saudi Arabia',
    serverUrls: ['https://server13.mp3quran.net/ajm/'],
    everyayahSlug: 'Ahmed_Ajamy',
  ),
];

/// Default Qari
const Qari defaultQari = Qari(
  id: 'ar.alafasy',
  name: 'Mishary Rashid Alafasy',
  arabicName: 'مشاري راشد العفاسي',
  country: 'Kuwait',
  serverUrls: ['https://server8.mp3quran.net/alafasy/'],
  everyayahSlug: 'Alafasy',
);
