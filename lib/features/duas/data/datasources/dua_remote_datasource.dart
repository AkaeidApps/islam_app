import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/dua_model.dart';
import '../models/dua_category_model.dart';

class DuaRemoteDatasource {
  /// Loads duas from local JSON file as fallback
  Future<List<DuaModel>> getDuasFromLocal() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/duas_fallback.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData.map((json) => DuaModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load duas from local file');
    }
  }

  /// Gets dua categories based on the duas data
  Future<List<DuaCategoryModel>> getDuaCategories() async {
    // Default categories
    return [
      DuaCategoryModel(id: 'morning', name: 'Morning & Evening', duaCount: 10),
      DuaCategoryModel(id: 'prayer', name: 'After Prayer', duaCount: 8),
      DuaCategoryModel(id: 'food', name: 'Before & After Food', duaCount: 6),
      DuaCategoryModel(id: 'sleep', name: 'Before Sleep', duaCount: 5),
      DuaCategoryModel(id: 'travel', name: 'Travel', duaCount: 4),
      DuaCategoryModel(id: 'general', name: 'General Duas', duaCount: 12),
    ];
  }

  /// Gets duas by category
  Future<List<DuaModel>> getDuasByCategory(String categoryId) async {
    final duas = await getDuasFromLocal();
    return duas.where((dua) => dua.categoryId == categoryId).toList();
  }
}
