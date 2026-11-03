/// Telawa API Surah entity
class TelawaSurah {
  final int id;
  final String nameAr;
  final String nameEn;
  final String nameTrans;
  final String englishTranslation;
  final String revelationType; // Meccan or Medinan
  final int ayahCount;
  final int chronologicalOrder;

  const TelawaSurah({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.nameTrans,
    required this.englishTranslation,
    required this.revelationType,
    required this.ayahCount,
    required this.chronologicalOrder,
  });
}
