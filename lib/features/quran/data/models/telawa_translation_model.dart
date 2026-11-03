import '../../domain/entities/telawa_translation.dart';

/// Telawa API Translation model with JSON parsing
class TelawaTranslationModel extends TelawaTranslation {
  const TelawaTranslationModel({
    required super.ayahId,
    required super.language,
    required super.translator,
    required super.text,
  });

  factory TelawaTranslationModel.fromJson(Map<String, dynamic> json) {
    return TelawaTranslationModel(
      ayahId: json['ayahId'] as int,
      language: json['language'] as String,
      translator: json['translator'] as String,
      text: json['text'] as String,
    );
  }
}
