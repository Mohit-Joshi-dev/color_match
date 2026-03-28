/// The current phase of the game loop.
enum GamePhase {
  menu,
  memorize,
  reconstruct,
  roundResult,
  endGame,
}

/// Difficulty level, affecting memorization timer duration.
enum Difficulty {
  easy,
  hard;

  /// Human‑readable label for the UI.
  String get label => this == easy ? 'Easy' : 'Hard';

  /// Toggle to the other difficulty.
  Difficulty get toggled => this == easy ? hard : easy;
}
