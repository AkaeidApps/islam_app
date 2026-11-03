import '../../domain/entities/dua_category.dart';

class DuaCategoryModel {
  final String id;
  final String name;
  final String? description;
  final int duaCount;
  DuaCategoryModel({required this.id, required this.name, this.description, required this.duaCount});

  factory DuaCategoryModel.fromJson(Map<String, dynamic> j) => DuaCategoryModel(
    id: j['id'].toString(),
    name: j['title'] as String? ?? j['name'] as String? ?? '',
    description: j['description'] as String?,
    duaCount: (j['count'] as int?) ?? 0,
  );

  DuaCategory toEntity() => DuaCategory(id: id, name: name, description: description, duaCount: duaCount);
}