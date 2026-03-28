import 'package:flutter/material.dart';
import '../core/app_text_styles.dart';
import '../state/game_controller.dart';
import 'circle_icon_button.dart';

/// Final game‑over screen showing the average score and a witty message.
class EndView extends StatelessWidget {
  final GameController controller;

  const EndView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final avgScore = controller.averageScore;
    final message = controller.scoreMessage;

    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('result', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 8),
          Text(
            avgScore.toStringAsFixed(2),
            style: AppTextStyles.finalScoreValue,
          ),
          const SizedBox(height: 16),
          Text(message, style: AppTextStyles.subtitle.copyWith(fontSize: 20)),
          const SizedBox(height: 48),
          CircleIconButton(
            icon: Icons.refresh,
            isActive: true,
            onTap: controller.returnToMenu,
          ),
        ],
      ),
    );
  }
}
