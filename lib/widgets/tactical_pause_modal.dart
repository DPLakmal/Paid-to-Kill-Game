import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Tactical Pause Overlay Modal with frosted glassmorphism and holographic styling.
class TacticalPauseModal extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onRestart;
  final VoidCallback onAbort;

  const TacticalPauseModal({
    super.key,
    required this.onResume,
    required this.onRestart,
    required this.onAbort,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          color: Colors.black.withValues(alpha: 0.75),
          child: Center(
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF182230).withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.7), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withValues(alpha: 0.25),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pause_circle_filled, color: Color(0xFF00E5FF), size: 22),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'TACTICAL PAUSE',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            letterSpacing: 1.5,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      backgroundColor: const Color(0xFF00E5FF),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'monospace',
                      ),
                    ),
                    onPressed: onResume,
                    child: const Text('RESUME MISSION'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white54, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    onPressed: onRestart,
                    child: const Text('RESTART SECTOR'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      foregroundColor: const Color(0xFFFF5252),
                      side: const BorderSide(color: Color(0xFFFF5252), width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                    onPressed: onAbort,
                    child: const Text('ABORT TO MENU'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
