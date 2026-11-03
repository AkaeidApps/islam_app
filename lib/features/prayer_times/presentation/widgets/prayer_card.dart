import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

class PrayerCard extends StatelessWidget {
  final String name;
  final String? arabicName;
  final String time;
  final IconData icon;
  const PrayerCard({
    super.key,
    required this.name,
    this.arabicName,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Icon
            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.15),
              radius: 24,
              child: Icon(icon, color: AppColors.primaryDark, size: 24),
            ),
            const SizedBox(width: 12),
            // Names
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  if (arabicName != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      arabicName!,
                      style: AppTheme.arabicStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Time
            Text(
              time,
              style: const TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}