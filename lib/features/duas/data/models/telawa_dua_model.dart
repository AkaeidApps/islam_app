import '../../domain/entities/telawa_dua.dart';

/// Telawa API Dua Item model
class TelawaDuaItemModel extends TelawaDuaItem {
  const TelawaDuaItemModel({
    required super.id,
    required super.arabic,
    required super.repeat,
    required super.reference,
  });

  factory TelawaDuaItemModel.fromJson(Map<String, dynamic> json) {
    return TelawaDuaItemModel(
      id: json['id'] as int,
      arabic: json['arabic'] as String,
      repeat: json['repeat'] as String,
      reference: json['reference'] as String,
    );
  }
}

/// Telawa API Dua Category model with JSON parsing
class TelawaDuaCategoryModel extends TelawaDuaCategory {
  const TelawaDuaCategoryModel({
    required super.id,
    required super.title,
    super.audioUrl,
    required super.duaCount,
    super.duas,
  });

  factory TelawaDuaCategoryModel.fromJson(Map<String, dynamic> json) {
    List<TelawaDuaItemModel>? duas;
    if (json['duas'] != null) {
      duas = (json['duas'] as List<dynamic>)
          .map((item) => TelawaDuaItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return TelawaDuaCategoryModel(
      id: json['id'] as int,
      title: json['title'] as String,
      audioUrl: json['audioUrl'] as String?,
      duaCount: json['duaCount'] as int,
      duas: duas,
    );
  }
}
