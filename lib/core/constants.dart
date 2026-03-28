/// Central configuration constants for the Color Game.
///
/// All magic numbers live here so they can be tuned in one place.
class GameConstants {
  GameConstants._(); // prevent instantiation

  // ── Rounds ──────────────────────────────────────────────────────────────
  static const int maxRounds = 5;

  // ── Timer (milliseconds) ────────────────────────────────────────────────
  static const int easyTimerMs = 4000;
  static const int hardTimerMs = 2000;

  // ── Scoring ─────────────────────────────────────────────────────────────
  /// Maximum RGB Euclidean distance that still scores > 0.
  /// Lower values make the game harder (less forgiving).
  static const double maxScoringDistance = 120.0;

  /// Perfect score value.
  static const double maxScore = 10.0;

  // ── Color Generation ────────────────────────────────────────────────────
  /// Minimum saturation for generated targets (avoids washed‑out grays).
  static const double minSaturation = 0.30;

  /// Minimum value/brightness for generated targets (avoids near‑black).
  static const double minValue = 0.30;

  // ── Layout ──────────────────────────────────────────────────────────────
  static const double cardBorderRadius = 32.0;
  static const double cardMaxWidth = 700.0;
  static const double cardMinHeight = 450.0;
  static const double cardHeightFraction = 0.65;
  static const double cardWidthFraction = 0.90;
}

/// Constant text snippets used for player review and feedback.
class FeedbackMessages {
  FeedbackMessages._();

  // ── Final Game Average Score ───────────────────────────────────────────
  static const String finalGodlike = 'Hex code whisperer.';
  static const String finalPerfect = 'Human spectrophotometer.';
  static const String finalAmazing = 'Uncanny valley of color perception.';
  static const String finalGreat = 'Impressive. Very impressive.';
  static const String finalGoodPlus = 'You definitely know what a primary color is.';
  static const String finalGood = 'Pretty good!';
  static const String finalAverage = 'Average. Just aggressively average.';
  static const String finalOkay = 'Not bad.';
  static const String finalPoor = 'Have you considered a career outside of design?';
  static const String finalBad = "Blame the monitor. We both know it's not the monitor.";

  // ── Individual Round Score ──────────────────────────────────────────────
  static const String roundGodlike = 'Flawless victory.';
  static const String roundPerfect = 'Nailed it.';
  static const String roundAmazing = 'Practically identical.';
  static const String roundGreat = 'So close!';
  static const String roundGoodPlus = "I'll accept it.";
  static const String roundGood = 'Not bad at all.';
  static const String roundAverage = 'Acceptable variance.';
  static const String roundOkay = 'Could be worse.';
  static const String roundPoor = 'Did you slip?';
  static const String roundBad = 'A colorblind dog would\nhave gotten closer.';
  static const String roundTerrible = 'This is a different color entirely.';
  static const String roundAwful = "Were you even looking?";
  static const String roundAbysmal = "That's impressively bad.";
}
