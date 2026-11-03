import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../quran/providers/quran_providers.dart';
import '../data/models/telawa_dua_model.dart';

/// All dua categories from Telawa API
final telawaDuasProvider = FutureProvider<List<TelawaDuaCategoryModel>>((ref) async {
  final datasource = ref.watch(telawaDatasourceProvider);
  return datasource.getDuas();
});

/// Dua category detail with duas from Telawa API
final telawaDuaDetailProvider = FutureProvider.family<TelawaDuaCategoryModel, int>((ref, duaId) async {
  final datasource = ref.watch(telawaDatasourceProvider);
  return datasource.getDuaById(duaId);
});
