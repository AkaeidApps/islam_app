class Dua {
  final String id;
  final String categoryId;
  final String title;
  final String arabicText;
  final String? arabic;
  final String translation;
  final String? transliteration;
  final String? audioUrl;
  final String? source;
  const Dua({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.arabicText,
    this.arabic,
    required this.translation,
    this.transliteration,
    this.audioUrl,
    this.source,
  });
}