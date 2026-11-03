import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/quran/presentation/screens/quran_home_screen.dart';
import '../features/quran/presentation/screens/surah_detail_screen.dart';
import '../features/prayer_times/presentation/screens/prayer_times_screen.dart';
import '../features/qibla/presentation/screens/qibla_screen.dart';
import '../features/duas/presentation/screens/dua_categories_screen.dart';
import '../features/duas/presentation/screens/dua_detail_screen.dart';
import '../features/hadith/presentation/screens/hadith_list_screen.dart';
import '../features/tasbih/presentation/screens/tasbih_screen.dart';
import '../shared/widgets/bottom_nav_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/quran',
  routes: [
    ShellRoute(
      builder: (context, state, child) => BottomNavShell(child: child),
      routes: [
        GoRoute(
          path: '/quran',
          pageBuilder: (c, s) => const NoTransitionPage(child: QuranHomeScreen()),
          routes: [
            GoRoute(
              path: 'surah/:number',
              builder: (c, s) => SurahDetailScreen(
                surahNumber: int.parse(s.pathParameters['number']!),
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/prayer',
          pageBuilder: (c, s) => const NoTransitionPage(child: PrayerTimesScreen()),
        ),
        GoRoute(
          path: '/qibla',
          pageBuilder: (c, s) => const NoTransitionPage(child: QiblaScreen()),
        ),
        GoRoute(
          path: '/duas',
          pageBuilder: (c, s) => const NoTransitionPage(child: DuaCategoriesScreen()),
          routes: [
            GoRoute(
              path: 'category/:id',
              builder: (c, s) => DuaDetailScreen(
                categoryId: s.pathParameters['id']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/more',
          pageBuilder: (c, s) => const NoTransitionPage(child: _MoreScreen()),
        ),
      ],
    ),
    GoRoute(path: '/hadith', builder: (c, s) => const HadithListScreen()),
    GoRoute(path: '/tasbih', builder: (c, s) => const TasbihScreen()),
  ],
);

class _MoreScreen extends StatelessWidget {
  const _MoreScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('আরও')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('হাদিস'),
            onTap: () => context.push('/hadith'),
          ),
          ListTile(
            leading: const Icon(Icons.radio_button_checked),
            title: const Text('তাসবিহ কাউন্টার'),
            onTap: () => context.push('/tasbih'),
          ),
        ],
      ),
    );
  }
}