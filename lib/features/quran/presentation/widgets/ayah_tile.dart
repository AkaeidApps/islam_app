import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/ayah.dart';

class AyahTile extends StatelessWidget {
  final Ayah ayah;
  final bool isPlaying;
  final VoidCallback? onPlay;

  const AyahTile({
    super.key,
    required this.ayah,
    required this.isPlaying,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.primary.withOpacity(0.15),
                  child: Text(
                    '${ayah.numberInSurah}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                if (onPlay != null)
                  IconButton(
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: AppColors.primary,
                      size: 30,
                    ),
                    onPressed: onPlay,
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ayah.text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: GoogleFonts.amiri(
                fontSize: 24,
                height: 1.9,
                color: AppColors.textPrimary,
              ),
            ),
            if (ayah.translation != null) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  ayah.translation!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}