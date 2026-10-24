import 'package:flutter/material.dart';

/// Ultra-HD Tactical Noise Maker Button for creating acoustic distractions and luring guards.
class NoiseMakerButton extends StatelessWidget {
  final VoidCallback onTap;

  const NoiseMakerButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78,
        height: 78,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            center: Alignment(-0.25, -0.3),
            radius: 0.85,
            colors: [
              Color(0xFFFFCC80),
              Color(0xFFFF9800),
              Color(0xFFE65100),
              Color(0xFF3E2723),
            ],
          ),
          border: Border.all(color: Colors.white, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF9800).withValues(alpha: 0.6),
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
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.surround_sound, color: Colors.white, size: 34),
            SizedBox(height: 1),
            Text(
              'NOISE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 11,
                fontFamily: 'monospace',
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
