import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Ultra-HD Tactical Comms Dialogue Card:
/// Frosted glassmorphism background, glowing holographic cyan border,
/// encrypted radio frequency telemetry, speaker rank badges, and crisp high-definition avatars.
class RetroDialogueBox extends StatelessWidget {
  final String speakerName;
  final String dialogueText;
  final String avatarType; // 'falkov', 'ramon'
  final VoidCallback? onDismiss;

  const RetroDialogueBox({
    super.key,
    required this.speakerName,
    required this.dialogueText,
    this.avatarType = 'falkov',
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final isRamon = avatarType == 'ramon';
    final isGuard = avatarType == 'guard';
    final accentColor = isRamon
        ? const Color(0xFFFF9800)
        : isGuard
            ? const Color(0xFF64B5F6)
            : const Color(0xFF00E5FF);

    return GestureDetector(
      onTap: onDismiss,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF161F2C).withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.8),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.25),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  offset: const Offset(0, 6),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top telemetry status bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isRamon ? const Color(0xFFFF9800) : const Color(0xFF00E5FF),
                            boxShadow: [
                              BoxShadow(
                                color: isRamon ? const Color(0xFFFF9800) : const Color(0xFF00E5FF),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'ENCRYPTED COMM // FREQ: 142.85 MHz',
                          style: TextStyle(
                            color: const Color(0xFF90A4AE),
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'SECURE',
                        style: TextStyle(
                          color: Color(0xFF00E676),
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Main dialogue body with HD portrait
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HD Avatar Container
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isRamon ? const Color(0xFFFFB74D) : const Color(0xFF80DEEA),
                          width: 1.5,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isRamon
                              ? [const Color(0xFF3E2723), const Color(0xFF1B0000)]
                              : [const Color(0xFF00363A), const Color(0xFF001E26)],
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.5),
                        child: CustomPaint(
                          painter: _HDAvatarPainter(avatarType: avatarType),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Speaker Name & Speech Body
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                speakerName.toUpperCase(),
                                style: TextStyle(
                                  color: isRamon ? const Color(0xFFFFB74D) : const Color(0xFF80DEEA),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'monospace',
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isRamon
                                    ? '[ASSASSIN]'
                                    : isGuard
                                        ? '[SECURITY GUARD]'
                                        : '[INTEL SPECIALIST]',
                                style: const TextStyle(
                                  color: Color(0xFF78909C),
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            dialogueText,
                            style: const TextStyle(
                              color: Color(0xFFECEFF1),
                              fontSize: 13,
                              height: 1.35,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Tap to continue prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'TAP TO PROCEED ▶',
                      style: TextStyle(
                        color: (isRamon ? const Color(0xFFFF9800) : const Color(0xFF00E5FF)).withValues(alpha: 0.8),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HDAvatarPainter extends CustomPainter {
  final String avatarType;
  _HDAvatarPainter({required this.avatarType});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    if (avatarType == 'falkov') {
      // Falkov (Tactical handler with blonde hair and optical HUD glasses)
      final facePaint = Paint()..color = const Color(0xFFE5A968);
      canvas.drawCircle(Offset(w * 0.5, h * 0.55), w * 0.32, facePaint);

      // Blonde hair styled with specular highlights
      final hairPaint = Paint()..color = const Color(0xFFFFD54F);
      canvas.drawArc(
        Rect.fromCircle(center: Offset(w * 0.5, h * 0.45), radius: w * 0.36),
        3.14,
        3.14,
        true,
        hairPaint,
      );

      // Glasses with glowing cyan optical frames
      final glassesPaint = Paint()
        ..color = const Color(0xFF00E5FF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.20, h * 0.44, w * 0.26, h * 0.16), const Radius.circular(3)),
        glassesPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.54, h * 0.44, w * 0.26, h * 0.16), const Radius.circular(3)),
        glassesPaint,
      );

      // White optical reflection glare
      final glarePaint = Paint()..color = Colors.white.withValues(alpha: 0.9);
      canvas.drawRect(Rect.fromLTWH(w * 0.24, h * 0.47, w * 0.18, h * 0.08), glarePaint);
      canvas.drawRect(Rect.fromLTWH(w * 0.58, h * 0.47, w * 0.18, h * 0.08), glarePaint);
    } else if (avatarType == 'guard') {
      // Security Guard (Front-facing reference: blue beret with gold badge, stern face, steel blue blazer, white shirt, dark tie)
      // 1. Steel Blue Uniform Jacket & Shoulders
      final jacketPaint = Paint()..color = const Color(0xFF355278);
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.12, h * 0.70, w * 0.76, h * 0.30), const Radius.circular(8)),
        jacketPaint,
      );
      // White shirt collar V-neck
      final shirtPath = Path()
        ..moveTo(w * 0.38, h * 0.70)
        ..lineTo(w * 0.50, h * 0.88)
        ..lineTo(w * 0.62, h * 0.70)
        ..close();
      canvas.drawPath(shirtPath, Paint()..color = Colors.white);
      // Dark formal necktie
      final tiePath = Path()
        ..moveTo(w * 0.46, h * 0.76)
        ..lineTo(w * 0.54, h * 0.76)
        ..lineTo(w * 0.52, h * 0.98)
        ..lineTo(w * 0.48, h * 0.98)
        ..close();
      canvas.drawPath(tiePath, Paint()..color = const Color(0xFF141920));

      // 2. Face & Hair
      final facePaint = Paint()..color = const Color(0xFFD4A373);
      canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.5, h * 0.50), width: w * 0.44, height: h * 0.42), facePaint);
      // Dark brown hair trim
      final hairPaint = Paint()..color = const Color(0xFF3E2723);
      canvas.drawArc(
        Rect.fromCircle(center: Offset(w * 0.5, h * 0.42), radius: w * 0.23),
        3.14,
        3.14,
        true,
        hairPaint,
      );

      // Stern Eyes & Eyebrows
      final browPaint = Paint()..color = const Color(0xFF26190E)..strokeWidth = 2.0;
      canvas.drawLine(Offset(w * 0.34, h * 0.44), Offset(w * 0.44, h * 0.46), browPaint);
      canvas.drawLine(Offset(w * 0.66, h * 0.44), Offset(w * 0.56, h * 0.46), browPaint);
      canvas.drawCircle(Offset(w * 0.39, h * 0.50), 2.2, Paint()..color = const Color(0xFF1F2937));
      canvas.drawCircle(Offset(w * 0.61, h * 0.50), 2.2, Paint()..color = const Color(0xFF1F2937));

      // 3. Military Blue Beret (Slanted crown draped to the left)
      final beretRect = Rect.fromLTWH(w * 0.22, h * 0.16, w * 0.58, h * 0.28);
      final beretPaint = Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.2, -0.3),
          colors: [
            Color(0xFF5075A6),
            Color(0xFF3B5B82),
            Color(0xFF233852),
          ],
        ).createShader(beretRect);
      canvas.drawOval(beretRect, beretPaint);

      // Gold cap badge on right crown
      canvas.drawCircle(Offset(w * 0.62, h * 0.28), 3.2, Paint()..color = const Color(0xFFF59E0B));
      canvas.drawCircle(Offset(w * 0.62, h * 0.28), 1.6, Paint()..color = const Color(0xFFFDE68A));
    } else {
      // Ramon Spectre (Shadow operative with tactical bandana, scar, and glowing laser eyepiece)
      final facePaint = Paint()..color = const Color(0xFFC48A54);
      canvas.drawCircle(Offset(w * 0.5, h * 0.55), w * 0.32, facePaint);

      // Carbon-black bandana with red edge highlight
      final bandana = Paint()..color = const Color(0xFF1A1A1A);
      canvas.drawRect(Rect.fromLTWH(w * 0.15, h * 0.20, w * 0.70, h * 0.26), bandana);
      final redStripe = Paint()..color = const Color(0xFFFF1744)..strokeWidth = 2.0;
      canvas.drawLine(Offset(w * 0.15, h * 0.45), Offset(w * 0.85, h * 0.45), redStripe);

      // Eye shadow
      canvas.drawCircle(Offset(w * 0.36, h * 0.54), 4.5, Paint()..color = const Color(0xFF0F172A));
      canvas.drawCircle(Offset(w * 0.64, h * 0.54), 4.5, Paint()..color = const Color(0xFF0F172A));

      // Left eye: Intense human eye
      canvas.drawCircle(Offset(w * 0.36, h * 0.54), 2, Paint()..color = Colors.white);
      // Right eye: Glowing night-vision sniper ocular
      canvas.drawCircle(Offset(w * 0.64, h * 0.54), 2.5, Paint()..color = const Color(0xFFFF1744));
      canvas.drawCircle(
        Offset(w * 0.64, h * 0.54),
        5.0,
        Paint()
          ..color = const Color(0xFFFF1744).withValues(alpha: 0.35)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );

      // Facial stubble
      final stubble = Paint()..color = const Color(0xFF5A3E26)..strokeWidth = 1.2;
      for (double i = w * 0.3; i <= w * 0.7; i += 3.5) {
        canvas.drawLine(Offset(i, h * 0.70), Offset(i, h * 0.74), stubble);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _HDAvatarPainter oldDelegate) => oldDelegate.avatarType != avatarType;
}
