import 'package:flutter/material.dart';

enum CombatButtonMode {
  fire,
  unlockDoor,
  lockedDoor,
}

/// Ultra-HD Floating Action Button for discharging silenced takedowns, weapon fire,
/// and dynamically adapting to unlock/lock blast doors when in front of room entrances.
class CombatFireButton extends StatelessWidget {
  final VoidCallback onTap;
  final CombatButtonMode mode;

  const CombatFireButton({
    super.key,
    required this.onTap,
    this.mode = CombatButtonMode.fire,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors;
    Color glowColor;
    IconData icon;
    String label;

    switch (mode) {
      case CombatButtonMode.unlockDoor:
        gradientColors = const [
          Color(0xFF80E27E),
          Color(0xFF00E676),
          Color(0xFF00A152),
          Color(0xFF004D20),
        ];
        glowColor = const Color(0xFF00E676);
        icon = Icons.lock_open;
        label = 'UNLOCK';
        break;
      case CombatButtonMode.lockedDoor:
        gradientColors = const [
          Color(0xFFFFB74D),
          Color(0xFFFF9800),
          Color(0xFFE65100),
          Color(0xFF5D2400),
        ];
        glowColor = const Color(0xFFFF9800);
        icon = Icons.lock;
        label = 'LOCKED';
        break;
      case CombatButtonMode.fire:
        gradientColors = const [
          Color(0xFFFF8A80),
          Color(0xFFFF1744),
          Color(0xFFB71C1C),
          Color(0xFF4A0000),
        ];
        glowColor = const Color(0xFFFF1744);
        icon = Icons.gps_fixed;
        label = 'FIRE';
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 78,
        height: 78,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: const Alignment(-0.25, -0.3),
            radius: 0.85,
            colors: gradientColors,
          ),
          border: Border.all(color: Colors.white, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: glowColor.withValues(alpha: 0.65),
              blurRadius: 18,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 1),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 10,
                fontFamily: 'monospace',
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

