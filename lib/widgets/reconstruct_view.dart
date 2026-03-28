import 'package:flutter/material.dart';
import '../core/color_utils.dart';
import '../core/app_text_styles.dart';
import '../state/game_controller.dart';
import 'vertical_color_slider.dart';

/// The reconstruction phase where the player uses HSV sliders to recreate
/// the memorized color.
class ReconstructView extends StatelessWidget {
  final GameController controller;

  const ReconstructView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final guessColor = controller.currentGuessColor.toColor();

    return Stack(
      children: [
        // ── Full-bleed guess color preview ─────────────────────────────
        Positioned.fill(child: Container(color: guessColor)),

        // ── Slider tracks on the left ─────────────────────────────────
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width: 150,
          child: Row(
            children: [
              // Hue
              Expanded(
                child: VerticalColorSlider(
                  gradientColors: ColorUtils.hueGradientColors,
                  value: controller.hue / 360.0,
                  onChanged: controller.updateHue,
                ),
              ),
              // Saturation
              Expanded(
                child: VerticalColorSlider(
                  gradientColors: ColorUtils.saturationGradient(
                    controller.hue,
                    controller.brightness,
                  ),
                  value: controller.saturation,
                  onChanged: controller.updateSaturation,
                ),
              ),
              // Brightness
              Expanded(
                child: VerticalColorSlider(
                  gradientColors: ColorUtils.brightnessGradient(
                    controller.hue,
                    controller.saturation,
                  ),
                  value: controller.brightness,
                  onChanged: controller.updateBrightness,
                ),
              ),
            ],
          ),
        ),

        // ── Round indicator ───────────────────────────────────────────
        Positioned(
          top: 32,
          left: 182,
          child: Text(
            '${controller.currentRound}/${controller.maxRounds}',
            style: AppTextStyles.roundIndicator.copyWith(
              color: ColorUtils.applyContrast(guessColor, opacity: 0.7),
            ),
          ),
        ),

        // ── Submit button ─────────────────────────────────────────────
        Positioned(
          bottom: 32,
          right: 32,
          child: GestureDetector(
            onTap: controller.submitGuess,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.check, color: Colors.black, size: 28),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
