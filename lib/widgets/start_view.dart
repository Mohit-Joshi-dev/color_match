import 'package:flutter/material.dart';
import '../core/app_text_styles.dart';
import '../models/game_state.dart';
import '../state/game_controller.dart';
/// The start / menu screen where the player picks mode and difficulty.
class StartView extends StatelessWidget {
  final GameController controller;

  const StartView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('color', style: AppTextStyles.heroTitle),
          const SizedBox(height: 16),
          Text(
            "Humans can't reliably recall colors. This is a simple "
            "game to see how good (or bad) you are at it.",
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 12),
          Text(
            "We'll show you five colors, then you'll try and recreate them.",
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              ElevatedButton(
                onPressed: controller.startGame,
                child: const Text('Start'),
              ),
              const SizedBox(width: 24),
              // Difficulty toggle
              _DifficultyToggle(controller: controller),
            ],
          ),
        ],
      ),
    );
  }
}

/// Animated difficulty toggle matching the original site's pill style.
class _DifficultyToggle extends StatelessWidget {
  final GameController controller;

  const _DifficultyToggle({required this.controller});

  @override
  Widget build(BuildContext context) {
    final isHard = controller.difficulty == Difficulty.hard;
    // Need to import Difficulty — it's re-exported through controller
    return GestureDetector(
      onTap: controller.toggleDifficulty,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isHard
                      ? Colors.orangeAccent.withOpacity(0.6)
                      : Colors.white.withOpacity(0.2),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment:
                      isHard ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 16,
                    height: 16,
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                controller.difficulty.label,
                style: AppTextStyles.difficultyToggle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
