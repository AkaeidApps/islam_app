/// Telawa API Reciter entity
class TelawaReciter {
  final int id;
  final String identifier;
  final String name;
  final String style; // Murattal or Mujawwad
  final String language;
  final String audioBaseUrl;
  final String format;
  final bool isDefault;

  const TelawaReciter({
    required this.id,
    required this.identifier,
    required this.name,
    required this.style,
    required this.language,
    required this.audioBaseUrl,
    required this.format,
    required this.isDefault,
  });

  /// Generate audio URL for a specific ayah
  String getAyahAudioUrl(int surahNumber, int ayahNumber) {
    final surah = surahNumber.toString().padLeft(3, '0');
    final ayah = ayahNumber.toString().padLeft(3, '0');
    return '$audioBaseUrl/$surah$ayah.$format';
  }
}
