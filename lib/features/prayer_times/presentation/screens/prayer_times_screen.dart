import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../providers/prayer_providers.dart';
import '../widgets/prayer_card.dart';

class PrayerTimesScreen extends ConsumerWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dhakaPrayerTimesProvider);
    final now = DateTime.now();
    final dateStr =
        '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
    final hijriAsync = ref.watch(hijriDateProvider(dateStr));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Gradient header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('নামাজের সময়'),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mosque_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ঢাকা, বাংলাদেশ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    hijriAsync.when(
                      loading: () => const SizedBox(
                        height: 16,
                        width: 100,
                        child: LinearProgressIndicator(color: Colors.white),
                      ),
                      error: (e, _) => const SizedBox.shrink(),
                      data: (hijri) => Text(
                        hijri.formatted,
                        style: AppTheme.arabicStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Prayer times list
          SliverToBoxAdapter(
            child: async.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: LoadingView()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(32),
                child: ErrorView(
                  message: 'লোড ব্যর্থ: $e',
                  onRetry: () => ref.invalidate(dhakaPrayerTimesProvider),
                ),
              ),
              data: (t) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date info card
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.1),
                          AppColors.primary.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              t.date,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                        if (t.hijriDate != null) ...[
                          const SizedBox(height: 8),
                          Divider(color: AppColors.primary.withOpacity(0.2)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: AppColors.accent,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                t.hijriDate!.formatted,
                                style: AppTheme.arabicStyle(
                                  color: AppColors.primaryDark,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Prayer cards
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'আজকের নামাজের সময়',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrayerCard(
                    name: 'ফজর',
                    arabicName: 'الفجر',
                    time: t.fajr,
                    icon: Icons.wb_twilight,
                  ),
                  PrayerCard(
                    name: 'যোহর',
                    arabicName: 'الظهر',
                    time: t.dhuhr,
                    icon: Icons.wb_sunny,
                  ),
                  PrayerCard(
                    name: 'আসর',
                    arabicName: 'العصر',
                    time: t.asr,
                    icon: Icons.wb_sunny_outlined,
                  ),
                  PrayerCard(
                    name: 'মাগরিব',
                    arabicName: 'المغرب',
                    time: t.maghrib,
                    icon: Icons.nights_stay,
                  ),
                  PrayerCard(
                    name: 'ইশা',
                    arabicName: 'العشاء',
                    time: t.isha,
                    icon: Icons.nightlight_round,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}