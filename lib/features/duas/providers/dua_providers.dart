import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../data/models/dua_category_model.dart';
import '../data/models/dua_model.dart';
import '../domain/entities/dua.dart';
import '../domain/entities/dua_category.dart';
import 'telawa_dua_providers.dart';

final _dioProvider = Provider<Dio>((ref) => DioClient.create());

final duaCategoriesProvider = FutureProvider.autoDispose<List<DuaCategory>>((ref) async {
  final dio = ref.watch(_dioProvider);
  final r = await dio.get(
    '${ApiEndpoints.duaBase}/islamic/dua',
    queryParameters: {'type': 'category', 'lang': 'bn'},
  );
  final list = r.data['data'] as List;
  return list
      .map((e) => DuaCategoryModel.fromJson(e as Map<String, dynamic>).toEntity())
      .toList();
});

final duasByCategoryProvider =
FutureProvider.autoDispose.family<List<Dua>, String>((ref, categoryId) async {
  final dio = ref.watch(_dioProvider);
  final r = await dio.get(
    '${ApiEndpoints.duaBase}/islamic/dua',
    queryParameters: {
      'type': 'sub-category',
      'category_id': categoryId,
      'lang': 'bn',
    },
  );
  final list = r.data['data'] as List;
  return list
      .map((e) => DuaModel.fromJson(e as Map<String, dynamic>).toEntity())
      .toList();
});

/// Telawa API Dua categories provider — converts to DuaCategory entities
final telawaDuaCategoriesProvider = FutureProvider.autoDispose<List<DuaCategory>>((ref) async {
  final categories = await ref.watch(telawaDuasProvider.future);
  return categories
      .map((c) => DuaCategory(
            id: '${c.id}',
            name: c.title,
            duaCount: c.duaCount,
          ))
      .toList();
});

/// Telawa API Duas by category — converts to Dua entities
final telawaDuasByCategoryProvider =
    FutureProvider.autoDispose.family<List<Dua>, int>((ref, categoryId) async {
  final category = await ref.watch(telawaDuaDetailProvider(categoryId).future);
  if (category.duas == null || category.duas!.isEmpty) return [];

  return category.duas!
      .map((d) => Dua(
            id: '${d.id}',
            categoryId: '$categoryId',
            title: category.title,
            arabicText: d.arabic,
            translation: '',
            audioUrl: category.audioUrl,
            source: d.reference.isNotEmpty ? d.reference : null,
          ))
      .toList();
});