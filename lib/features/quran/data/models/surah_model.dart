import '../../domain/entities/surah.dart';

class SurahModel {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;

  SurahModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory SurahModel.fromJson(Map<String, dynamic> j) => SurahModel(
    number: j['number'] as int,
    name: j['name'] as String,
    englishName: j['englishName'] as String,
    englishNameTranslation: j['englishNameTranslation'] as String,
    numberOfAyahs: j['numberOfAyahs'] as int,
    revelationType: j['revelationType'] as String,
  );

  Surah toEntity() => Surah(
    number: number,
    name: name,
    englishName: englishName,
    englishNameTranslation: englishNameTranslation,
    numberOfAyahs: numberOfAyahs,
    revelationType: revelationType,
  );
}