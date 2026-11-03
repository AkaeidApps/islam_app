import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../providers/hadith_providers.dart';

class HadithListScreen extends ConsumerWidget {
  const HadithListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(hadithProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('হাদিস')),
      body: async.when(
        loading: () => const LoadingView(),
        error: (e, _) => Center(child: Text('লোড ব্যর্থ: $e')),
        data: (list) => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (context, i) {
            final h = list[i];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      h.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      h.arabic,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.amiri(
                        fontSize: 20,
                        height: 1.9,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(h.bengali, style: const TextStyle(height: 1.5)),
                    const SizedBox(height: 8),
                    Text(
                      'সূত্র: ${h.source}',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}