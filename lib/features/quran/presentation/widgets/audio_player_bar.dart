import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../domain/entities/qari.dart';
import '../../providers/quran_providers.dart';

class AudioPlayerBar extends ConsumerWidget {
  final int totalAyahs;
  final int? surahNumber;

  const AudioPlayerBar({
    super.key,
    required this.totalAyahs,
    this.surahNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioPlayerProvider);
    final notifier = ref.read(audioPlayerProvider.notifier);
    final selectedQari = ref.watch(selectedQariProvider);

    if (!audioState.isPlaying && audioState.currentAyahIndex == 0 && audioState.progress == 0.0) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar
          Slider(
            value: audioState.progress > 0 ? audioState.progress : ((totalAyahs > 0 && audioState.currentAyahIndex > 0)
                ? (audioState.currentAyahIndex) / totalAyahs
                : 0.0),
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.3),
            onChanged: (value) {
              notifier.setProgress(value);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Qari info
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audioState.currentSurahName.isNotEmpty
                            ? audioState.currentSurahName
                            : 'Quran Recitation',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        selectedQari.name,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Ayah counter
                Text(
                  '${audioState.currentAyahIndex + 1}/$totalAyahs',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 12),
                // Controls
                IconButton(
                  icon: const Icon(Icons.skip_previous, color: Colors.white, size: 28),
                  onPressed: notifier.previousAyah,
                ),
                // Play/Pause button
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      audioState.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    onPressed: notifier.togglePlay,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next, color: Colors.white, size: 28),
                  onPressed: notifier.nextAyah,
                ),
                IconButton(
                  icon: const Icon(Icons.stop, color: Colors.white70, size: 24),
                  onPressed: notifier.stop,
                ),
                // Qari selector
                PopupMenuButton<Qari>(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  icon: const Icon(Icons.tune, color: Colors.white70, size: 24),
                  itemBuilder: (context) => availableQaris.map((qari) {
                    return PopupMenuItem<Qari>(
                      value: qari,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              qari.name,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          Text(
                            qari.arabicName,
                            style: AppTheme.arabicStyle(fontSize: 14, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onSelected: (qari) {
                    ref.read(selectedQariProvider.notifier).state = qari;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
