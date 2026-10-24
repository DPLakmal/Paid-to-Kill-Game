import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../services/original_asset_loader.dart';
import '../models/active_guard.dart';

/// Authentic tilemap painter upgraded with High-Definition (HD) Walls and Doors,
/// matching the 2005 Rovio J2ME level 0 geometry while rendering modern, crisp 
/// architectural bevels, drop shadows, blast doors, and glowing LED sensor lights.
class AuthenticTilemapPainter extends CustomPainter {
  final Offset playerPos; // normalized (0..1) or grid coordinates (x, y)
  final double playerAngle;
  final bool isHidden;
  final bool alertActive;
  final List<ActiveGuard>? activeGuards;
  final bool isRoomInteriorOpen;
  final bool isDoorUnlocked;
  final bool hasRetrievedDataKey;
  final double roomAnimationValue;

  AuthenticTilemapPainter({
    required this.playerPos,
    this.playerAngle = 0.0,
    this.isHidden = false,
    this.alertActive = false,
    this.activeGuards,
    this.isRoomInteriorOpen = false,
    this.isDoorUnlocked = false,
    this.hasRetrievedDataKey = false,
    this.roomAnimationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final loader = OriginalAssetLoader.instance;
    final level = loader.level0;
    if (!loader.isLoaded || level == null) {
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = const Color(0xFF263238));
      return;
    }

    // Authentic level 0 is 17 tiles wide x 24 tiles high, each tile is 10x10 px (170 x 240 px native).
    final mapWidth = level.width * 10.0;
    final mapHeight = level.height * 10.0;

    final scaleX = size.width / mapWidth;
    final scaleY = size.height / mapHeight;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    final offsetX = (size.width - mapWidth * scale) / 2;
    final offsetY = (size.height - mapHeight * scale) / 2;

    canvas.save();
    canvas.translate(offsetX, offsetY);
    canvas.scale(scale);

    // 1. Siberian Base Snow Ground (Multi-stop High-Definition arctic snow shader)
    final snowPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFF0F5FA),
          Color(0xFFE2ECF5),
          Color(0xFFD4E2EE),
          Color(0xFFC8D8E6),
        ],
        stops: [0.0, 0.35, 0.70, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, mapWidth, mapHeight));
    canvas.drawRect(Rect.fromLTWH(0, 0, mapWidth, mapHeight), snowPaint);

    // 2. High-Quality Snow Drift Ridges & Wind Contours
    _drawHdSnowDriftContours(canvas, mapWidth, mapHeight);

    // 3. HD Footprint Trails & Snow Contours
    _drawHdSnowDriftsAndFootprints(canvas);

    // 4. HD Floodlight Illumination Pools on Snow
    _drawHdLightPools(canvas);

    // 5. HD Fences & Barbed Wire
    _drawHdFences(canvas);

    // 6. HD HIGH-DEFINITION ARCHITECTURAL WALLS & BUILDINGS
    _drawHdDropShadows(canvas);
    _drawHdWallsAndRoofs(canvas);

    // 7. HD HIGH-DEFINITION DOORS & SENSOR INDICATORS
    _drawHdDoors(canvas);

    // 8. HD "GM" Siberian Department Pylons
    _drawHdPylons(canvas);

    // 9. HD Floodlight Towers
    _drawHdLightTowers(canvas);

    // 10. Draw Actors / Entities
    // Falkov (Blonde hair assistant at starting coordinates)
    _drawActor(canvas, 16.0, 186.0, isFalkov: true);

    // Ramon Spectre (Player)
    if (!isHidden) {
      final px = playerPos.dx <= 1.0 ? playerPos.dx * mapWidth : playerPos.dx * 10.0;
      final py = playerPos.dy <= 1.0 ? playerPos.dy * mapHeight : playerPos.dy * 10.0;
      _drawActor(canvas, px, py, isPlayer: true, angle: playerAngle);
    }

    // Dynamic Active Guards
    if (activeGuards != null && activeGuards!.isNotEmpty) {
      for (final guard in activeGuards!) {
        final gx = guard.position.dx * 10.0;
        final gy = guard.position.dy * 10.0;
        _drawActor(
          canvas,
          gx,
          gy,
          isGuard: true,
          isAlert: guard.isAlert || alertActive,
          isDefeated: guard.isDefeated,
          angle: guard.angle,
        );
      }
    } else {
      // Fallback to static entities from level_0.json
      for (final entity in level.entities) {
        final etype = entity['entityType'] as int;
        final gx = (entity['initialX'] as int) * 10.0;
        final gy = (entity['initialY'] as int) * 10.0;

        if (etype != 0 && etype != 3) {
          _drawActor(canvas, gx, gy, isGuard: true, isAlert: alertActive);
        }
      }
    }

    // 11. Atmospheric Cinematic Vignette & Ambient Darkness around the active room
    if (isRoomInteriorOpen) {
      // Darken outside environment around the cutaway room
      final ambientDarkness = Paint()..color = Colors.black.withValues(alpha: 0.72);
      canvas.saveLayer(Rect.fromLTWH(0, 0, mapWidth, mapHeight), Paint());
      canvas.drawRect(Rect.fromLTWH(0, 0, mapWidth, mapHeight), ambientDarkness);

      // Carve out illuminated spotlight over the service room interior
      final clearPaint = Paint()..blendMode = BlendMode.dstOut;
      final roomHole = RRect.fromRectAndRadius(const Rect.fromLTWH(26, 69, 37, 120), const Radius.circular(4));
      canvas.drawRRect(roomHole, clearPaint);
      canvas.restore();
    } else {
      _drawHdVignette(canvas, mapWidth, mapHeight);
    }

    canvas.restore();
  }

  /// High-Definition Snow Drift Contours & Frost Lines
  void _drawHdSnowDriftContours(Canvas canvas, double mapWidth, double mapHeight) {
    final ridgePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final shadowRidgePaint = Paint()
      ..color = const Color(0xFFB0C4DE).withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Wind-swept snow drift curves
    final drift1 = Path()
      ..moveTo(10, 50)
      ..quadraticBezierTo(40, 42, 80, 52)
      ..quadraticBezierTo(120, 60, 160, 48);
    canvas.drawPath(drift1, shadowRidgePaint);
    canvas.drawPath(drift1.shift(const Offset(0, -0.8)), ridgePaint);

    final drift2 = Path()
      ..moveTo(15, 140)
      ..quadraticBezierTo(50, 132, 90, 142)
      ..quadraticBezierTo(130, 150, 165, 138);
    canvas.drawPath(drift2, shadowRidgePaint);
    canvas.drawPath(drift2.shift(const Offset(0, -0.8)), ridgePaint);

    final drift3 = Path()
      ..moveTo(20, 205)
      ..quadraticBezierTo(70, 198, 110, 208)
      ..quadraticBezierTo(140, 215, 160, 202);
    canvas.drawPath(drift3, shadowRidgePaint);
    canvas.drawPath(drift3.shift(const Offset(0, -0.8)), ridgePaint);
  }

  /// High-Definition Drop Shadows for all buildings and boundary walls
  void _drawHdDropShadows(Canvas canvas) {
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.28)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);

    // Left Building Shadow (cast south-east)
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(26, 68, 44, 124), const Radius.circular(3)),
      shadowPaint,
    );

    // Right L-Building Shadows
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(86, 68, 86, 56), const Radius.circular(3)),
      shadowPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(126, 124, 46, 68), const Radius.circular(3)),
      shadowPaint,
    );

    // Top Perimeter Wall Shadow
    canvas.drawRect(const Rect.fromLTWH(0, 18, 170, 4), shadowPaint);
  }

  /// High-Definition 3D Walls, Sloped Concrete Bases, and Parapet Coping Roofs
  void _drawHdWallsAndRoofs(Canvas canvas) {
    // -------------------------------------------------------------
    // A. NORTH PERIMETER WALL & TOP WALKWAY (Y: 0..18, X: 0..170)
    // -------------------------------------------------------------
    final northWallRect = const Rect.fromLTWH(0, 0, 170, 18);
    final northWallPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFC7BCAB), Color(0xFFAFA291), Color(0xFF8C8070)],
      ).createShader(northWallRect);
    canvas.drawRect(northWallRect, northWallPaint);

    // Parapet trim line on north wall
    canvas.drawLine(
      const Offset(0, 3),
      const Offset(170, 3),
      Paint()..color = const Color(0xFFEFECE6)..strokeWidth = 1.5,
    );
    canvas.drawLine(
      const Offset(0, 18),
      const Offset(170, 18),
      Paint()..color = const Color(0xFF5E5446)..strokeWidth = 1.0,
    );

    // Barred surveillance vents on north wall
    _drawWallVent(canvas, 42, 6, 10, 5);
    _drawWallVent(canvas, 138, 6, 10, 5);

    // -------------------------------------------------------------
    // B. WEST BOUNDARY WALL & CATWALK
    // -------------------------------------------------------------
    final westWallPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFB5AA9A), Color(0xFF8A7F70)],
      ).createShader(const Rect.fromLTWH(0, 0, 7, 240));
    canvas.drawRect(const Rect.fromLTWH(0, 0, 7, 240), westWallPaint);

    // Catwalk bridge connecting west wall to left building (X: 7..24, Y: 68..77)
    final catwalkRect = const Rect.fromLTWH(7, 68, 17, 9);
    canvas.drawRect(
      catwalkRect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF9E8F7C), Color(0xFF6D5F4E)],
        ).createShader(catwalkRect),
    );
    // Industrial metal grating cross lines
    final gratePaint = Paint()..color = const Color(0xFFD6CBC0).withValues(alpha: 0.5)..strokeWidth = 0.6;
    for (double gx = 9; gx <= 22; gx += 3) {
      canvas.drawLine(Offset(gx, 68), Offset(gx, 77), gratePaint);
    }

    // -------------------------------------------------------------
    // C. LEFT MILITARY BUILDING (X: 23..66, Y: 66..188)
    // -------------------------------------------------------------
    final leftBuildingOuter = const Rect.fromLTWH(23, 66, 43, 122);

    // 1. Sloped Concrete Base (Tan/Sandstone gradient with bevels)
    final leftBasePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFDDD2C2), Color(0xFFBAAE9E), Color(0xFF918575)],
      ).createShader(leftBuildingOuter);
    canvas.drawRRect(RRect.fromRectAndRadius(leftBuildingOuter, const Radius.circular(2)), leftBasePaint);

    // 2. Flat Aggregate Gravel Roof (Recessed) OR Opened Cutaway Roof into Interior Room
    final leftRoofRect = const Rect.fromLTWH(28, 71, 33, 107);
    if (isRoomInteriorOpen) {
      // Cutaway Roof Open: Render authentic service room interior inside the building footprint
      _drawCutawayRoomInterior(canvas, leftBuildingOuter, leftRoofRect);
    } else {
      final leftRoofPaint = Paint()
        ..shader = const RadialGradient(
          center: Alignment.center,
          radius: 0.9,
          colors: [Color(0xFF8E8375), Color(0xFF756A5C), Color(0xFF5A5043)],
        ).createShader(leftRoofRect);
      canvas.drawRect(leftRoofRect, leftRoofPaint);

      // Fine speckled gravel aggregate texture
      final specklePaint = Paint()..color = Colors.white.withValues(alpha: 0.12);
      for (double sy = 74; sy < 175; sy += 6) {
        for (double sx = 31; sx < 58; sx += 6) {
          canvas.drawCircle(Offset(sx, sy), 0.7, specklePaint);
        }
      }

      // 3. Crisp White Parapet Coping Border (3D Bevel)
      _drawParapetBorder(canvas, leftRoofRect);
    }

    // Architectural panel seams on Left Building concrete plinth
    final seamPaint = Paint()..color = const Color(0xFF6B5E4F).withValues(alpha: 0.45)..strokeWidth = 0.6;
    canvas.drawLine(const Offset(37, 66), const Offset(37, 71), seamPaint);
    canvas.drawLine(const Offset(52, 66), const Offset(52, 71), seamPaint);
    canvas.drawLine(const Offset(23, 110), const Offset(28, 110), seamPaint);
    canvas.drawLine(const Offset(23, 145), const Offset(28, 145), seamPaint);
    canvas.drawLine(const Offset(61, 110), const Offset(66, 110), seamPaint);
    canvas.drawLine(const Offset(61, 145), const Offset(66, 145), seamPaint);

    // Wall Louver & Security Sensor on East Wall of Left Building
    canvas.drawRect(const Rect.fromLTWH(64, 100, 2, 8), Paint()..color = const Color(0xFF4A4033));
    canvas.drawCircle(const Offset(65.5, 104), 1.2, Paint()..color = const Color(0xFFFF1744)); // Red sensor dot

    // -------------------------------------------------------------
    // D. RIGHT L-SHAPED MILITARY BUILDING
    // -------------------------------------------------------------
    // Main North Wing: X: 83..166, Y: 66..122
    // South Wing: X: 124..166, Y: 122..188
    final pathRightBuilding = Path()
      ..moveTo(83, 66)
      ..lineTo(166, 66)
      ..lineTo(166, 188)
      ..lineTo(124, 188)
      ..lineTo(124, 122)
      ..lineTo(83, 122)
      ..close();

    final rightBasePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFDFD4C4), Color(0xFFBFAF9E), Color(0xFF8D8171)],
      ).createShader(const Rect.fromLTWH(83, 66, 83, 122));
    canvas.drawPath(pathRightBuilding, rightBasePaint);

    // Roof Path for Right L-Building
    final pathRightRoof = Path()
      ..moveTo(88, 71)
      ..lineTo(161, 71)
      ..lineTo(161, 183)
      ..lineTo(129, 183)
      ..lineTo(129, 117)
      ..lineTo(88, 117)
      ..close();

    final rightRoofPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF8A7F71), Color(0xFF6F6557), Color(0xFF584E41)],
      ).createShader(const Rect.fromLTWH(88, 71, 73, 112));
    canvas.drawPath(pathRightRoof, rightRoofPaint);

    // Parapet trim for L-shaped roof
    final parapetStroke = Paint()
      ..color = const Color(0xFFFAF7F2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(pathRightRoof, parapetStroke);

    final innerParapetShadow = Paint()
      ..color = const Color(0xFF3E362C).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawPath(pathRightRoof, innerParapetShadow);

    // Security windows on inner alcove wall (X: 89..105, Y: 122)
    _drawWallWindow(canvas, 95, 119, 10, 4);

    // Architectural panel seams on Right Building
    canvas.drawLine(const Offset(105, 66), const Offset(105, 71), seamPaint);
    canvas.drawLine(const Offset(135, 66), const Offset(135, 71), seamPaint);
    canvas.drawLine(const Offset(124, 150), const Offset(129, 150), seamPaint);
    canvas.drawLine(const Offset(161, 150), const Offset(166, 150), seamPaint);

    // -------------------------------------------------------------
    // E. SOUTH BOUNDARY WALL (Y: 220..240, X: 0..170)
    // -------------------------------------------------------------
    final southWallRect = const Rect.fromLTWH(0, 222, 170, 18);
    final southWallPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFBDB2A2), Color(0xFF8F8474)],
      ).createShader(southWallRect);
    canvas.drawRect(southWallRect, southWallPaint);
    canvas.drawLine(const Offset(0, 222), const Offset(170, 222), Paint()..color = const Color(0xFFEBE6DC)..strokeWidth = 1.2);
  }

  /// Draw authentic cutaway interior of the service room (matching assets/images/room_cutaway_interior.jpg)
  void _drawCutawayRoomInterior(Canvas canvas, Rect buildingOuter, Rect roofRect) {
    final loader = OriginalAssetLoader.instance;
    final roomImage = loader.images['room_cutaway_interior.jpg'];

    // 1. Concrete thick boundary cutaway walls (dark charcoal rim)
    final wallBorderPaint = Paint()
      ..color = const Color(0xFF222933)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(roofRect.inflate(1.5), const Radius.circular(2)), wallBorderPaint);

    if (roomImage != null) {
      // Draw high-resolution rendered cutaway asset precisely into the building interior
      final src = Rect.fromLTWH(0, 0, roomImage.width.toDouble(), roomImage.height.toDouble());
      canvas.drawImageRect(roomImage, src, roofRect, Paint()..filterQuality = FilterQuality.high);
    } else {
      // Fallback layered vector representation matching room_cutaway_interior.jpg
      // Ceramic tiled floor
      final floorPaint = Paint()..color = const Color(0xFFC7CFD6);
      canvas.drawRect(roofRect, floorPaint);

      // White tile grid lines
      final tileGridPaint = Paint()
        ..color = const Color(0xFFA5B2BD)
        ..strokeWidth = 0.4;
      for (double tx = roofRect.left + 3; tx < roofRect.right; tx += 4) {
        canvas.drawLine(Offset(tx, roofRect.top), Offset(tx, roofRect.bottom), tileGridPaint);
      }
      for (double ty = roofRect.top + 3; ty < roofRect.bottom; ty += 4) {
        canvas.drawLine(Offset(roofRect.left, ty), Offset(roofRect.right, ty), tileGridPaint);
      }

      // Floor drain grate
      final drainRect = Rect.fromLTWH(roofRect.left + 6, roofRect.top + 30, 7, 7);
      canvas.drawRect(drainRect, Paint()..color = const Color(0xFF37474F));

      // Dispenser unit on north wall
      final dispenserRect = Rect.fromLTWH(roofRect.center.dx - 4, roofRect.top + 4, 8, 5);
      canvas.drawRect(dispenserRect, Paint()..color = const Color(0xFF455A64));
      canvas.drawRect(Rect.fromLTWH(roofRect.center.dx - 2, roofRect.top + 5, 4, 2.5), Paint()..color = const Color(0xFF00E676));

      // Center partition workstation
      final partRect = Rect.fromLTWH(roofRect.center.dx - 2, roofRect.top + 46, 12, 14);
      canvas.drawRect(partRect, Paint()..color = const Color(0xFF455A64));
      canvas.drawRect(partRect.deflate(1.2), Paint()..color = const Color(0xFF263238));

      // Right-side red hydraulic cylinder
      final cylinderRect = Rect.fromLTWH(roofRect.right - 4.5, roofRect.top + 10, 2.5, 8);
      canvas.drawRect(cylinderRect, Paint()..color = const Color(0xFFD32F2F));

      // South exit threshold
      final exitRect = Rect.fromLTWH(roofRect.left + 5, roofRect.bottom - 4, 10, 4);
      canvas.drawRect(exitRect, Paint()..color = const Color(0xFF1E2836));
    }

    // Encrypted Data Key glow if unretrieved
    if (!hasRetrievedDataKey) {
      final keyCenter = Offset(roofRect.center.dx + 4, roofRect.top + 52);
      final pulse = (math.sin(roomAnimationValue * 2 * math.pi) + 1.0) / 2.0;
      final glowPaint = Paint()
        ..color = const Color(0xFFFFD700).withValues(alpha: 0.4 + 0.4 * pulse)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);
      canvas.drawCircle(keyCenter, 3.5, glowPaint);
      canvas.drawCircle(keyCenter, 1.2, Paint()..color = const Color(0xFFFFC107));
    }

    // 3D Inner Parapet Bevel Stroke around cutaway roof opening
    final parapetRim = Paint()
      ..color = const Color(0xFF475569)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(roofRect, parapetRim);

    final highlightRim = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawLine(roofRect.topLeft, roofRect.topRight, highlightRim);
    canvas.drawLine(roofRect.topLeft, roofRect.bottomLeft, highlightRim);
  }

  /// High-Definition Blast Doors with ribbed steel slats, hazard stripes, & Glowing LED Sensors
  void _drawHdDoors(Canvas canvas) {
    // -------------------------------------------------------------
    // 1. NORTH MAIN GATE BLAST DOOR (X: 84..96, Y: 4..16)
    // -------------------------------------------------------------
    _drawSlidingBlastDoor(
      canvas: canvas,
      doorRect: const Rect.fromLTWH(84, 4, 12, 12),
      isUnlocked: true,
      hasSensorLight: true,
      sensorOffset: const Offset(90, 3),
      showHazardStripes: true,
    );

    // -------------------------------------------------------------
    // 2. WEST BUILDING ENTRANCE DOOR (X: 33..45, Y: 178..188)
    // -------------------------------------------------------------
    _drawSlidingBlastDoor(
      canvas: canvas,
      doorRect: const Rect.fromLTWH(34, 178, 11, 10),
      isUnlocked: isDoorUnlocked,
      hasSensorLight: true,
      sensorOffset: const Offset(39.5, 176.5),
      showHazardStripes: false,
    );

    // High-Definition Storage Cabinets / Closets next to West Door (X: 47..55, Y: 178..188)
    _drawHdCabinets(canvas, 47, 178);

    // -------------------------------------------------------------
    // 3. EAST BUILDING EXTRACTION DOOR (X: 134..146, Y: 178..188)
    // -------------------------------------------------------------
    _drawSlidingBlastDoor(
      canvas: canvas,
      doorRect: const Rect.fromLTWH(134, 178, 11, 10),
      isUnlocked: true,
      hasSensorLight: true,
      sensorOffset: const Offset(139.5, 176.5),
      showHazardStripes: false,
    );

    // High-Definition Glowing Holographic Interaction / Extraction Ring on snow in front of East Blast Door
    _drawHolographicInteractionRing(canvas, const Offset(140, 195), radius: 5.5);
  }

  /// High-Definition Sliding Blast Door component
  void _drawSlidingBlastDoor({
    required Canvas canvas,
    required Rect doorRect,
    required bool isUnlocked,
    required bool hasSensorLight,
    required Offset sensorOffset,
    bool showHazardStripes = false,
  }) {
    // Outer recessed steel door frame
    canvas.drawRRect(
      RRect.fromRectAndRadius(doorRect.inflate(1.2), const Radius.circular(1.5)),
      Paint()..color = const Color(0xFF2B333D),
    );

    // Door Panel (Horizontal Ribbed Titanium/Steel)
    final doorPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFF8C9AA8), Color(0xFF5C6975), Color(0xFF38434E)],
      ).createShader(doorRect);
    canvas.drawRRect(RRect.fromRectAndRadius(doorRect, const Radius.circular(1.0)), doorPaint);

    // Horizontal Ribs / Slats
    final slatPaint = Paint()..color = const Color(0xFF27313B)..strokeWidth = 0.8;
    final highlightPaint = Paint()..color = Colors.white.withValues(alpha: 0.25)..strokeWidth = 0.5;
    for (double sy = doorRect.top + 2.5; sy < doorRect.bottom - 1; sy += 2.2) {
      canvas.drawLine(Offset(doorRect.left + 1, sy), Offset(doorRect.right - 1, sy), slatPaint);
      canvas.drawLine(Offset(doorRect.left + 1, sy - 0.6), Offset(doorRect.right - 1, sy - 0.6), highlightPaint);
    }

    // Threshold Hazard Stripes (Yellow / Black diagonal)
    if (showHazardStripes) {
      final hazardRect = Rect.fromLTWH(doorRect.left, doorRect.bottom - 1.5, doorRect.width, 2.0);
      canvas.drawRect(hazardRect, Paint()..color = const Color(0xFFFFD600));
      final stripePaint = Paint()..color = const Color(0xFF1E232A)..strokeWidth = 1.0;
      for (double hx = hazardRect.left; hx <= hazardRect.right; hx += 3.0) {
        canvas.drawLine(Offset(hx, hazardRect.bottom), Offset(hx + 1.5, hazardRect.top), stripePaint);
      }
    }

    // Glowing LED Electronic Sensor Light (Emerald Green or Crimson Red)
    if (hasSensorLight) {
      final ledColor = isUnlocked ? const Color(0xFF00E676) : const Color(0xFFFF1744);

      // Radial Bloom Glow
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            ledColor.withValues(alpha: 0.9),
            ledColor.withValues(alpha: 0.35),
            ledColor.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: sensorOffset, radius: 4.5));
      canvas.drawCircle(sensorOffset, 4.5, glowPaint);

      // Inner intense core LED
      canvas.drawCircle(sensorOffset, 1.3, Paint()..color = Colors.white);
      canvas.drawCircle(sensorOffset, 1.0, Paint()..color = ledColor);
    }
  }

  /// High-Definition Storage Cabinets / Concealment Closets
  void _drawHdCabinets(Canvas canvas, double x, double y) {
    // Two twin rounded steel capsule lockers
    for (int i = 0; i < 2; i++) {
      final cabRect = Rect.fromLTWH(x + (i * 4.2), y, 3.6, 9.5);

      // Drop shadow
      canvas.drawRRect(
        RRect.fromRectAndRadius(cabRect.translate(0.5, 0.5), const Radius.circular(1.8)),
        Paint()..color = Colors.black38,
      );

      // Steel Locker Body
      final cabPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [Color(0xFFB0BEC5), Color(0xFF78909C), Color(0xFF455A64)],
        ).createShader(cabRect);
      canvas.drawRRect(RRect.fromRectAndRadius(cabRect, const Radius.circular(1.8)), cabPaint);

      // Vertical door seam
      canvas.drawLine(
        Offset(cabRect.center.dx, cabRect.top + 1.5),
        Offset(cabRect.center.dx, cabRect.bottom - 1.5),
        Paint()..color = const Color(0xFF263238)..strokeWidth = 0.5,
      );

      // Chrome latch handle
      canvas.drawRect(
        Rect.fromLTWH(cabRect.center.dx + 0.3, cabRect.center.dy - 1, 0.6, 2.0),
        Paint()..color = Colors.white,
      );

      // Top ventilation slots
      canvas.drawLine(
        Offset(cabRect.left + 0.8, cabRect.top + 1.5),
        Offset(cabRect.right - 0.8, cabRect.top + 1.5),
        Paint()..color = const Color(0xFF37474F)..strokeWidth = 0.4,
      );
    }
  }

  /// Holographic White Pulsing Interaction Ring on the ground
  void _drawHolographicInteractionRing(Canvas canvas, Offset center, {required double radius}) {
    final ringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, radius, ringPaint);

    final innerGlowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius - 1.0, innerGlowPaint);

    final dotPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    canvas.drawCircle(center, 0.8, dotPaint);
  }

  /// 3D Parapet Edge Coping Border
  void _drawParapetBorder(Canvas canvas, Rect roofRect) {
    // Outer white coping stone
    final borderPaint = Paint()
      ..color = const Color(0xFFFAF7F2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    canvas.drawRect(roofRect, borderPaint);

    // Inner shadow edge
    final innerShadow = Paint()
      ..color = const Color(0xFF423B33).withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawRect(roofRect.deflate(1.0), innerShadow);
  }

  /// Recessed Security Window with metallic frame and bars
  void _drawWallWindow(Canvas canvas, double x, double y, double w, double h) {
    final winRect = Rect.fromLTWH(x, y, w, h);
    canvas.drawRect(winRect, Paint()..color = const Color(0xFF1E2630));
    canvas.drawRect(winRect, Paint()..color = const Color(0xFF6B7280)..style = PaintingStyle.stroke..strokeWidth = 0.8);

    // Steel security bars
    final barPaint = Paint()..color = const Color(0xFF9CA3AF)..strokeWidth = 0.8;
    canvas.drawLine(Offset(x + w * 0.33, y), Offset(x + w * 0.33, y + h), barPaint);
    canvas.drawLine(Offset(x + w * 0.66, y), Offset(x + w * 0.66, y + h), barPaint);
  }

  /// Horizontal louvered wall air vent
  void _drawWallVent(Canvas canvas, double x, double y, double w, double h) {
    final ventRect = Rect.fromLTWH(x, y, w, h);
    canvas.drawRect(ventRect, Paint()..color = const Color(0xFF2D333B));
    final louverPaint = Paint()..color = const Color(0xFF606770)..strokeWidth = 0.6;
    canvas.drawLine(Offset(x, y + h * 0.3), Offset(x + w, y + h * 0.3), louverPaint);
    canvas.drawLine(Offset(x, y + h * 0.7), Offset(x + w, y + h * 0.7), louverPaint);
  }

  /// High-Definition Footprint Trails in the Snow
  void _drawHdSnowDriftsAndFootprints(Canvas canvas) {
    final printPaint = Paint()
      ..color = const Color(0xFF9EAEC0).withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    // Helper to draw a pair of tactical boot treads
    void drawBootPrints(double x, double y, double angle) {
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle);
      canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(-1.2, -0.6, 2.4, 1.2), const Radius.circular(0.5)), printPaint);
      canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(-1.2, 1.0, 2.4, 1.2), const Radius.circular(0.5)), printPaint);
      canvas.restore();
    }

    // Trail 1: North gate footsteps leading into courtyard
    drawBootPrints(88, 18, 1.57);
    drawBootPrints(89, 23, 1.57);
    drawBootPrints(91, 28, 1.4);
    drawBootPrints(93, 34, 1.57);
    drawBootPrints(94, 40, 1.57);

    // Trail 2: Lower corridor guard patrol prints
    drawBootPrints(114, 138, 1.57);
    drawBootPrints(115, 144, 1.57);
    drawBootPrints(116, 150, 1.57);
    drawBootPrints(115, 156, 1.57);
    drawBootPrints(114, 162, 1.57);

    // Trail 3: Footprints near east extraction door
    drawBootPrints(150, 168, 1.57);
    drawBootPrints(151, 174, 1.57);
    drawBootPrints(152, 180, 1.57);

    // Trail 4: Starting path near Ramon and Falkov
    drawBootPrints(36, 176, 0.0);
    drawBootPrints(42, 176, 0.0);
    drawBootPrints(48, 177, 0.1);
    drawBootPrints(54, 177, 0.0);
  }

  /// High-Definition Volumetric Dual Light Beams & Halogen Illumination Pools cast onto Snow
  void _drawHdLightPools(Canvas canvas) {
    final lightPositions = [
      const Offset(58, 20),
      const Offset(130, 20),
      const Offset(70, 78),
      const Offset(108, 128),
    ];

    for (final pos in lightPositions) {
      final mastTopY = pos.dy - 16.5;

      // 1. Left Volumetric Light Beam Cone (Shooting Down & Outward Left)
      final leftBeamPath = Path()
        ..moveTo(pos.dx - 2.5, mastTopY + 1.0)
        ..lineTo(pos.dx - 4.5, mastTopY + 1.0)
        ..lineTo(pos.dx - 26.0, pos.dy + 32.0)
        ..lineTo(pos.dx + 2.0, pos.dy + 32.0)
        ..close();

      final leftBeamPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFF9C4).withValues(alpha: 0.52),
            const Color(0xFFFFE082).withValues(alpha: 0.30),
            const Color(0xFFFFD54F).withValues(alpha: 0.12),
            Colors.transparent,
          ],
          stops: const [0.0, 0.35, 0.70, 1.0],
        ).createShader(Rect.fromLTWH(pos.dx - 26.0, mastTopY, 28.0, pos.dy + 32.0 - mastTopY));
      canvas.drawPath(leftBeamPath, leftBeamPaint);

      // 2. Right Volumetric Light Beam Cone (Shooting Down & Outward Right)
      final rightBeamPath = Path()
        ..moveTo(pos.dx + 2.5, mastTopY + 1.0)
        ..lineTo(pos.dx + 4.5, mastTopY + 1.0)
        ..lineTo(pos.dx + 26.0, pos.dy + 32.0)
        ..lineTo(pos.dx - 2.0, pos.dy + 32.0)
        ..close();

      final rightBeamPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFF9C4).withValues(alpha: 0.52),
            const Color(0xFFFFE082).withValues(alpha: 0.30),
            const Color(0xFFFFD54F).withValues(alpha: 0.12),
            Colors.transparent,
          ],
          stops: const [0.0, 0.35, 0.70, 1.0],
        ).createShader(Rect.fromLTWH(pos.dx - 2.0, mastTopY, 28.0, pos.dy + 32.0 - mastTopY));
      canvas.drawPath(rightBeamPath, rightBeamPaint);

      // 3. Overlapping Warm Halogen Illumination Pool on Snow
      final poolRect = Rect.fromCenter(center: Offset(pos.dx, pos.dy + 15.0), width: 48, height: 34);
      final poolPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFFFDE7).withValues(alpha: 0.44),
            const Color(0xFFFFF59D).withValues(alpha: 0.26),
            const Color(0xFFFFE082).withValues(alpha: 0.12),
            Colors.transparent,
          ],
          stops: const [0.0, 0.35, 0.65, 1.0],
        ).createShader(poolRect);
      canvas.drawOval(poolRect, poolPaint);
    }
  }

  /// High-Definition Chain-link & Barbed Wire Security Fences
  void _drawHdFences(Canvas canvas) {
    const fenceY = 46.0;
    const startX = 42.0;
    const endX = 79.0;

    // Fence Posts
    final postPaint = Paint()..color = const Color(0xFF37474F)..strokeWidth = 1.2;
    for (double px = startX; px <= endX; px += 9.0) {
      canvas.drawLine(Offset(px, fenceY - 4), Offset(px, fenceY + 4), postPaint);
      canvas.drawCircle(Offset(px, fenceY - 4), 0.8, Paint()..color = const Color(0xFF90A4AE));
    }

    // Top and Bottom Rails
    final railPaint = Paint()..color = const Color(0xFF546E7A)..strokeWidth = 0.8;
    canvas.drawLine(const Offset(startX, fenceY - 3), const Offset(endX, fenceY - 3), railPaint);
    canvas.drawLine(const Offset(startX, fenceY + 3), const Offset(endX, fenceY + 3), railPaint);

    // Diamond Chain-link Mesh
    final meshPaint = Paint()..color = const Color(0xFF78909C).withValues(alpha: 0.6)..strokeWidth = 0.5;
    for (double mx = startX; mx < endX; mx += 3.5) {
      canvas.drawLine(Offset(mx, fenceY - 3), Offset(mx + 3.5, fenceY + 3), meshPaint);
      canvas.drawLine(Offset(mx + 3.5, fenceY - 3), Offset(mx, fenceY + 3), meshPaint);
    }

    // Coiled Razor-wire on Top Rail
    final wirePaint = Paint()..color = const Color(0xFFCFD8DC)..strokeWidth = 0.6;
    for (double rx = startX; rx < endX; rx += 4.0) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(rx + 2, fenceY - 4), radius: 1.6),
        0,
        math.pi * 2,
        false,
        wirePaint,
      );
    }
  }

  /// High-Definition "GM" Siberian Department Corporate Pylons
  void _drawHdPylons(Canvas canvas) {
    final pylonCoords = [
      const Offset(84, 13),
      const Offset(104, 13),
      const Offset(84, 110),
      const Offset(72, 172),
    ];

    for (final pos in pylonCoords) {
      // Concrete Pedestal Base with drop shadow
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromCenter(center: pos.translate(0.5, 0.8), width: 9, height: 7), const Radius.circular(1.0)),
        Paint()..color = Colors.black26,
      );

      final pedestalRect = Rect.fromCenter(center: pos, width: 8.5, height: 6.5);
      final pedPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [Color(0xFFCFD8DC), Color(0xFF90A4AE), Color(0xFF607D8B)],
        ).createShader(pedestalRect);
      canvas.drawRRect(RRect.fromRectAndRadius(pedestalRect, const Radius.circular(1.0)), pedPaint);

      // Cobalt Blue "GM" Sign Box
      final signRect = Rect.fromCenter(center: pos.translate(0, -0.5), width: 6.8, height: 4.8);
      final signPaint = Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1976D2), Color(0xFF0D47A1)],
        ).createShader(signRect);
      canvas.drawRRect(RRect.fromRectAndRadius(signRect, const Radius.circular(0.8)), signPaint);
      canvas.drawRRect(
        RRect.fromRectAndRadius(signRect, const Radius.circular(0.8)),
        Paint()..color = Colors.white.withValues(alpha: 0.8)..style = PaintingStyle.stroke..strokeWidth = 0.5,
      );

      // "GM" Monogram Vector Lettering
      final textPaint = Paint()..color = Colors.white..strokeWidth = 0.8..style = PaintingStyle.stroke;
      // G
      final gPath = Path()
        ..moveTo(signRect.left + 2.6, signRect.top + 1.4)
        ..lineTo(signRect.left + 1.4, signRect.top + 1.4)
        ..lineTo(signRect.left + 1.4, signRect.bottom - 1.4)
        ..lineTo(signRect.left + 2.6, signRect.bottom - 1.4)
        ..lineTo(signRect.left + 2.6, signRect.top + 2.4)
        ..lineTo(signRect.left + 2.0, signRect.top + 2.4);
      canvas.drawPath(gPath, textPaint);

      // M
      final mPath = Path()
        ..moveTo(signRect.left + 3.8, signRect.bottom - 1.4)
        ..lineTo(signRect.left + 3.8, signRect.top + 1.4)
        ..lineTo(signRect.left + 4.6, signRect.top + 2.4)
        ..lineTo(signRect.left + 5.4, signRect.top + 1.4)
        ..lineTo(signRect.left + 5.4, signRect.bottom - 1.4);
      canvas.drawPath(mPath, textPaint);

      // Top steel wall mounting bracket & clips
      final bracketPaint = Paint()..color = const Color(0xFF263238)..strokeWidth = 0.8;
      canvas.drawLine(Offset(signRect.center.dx - 2.5, signRect.top - 1.0), Offset(signRect.center.dx + 2.5, signRect.top - 1.0), bracketPaint);
      canvas.drawRect(Rect.fromCenter(center: Offset(signRect.center.dx, signRect.top - 0.6), width: 1.4, height: 1.0), bracketPaint);

      // "Genetics Lab" Micro-lettering underneath GM
      final subTextPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.85)
        ..strokeWidth = 0.4;
      // High-precision micro-text line representing "Genetics Lab"
      canvas.drawLine(Offset(signRect.left + 1.2, signRect.bottom - 0.7), Offset(signRect.right - 1.2, signRect.bottom - 0.7), subTextPaint);
    }
  }

  /// High-Definition Military Floodlight Towers matching authentic reference:
  /// Heavy industrial tapered concrete plinth, cross-braced steel lattice truss mast,
  /// and hooded dual halogen floodlights with brilliant white filaments and warm golden bloom.
  void _drawHdLightTowers(Canvas canvas) {
    final towerCoords = [
      const Offset(58, 20),
      const Offset(130, 20),
      const Offset(70, 78),
      const Offset(108, 128),
    ];

    for (final pos in towerCoords) {
      final baseY = pos.dy;

      // -------------------------------------------------------------
      // 1. PLINTH CONTACT DROP SHADOW ON SNOW
      // -------------------------------------------------------------
      canvas.drawOval(
        Rect.fromCenter(center: Offset(pos.dx + 0.4, baseY + 6.8), width: 14.5, height: 5.5),
        Paint()..color = Colors.black45,
      );

      // -------------------------------------------------------------
      // 2. HEAVY INDUSTRIAL TAPERED CONCRETE PLINTH (Trapezoidal Base)
      // -------------------------------------------------------------
      // Base width: 11.5 px (bottom), 9.0 px (top platform), height: 12.5 px
      final plinthPath = Path()
        ..moveTo(pos.dx - 4.5, baseY - 6.0)
        ..lineTo(pos.dx + 4.5, baseY - 6.0)
        ..lineTo(pos.dx + 5.75, baseY + 6.5)
        ..lineTo(pos.dx - 5.75, baseY + 6.5)
        ..close();

      final plinthPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [
            Color(0xFF9E9587),
            Color(0xFF7E7668),
            Color(0xFF625B4F),
            Color(0xFF454037),
          ],
          stops: const [0.0, 0.28, 0.68, 1.0],
        ).createShader(Rect.fromLTWH(pos.dx - 6.0, baseY - 6.0, 12.0, 12.5));
      canvas.drawPath(plinthPath, plinthPaint);

      // Vertical concrete formwork seams & weathering texture
      final seamPaint = Paint()
        ..color = const Color(0xFF2E2922).withValues(alpha: 0.42)
        ..strokeWidth = 0.6;
      canvas.drawLine(Offset(pos.dx - 1.6, baseY - 6.0), Offset(pos.dx - 2.0, baseY + 6.5), seamPaint);
      canvas.drawLine(Offset(pos.dx + 1.6, baseY - 6.0), Offset(pos.dx + 2.0, baseY + 6.5), seamPaint);

      // Vertical center highlight where floodlight illumination grazes down plinth face
      final grazingPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFF9C4).withValues(alpha: 0.28),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(pos.dx - 1.5, baseY - 6.0, 3.0, 10.0));
      canvas.drawRect(Rect.fromLTWH(pos.dx - 1.2, baseY - 5.5, 2.4, 9.5), grazingPaint);

      // Chamfered top platform concrete coping bevel
      canvas.drawLine(
        Offset(pos.dx - 4.5, baseY - 6.0),
        Offset(pos.dx + 4.5, baseY - 6.0),
        Paint()..color = const Color(0xFFBEB6A7)..strokeWidth = 1.0,
      );

      // Industrial dark steel anchor baseplate
      final plateRect = Rect.fromCenter(center: Offset(pos.dx, baseY - 6.4), width: 7.2, height: 1.6);
      canvas.drawRRect(
        RRect.fromRectAndRadius(plateRect, const Radius.circular(0.4)),
        Paint()..color = const Color(0xFF212529),
      );
      // 4 Steel corner bolts
      final boltPaint = Paint()..color = const Color(0xFFCFD8DC);
      canvas.drawCircle(Offset(plateRect.left + 0.8, plateRect.center.dy), 0.4, boltPaint);
      canvas.drawCircle(Offset(plateRect.right - 0.8, plateRect.center.dy), 0.4, boltPaint);

      // -------------------------------------------------------------
      // 3. STEEL LATTICE TRUSS MAST (Square Cross-Braced Structure)
      // -------------------------------------------------------------
      final mastTopY = baseY - 16.5;
      final mastBottomY = baseY - 6.5;
      final mastMidY = baseY - 11.5;

      // Vertical corner angle-iron columns (Gunmetal with metallic edge highlights)
      final mastColPaint = Paint()..color = const Color(0xFF1E2328)..strokeWidth = 1.0;
      final edgeHighlightPaint = Paint()..color = const Color(0xFF788390)..strokeWidth = 0.5;

      // Left column
      canvas.drawLine(Offset(pos.dx - 2.5, mastBottomY), Offset(pos.dx - 2.1, mastTopY), mastColPaint);
      canvas.drawLine(Offset(pos.dx - 2.8, mastBottomY), Offset(pos.dx - 2.4, mastTopY), edgeHighlightPaint);

      // Right column
      canvas.drawLine(Offset(pos.dx + 2.5, mastBottomY), Offset(pos.dx + 2.1, mastTopY), mastColPaint);
      canvas.drawLine(Offset(pos.dx + 2.2, mastBottomY), Offset(pos.dx + 1.8, mastTopY), edgeHighlightPaint);

      // 3D Perspective center strut (gives hollow square truss depth)
      canvas.drawLine(
        Offset(pos.dx, mastBottomY),
        Offset(pos.dx, mastTopY),
        Paint()..color = const Color(0xFF12161A)..strokeWidth = 0.6,
      );

      // Multi-tier 'X' cross-bracing struts
      final strutPaint = Paint()
        ..color = const Color(0xFF4A5568)
        ..strokeWidth = 0.7;

      // Tier 1 (Lower half X-bracing)
      canvas.drawLine(Offset(pos.dx - 2.5, mastBottomY), Offset(pos.dx + 2.3, mastMidY), strutPaint);
      canvas.drawLine(Offset(pos.dx + 2.5, mastBottomY), Offset(pos.dx - 2.3, mastMidY), strutPaint);

      // Middle structural collar rail
      canvas.drawLine(Offset(pos.dx - 2.4, mastMidY), Offset(pos.dx + 2.4, mastMidY), mastColPaint);

      // Tier 2 (Upper half X-bracing)
      canvas.drawLine(Offset(pos.dx - 2.3, mastMidY), Offset(pos.dx + 2.1, mastTopY), strutPaint);
      canvas.drawLine(Offset(pos.dx + 2.3, mastMidY), Offset(pos.dx - 2.1, mastTopY), strutPaint);

      // Top mounting platform collar rail
      canvas.drawLine(Offset(pos.dx - 2.8, mastTopY), Offset(pos.dx + 2.8, mastTopY), mastColPaint);

      // -------------------------------------------------------------
      // 4. DUAL HOODED HALOGEN FLOODLIGHTS HEAD
      // -------------------------------------------------------------
      // Center electrical junction box with conduit pipe
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(pos.dx, mastTopY - 1.2), width: 3.4, height: 2.6),
          const Radius.circular(0.5),
        ),
        Paint()..color = const Color(0xFF1B2026),
      );

      // Dual swivel mounting arms
      final armPaint = Paint()..color = const Color(0xFF2D3748)..strokeWidth = 1.0;
      canvas.drawLine(Offset(pos.dx - 1.5, mastTopY - 0.8), Offset(pos.dx - 3.4, mastTopY - 1.6), armPaint);
      canvas.drawLine(Offset(pos.dx + 1.5, mastTopY - 0.8), Offset(pos.dx + 3.4, mastTopY - 1.6), armPaint);

      // Left & Right Floodlights
      _drawSingleFloodlight(
        canvas: canvas,
        center: Offset(pos.dx - 3.5, mastTopY - 1.8),
        angle: -0.48, // Angled outward & downward left (~28 deg)
      );

      _drawSingleFloodlight(
        canvas: canvas,
        center: Offset(pos.dx + 3.5, mastTopY - 1.8),
        angle: 0.48, // Angled outward & downward right (~28 deg)
      );
    }
  }

  /// Individual Hooded Floodlight with Parabolic Reflector & Halogen Flare
  void _drawSingleFloodlight({
    required Canvas canvas,
    required Offset center,
    required double angle,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);

    // 1. Outer Dark Protective Hood / Cowl Visor (Shielding top of lamp from weather)
    final cowlPath = Path()
      ..moveTo(-3.2, -1.8)
      ..lineTo(3.2, -1.8)
      ..lineTo(2.4, 1.4)
      ..lineTo(-2.4, 1.4)
      ..close();
    canvas.drawPath(cowlPath, Paint()..color = const Color(0xFF1A1F26));
    canvas.drawPath(
      cowlPath,
      Paint()
        ..color = const Color(0xFF4A5568)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5,
    );

    // 2. Inner Parabolic Golden Reflector Dish
    final dishRect = Rect.fromCenter(center: const Offset(0, 0.4), width: 4.8, height: 3.2);
    final dishPaint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xFFFFF9C4),
          Color(0xFFFFD54F),
          Color(0xFFFF8F00),
        ],
        stops: [0.0, 0.55, 1.0],
      ).createShader(dishRect);
    canvas.drawOval(dishRect, dishPaint);

    // 3. Radial Golden Halogen Corona Bloom
    final haloPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFFDE7).withValues(alpha: 0.95),
          const Color(0xFFFFD54F).withValues(alpha: 0.65),
          const Color(0xFFFF8F00).withValues(alpha: 0.25),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 0.70, 1.0],
      ).createShader(Rect.fromCircle(center: const Offset(0, 0.4), radius: 5.5));
    canvas.drawCircle(const Offset(0, 0.4), 5.5, haloPaint);

    // 4. Core Quartz-Halogen White Filament Hot-Spot
    canvas.drawCircle(const Offset(0, 0.4), 1.4, Paint()..color = Colors.white);
    canvas.drawCircle(const Offset(0, 0.4), 0.7, Paint()..color = const Color(0xFFFFF9C4));

    canvas.restore();
  }

  /// Atmospheric Cinematic Vignette & Tactical Reticle Marks
  void _drawHdVignette(Canvas canvas, double mapWidth, double mapHeight) {
    final mapRect = Rect.fromLTWH(0, 0, mapWidth, mapHeight);
    final vignettePaint = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 0.95,
        colors: [
          Colors.transparent,
          Colors.transparent,
          const Color(0xFF0F172A).withValues(alpha: 0.35),
        ],
        stops: const [0.0, 0.75, 1.0],
      ).createShader(mapRect);
    canvas.drawRect(mapRect, vignettePaint);

    // High-Quality Tactical Corner Brackets
    final bracketPaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.35)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    const bLen = 10.0;
    // Top-Left
    canvas.drawLine(const Offset(4, 4), const Offset(4 + bLen, 4), bracketPaint);
    canvas.drawLine(const Offset(4, 4), const Offset(4, 4 + bLen), bracketPaint);
    // Top-Right
    canvas.drawLine(Offset(mapWidth - 4, 4), Offset(mapWidth - 4 - bLen, 4), bracketPaint);
    canvas.drawLine(Offset(mapWidth - 4, 4), Offset(mapWidth - 4, 4 + bLen), bracketPaint);
    // Bottom-Left
    canvas.drawLine(Offset(4, mapHeight - 4), Offset(4 + bLen, mapHeight - 4), bracketPaint);
    canvas.drawLine(Offset(4, mapHeight - 4), Offset(4, mapHeight - 4 - bLen), bracketPaint);
    // Bottom-Right
    canvas.drawLine(Offset(mapWidth - 4, mapHeight - 4), Offset(mapWidth - 4 - bLen, mapHeight - 4), bracketPaint);
    canvas.drawLine(Offset(mapWidth - 4, mapHeight - 4), Offset(mapWidth - 4, mapHeight - 4 - bLen), bracketPaint);
  }

  /// Actor rendering with drop shadows, orientation, and HD vision cones
  void _drawActor(
    Canvas canvas,
    double x,
    double y, {
    bool isPlayer = false,
    bool isGuard = false,
    bool isFalkov = false,
    bool isAlert = false,
    bool isDefeated = false,
    double angle = 0.0,
  }) {
    canvas.save();
    canvas.translate(x + 5, y + 5);

    // Multi-stage realistic drop shadow
    canvas.drawCircle(const Offset(1.2, 1.6), 5.4, Paint()..color = Colors.black38);

    if (isPlayer) {
      canvas.rotate(angle);

      // Ramon Spectre (Dark assassin tactical suit, muscular shoulders, silenced pistol)
      // Directional laser sight indicator
      final laserPaint = Paint()
        ..color = const Color(0xFF00E5FF).withValues(alpha: 0.5)
        ..strokeWidth = 0.6;
      canvas.drawLine(const Offset(5, 0), const Offset(20, 0), laserPaint);
      canvas.drawCircle(const Offset(20, 0), 0.8, Paint()..color = const Color(0xFF00E5FF));

      // Tactical body/torso with carbon-fiber vest shading
      final bodyRect = const Rect.fromLTWH(-4.5, -4.5, 9.0, 9.0);
      final bodyPaint = Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.2, -0.2),
          colors: [Color(0xFF334155), Color(0xFF1E293B), Color(0xFF0F172A)],
        ).createShader(bodyRect);
      canvas.drawCircle(Offset.zero, 5.0, bodyPaint);

      // Utility harness straps
      final harnessPaint = Paint()..color = const Color(0xFF0F172A)..strokeWidth = 1.0;
      canvas.drawLine(const Offset(-3, -3), const Offset(3, 3), harnessPaint);
      canvas.drawLine(const Offset(-3, 3), const Offset(3, -3), harnessPaint);

      // Head with Black Tactical Bandana
      canvas.drawCircle(const Offset(-0.5, 0), 2.8, Paint()..color = const Color(0xFF0F172A));
      // Bandana cloth knot at back
      canvas.drawCircle(const Offset(-3.2, 0), 1.2, Paint()..color = const Color(0xFF090D16));
      canvas.drawLine(const Offset(-3.2, 0), const Offset(-4.8, -1.2), Paint()..color = const Color(0xFF090D16)..strokeWidth = 0.8);
      canvas.drawLine(const Offset(-3.2, 0), const Offset(-4.8, 1.2), Paint()..color = const Color(0xFF090D16)..strokeWidth = 0.8);

      // Silenced Tactical Pistol held with two hands
      final gunPaint = Paint()..color = const Color(0xFF0F172A);
      canvas.drawRect(const Rect.fromLTWH(3.0, -1.0, 5.5, 2.0), gunPaint);
      // Suppressor / Silencer cylinder
      canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(8.0, -0.8, 4.0, 1.6), const Radius.circular(0.6)),
        Paint()..color = const Color(0xFF334155),
      );
    } else if (isFalkov) {
      // Falkov (Blonde hair, glasses gleam, brown leather vest)
      final vestPaint = Paint()
        ..shader = const RadialGradient(
          center: Alignment(-0.2, -0.2),
          colors: [Color(0xFFA1887F), Color(0xFF8D6E63), Color(0xFF5D4037)],
        ).createShader(const Rect.fromLTWH(-4.5, -4.5, 9, 9));
      canvas.drawCircle(Offset.zero, 4.8, vestPaint);

      // Blonde layered hair
      canvas.drawCircle(const Offset(0, -1.2), 3.0, Paint()..color = const Color(0xFFFFD54F));
      canvas.drawCircle(const Offset(-0.8, -1.8), 1.5, Paint()..color = const Color(0xFFFFE082));

      // Wireframe spectacles gleam
      final glassPaint = Paint()..color = Colors.white..strokeWidth = 0.6..style = PaintingStyle.stroke;
      canvas.drawCircle(const Offset(-1.2, -0.2), 0.9, glassPaint);
      canvas.drawCircle(const Offset(1.2, -0.2), 0.9, glassPaint);

      // High-Definition Dialogue Speech Bubble
      canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(-7, -15, 14, 9), const Radius.circular(3.5)),
        Paint()..color = Colors.white,
      );
      final bubbleTail = Path()
        ..moveTo(-2, -6)
        ..lineTo(0, -3)
        ..lineTo(2, -6)
        ..close();
      canvas.drawPath(bubbleTail, Paint()..color = Colors.white);
      // Three dots "..."
      final dotPaint = Paint()..color = const Color(0xFF1E293B);
      canvas.drawCircle(const Offset(-3.2, -10.5), 0.8, dotPaint);
      canvas.drawCircle(const Offset(0, -10.5), 0.8, dotPaint);
      canvas.drawCircle(const Offset(3.2, -10.5), 0.8, dotPaint);
    } else {
      // -------------------------------------------------------------
      // AUTHENTIC SECURITY GUARD (Matching Character Reference Art):
      // Steel blue corporate suit blazer, white collared shirt with dark necktie,
      // tilted military blue beret with golden cap badge, and assault rifle.
      // -------------------------------------------------------------
      if (isDefeated) {
        // Neutralized Guard lying prone on snow
        canvas.save();
        canvas.rotate(angle);
        // Prone body in steel blue suit
        canvas.drawOval(
          Rect.fromCenter(center: Offset.zero, width: 9.5, height: 6.0),
          Paint()..color = const Color(0xFF2C4666),
        );
        // Brown boots
        canvas.drawCircle(const Offset(-4.5, 1.2), 1.6, Paint()..color = const Color(0xFF5D3A1F));
        canvas.drawCircle(const Offset(-4.5, -1.2), 1.6, Paint()..color = const Color(0xFF5D3A1F));
        // Dislodged Blue Beret on snow
        canvas.drawCircle(const Offset(3.5, 2.8), 2.4, Paint()..color = const Color(0xFF3B5B82));
        canvas.drawCircle(const Offset(4.0, 2.2), 0.7, Paint()..color = const Color(0xFFF59E0B)); // Gold badge
        // Dropped Assault Rifle
        canvas.drawRect(const Rect.fromLTWH(0.0, -4.5, 6.5, 1.4), Paint()..color = const Color(0xFF1E2228));
        canvas.drawRect(const Rect.fromLTWH(2.0, -3.2, 1.2, 1.6), Paint()..color = const Color(0xFF374151)); // Magazine
        // Takedown marker
        final xPaint = Paint()..color = const Color(0xFF90A4AE)..strokeWidth = 0.8;
        canvas.drawLine(const Offset(-2, -2), const Offset(2, 2), xPaint);
        canvas.drawLine(const Offset(-2, 2), const Offset(2, -2), xPaint);
        canvas.restore();
      } else {
        canvas.save();
        canvas.rotate(angle);

        // 1. Dynamic Perception Vision Cone
        final coneColor = isAlert ? const Color(0xFFFF1744) : const Color(0xFF00E5FF);
        final conePaint = Paint()
          ..shader = RadialGradient(
            center: Alignment.centerLeft,
            radius: 1.0,
            colors: [
              coneColor.withValues(alpha: isAlert ? 0.45 : 0.35),
              coneColor.withValues(alpha: 0.12),
              Colors.transparent,
            ],
          ).createShader(const Rect.fromLTWH(0, -18, 36, 36));

        final cone = Path()
          ..moveTo(0, 0)
          ..lineTo(32, -18)
          ..lineTo(32, 18)
          ..close();
        canvas.drawPath(cone, conePaint);

        // Radar sweep perimeter line
        final radarRimPaint = Paint()
          ..color = coneColor.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8;
        canvas.drawArc(
          const Rect.fromLTWH(-32, -32, 64, 64),
          -0.52,
          1.04,
          false,
          radarRimPaint,
        );

        // 2. Brown Combat Boots & Steel Blue Trousers
        // Left & right boots slightly visible below suit hem
        final bootPaint = Paint()..color = const Color(0xFF5D3A1F);
        final solePaint = Paint()..color = const Color(0xFF1F1A17);
        canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(-4.0, -3.8, 3.2, 1.8), const Radius.circular(0.8)), bootPaint);
        canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(-4.0, -3.8, 3.2, 0.6), const Radius.circular(0.3)), solePaint);
        canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(-4.0, 2.0, 3.2, 1.8), const Radius.circular(0.8)), bootPaint);
        canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(-4.0, 3.2, 3.2, 0.6), const Radius.circular(0.3)), solePaint);

        // 3. Tailored Steel Blue Uniform Suit Blazer
        final suitRect = const Rect.fromLTWH(-4.8, -4.8, 9.6, 9.6);
        final suitPaint = Paint()
          ..shader = const RadialGradient(
            center: Alignment(-0.25, -0.2),
            colors: [
              Color(0xFF4A6E9B),
              Color(0xFF355278),
              Color(0xFF223650),
            ],
          ).createShader(suitRect);
        canvas.drawCircle(Offset.zero, 5.2, suitPaint);

        // Suit shoulder seams & sleeve caps
        final seamPaint = Paint()..color = const Color(0xFF1B2B3F)..strokeWidth = 0.7;
        canvas.drawLine(const Offset(-2.8, -4.5), const Offset(-0.5, -4.8), seamPaint);
        canvas.drawLine(const Offset(-2.8, 4.5), const Offset(-0.5, 4.8), seamPaint);

        // 4. White Shirt Collar & Dark Formal Necktie
        // Crisp White Shirt V-neck opening
        final shirtPath = Path()
          ..moveTo(-1.2, -1.8)
          ..lineTo(1.5, 0.0)
          ..lineTo(-1.2, 1.8)
          ..close();
        canvas.drawPath(shirtPath, Paint()..color = Colors.white);

        // Dark Charcoal / Black Necktie Knot & Length
        final tiePaint = Paint()..color = const Color(0xFF141920);
        canvas.drawCircle(const Offset(-0.4, 0.0), 0.9, tiePaint); // Knot
        final tiePath = Path()
          ..moveTo(-0.4, -0.6)
          ..lineTo(2.0, 0.0)
          ..lineTo(-0.4, 0.6)
          ..close();
        canvas.drawPath(tiePath, tiePaint); // Tie blade

        // 5. Hands Gripping Assault Rifle (Tanned Skin Tone)
        final skinPaint = Paint()..color = const Color(0xFFD4A373);
        canvas.drawCircle(const Offset(2.2, 1.6), 1.1, skinPaint); // Trigger hand
        canvas.drawCircle(const Offset(5.0, 0.6), 1.1, skinPaint); // Handguard grip

        // 6. Tactical Assault Rifle (Frame 4 from reference art)
        // Gunmetal Receiver & Stock
        final gunPaint = Paint()..color = const Color(0xFF1E2228);
        canvas.drawRect(const Rect.fromLTWH(1.5, -0.8, 6.2, 1.6), gunPaint);
        // Stock resting against shoulder
        canvas.drawRect(const Rect.fromLTWH(-1.2, -0.6, 2.7, 1.2), Paint()..color = const Color(0xFF15191E));
        // Extended Barrel & Flash Hider
        canvas.drawLine(const Offset(7.7, 0.0), const Offset(10.2, 0.0), Paint()..color = const Color(0xFF15191E)..strokeWidth = 1.0);
        canvas.drawCircle(const Offset(10.2, 0.0), 0.7, Paint()..color = const Color(0xFF374151)); // Muzzle tip
        // Curved Banana Magazine
        final magPaint = Paint()..color = const Color(0xFF374151);
        final magPath = Path()
          ..moveTo(3.8, 0.8)
          ..lineTo(4.8, 0.8)
          ..quadraticBezierTo(5.2, 2.4, 4.4, 3.2)
          ..lineTo(3.4, 3.0)
          ..quadraticBezierTo(4.0, 2.2, 3.8, 0.8)
          ..close();
        canvas.drawPath(magPath, magPaint);

        // 7. Head with Tilted Military Blue Beret & Golden Cap Badge
        // Head / Face base (Tanned skin tone)
        canvas.drawCircle(const Offset(-0.4, -0.8), 2.9, skinPaint);
        // Dark brown cropped hair at nape and sideburns
        final hairPaint = Paint()..color = const Color(0xFF3E2723);
        canvas.drawCircle(const Offset(-1.8, -1.0), 1.8, hairPaint);

        // Military Blue Beret (Slanted crown draped to the left)
        final beretRect = const Rect.fromLTWH(-2.8, -3.8, 5.6, 4.4);
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

        // Golden / Bronze Circular Cap Badge / Insignia (Right crown)
        final badgePaint = Paint()..color = const Color(0xFFF59E0B);
        final badgeGlint = Paint()..color = const Color(0xFFFDE68A);
        canvas.drawCircle(const Offset(0.8, -2.6), 1.0, badgePaint);
        canvas.drawCircle(const Offset(0.8, -2.6), 0.5, badgeGlint);

        // 8. Dynamic Alert Warning Badge [!] if isAlert
        if (isAlert) {
          // Radial warning bloom
          canvas.drawCircle(
            const Offset(0, -9.0),
            4.2,
            Paint()..color = const Color(0xFFFF1744).withValues(alpha: 0.35),
          );
          // Red Hexagonal / Circular Badge
          canvas.drawCircle(const Offset(0, -9.0), 3.0, Paint()..color = const Color(0xFFFF1744));
          // White exclamation mark
          final exclPaint = Paint()..color = Colors.white..strokeWidth = 1.0;
          canvas.drawLine(const Offset(0, -10.5), const Offset(0, -8.7), exclPaint);
          canvas.drawCircle(const Offset(0, -7.8), 0.45, Paint()..color = Colors.white);
        }

        canvas.restore();
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant AuthenticTilemapPainter oldDelegate) {
    return true; // Continuously repaints as guards and player move
  }
}

