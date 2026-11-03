import '../../domain/entities/telawa_surah.dart';
import 'telawa_ayah_model.dart';

/// Telawa API Surah model with JSON parsing (includes ayahs when fetched via detail endpoint)
class TelawaSurahModel extends TelawaSurah {
  final List<TelawaAyahModel>? ayahs;

  const TelawaSurahModel({
    required super.id,
    required super.nameAr,
    required super.nameEn,
    required super.nameTrans,
    required super.englishTranslation,
    required super.revelationType,
    required super.ayahCount,
    required super.chronologicalOrder,
    this.ayahs,
  });

  factory TelawaSurahModel.fromJson(Map<String, dynamic> json) {
    List<TelawaAyahModel>? ayahs;
    if (json['ayahs'] != null) {
      ayahs = (json['ayahs'] as List<dynamic>)
          .map((item) => TelawaAyahModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return TelawaSurahModel(
      id: json['id'] as int,
      nameAr: json['nameAr'] as String,
      nameEn: json['nameEn'] as String,
      nameTrans: json['nameTrans'] as String,
      englishTranslation: json['englishTranslation'] as String,
      revelationType: json['revelationType'] as String,
      ayahCount: json['ayahCount'] as int,
      chronologicalOrder: json['chronologicalOrder'] as int,
      ayahs: ayahs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'nameTrans': nameTrans,
      'englishTranslation': englishTranslation,
      'revelationType': revelationType,
      'ayahCount': ayahCount,
      'chronologicalOrder': chronologicalOrder,
      'ayahs': ayahs?.map((a) => a.toJson()).toList(),
    };
  }
}
