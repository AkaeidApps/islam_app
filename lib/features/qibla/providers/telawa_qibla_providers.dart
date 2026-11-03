import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../quran/providers/quran_providers.dart';
import '../data/models/telawa_qibla_model.dart';

/// Qibla direction from Telawa API
final telawaQiblaProvider =
    FutureProvider.family<TelawaQiblaModel, (double lat, double lng)>((ref, coords) async {
  final datasource = ref.watch(telawaDatasourceProvider);
  return datasource.getQibla(coords.$1, coords.$2);
});
