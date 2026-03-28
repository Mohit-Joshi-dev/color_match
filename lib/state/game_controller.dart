import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import '../core/constants.dart';
import '../core/color_utils.dart';
import '../models/game_state.dart';
import '../models/round_data.dart';

/// Central game state controller.
///
/// Owns all mutable game state and exposes methods for UI actions.
/// Widgets listen via [ListenableBuilder] — no external packages needed.
class GameController extends ChangeNotifier {
  // ── Phase & Config ──────────────────────────────────────────────────────

  GamePhase _phase = GamePhase.menu;
  GamePhase get phase => _phase;

  Difficulty _difficulty = Difficulty.easy;
  Difficulty get difficulty => _difficulty;

  // ── Round Tracking ──────────────────────────────────────────────────────

  int _currentRound = 0;
  int get currentRound => _currentRound;
  int get maxRounds => GameConstants.maxRounds;

  List<RoundData> _rounds = [];
  List<RoundData> get rounds => List.unmodifiable(_rounds);

  // ── Current Guess (slider values) ───────────────────────────────────────

  double _hue = 180.0;
  double get hue => _hue;

  double _saturation = 0.5;
  double get saturation => _saturation;

  double _brightness = 0.5;
  double get brightness => _brightness;

  // ── Computed Getters ────────────────────────────────────────────────────

  /// The target color for the current round.
  HSVColor get currentTarget => _rounds[_currentRound - 1].target;

  /// The color the user is currently dialing in.
  HSVColor get currentGuessColor =>
      HSVColor.fromAHSV(1.0, _hue, _saturation, _brightness);

  /// Timer duration for the memorize phase based on difficulty.
  int get timerDurationMs => _difficulty == Difficulty.easy
      ? GameConstants.easyTimerMs
      : GameConstants.hardTimerMs;

  /// Average score across all completed rounds.
  double get averageScore {
    final scored = _rounds.where((r) => r.isCompleted);
    if (scored.isEmpty) return 0.0;
    return scored.map((r) => r.score!).reduce((a, b) => a + b) / scored.length;
  }

  /// Witty feedback message based on final average.
  String get scoreMessage => ColorUtils.getScoreMessage(averageScore);

  /// The most recently completed round's data (for the result view).
  RoundData get lastCompletedRound => _rounds[_currentRound - 1];

  // ── Actions ─────────────────────────────────────────────────────────────

  /// Toggles between Easy and Hard.
  void toggleDifficulty() {
    _difficulty = _difficulty.toggled;
    notifyListeners();
  }

  /// Starts a new game: generates targets, resets state, enters round 1.
  void startGame() {
    final targets = ColorUtils.generateTargetColors(GameConstants.maxRounds);
    _rounds = targets.map((t) => RoundData(target: t)).toList();
    _currentRound = 0;
    _advanceToNextRound();
  }

  /// Called when the memorize timer expires.
  void onMemorizeDone() {
    // Randomize starting slider position so the player can't just "not move"
    final random = Random();
    _hue = random.nextDouble() * 360;
    _saturation = 0.5;
    _brightness = 0.5;
    _phase = GamePhase.reconstruct;
    notifyListeners();
  }

  /// Updates a single slider axis. Called rapidly during drag.
  void updateHue(double value) {
    _hue = (value * 360).clamp(0.0, 360.0);
    notifyListeners();
  }

  void updateSaturation(double value) {
    _saturation = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  void updateBrightness(double value) {
    _brightness = value.clamp(0.0, 1.0);
    notifyListeners();
  }

  /// Submits the current slider values as the player's guess.
  void submitGuess() {
    final guess = currentGuessColor;
    final target = currentTarget;
    final score = ColorUtils.calculateScore(
      target.toColor(),
      guess.toColor(),
    );

    _rounds[_currentRound - 1] = _rounds[_currentRound - 1].withResult(guess, score);
    _phase = GamePhase.roundResult;
    notifyListeners();
  }

  /// Advances to the next round or ends the game.
  void nextRound() {
    if (_currentRound < GameConstants.maxRounds) {
      _advanceToNextRound();
    } else {
      _phase = GamePhase.endGame;
      notifyListeners();
    }
  }

  /// Returns to the main menu.
  void returnToMenu() {
    _phase = GamePhase.menu;
    notifyListeners();
  }

  // ── Private ─────────────────────────────────────────────────────────────

  void _advanceToNextRound() {
    _currentRound++;
    _phase = GamePhase.memorize;
    notifyListeners();
  }
}
