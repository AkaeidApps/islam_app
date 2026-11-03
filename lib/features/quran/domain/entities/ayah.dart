class Ayah {
  final int number;          // global ayah number (1-6236)
  final int numberInSurah;
  final String text;
  final String? translation;
  final String? audioUrl;

  const Ayah({
    required this.number,
    required this.numberInSurah,
    required this.text,
    this.translation,
    this.audioUrl,
  });
}