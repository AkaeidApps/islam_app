import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/dua.dart';
import '../../providers/dua_providers.dart';

class DuaDetailScreen extends ConsumerWidget {
  final String categoryId;
  const DuaDetailScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use Telawa API as primary source for duas
    final id = int.tryParse(categoryId) ?? 0;
    final async = ref.watch(telawaDuasByCategoryProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text('দুআ')),
      body: async.when(
        loading: () => const LoadingView(),
        error: (e, _) => ErrorView(
          message: 'লোড ব্যর্থ: $e',
          onRetry: () => ref.invalidate(telawaDuasByCategoryProvider(id)),
        ),
        data: (duas) => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: duas.length,
          itemBuilder: (context, i) => _DuaCard(dua: duas[i]),
        ),
      ),
    );
  }
}

class _DuaCard extends StatefulWidget {
  final Dua dua;
  const _DuaCard({required this.dua});

  @override
  State<_DuaCard> createState() => _DuaCardState();
}

class _DuaCardState extends State<_DuaCard> {
  late final AudioPlayer _player;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (widget.dua.audioUrl == null) return;
    if (_playing) {
      await _player.pause();
      setState(() => _playing = false);
    } else {
      try {
        if (_player.audioSource == null) {
          await _player.setUrl(widget.dua.audioUrl!);
        }
        await _player.play();
        setState(() => _playing = true);
      } catch (_) {}
    }
  }

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
                Expanded(
                  child: Text(
                    widget.dua.title,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
                if (widget.dua.audioUrl != null)
                  IconButton(
                    icon: Icon(
                      _playing
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    onPressed: _toggle,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.dua.arabicText,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: GoogleFonts.amiri(
                  fontSize: 22,
                  height: 1.9,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.dua.translation,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
            if (widget.dua.source != null) ...[
              const SizedBox(height: 8),
              Text(
                'সূত্র: ${widget.dua.source}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}