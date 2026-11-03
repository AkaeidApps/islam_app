import '../../domain/entities/telawa_tafsir.dart';

/// Telawa API Tafsir model with JSON parsing
class TelawaTafsirModel extends TelawaTafsir {
  const TelawaTafsirModel({
    required super.ayahId,
    required super.language,
    required super.source,
    required super.text,
  });

  factory TelawaTafsirModel.fromJson(Map<String, dynamic> json) {
    return TelawaTafsirModel(
      ayahId: json['ayahId'] as int,
      language: json['language'] as String,
      source: json['source'] as String,
      text: json['text'] as String,
    );
  }
}
