import 'package:flutter/material.dart';

/// Collision manager handling authentic physical boundaries for Level 0
/// (walls, blast doors, buildings, security fences, and facility obstacles).
///
/// Prevents the player from penetrating solid geometry while supporting
/// smooth tangential wall-sliding along unblocked axes.
class LevelCollision {
  static const double mapWidth = 170.0;
  static const double mapHeight = 240.0;
  static const double playerRadius = 4.2;

  /// Static obstacle bounding boxes in native map pixel coordinates (170 x 240).
  static const List<Rect> obstacles = [
    // 1. North Perimeter Wall & Reinforced North Blast Gate (Y: 0..20, X: 0..170)
    Rect.fromLTWH(0.0, 0.0, 170.0, 20.0),

    // 2. West Boundary Perimeter Wall (X: 0..7, Y: 0..240)
    Rect.fromLTWH(0.0, 0.0, 7.0, 240.0),

    // 3. Catwalk Bridge connecting West Wall to Left Building (X: 7..23, Y: 68..77)
    Rect.fromLTWH(7.0, 68.0, 16.0, 9.0),

    // 4. Left Military Building (X: 23..66, Y: 66..188)
    // Encompasses aggregate roof, solid concrete plinth, West Blast Door (X: 34..45, Y: 178..188),
    // and concealment lockers (X: 47..55, Y: 178..188).
    Rect.fromLTWH(23.0, 66.0, 43.0, 122.0),

    // 5. Right L-Shaped Building - North Wing (X: 83..167, Y: 66..122)
    Rect.fromLTWH(83.0, 66.0, 84.0, 56.0),

    // 6. Right L-Shaped Building - South Wing (X: 124..167, Y: 122..188)
    // Encompasses East Blast Extraction Door (X: 134..145, Y: 178..188).
    Rect.fromLTWH(124.0, 122.0, 43.0, 66.0),

    // 7. East Boundary Perimeter Wall (X: 163..170, Y: 0..240)
    Rect.fromLTWH(163.0, 0.0, 7.0, 240.0),

    // 8. South Perimeter Boundary Wall (X: 0..170, Y: 222..240)
    Rect.fromLTWH(0.0, 222.0, 170.0, 18.0),

    // 9. Chain-link Security Fence & Razor Wire (X: 42..79, Y: 42..50)
    Rect.fromLTWH(42.0, 42.0, 37.0, 8.0),

    // 10. South Courtyard "GM" Siberian Pylon (Centered at (72, 172))
    Rect.fromLTWH(67.5, 168.5, 9.0, 7.0),
  ];

  /// Tests if a circle centered at native pixel coordinates (cx, cy) with [radius]
  /// collides with any solid obstacle or the outer map borders.
  /// If [isWestDoorUnlocked] is true, the doorway opening at (X: 34..45, Y: 178..188) allows passage.
  static bool isColliding(
    double cx,
    double cy, {
    double radius = playerRadius,
    bool isWestDoorUnlocked = false,
  }) {
    // 1. Map boundary containment
    if (cx - radius < 0 || cx + radius > mapWidth || cy - radius < 0 || cy + radius > mapHeight) {
      return true;
    }

    // 2. Obstacle AABB circle-distance test
    for (int i = 0; i < obstacles.length; i++) {
      final rect = obstacles[i];

      // Left building is index 3 (X: 23..66, Y: 66..188)
      if (i == 3 && isWestDoorUnlocked) {
        // When door is unlocked and player is either inside the room or entering through the doorway
        // Walkable interior is X: 28..61, Y: 72..188
        if (cx >= 27.0 && cx <= 62.0 && cy >= 71.0 && cy <= 194.0) {
          // Check interior room walls and partition:
          // Left inner wall
          if (cx - radius < 28.0) return true;
          // Right inner wall
          if (cx + radius > 61.0) return true;
          // North inner wall
          if (cy - radius < 72.0) return true;
          // Center partition desk (X: 38..52, Y: 114..132)
          if (cx + radius > 38.0 && cx - radius < 52.0 && cy + radius > 114.0 && cy - radius < 132.0) {
            return true;
          }
          // Inside walkable area
          continue;
        }
      }

      final closestX = cx.clamp(rect.left, rect.right);
      final closestY = cy.clamp(rect.top, rect.bottom);
      final dx = cx - closestX;
      final dy = cy - closestY;

      if ((dx * dx + dy * dy) < (radius * radius)) {
        return true;
      }
    }

    return false;
  }

  /// Tests if a normalized position (0.0..1.0, 0.0..1.0) is blocked by walls or doors.
  static bool isPositionBlocked(
    Offset normalizedPos, {
    double radius = playerRadius,
    bool isWestDoorUnlocked = false,
  }) {
    final cx = normalizedPos.dx * mapWidth + 5.0;
    final cy = normalizedPos.dy * mapHeight + 5.0;
    return isColliding(cx, cy, radius: radius, isWestDoorUnlocked: isWestDoorUnlocked);
  }

  /// Calculates the resolved player position after moving by [moveDir],
  /// applying wall-sliding along unblocked axes when encountering walls or doors.
  static Offset resolveMovement({
    required Offset currentNormalizedPos,
    required Offset moveDir,
    double speedPxPerSec = 52.0, // ~5.2 tiles per second
    double dt = 0.032,
    double radius = playerRadius,
    bool isWestDoorUnlocked = false,
  }) {
    if (moveDir == Offset.zero) return currentNormalizedPos;

    // Normalize direction vector
    Offset dir = moveDir;
    final dirLen = dir.distance;
    if (dirLen > 1.0) {
      dir = Offset(dir.dx / dirLen, dir.dy / dirLen);
    }

    final double step = speedPxPerSec * dt;
    final double currentPxX = currentNormalizedPos.dx * mapWidth;
    final double currentPxY = currentNormalizedPos.dy * mapHeight;

    final double deltaPxX = dir.dx * step;
    final double deltaPxY = dir.dy * step;

    // 1. Attempt Full Movement (Diagonal or Direct)
    final targetX = currentPxX + deltaPxX;
    final targetY = currentPxY + deltaPxY;
    if (!isColliding(targetX + 5.0, targetY + 5.0, radius: radius, isWestDoorUnlocked: isWestDoorUnlocked)) {
      return Offset(targetX / mapWidth, targetY / mapHeight);
    }

    // 2. Wall Sliding: Attempt Horizontal-Only Movement
    if (deltaPxX.abs() > 0.001) {
      if (!isColliding(targetX + 5.0, currentPxY + 5.0, radius: radius, isWestDoorUnlocked: isWestDoorUnlocked)) {
        return Offset(targetX / mapWidth, currentNormalizedPos.dy);
      }
    }

    // 3. Wall Sliding: Attempt Vertical-Only Movement
    if (deltaPxY.abs() > 0.001) {
      if (!isColliding(currentPxX + 5.0, targetY + 5.0, radius: radius, isWestDoorUnlocked: isWestDoorUnlocked)) {
        return Offset(currentNormalizedPos.dx, targetY / mapHeight);
      }
    }

    // 4. Completely blocked (Cornered against wall/door)
    return currentNormalizedPos;
  }
}
