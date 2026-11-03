import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/hadith_model.dart';

class HadithLocalDatasource {
  /// Loads hadiths from local JSON file
  Future<List<HadithModel>> getHadiths() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/hadith.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData.map((json) => HadithModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load hadiths from local file');
    }
  }
}
