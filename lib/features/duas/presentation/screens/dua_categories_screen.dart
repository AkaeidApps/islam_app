import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../providers/dua_providers.dart';

class DuaCategoriesScreen extends ConsumerWidget {
  const DuaCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use Telawa API as primary source for duas
    final async = ref.watch(telawaDuaCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('দুআ ও যিকর')),
      body: async.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(
          message: 'লোড ব্যর্থ: $e',
          onRetry: () => ref.invalidate(telawaDuaCategoriesProvider),
        ),
        data: (cats) => GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.05,
          ),
          itemCount: cats.length,
          itemBuilder: (context, i) {
            final c = cats[i];
            return Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => context.push('/duas/category/${c.id}'),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: AppColors.primary.withOpacity(0.15),
                        child: const Icon(Icons.menu_book,
                            color: AppColors.primaryDark),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        c.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${c.duaCount}টি',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}