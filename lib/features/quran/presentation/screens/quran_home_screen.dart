import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../providers/quran_providers.dart';

class QuranHomeScreen extends ConsumerWidget {
  const QuranHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use Telawa API as primary source for surah list
    final listAsync = ref.watch(telawaSurahsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('কুরআন')),
      body: listAsync.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(
          message: 'লোড ব্যর্থ: $e',
          onRetry: () => ref.invalidate(telawaSurahsListProvider),
        ),
        data: (surahs) => ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: surahs.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final s = surahs[i];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  child: Text(
                    '${s.number}',
                    style: const TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  s.englishName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${s.englishNameTranslation} • ${s.numberOfAyahs} আয়াত',
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                trailing: const Icon(Icons.chevron_right, color: AppColors.primary),
                onTap: () => context.push('/quran/surah/${s.number}'),
              ),
            );
          },
        ),
      ),
    );
  }
}