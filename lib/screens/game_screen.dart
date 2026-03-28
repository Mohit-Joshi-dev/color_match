import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart';
import '../core/theme.dart';
import '../core/app_text_styles.dart';
import '../models/game_state.dart';
import '../state/game_controller.dart';
import '../widgets/start_view.dart';
import '../widgets/memorize_view.dart';
import '../widgets/reconstruct_view.dart';
import '../widgets/round_result_view.dart';
import '../widgets/end_view.dart';

/// Root game screen — owns the [GameController] and renders the shell
/// (glow border, header, central card, footer).
///
/// Delegates the card interior to the appropriate view widget via
/// [AnimatedSwitcher].
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _controller = GameController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onStateChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_onStateChange);
    _controller.dispose();
    super.dispose();
  }

  void _onStateChange() => setState(() {});

  // ── View Router ─────────────────────────────────────────────────────────

  Widget _buildPhaseView() {
    switch (_controller.phase) {
      case GamePhase.menu:
        return StartView(controller: _controller);
      case GamePhase.memorize:
        return MemorizeView(controller: _controller);
      case GamePhase.reconstruct:
        return ReconstructView(controller: _controller);
      case GamePhase.roundResult:
        return RoundResultView(controller: _controller);
      case GamePhase.endGame:
        return EndView(controller: _controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final glowColor = AppTheme.glowColor(brightness);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // ── Background glow ─────────────────────────────────────────────
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: glowColor,
                    blurRadius: 150,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // ── Header ──────────────────────────────────────────────────────
          Positioned(
            top: 32,
            left: 32,
            child: Text('Colors.', style: AppTextStyles.logoStyle),
          ),

          // ── Central game card ───────────────────────────────────────────
          Center(
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium ??
                  const TextStyle(color: Colors.white),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: GameConstants.cardMaxWidth,
                  minHeight: GameConstants.cardMinHeight,
                  maxHeight: math.max(
                    GameConstants.cardMinHeight,
                    screenSize.height * GameConstants.cardHeightFraction,
                  ),
                ),
                width: screenSize.width * GameConstants.cardWidthFraction,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius:
                      BorderRadius.circular(GameConstants.cardBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: KeyedSubtree(
                    key: ValueKey<GamePhase>(_controller.phase),
                    child: _buildPhaseView(),
                  ),
                ),
              ),
            ),
          ),

          // ── Footer ──────────────────────────────────────────────────────
          Positioned(
            bottom: 32,
            left: 32,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  final url = Uri.parse('https://dialed.gg');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: Text(
                  'inspired by dialed.gg',
                  style: AppTextStyles.logoStyle.copyWith(
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
