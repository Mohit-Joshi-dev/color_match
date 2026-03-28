import 'package:flutter/material.dart';
import '../core/app_text_styles.dart';
import '../core/color_utils.dart';
import '../state/game_controller.dart';

/// Displays the target color for the player to memorize.
///
/// Shows a large countdown timer (e.g. "361" = 3.61s) matching the
/// dialed.gg style, with "Seconds to remember" subtitle. No progress bar.
class MemorizeView extends StatefulWidget {
  final GameController controller;

  const MemorizeView({super.key, required this.controller});

  @override
  State<MemorizeView> createState() => _MemorizeViewState();
}

class _MemorizeViewState extends State<MemorizeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _timerController;

  @override
  void initState() {
    super.initState();
    final durationMs = widget.controller.timerDurationMs;
    _timerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMs),
    );
    _timerController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.controller.onMemorizeDone();
      }
    });
    _timerController.forward();
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final targetColor = widget.controller.currentTarget.toColor();
    final totalSeconds =
        widget.controller.timerDurationMs / 1000.0;

    return Stack(
      children: [
        // Full‑bleed target color
        Positioned.fill(
          child: Container(color: targetColor),
        ),

        // Round indicator — top left
        Positioned(
          top: 32,
          left: 32,
          child: Text(
            '${widget.controller.currentRound}/${widget.controller.maxRounds}',
            style: AppTextStyles.roundIndicator.copyWith(
              color: ColorUtils.applyContrast(targetColor, opacity: 0.7),
            ),
          ),
        ),

        // Large countdown timer — right-aligned area
        Positioned(
          top: 32,
          right: 32,
          child: AnimatedBuilder(
            animation: _timerController,
            builder: (context, _) {
              final remaining =
                  totalSeconds * (1.0 - _timerController.value);
              // Format as integer with no decimal, e.g. "361" for 3.61s
              final display =
                  (remaining * 100).ceil().clamp(0, 99999).toString();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    display,
                    style: AppTextStyles.timerDisplay.copyWith(
                      color: ColorUtils.applyContrast(targetColor),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Seconds to remember',
                    style: AppTextStyles.timerLabel.copyWith(
                      color: ColorUtils.applyContrast(targetColor, opacity: 0.7),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
