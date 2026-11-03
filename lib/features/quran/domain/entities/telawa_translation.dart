/// Telawa API Translation entity
class TelawaTranslation {
  final int ayahId;
  final String language;
  final String translator;
  final String text;

  const TelawaTranslation({
    required this.ayahId,
    required this.language,
    required this.translator,
    required this.text,
  });
}
