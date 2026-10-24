import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../services/game_manager.dart';
import '../models/mission.dart';
import 'game_viewport_screen.dart';

/// Ultra-HD Mission Briefing Screen:
/// Classified dossier presentation, frosted glassmorphism card,
/// high-definition illustrated cutscene art, and glowing tactile softkeys.
class MissionBriefingScreen extends StatelessWidget {
  final GameManager gameManager;
  final Mission mission;

  const MissionBriefingScreen({
    super.key,
    required this.gameManager,
    required this.mission,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E15),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                child: Column(
                  children: [
                    // Classified Header Tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF1744).withValues(alpha: 0.15),
                        border: Border.all(color: const Color(0xFFFF1744), width: 1.5),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF1744).withValues(alpha: 0.25),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.lock, color: Color(0xFFFF1744), size: 14),
                          SizedBox(width: 6),
                          Text(
                            'CLASSIFIED DOSSIER // EYES ONLY',
                            style: TextStyle(
                              color: Color(0xFFFF1744),
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Mission Title
                    Text(
                      mission.title.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'monospace',
                        letterSpacing: 1.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SECTOR: ${mission.location.toUpperCase()}',
                      style: const TextStyle(
                        color: Color(0xFF00E5FF),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 24),

                    // High-Definition Illustrated Cutscene Window
                    Container(
                      width: 260,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.7), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00E5FF).withValues(alpha: 0.25),
                            blurRadius: 16,
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.8),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomPaint(
                          painter: _HDBriefingIllustrationPainter(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Story Narrative Dossier Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF141D29).withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.12), width: 1.2),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.description, color: Color(0xFFFFB74D), size: 16),
                                  SizedBox(width: 8),
                                  Text(
                                    'MISSION INTEL SYNOPSIS:',
                                    style: TextStyle(
                                      color: Color(0xFFFFB74D),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Ramon Spectre, an elite contract assassin, awakens in a snow-covered perimeter yard with acute memory loss. On a reinforced blast barrier nearby, the insignia reads "GM Siberian Department". Avoid alert cones, eliminate guards silently, and exfiltrate.',
                                style: TextStyle(
                                  color: Color(0xFFECEFF1),
                                  fontSize: 13,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              const SizedBox(height: 14),
                              const Divider(color: Color(0xFF263238), height: 1),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'CONTRACT BOUNTY:',
                                    style: TextStyle(
                                      color: Color(0xFF90A4AE),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                  Text(
                                    '\$${mission.rewardCurrency}',
                                    style: const TextStyle(
                                      color: Color(0xFF00E676),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Ultra-HD Softkeys Bar (DEPLOY / MENU)
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF0F141C),
                border: Border(top: BorderSide(color: Color(0xFF263238), width: 1.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Deploy Action
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => GameViewportScreen(
                            gameManager: gameManager,
                            mission: mission,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF00E5FF),
                            Color(0xFF00B0FF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00E5FF).withValues(alpha: 0.4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.play_arrow, color: Colors.black, size: 20),
                          SizedBox(width: 6),
                          Text(
                            'DEPLOY AGENT',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'monospace',
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Menu Action
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFF455A64)),
                      ),
                      child: const Text(
                        'RETURN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HDBriefingIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Atmospheric Siberian sky with gradient
    final skyPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(0, h * 0.65),
        [const Color(0xFF37474F), const Color(0xFF607D8B), const Color(0xFF90A4AE)],
      );
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.65), skyPaint);

    // Snow ground with cold blue ambient reflection
    final groundPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, h * 0.65),
        Offset(0, h),
        [const Color(0xFFECEFF1), const Color(0xFFCFD8DC)],
      );
    canvas.drawRect(Rect.fromLTWH(0, h * 0.65, w, h * 0.35), groundPaint);

    // Distant mountain peaks
    final mtnPath = Path()
      ..moveTo(0, h * 0.65)
      ..lineTo(w * 0.25, h * 0.42)
      ..lineTo(w * 0.55, h * 0.56)
      ..lineTo(w * 0.82, h * 0.38)
      ..lineTo(w, h * 0.52)
      ..lineTo(w, h * 0.65)
      ..close();
    canvas.drawPath(mtnPath, Paint()..color = const Color(0xFF455A64));

    // Ramon Spectre kneeling in snow (Tactical silhouette)
    final bodyPaint = Paint()..color = const Color(0xFF1E2836);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.55, h * 0.62), width: 44, height: 50),
      bodyPaint,
    );

    // Head clutching pose
    canvas.drawCircle(Offset(w * 0.49, h * 0.38), 14, Paint()..color = const Color(0xFF0F172A));
    // Muscular arm reaching to head
    final armPath = Path()
      ..moveTo(w * 0.58, h * 0.50)
      ..lineTo(w * 0.41, h * 0.42)
      ..lineTo(w * 0.45, h * 0.35)
      ..close();
    canvas.drawPath(armPath, Paint()..color = const Color(0xFFB48560));

    // Glowing night-vision ocular red dot
    canvas.drawCircle(Offset(w * 0.53, h * 0.38), 2.5, Paint()..color = const Color(0xFFFF1744));
    canvas.drawCircle(
      Offset(w * 0.53, h * 0.38),
      6.0,
      Paint()
        ..color = const Color(0xFFFF1744).withValues(alpha: 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // Snow flurry particles
    final snowDot = Paint()..color = Colors.white.withValues(alpha: 0.9);
    final dots = [
      Offset(w * 0.12, h * 0.20),
      Offset(w * 0.32, h * 0.12),
      Offset(w * 0.72, h * 0.26),
      Offset(w * 0.86, h * 0.42),
      Offset(w * 0.24, h * 0.68),
      Offset(w * 0.65, h * 0.76),
    ];
    for (final d in dots) {
      canvas.drawCircle(d, 1.8, snowDot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
