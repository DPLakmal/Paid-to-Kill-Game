import 'package:flutter/material.dart';

/// Reusable virtual D-Pad control matching classic mid-2000s phone gaming
class VirtualDpad extends StatelessWidget {
  final ValueChanged<Offset> onDirectionChanged;

  const VirtualDpad({super.key, required this.onDirectionChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24, width: 1.5),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Up
          Positioned(
            top: 4,
            child: GestureDetector(
              onTapDown: (_) => onDirectionChanged(const Offset(0, -1)),
              onTapUp: (_) => onDirectionChanged(Offset.zero),
              child: const Icon(Icons.arrow_drop_up, color: Colors.white70, size: 36),
            ),
          ),
          // Down
          Positioned(
            bottom: 4,
            child: GestureDetector(
              onTapDown: (_) => onDirectionChanged(const Offset(0, 1)),
              onTapUp: (_) => onDirectionChanged(Offset.zero),
              child: const Icon(Icons.arrow_drop_down, color: Colors.white70, size: 36),
            ),
          ),
          // Left
          Positioned(
            left: 4,
            child: GestureDetector(
              onTapDown: (_) => onDirectionChanged(const Offset(-1, 0)),
              onTapUp: (_) => onDirectionChanged(Offset.zero),
              child: const Icon(Icons.arrow_left, color: Colors.white70, size: 36),
            ),
          ),
          // Right
          Positioned(
            right: 4,
            child: GestureDetector(
              onTapDown: (_) => onDirectionChanged(const Offset(1, 0)),
              onTapUp: (_) => onDirectionChanged(Offset.zero),
              child: const Icon(Icons.arrow_right, color: Colors.white70, size: 36),
            ),
          ),
          // Center dot
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Colors.white30,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
