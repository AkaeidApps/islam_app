import '../../domain/entities/dua.dart';

class DuaModel {
  final String id;
  final String categoryId;
  final String title;
  final String arabicText;
  final String? arabic;
  final String translation;
  final String? transliteration;
  final String? audioUrl;
  final String? source;

  DuaModel({
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

  factory DuaModel.fromJson(Map<String, dynamic> j) => DuaModel(
    id: j['id'].toString(),
    categoryId: j['category_id'].toString(),
    title: j['title'] as String? ?? '',
    arabicText: j['arabic'] as String? ?? '',
    arabic: j['arabic'] as String?,
    translation: j['translation'] as String? ?? '',
    transliteration: j['transliteration'] as String?,
    audioUrl: j['audio_url'] as String?,
    source: j['source'] as String?,
  );

  Dua toEntity() => Dua(
    id: id,
    categoryId: categoryId,
    title: title,
    arabicText: arabicText,
    arabic: arabic,
    translation: translation,
    transliteration: transliteration,
    audioUrl: audioUrl,
    source: source,
  );
}