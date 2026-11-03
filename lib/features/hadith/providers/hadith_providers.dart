import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/hadith_model.dart';

final hadithProvider = FutureProvider.autoDispose<List<HadithModel>>((ref) async {
  final raw = await rootBundle.loadString('assets/data/hadith.json');
  final list = jsonDecode(raw) as List;
  return list.map((e) => HadithModel.fromJson(e as Map<String, dynamic>)).toList();
});