import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/bridge_messages.dart';

/// Modern tactical HUD detection pill floating at the top of the map viewport.
/// Matches reference UI with:
/// - Sleek dark glass capsule with soft border
/// - Cyan/Amber/Red status badge with shield icon (e.g. [🛡 QUIET])
/// - "DETECTION:" label
/// - Glossy neon cyan-blue detection gauge bar
/// - Percentage indicator
class TacticalHudPill extends StatelessWidget {
  final AlarmState alarmState;
  final double detectionMeter;

  const TacticalHudPill({
    super.key,
    required this.alarmState,
    required this.detectionMeter,
  });

  Color _getAlarmColor(AlarmState state) {
    switch (state) {
      case AlarmState.quiet:
        return const Color(0xFF00E5FF);
      case AlarmState.suspicious:
        return const Color(0xFFFFB74D);
      case AlarmState.alert:
        return const Color(0xFFFF1744);
      case AlarmState.searching:
        return Colors.orangeAccent;
      case AlarmState.resetting:
        return Colors.amberAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final alarmColor = _getAlarmColor(alarmState);
    final clampedDetection = detectionMeter.clamp(0.0, 1.0);
    final detectionPercent = (clampedDetection * 100).toInt();

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF090E17).withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF26354A).withValues(alpha: 0.85),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Alarm State Badge Pill (e.g. [🛡 QUIET])
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFF031B26),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: alarmColor, width: 1.3),
                  boxShadow: [
                    BoxShadow(
                      color: alarmColor.withValues(alpha: 0.35),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shield, color: alarmColor, size: 12),
                    const SizedBox(width: 5),
                    Text(
                      alarmState.name.toUpperCase(),
                      style: TextStyle(
                        color: alarmColor,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.1,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // Detection label
              const Text(
                'DETECTION:',
                style: TextStyle(
                  color: Color(0xFF90A4AE),
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(width: 8),

              // Modern progress gauge bar with glow
              Expanded(
                child: Container(
                  height: 7,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B2430),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: [
                        FractionallySizedBox(
                          widthFactor: clampedDetection,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: clampedDetection > 0.75
                                    ? [const Color(0xFFFF5252), const Color(0xFFFF1744)]
                                    : (clampedDetection > 0.4
                                        ? [const Color(0xFFFFD54F), const Color(0xFFFF9800)]
                                        : [const Color(0xFF80D8FF), const Color(0xFF00E5FF)]),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: alarmColor.withValues(alpha: 0.6),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Percentage readout
              Text(
                '$detectionPercent%',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
