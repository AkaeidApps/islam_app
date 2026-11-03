import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../providers/qibla_providers.dart';

class QiblaScreen extends ConsumerWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(qiblaProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('কিবলা')),
      body: async.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(
          message: 'লোড ব্যর্থ: $e',
          onRetry: () => ref.invalidate(qiblaProvider),
        ),
        data: (s) {
          final arrow = s.deviceHeading == null
              ? s.qiblaBearing
              : (s.qiblaBearing - s.deviceHeading!) * math.pi / 180;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.mosque, size: 48, color: AppColors.primaryDark),
                const SizedBox(height: 16),
                Text(
                  'কিবলা দিক: ${s.qiblaBearing.toStringAsFixed(1)}°',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (s.distanceKm != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'কাবা থেকে দূরত্ব: ${s.distanceKm!.toStringAsFixed(0)} কিমি',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
                const SizedBox(height: 24),
                Transform.rotate(
                  angle: arrow,
                  child: Icon(
                    Icons.navigation,
                    size: 120,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                if (s.deviceHeading != null)
                  Text(
                    'ডিভাইস হেডিং: ${s.deviceHeading!.toStringAsFixed(1)}°',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}