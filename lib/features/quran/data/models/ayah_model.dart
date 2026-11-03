import '../../domain/entities/ayah.dart';

class AyahModel {
  final int number;
  final int numberInSurah;
  final String text;
  final String? translation;
  final String? audio;

  AyahModel({
    required this.number,
    required this.numberInSurah,
    required this.text,
    this.translation,
    this.audio,
  });

  factory AyahModel.fromJson(Map<String, dynamic> j) => AyahModel(
    number: j['number'] as int,
    numberInSurah: j['numberInSurah'] as int,
    text: j['text'] as String,
    audio: j['audio'] as String?,
  );

  Ayah toEntity({String? translation, String? audioUrl}) => Ayah(
    number: number,
    numberInSurah: numberInSurah,
    text: text,
    translation: translation ?? this.translation,
    audioUrl: audioUrl ?? audio,
  );
}