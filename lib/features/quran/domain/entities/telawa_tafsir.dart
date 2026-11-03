/// Telawa API Tafsir entity (Ibn Kathir)
class TelawaTafsir {
  final int ayahId;
  final String language;
  final String source;
  final String text;

  const TelawaTafsir({
    required this.ayahId,
    required this.language,
    required this.source,
    required this.text,
  });
}
