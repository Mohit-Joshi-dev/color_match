import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A custom vertical slider rendered as a gradient track with a draggable thumb.
///
/// Used for Hue, Saturation, and Brightness channels. Supports multi‑stop
/// gradients and reports values in 0.0–1.0 range (bottom = 0, top = 1).
class VerticalColorSlider extends StatelessWidget {
  /// The gradient colors painted bottom → top.
  final List<Color> gradientColors;

  /// Current value in [0.0, 1.0].
  final double value;

  /// Called when the user drags to a new value.
  final ValueChanged<double> onChanged;

  /// Thumb diameter.
  final double thumbSize;

  const VerticalColorSlider({
    super.key,
    required this.gradientColors,
    required this.value,
    required this.onChanged,
    this.thumbSize = 24.0,
  });

  void _handlePointer(Offset localPosition, double trackHeight) {
    final dy = localPosition.dy;
    final normalized = 1.0 - (dy / trackHeight); // top = 1, bottom = 0
    onChanged(normalized.clamp(0.0, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackHeight = constraints.maxHeight;
        final trackWidth = constraints.maxWidth;
        final halfThumb = thumbSize / 2;

        return MouseRegion(
          cursor: SystemMouseCursors.grab,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanDown: (d) => _handlePointer(d.localPosition, trackHeight),
            onPanUpdate: (d) => _handlePointer(d.localPosition, trackHeight),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: gradientColors,
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: (trackHeight * value - halfThumb)
                        .clamp(0.0, trackHeight - thumbSize),
                    left: (trackWidth - thumbSize) / 2,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
