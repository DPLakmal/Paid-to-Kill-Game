import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../services/original_asset_loader.dart';

/// Collision and interaction manager for the Interior Service Room
/// (matching assets/images/room_interior.png, coordinate space 680 x 1024).
class InteriorRoomCollision {
  static const double roomWidth = 680.0;
  static const double roomHeight = 1024.0;
  static const double playerRadius = 26.0;

  // Solid obstacle bounding boxes in native room coordinates (680 x 1024):
  static const List<Rect> solidObstacles = [
    // Top reinforced wall (Y: 0..230)
    Rect.fromLTWH(0, 0, 680, 230),

    // West solid wall (X: 0..115, Y: 0..1024)
    Rect.fromLTWH(0, 0, 115, 1024),

    // Top Dispenser Unit & Surveillance Monitor (X: 230..450, Y: 210..290)
    Rect.fromLTWH(230, 210, 220, 80),

    // Top Right Conduit & Sealed Gate Partition (X: 520..680, Y: 0..410)
    Rect.fromLTWH(520, 0, 160, 410),

    // East solid wall (X: 575..680, Y: 410..1024)
    Rect.fromLTWH(575, 410, 105, 614),

    // Center Partition Workstation (where Data Key is located) (X: 250..430, Y: 560..710)
    Rect.fromLTWH(250, 560, 180, 150),

    // South blast wall left segment (X: 0..240, Y: 940..1024)
    Rect.fromLTWH(0, 940, 240, 84),

    // South blast wall right segment (X: 440..680, Y: 940..1024)
    Rect.fromLTWH(440, 940, 240, 84),
  ];

  /// Tests collision for an interior coordinate (px, py).
  static bool isColliding(double px, double py, {double radius = playerRadius}) {
    // Outer room bounds
    if (px - radius < 100 || px + radius > 590 || py - radius < 210 || py + radius > 1000) {
      return true;
    }

    for (final rect in solidObstacles) {
      final closestX = px.clamp(rect.left, rect.right);
      final closestY = py.clamp(rect.top, rect.bottom);
      final dx = px - closestX;
      final dy = py - closestY;
      if ((dx * dx + dy * dy) < (radius * radius)) {
        return true;
      }
    }
    return false;
  }

  /// Smooth tangential wall sliding movement inside the room.
  static Offset resolveMovement({
    required Offset currentPos, // In 0.0 .. 1.0 normalized
    required Offset moveDir,
    required double speedPxPerSec,
    required double dt,
  }) {
    final double curX = currentPos.dx * roomWidth;
    final double curY = currentPos.dy * roomHeight;

    final double stepX = moveDir.dx * speedPxPerSec * dt;
    final double stepY = moveDir.dy * speedPxPerSec * dt;

    // 1. Try full diagonal step
    if (!isColliding(curX + stepX, curY + stepY)) {
      return Offset(
        (curX + stepX) / roomWidth,
        (curY + stepY) / roomHeight,
      );
    }

    // 2. Try horizontal slide
    if (stepX.abs() > 0.001 && !isColliding(curX + stepX, curY)) {
      return Offset(
        (curX + stepX) / roomWidth,
        curY / roomHeight,
      );
    }

    // 3. Try vertical slide
    if (stepY.abs() > 0.001 && !isColliding(curX, curY + stepY)) {
      return Offset(
        curX / roomWidth,
        (curY + stepY) / roomHeight,
      );
    }

    return currentPos;
  }
}

/// Interactive interior room widget showing authentic visual detail matching room_interior.png.
class InteriorRoomPainter extends CustomPainter {
  final Offset playerPos; // normalized 0..1
  final double playerAngle;
  final bool hasDataKey;
  final double animationValue; // 0..1 for pulsing LEDs

  InteriorRoomPainter({
    required this.playerPos,
    required this.playerAngle,
    required this.hasDataKey,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Fill entire viewport with solid black (outside the room = darkness)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.black,
    );

    // 2. Load the cutaway interior image from assets
    final loader = OriginalAssetLoader.instance;
    final ui.Image? roomImage = loader.images['room_cutaway_interior.jpg'];

    // 3. Calculate centered room rect maintaining aspect ratio
    // The cutaway image is portrait-oriented (roughly 2:3 aspect)
    const double roomAspect = 680.0 / 1024.0; // ~0.664
    final double screenAspect = size.width / size.height;

    double roomW, roomH, roomX, roomY;
    if (screenAspect < roomAspect) {
      // Screen is narrower — fit to width with padding top/bottom
      roomW = size.width * 0.92;
      roomH = roomW / roomAspect;
      roomX = (size.width - roomW) / 2;
      roomY = (size.height - roomH) / 2;
    } else {
      // Screen is wider — fit to height with padding left/right
      roomH = size.height * 0.92;
      roomW = roomH * roomAspect;
      roomX = (size.width - roomW) / 2;
      roomY = (size.height - roomH) / 2;
    }

    final roomRect = Rect.fromLTWH(roomX, roomY, roomW, roomH);

    if (roomImage != null) {
      // Draw the cutaway image filling the room rect
      final src = Rect.fromLTWH(
        0, 0,
        roomImage.width.toDouble(),
        roomImage.height.toDouble(),
      );
      canvas.drawImageRect(
        roomImage,
        src,
        roomRect,
        Paint()..filterQuality = FilterQuality.high,
      );
    } else {
      // Fallback: draw vector interior if image not loaded
      final sx = roomW / InteriorRoomCollision.roomWidth;
      final sy = roomH / InteriorRoomCollision.roomHeight;
      canvas.save();
      canvas.translate(roomX, roomY);
      canvas.scale(sx, sy);
      _drawFloor(canvas);
      _drawWallsAndPipes(canvas);
      _drawDispenserAndTerminal(canvas);
      _drawPartitionWorkstation(canvas);
      _drawSouthBlastExit(canvas);
      _drawAnimatedSensors(canvas);
      _drawPlayer(canvas);
      canvas.restore();
    }

    // 4. Draw data key glow overlay on top of image if unretrieved
    if (!hasDataKey) {
      final pulse = (math.sin(animationValue * 2 * math.pi) + 1.0) / 2.0;
      // Data key position relative to room rect (approx center-right of room)
      final keyX = roomRect.left + roomRect.width * 0.58;
      final keyY = roomRect.top + roomRect.height * 0.60;
      final glowPaint = Paint()
        ..color = const Color(0xFFFFD700).withValues(alpha: 0.3 + 0.4 * pulse)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
      canvas.drawCircle(Offset(keyX, keyY), roomW * 0.04, glowPaint);
      final keyPaint = Paint()..color = const Color(0xFFFFC107);
      canvas.drawCircle(Offset(keyX, keyY), roomW * 0.015, keyPaint);
    }

    // 5. Draw the player inside the room
    _drawPlayerOnRoom(canvas, roomRect);
  }

  void _drawFloor(Canvas canvas) {
    // Industrial white/slate ceramic tiled floor
    final bgPaint = Paint()..color = const Color(0xFFC4CCD3);
    canvas.drawRect(const Rect.fromLTWH(0, 0, 680, 1024), bgPaint);

    // Floor tile grid lines (32x32 native grid)
    final gridPaint = Paint()
      ..color = const Color(0xFFA0ACB7)
      ..strokeWidth = 1.5;

    for (double x = 110; x <= 580; x += 38) {
      canvas.drawLine(Offset(x, 220), Offset(x, 960), gridPaint);
    }
    for (double y = 220; y <= 960; y += 38) {
      canvas.drawLine(Offset(110, y), Offset(580, y), gridPaint);
    }

    // Drainage grate in floor (left-center)
    final gratePaint = Paint()..color = const Color(0xFF333A42);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(180, 420, 48, 48), const Radius.circular(4)),
      gratePaint,
    );
    final slitPaint = Paint()
      ..color = const Color(0xFF1E2228)
      ..strokeWidth = 3;
    for (double sy = 428; sy <= 460; sy += 8) {
      canvas.drawLine(Offset(184, sy), Offset(224, sy), slitPaint);
    }
  }

  void _drawWallsAndPipes(Canvas canvas) {
    // West solid reinforced bulkhead
    final wallPaint = Paint()..color = const Color(0xFF2A323D);
    canvas.drawRect(const Rect.fromLTWH(0, 0, 115, 1024), wallPaint);

    // West metallic wall plate trims
    final trimPaint = Paint()
      ..color = const Color(0xFF475569)
      ..strokeWidth = 3;
    canvas.drawLine(const Offset(115, 0), const Offset(115, 1024), trimPaint);

    // East solid reinforced bulkhead
    canvas.drawRect(const Rect.fromLTWH(575, 410, 105, 614), wallPaint);
    canvas.drawLine(const Offset(575, 410), const Offset(575, 1024), trimPaint);

    // Top reinforced wall
    canvas.drawRect(const Rect.fromLTWH(0, 0, 680, 225), wallPaint);
    canvas.drawLine(const Offset(0, 225), const Offset(680, 225), trimPaint);

    // Top-Right Hallway with Red Hydraulic Cylinder Gate
    final hallPaint = Paint()..color = const Color(0xFF192028);
    canvas.drawRect(const Rect.fromLTWH(520, 0, 160, 410), hallPaint);

    // Red Hydraulic Gate Cylinder
    final cylinderPaint = Paint()..color = const Color(0xFFD32F2F);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(535, 160, 28, 120), const Radius.circular(6)),
      cylinderPaint,
    );
    final pistonPaint = Paint()
      ..color = const Color(0xFFB0BEC5)
      ..strokeWidth = 8;
    canvas.drawLine(const Offset(549, 130), const Offset(549, 160), pistonPaint);
    canvas.drawLine(const Offset(549, 280), const Offset(549, 310), pistonPaint);

    // Industrial pressure pipes along east edge
    final pipePaint = Paint()
      ..color = const Color(0xFF607D8B)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(630, 460), const Offset(630, 920), pipePaint);
    canvas.drawLine(const Offset(650, 500), const Offset(650, 950), pipePaint);
  }

  void _drawDispenserAndTerminal(Canvas canvas) {
    // Top wall automated ammo/med dispenser unit
    final dispenserRect = const Rect.fromLTWH(240, 205, 200, 55);
    final dispenserPaint = Paint()..color = const Color(0xFF37474F);
    canvas.drawRect(dispenserRect, dispenserPaint);

    // Phosphor Green Monitor
    final monitorRect = const Rect.fromLTWH(290, 215, 100, 35);
    final monPaint = Paint()..color = const Color(0xFF00E676);
    canvas.drawRect(monitorRect, monPaint);

    // Scanning scanlines on green monitor
    final linePaint = Paint()
      ..color = const Color(0xFF003300).withValues(alpha: 0.6)
      ..strokeWidth = 2;
    for (double ly = 218; ly <= 248; ly += 5) {
      canvas.drawLine(Offset(292, ly), Offset(388, ly), linePaint);
    }
  }

  void _drawPartitionWorkstation(Canvas canvas) {
    // Center Partition Workstation Desk (X: 250..430, Y: 560..710)
    final shadowPaint = Paint()..color = Colors.black.withValues(alpha: 0.35);
    canvas.drawRect(const Rect.fromLTWH(256, 568, 180, 150), shadowPaint);

    final deskPaint = Paint()..color = const Color(0xFF455A64);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(250, 560, 180, 150), const Radius.circular(8)),
      deskPaint,
    );

    // Server racks / terminal console surface
    final topSurfacePaint = Paint()..color = const Color(0xFF263238);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(260, 570, 160, 130), const Radius.circular(6)),
      topSurfacePaint,
    );

    // Keycard reader / terminal interface
    final terminalPaint = Paint()..color = const Color(0xFF0288D1);
    canvas.drawRect(const Rect.fromLTWH(280, 590, 50, 30), terminalPaint);

    // Encrypted DATA KEY item (glowing gold if unretrieved)
    if (!hasDataKey) {
      final pulse = (math.sin(animationValue * 2 * math.pi) + 1.0) / 2.0;
      final keyGlow = Paint()
        ..color = const Color(0xFFFFD700).withValues(alpha: 0.3 + 0.4 * pulse)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
      canvas.drawCircle(const Offset(370, 630), 22, keyGlow);

      final keyPaint = Paint()..color = const Color(0xFFFFC107);
      canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(358, 620, 24, 20), const Radius.circular(4)),
        keyPaint,
      );

      // Microchip teeth
      final chipPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2;
      canvas.drawLine(const Offset(362, 624), const Offset(362, 636), chipPaint);
      canvas.drawLine(const Offset(368, 624), const Offset(368, 636), chipPaint);
      canvas.drawLine(const Offset(374, 624), const Offset(374, 636), chipPaint);
    }
  }

  void _drawSouthBlastExit(Canvas canvas) {
    // South Blast Door opening (X: 240..440, Y: 940..1024)
    final doorFramePaint = Paint()..color = const Color(0xFF1E2836);
    canvas.drawRect(const Rect.fromLTWH(240, 950, 200, 74), doorFramePaint);

    // Blast door threshold stripes
    final stripePaint = Paint()
      ..color = const Color(0xFFFFB300)
      ..strokeWidth = 4;
    for (double sx = 246; sx <= 434; sx += 18) {
      canvas.drawLine(Offset(sx, 952), Offset(sx + 10, 966), stripePaint);
    }

    // Outer siberian snow glimpse beyond south doorway
    final snowPaint = Paint()..color = const Color(0xFFB0C4DE);
    canvas.drawRect(const Rect.fromLTWH(260, 974, 160, 50), snowPaint);
  }

  void _drawAnimatedSensors(Canvas canvas) {
    // Emerald LED status beacons pulsing
    final pulse = (math.sin(animationValue * 2 * math.pi) + 1.0) / 2.0;
    final ledPaint = Paint()
      ..color = Color.lerp(const Color(0xFF00C853), const Color(0xFF69F0AE), pulse)!;

    // South doorway status sensor beacons
    canvas.drawCircle(const Offset(245, 946), 4.5, ledPaint);
    canvas.drawCircle(const Offset(435, 946), 4.5, ledPaint);

    // North bulkhead status lights
    canvas.drawCircle(const Offset(130, 222), 4.0, ledPaint);
    canvas.drawCircle(const Offset(500, 222), 4.0, ledPaint);
  }

  /// Draw the player character positioned within the room image rect
  void _drawPlayerOnRoom(Canvas canvas, Rect roomRect) {
    // Map normalized player pos (0..1) to pixel position inside room rect
    // Player walkable area is approximately: X 15%..85%, Y 22%..95% of image
    final px = roomRect.left + (0.15 + playerPos.dx * 0.70) * roomRect.width;
    final py = roomRect.top + (0.22 + playerPos.dy * 0.73) * roomRect.height;

    // Scale player size relative to room
    final playerScale = roomRect.width / 680.0;

    canvas.save();
    canvas.translate(px, py);
    canvas.rotate(playerAngle);
    canvas.scale(playerScale, playerScale);

    // Shadow
    final shadowPaint = Paint()..color = Colors.black.withValues(alpha: 0.4);
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(0, 4), width: 34, height: 26),
      shadowPaint,
    );

    // Ramon Spectre: Trenchcoat shoulders (charcoal/dark navy)
    final coatPaint = Paint()..color = const Color(0xFF1B232D);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-16, -14, 32, 28), const Radius.circular(8)),
      coatPaint,
    );

    // Red Necktie Accent (Agent 47 signature homage)
    final tiePaint = Paint()
      ..color = const Color(0xFFD32F2F)
      ..strokeWidth = 3;
    canvas.drawLine(const Offset(0, -6), const Offset(0, 4), tiePaint);

    // Head / Fedora / Hair
    final headPaint = Paint()..color = const Color(0xFF263238);
    canvas.drawCircle(const Offset(0, -2), 9, headPaint);

    // Silenced Pistol Barrel extended forward
    final gunPaint = Paint()
      ..color = const Color(0xFF78909C)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(const Offset(10, 2), const Offset(24, 2), gunPaint);

    // Silencer tip
    final silencerPaint = Paint()..color = const Color(0xFF37474F);
    canvas.drawRect(const Rect.fromLTWH(20, 0, 7, 4), silencerPaint);

    canvas.restore();
  }

  void _drawPlayer(Canvas canvas) {
    // Legacy vector-only fallback (used by _drawFloor path)
    final px = playerPos.dx * InteriorRoomCollision.roomWidth;
    final py = playerPos.dy * InteriorRoomCollision.roomHeight;

    canvas.save();
    canvas.translate(px, py);
    canvas.rotate(playerAngle);

    final shadowPaint = Paint()..color = Colors.black.withValues(alpha: 0.4);
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(0, 4), width: 34, height: 26),
      shadowPaint,
    );
    final coatPaint = Paint()..color = const Color(0xFF1B232D);
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-16, -14, 32, 28), const Radius.circular(8)),
      coatPaint,
    );
    final tiePaint = Paint()
      ..color = const Color(0xFFD32F2F)
      ..strokeWidth = 3;
    canvas.drawLine(const Offset(0, -6), const Offset(0, 4), tiePaint);
    final headPaint = Paint()..color = const Color(0xFF263238);
    canvas.drawCircle(const Offset(0, -2), 9, headPaint);
    final gunPaint = Paint()
      ..color = const Color(0xFF78909C)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(const Offset(10, 2), const Offset(24, 2), gunPaint);
    final silencerPaint = Paint()..color = const Color(0xFF37474F);
    canvas.drawRect(const Rect.fromLTWH(20, 0, 7, 4), silencerPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant InteriorRoomPainter oldDelegate) {
    return oldDelegate.playerPos != playerPos ||
        oldDelegate.playerAngle != playerAngle ||
        oldDelegate.hasDataKey != hasDataKey ||
        oldDelegate.animationValue != animationValue;
  }
}
