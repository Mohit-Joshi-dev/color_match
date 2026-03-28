import 'dart:math';
import 'package:flutter/material.dart';
import 'constants.dart';

/// Pure utility functions for color math — no Flutter state, no side effects.
class ColorUtils {
  ColorUtils._();

  // ── Scoring ─────────────────────────────────────────────────────────────

  /// Calculates a score between 0.00 and 10.00 based on Euclidean distance
  /// in RGB space between [target] and [guess].
  static double calculateScore(Color target, Color guess) {
    final rDiff = (target.red - guess.red).toDouble();
    final gDiff = (target.green - guess.green).toDouble();
    final bDiff = (target.blue - guess.blue).toDouble();

    final distance = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff);
    final score =
        GameConstants.maxScore *
        (1.0 - distance / GameConstants.maxScoringDistance);

    return score.clamp(0.0, GameConstants.maxScore);
  }

  // ── Contrast ────────────────────────────────────────────────────────────

  /// Returns a high-contrast text color (black or white) based on the background
  static Color applyContrast(Color background, {double opacity = 1.0}) {
    final baseColor = background.computeLuminance() > 0.4
        ? Colors.black
        : Colors.white;
    return baseColor.withOpacity(opacity);
  }

  // ── Color Generation ────────────────────────────────────────────────────

  /// Generates [count] random HSV colors with good visual distribution.
  static List<HSVColor> generateTargetColors(int count, [Random? rng]) {
    final random = rng ?? Random();
    return List.generate(count, (_) {
      final h = random.nextDouble() * 360;
      final s =
          GameConstants.minSaturation +
          random.nextDouble() * (1.0 - GameConstants.minSaturation);
      final v =
          GameConstants.minValue +
          random.nextDouble() * (1.0 - GameConstants.minValue);
      return HSVColor.fromAHSV(1.0, h, s, v);
    });
  }

  // ── Gradient Helpers ────────────────────────────────────────────────────

  /// Full‑spectrum hue rainbow for the hue slider (7 stops, 0°→360°).
  static List<Color> get hueGradientColors {
    return List.generate(7, (i) {
      return HSVColor.fromAHSV(1.0, (i * 60.0) % 360, 1.0, 1.0).toColor();
    });
  }

  /// Two‑stop gradient for the saturation slider.
  static List<Color> saturationGradient(double hue, double value) {
    return [
      HSVColor.fromAHSV(1.0, hue, 0.0, value).toColor(),
      HSVColor.fromAHSV(1.0, hue, 1.0, value).toColor(),
    ];
  }

  /// Two‑stop gradient for the brightness slider.
  static List<Color> brightnessGradient(double hue, double saturation) {
    return [
      HSVColor.fromAHSV(1.0, hue, saturation, 0.0).toColor(),
      HSVColor.fromAHSV(1.0, hue, saturation, 1.0).toColor(),
    ];
  }

  // ── HSV Display ─────────────────────────────────────────────────────────

  /// Formats an HSVColor as "H123 S45 B67" (matching dialed.gg style).
  static String formatHSV(HSVColor color) {
    final h = color.hue.round();
    final s = (color.saturation * 100).round();
    final b = (color.value * 100).round();
    return 'H$h S$s B$b';
  }

  // ── Feedback Messages ───────────────────────────────────────────────────

  /// Returns a witty message for the final average score.
  static String getScoreMessage(double averageScore) {
    if (averageScore >= 9.8) return FeedbackMessages.finalGodlike;
    if (averageScore >= 9.5) return FeedbackMessages.finalPerfect;
    if (averageScore >= 9.0) return FeedbackMessages.finalAmazing;
    if (averageScore >= 8.0) return FeedbackMessages.finalGreat;
    if (averageScore >= 7.0) return FeedbackMessages.finalGoodPlus;
    if (averageScore >= 6.0) return FeedbackMessages.finalGood;
    if (averageScore >= 5.0) return FeedbackMessages.finalAverage;
    if (averageScore >= 4.0) return FeedbackMessages.finalOkay;
    if (averageScore >= 2.0) return FeedbackMessages.finalPoor;
    return FeedbackMessages.finalBad;
  }

  /// Returns a witty per‑round message based on the individual round score.
  static String getRoundMessage(double score) {
    if (score >= 9.8) return FeedbackMessages.roundGodlike;
    if (score >= 9.5) return FeedbackMessages.roundPerfect;
    if (score >= 9.0) return FeedbackMessages.roundAmazing;
    if (score >= 8.5) return FeedbackMessages.roundGreat;
    if (score >= 8.0) return FeedbackMessages.roundGoodPlus;
    if (score >= 7.0) return FeedbackMessages.roundGood;
    if (score >= 6.0) return FeedbackMessages.roundAverage;
    if (score >= 5.0) return FeedbackMessages.roundOkay;
    if (score >= 4.0) return FeedbackMessages.roundPoor;
    if (score >= 3.0) return FeedbackMessages.roundBad;
    if (score >= 2.0) return FeedbackMessages.roundTerrible;
    if (score >= 1.0) return FeedbackMessages.roundAwful;
    return FeedbackMessages.roundAbysmal;
  }
}
