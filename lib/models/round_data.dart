import 'package:flutter/painting.dart';

/// Immutable data for a single round of the game.
class RoundData {
  /// The color the player must memorize and recreate.
  final HSVColor target;

  /// The color the player guessed (null until submitted).
  final HSVColor? guess;

  /// The score for this round (null until scored).
  final double? score;

  const RoundData({
    required this.target,
    this.guess,
    this.score,
  });

  /// Returns a copy with [guess] and [score] filled in.
  RoundData withResult(HSVColor guess, double score) {
    return RoundData(target: target, guess: guess, score: score);
  }

  /// Whether this round has been completed.
  bool get isCompleted => guess != null && score != null;
}
