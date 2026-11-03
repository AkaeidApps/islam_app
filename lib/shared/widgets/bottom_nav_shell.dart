import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class BottomNavShell extends StatelessWidget {
  final Widget child;
  const BottomNavShell({super.key, required this.child});

  static const _tabs = [
    '/quran',
    '/prayer',
    '/qibla',
    '/duas',
    '/more',
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    int index = _tabs.indexWhere((t) => location.startsWith(t));
    if (index < 0) index = 0;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => context.go(_tabs[i]),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book, color: AppColors.primaryDark),
            label: 'কুরআন',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            activeIcon: Icon(Icons.access_time_filled, color: AppColors.primaryDark),
            label: 'নামাজ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore, color: AppColors.primaryDark),
            label: 'কিবলা',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism_outlined),
            activeIcon: Icon(Icons.volunteer_activism, color: AppColors.primaryDark),
            label: 'দুআ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            activeIcon: Icon(Icons.more_horiz, color: AppColors.primaryDark),
            label: 'আরও',
          ),
        ],
      ),
    );
  }
}