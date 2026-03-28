import 'package:flutter/material.dart';
import '../core/color_utils.dart';
import '../core/app_text_styles.dart';
import '../state/game_controller.dart';

/// Shows the target vs guess results split horizontally.
class RoundResultView extends StatelessWidget {
  final GameController controller;

  const RoundResultView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final round = controller.lastCompletedRound;
    final targetColor = round.target.toColor();
    final guessColor = round.guess!.toColor();
    final score = round.score!;
    final message = ColorUtils.getRoundMessage(score);
    final guessHSV = ColorUtils.formatHSV(round.guess!);
    final targetHSV = ColorUtils.formatHSV(round.target);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Top half: User's guess (with Score) ─────────────────────────
        Expanded(
          child: Container(
            color: guessColor,
            padding: const EdgeInsets.all(28),
            child: Stack(
              children: [
                // Round indicator (Top Left)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Text(
                    '${controller.currentRound}/${controller.maxRounds}',
                    style: AppTextStyles.roundIndicator.copyWith(
                      color: ColorUtils.applyContrast(guessColor, opacity: 0.7),
                    ),
                  ),
                ),
                
                // Score & Message (Top Right)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        score.toStringAsFixed(2),
                        style: AppTextStyles.resultScoreDisplay.copyWith(
                          color: ColorUtils.applyContrast(guessColor),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        textAlign: TextAlign.right,
                        style: AppTextStyles.resultMessage.copyWith(
                          color: ColorUtils.applyContrast(guessColor, opacity: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                // "Your selection" (Bottom Left)
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Your selection',
                        style: AppTextStyles.resultOverLabel.copyWith(
                          color: ColorUtils.applyContrast(guessColor, opacity: 0.6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        guessHSV,
                        style: AppTextStyles.hsvLabel.copyWith(
                          color: ColorUtils.applyContrast(guessColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Bottom half: Target / Original ─────────────────────────────────
        Expanded(
          child: Container(
            color: targetColor,
            padding: const EdgeInsets.all(28),
            child: Stack(
              children: [
                // "Original" (Bottom Left)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 80, // Prevent overlap with button
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Original',
                        style: AppTextStyles.resultOverLabel.copyWith(
                          color: ColorUtils.applyContrast(targetColor, opacity: 0.6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          targetHSV,
                          style: AppTextStyles.hsvLabel.copyWith(
                            color: ColorUtils.applyContrast(targetColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow button (Bottom Right)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: controller.nextRound,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: ColorUtils.applyContrast(targetColor),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
