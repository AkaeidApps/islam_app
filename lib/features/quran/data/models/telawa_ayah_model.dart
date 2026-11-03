import '../../domain/entities/telawa_ayah.dart';

/// Telawa API Ayah model with JSON parsing
class TelawaAyahModel extends TelawaAyah {
  const TelawaAyahModel({
    required super.id,
    required super.ayahNumber,
    required super.ayahKey,
    required super.juz,
    required super.hizb,
    required super.page,
    required super.textAr,
    required super.textSimple,
    required super.sajda,
  });

  factory TelawaAyahModel.fromJson(Map<String, dynamic> json) {
    return TelawaAyahModel(
      id: json['id'] as int,
      ayahNumber: json['ayahNumber'] as int,
      ayahKey: json['ayahKey'] as String,
      juz: json['juz'] as int,
      hizb: json['hizb'] as int,
      page: json['page'] as int,
      textAr: json['textAr'] as String,
      textSimple: json['textSimple'] as String,
      sajda: json['sajda'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ayahNumber': ayahNumber,
      'ayahKey': ayahKey,
      'juz': juz,
      'hizb': hizb,
      'page': page,
      'textAr': textAr,
      'textSimple': textSimple,
      'sajda': sajda,
    };
  }
}
