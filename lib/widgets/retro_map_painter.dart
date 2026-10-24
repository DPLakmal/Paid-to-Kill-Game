import 'package:flutter/material.dart';

/// Accurate custom painter reproducing the classic Paid to Kill (2005) Siberian military outpost:
/// Snow ground, light posts with yellow glow, buildings with flat roof parapets, sliding security doors,
/// GM logo pylons, barbed-wire security fences, footsteps in snow, assassin & guards in top-down view.
class RetroMapPainter extends CustomPainter {
  final Offset playerPos; // relative coordinate 0..1
  final double playerAngle;
  final bool isHidden;
  final bool alertActive;

  RetroMapPainter({
    required this.playerPos,
    this.playerAngle = 0.0,
    this.isHidden = false,
    this.alertActive = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Snow ground base (cold bluish white with subtle gradients)
    final snowPaint = Paint()..color = const Color(0xFFE2EAF2);
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), snowPaint);

    // Subtle shaded cold snow banks / wind sweeps
    final driftPaint = Paint()
      ..color = const Color(0xFFC7D5E5).withValues(alpha: 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(Offset(w * 0.25, h * 0.18), w * 0.35, driftPaint);
    canvas.drawCircle(Offset(w * 0.75, h * 0.65), w * 0.4, driftPaint);

    // Footprints in snow
    _drawFootprints(canvas, w, h);

    // 2. Outer Compound Perimeter Walls
    _drawPerimeterWalls(canvas, w, h);

    // 3. Central & Left Buildings (Sandy beige textured walls with recessed concrete rooftops)
    // Left building
    _drawBuilding(canvas, Rect.fromLTWH(w * 0.14, h * 0.40, w * 0.26, h * 0.35));

    // Right large L-shaped building
    _drawLBuilding(canvas, w, h);

    // Top perimeter wall structure
    _drawTopFacility(canvas, w, h);

    // 4. Barbed wire security fence (middle walkway)
    _drawFence(canvas, Offset(w * 0.25, h * 0.24), Offset(w * 0.50, h * 0.24));

    // 5. Light Towers with warm yellow illumination cones
    _drawLightTower(canvas, Offset(w * 0.36, h * 0.09));
    _drawLightTower(canvas, Offset(w * 0.76, h * 0.09));
    _drawLightTower(canvas, Offset(w * 0.43, h * 0.38));
    _drawLightTower(canvas, Offset(w * 0.63, h * 0.60));

    // 6. Security Pylons with "GM" logo & Security Gates
    _drawPylon(canvas, Offset(w * 0.44, h * 0.72));
    _drawPylon(canvas, Offset(w * 0.49, h * 0.59));

    // Sliding automated blast doors (with green / red sensor indicators)
    _drawBlastDoor(canvas, Offset(w * 0.24, h * 0.73), isGreen: false);
    _drawBlastDoor(canvas, Offset(w * 0.83, h * 0.71), isGreen: true);
    _drawBlastDoor(canvas, Offset(w * 0.55, h * 0.06), isGreen: true);

    // 7. Guards (top-down view: helmet, shoulders, weapon, vision cones)
    // Guard 1: Northern gate patrol
    _drawGuard(canvas, Offset(w * 0.56, h * 0.13), angle: 1.57, isAlert: alertActive);
    // Guard 2: Southern corridor guard
    _drawGuard(canvas, Offset(w * 0.70, h * 0.73), angle: -2.6, isAlert: alertActive);

    // 8. Operative Ramon Spectre (Player)
    if (!isHidden) {
      final px = playerPos.dx * w;
      final py = playerPos.dy * h;
      _drawPlayer(canvas, Offset(px, py), playerAngle);
    }
  }

  void _drawPerimeterWalls(Canvas canvas, double w, double h) {
    final wallPaint = Paint()..color = const Color(0xFFC0B69F);
    final wallStroke = Paint()
      ..color = const Color(0xFF8B836F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Left border wall
    canvas.drawRect(Rect.fromLTWH(0, 0, w * 0.05, h), wallPaint);
    canvas.drawRect(Rect.fromLTWH(0, 0, w * 0.05, h), wallStroke);

    // Outer boundary rim
    final rimPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRect(Rect.fromLTWH(w * 0.03, h * 0.01, w * 0.94, h * 0.82), rimPaint);
  }

  void _drawTopFacility(Canvas canvas, double w, double h) {
    final topWall = Paint()..color = const Color(0xFFC7BDAB);
    canvas.drawRect(Rect.fromLTWH(w * 0.06, 0, w * 0.88, h * 0.08), topWall);

    final edge = Paint()
      ..color = const Color(0xFF8A8272)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(w * 0.06, h * 0.08), Offset(w * 0.94, h * 0.08), edge);
  }

  void _drawBuilding(Canvas canvas, Rect r) {
    // Drop shadow
    canvas.drawRect(
      r.shift(const Offset(4, 4)),
      Paint()..color = const Color(0xFF334455).withValues(alpha: 0.35),
    );

    // Outer concrete bevel / wall
    canvas.drawRect(r, Paint()..color = const Color(0xFFC5BCA9));
    canvas.drawRect(
      r,
      Paint()
        ..color = const Color(0xFF7E7664)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    // Roof white parapet border
    final innerR = r.deflate(5);
    canvas.drawRect(
      innerR,
      Paint()
        ..color = const Color(0xFFECE5D8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Gravel flat rooftop
    canvas.drawRect(
      innerR.deflate(2),
      Paint()..color = const Color(0xFF988F7E),
    );
  }

  void _drawLBuilding(Canvas canvas, double w, double h) {
    final path = Path()
      ..moveTo(w * 0.49, h * 0.21)
      ..lineTo(w * 0.95, h * 0.21)
      ..lineTo(w * 0.95, h * 0.68)
      ..lineTo(w * 0.74, h * 0.68)
      ..lineTo(w * 0.74, h * 0.43)
      ..lineTo(w * 0.49, h * 0.43)
      ..close();

    // Shadow
    canvas.drawPath(
      path.shift(const Offset(5, 5)),
      Paint()..color = const Color(0xFF334455).withValues(alpha: 0.35),
    );

    // Building body
    canvas.drawPath(path, Paint()..color = const Color(0xFFC5BCA9));
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF7E7664)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    // Inner rooftop
    final innerPath = Path()
      ..moveTo(w * 0.51, h * 0.225)
      ..lineTo(w * 0.93, h * 0.225)
      ..lineTo(w * 0.93, h * 0.66)
      ..lineTo(w * 0.76, h * 0.66)
      ..lineTo(w * 0.76, h * 0.415)
      ..lineTo(w * 0.51, h * 0.415)
      ..close();

    canvas.drawPath(
      innerPath,
      Paint()
        ..color = const Color(0xFFEDE8DD)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    canvas.drawPath(innerPath, Paint()..color = const Color(0xFF988F7E));
  }

  void _drawFence(Canvas canvas, Offset p1, Offset p2) {
    final fenceWalk = Paint()..color = const Color(0xFFA69C89);
    canvas.drawRect(Rect.fromPoints(p1 - const Offset(0, 10), p2 + const Offset(0, 6)), fenceWalk);

    // Chainlink cross pattern
    final meshPaint = Paint()
      ..color = const Color(0xFF5A6672)
      ..strokeWidth = 1.2;
    for (double x = p1.dx; x <= p2.dx; x += 6) {
      canvas.drawLine(Offset(x, p1.dy - 8), Offset(x + 4, p1.dy + 4), meshPaint);
      canvas.drawLine(Offset(x + 4, p1.dy - 8), Offset(x, p1.dy + 4), meshPaint);
    }
  }

  void _drawLightTower(Canvas canvas, Offset center) {
    // Pedestal
    final baseRect = Rect.fromCenter(center: center, width: 22, height: 26);
    canvas.drawRect(baseRect, Paint()..color = const Color(0xFFB5AB98));
    canvas.drawRect(
      baseRect,
      Paint()
        ..color = const Color(0xFF554E41)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Yellow halogen lamp glow
    final glowPaint = Paint()
      ..color = const Color(0xFFFFD54F).withValues(alpha: 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
    canvas.drawCircle(center, 22, glowPaint);

    // Dual lamps
    final lampPaint = Paint()..color = const Color(0xFFFFC107);
    canvas.drawCircle(center + const Offset(-4, -6), 3.5, lampPaint);
    canvas.drawCircle(center + const Offset(4, -6), 3.5, lampPaint);
  }

  void _drawPylon(Canvas canvas, Offset pos) {
    final r = Rect.fromCenter(center: pos, width: 20, height: 20);
    canvas.drawRect(r, Paint()..color = const Color(0xFFB7AC99));
    canvas.drawRect(
      r,
      Paint()
        ..color = const Color(0xFF1E3A8A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Blue GM badge
    final badge = Rect.fromCenter(center: pos, width: 14, height: 10);
    canvas.drawRect(badge, Paint()..color = const Color(0xFF1D4ED8));

    // "GM" letters
    final tp = TextPainter(
      text: const TextSpan(
        text: 'GM',
        style: TextStyle(
          color: Colors.white,
          fontSize: 7,
          fontWeight: FontWeight.w900,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
  }

  void _drawBlastDoor(Canvas canvas, Offset pos, {required bool isGreen}) {
    final doorRect = Rect.fromCenter(center: pos, width: 24, height: 16);
    canvas.drawRect(doorRect, Paint()..color = const Color(0xFF888D94));

    // Horizontal ridges
    final ridgePaint = Paint()..color = const Color(0xFF555960)..strokeWidth = 1.2;
    canvas.drawLine(pos - const Offset(10, 3), pos + const Offset(10, -3), ridgePaint);
    canvas.drawLine(pos - const Offset(10, 3), pos + const Offset(10, 3), ridgePaint);

    // Indicator light (green = unlockable / openable, red = locked)
    canvas.drawCircle(
      pos + const Offset(0, -10),
      2.5,
      Paint()..color = isGreen ? const Color(0xFF00E676) : const Color(0xFFFF1744),
    );
  }

  void _drawFootprints(Canvas canvas, double w, double h) {
    final fpPaint = Paint()..color = const Color(0xFF90A4AE).withValues(alpha: 0.5);
    final pts = [
      Offset(w * 0.12, h * 0.77),
      Offset(w * 0.16, h * 0.75),
      Offset(w * 0.20, h * 0.76),
      Offset(w * 0.28, h * 0.76),
      Offset(w * 0.60, h * 0.18),
      Offset(w * 0.62, h * 0.22),
      Offset(w * 0.61, h * 0.26),
      Offset(w * 0.68, h * 0.68),
      Offset(w * 0.69, h * 0.71),
    ];
    for (final p in pts) {
      canvas.drawOval(Rect.fromCenter(center: p, width: 2.5, height: 4), fpPaint);
    }
  }

  void _drawGuard(Canvas canvas, Offset pos, {required double angle, required bool isAlert}) {
    // Translucent vision cone
    final conePaint = Paint()
      ..color = (isAlert ? const Color(0xFFFF3344) : const Color(0xFF3898EC)).withValues(alpha: 0.18);
    final conePath = Path()
      ..moveTo(pos.dx, pos.dy)
      ..arcTo(
        Rect.fromCircle(center: pos, radius: 64),
        angle - 0.45,
        0.9,
        false,
      )
      ..close();
    canvas.drawPath(conePath, conePaint);

    // Guard body (Dark tactical suit with blue beret / helmet)
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(angle);

    // Shoulders
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 14, height: 18),
      Paint()..color = const Color(0xFF263238),
    );
    // Helmet
    canvas.drawCircle(
      Offset.zero,
      5.5,
      Paint()..color = const Color(0xFF1E3A8A),
    );
    // Assault Rifle barrel
    canvas.drawRect(
      const Rect.fromLTWH(3, -1.5, 9, 3),
      Paint()..color = const Color(0xFF111827),
    );

    canvas.restore();
  }

  void _drawPlayer(Canvas canvas, Offset pos, double angle) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(angle);

    // Assassin Shadow
    canvas.drawCircle(
      const Offset(2, 2),
      7,
      Paint()..color = Colors.black.withValues(alpha: 0.3),
    );

    // Black stealth vest & dark jacket (Ramon Spectre)
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: 16, height: 18),
      Paint()..color = const Color(0xFF1F2937),
    );

    // Arms
    canvas.drawCircle(const Offset(6, 4), 3, Paint()..color = const Color(0xFF9E7B5C));
    canvas.drawCircle(const Offset(6, -4), 3, Paint()..color = const Color(0xFF9E7B5C));

    // Black bandana / head
    canvas.drawCircle(Offset.zero, 5.5, Paint()..color = const Color(0xFF111827));
    // Red bandana accent / face
    canvas.drawCircle(const Offset(2, 0), 2.5, Paint()..color = const Color(0xFF9E7B5C));

    // Silenced pistol
    canvas.drawRect(
      const Rect.fromLTWH(4, 2, 8, 2.2),
      Paint()..color = const Color(0xFF0F172A),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant RetroMapPainter oldDelegate) {
    return oldDelegate.playerPos != playerPos ||
        oldDelegate.playerAngle != playerAngle ||
        oldDelegate.isHidden != isHidden ||
        oldDelegate.alertActive != alertActive;
  }
}
