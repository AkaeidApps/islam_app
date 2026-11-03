/// Telawa API Ayah entity
class TelawaAyah {
  final int id;
  final int ayahNumber;
  final String ayahKey; // "surah:ayah" format
  final int juz;
  final int hizb;
  final int page;
  final String textAr; // Arabic text with tashkeel
  final String textSimple; // Arabic text without tashkeel
  final bool sajda;

  const TelawaAyah({
    required this.id,
    required this.ayahNumber,
    required this.ayahKey,
    required this.juz,
    required this.hizb,
    required this.page,
    required this.textAr,
    required this.textSimple,
    required this.sajda,
  });
}
