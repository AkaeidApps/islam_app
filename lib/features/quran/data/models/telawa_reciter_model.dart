import '../../domain/entities/telawa_reciter.dart';

/// Telawa API Reciter model with JSON parsing
class TelawaReciterModel extends TelawaReciter {
  const TelawaReciterModel({
    required super.id,
    required super.identifier,
    required super.name,
    required super.style,
    required super.language,
    required super.audioBaseUrl,
    required super.format,
    required super.isDefault,
  });

  factory TelawaReciterModel.fromJson(Map<String, dynamic> json) {
    return TelawaReciterModel(
      id: json['id'] as int,
      identifier: json['identifier'] as String,
      name: json['name'] as String,
      style: json['style'] as String,
      language: json['language'] as String,
      audioBaseUrl: json['audioBaseUrl'] as String,
      format: json['format'] as String,
      isDefault: json['isDefault'] as bool,
    );
  }
}
