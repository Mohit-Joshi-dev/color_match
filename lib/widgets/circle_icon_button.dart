import 'package:flutter/material.dart';

/// A circular icon button matching the dialed.gg aesthetic.
///
/// Supports active (gradient border), disabled (dimmed), and default states.
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final bool isDisabled;
  final VoidCallback? onTap;
  final double size;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.isActive = false,
    this.isDisabled = false,
    this.onTap,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isActive
        ? Colors.white
        : isDisabled
            ? Colors.white30
            : Colors.white54;

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: MouseRegion(
        cursor: isDisabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1),
            gradient: isActive
                ? const SweepGradient(
                    colors: [
                      Color(0xFFFF7B00),
                      Color(0xFFFF007B),
                      Color(0xFF7B00FF),
                      Color(0xFF007BFF),
                      Color(0xFF00FF7B),
                      Color(0xFFFF7B00),
                    ],
                  )
                : null,
          ),
          child: isActive
              ? Center(
                  child: Container(
                    width: size - 4,
                    height: size - 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                    ),
                    child: Icon(icon, color: iconColor, size: size * 0.5),
                  ),
                )
              : Icon(icon, color: iconColor, size: size * 0.5),
        ),
      ),
    );
  }
}
