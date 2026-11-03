/// Telawa API Dua entity (individual dua within a category)
class TelawaDuaItem {
  final int id;
  final String arabic;
  final String repeat;
  final String reference;

  const TelawaDuaItem({
    required this.id,
    required this.arabic,
    required this.repeat,
    required this.reference,
  });
}

/// Telawa API Dua Category entity
class TelawaDuaCategory {
  final int id;
  final String title;
  final String? audioUrl;
  final int duaCount;
  final List<TelawaDuaItem>? duas;

  const TelawaDuaCategory({
    required this.id,
    required this.title,
    this.audioUrl,
    required this.duaCount,
    this.duas,
  });
}
