import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Authentic waypoint definition for patrol guards.
class GuardWaypoint {
  final double gridX;
  final double gridY;
  final double waitTime; // seconds
  final int direction; // 0..7 clockwise starting from Up (0)

  const GuardWaypoint({
    required this.gridX,
    required this.gridY,
    required this.waitTime,
    required this.direction,
  });

  /// Converts J2ME 8-direction format to radians.
  /// 0: Up (-pi/2), 2: Right (0), 4: Down (pi/2), 6: Left (pi).
  double get angle {
    return (direction * (math.pi / 4)) - (math.pi / 2);
  }
}

/// Dynamic active guard with real-time waypoint patrol, head scanning, and alert perception.
class ActiveGuard {
  final int id;
  final int entityType;
  Offset position; // in grid units (0..17, 0..24)
  double angle; // in radians
  int waypointIndex;
  double waitRemaining;
  bool isDefeated;
  bool isAlert;
  double scanPhase;
  final List<GuardWaypoint> waypoints;

  ActiveGuard({
    required this.id,
    required this.entityType,
    required this.position,
    required this.angle,
    required this.waypoints,
    this.waypointIndex = 0,
    this.waitRemaining = 0.0,
    this.isDefeated = false,
    this.isAlert = false,
    this.scanPhase = 0.0,
  });

  /// Updates guard position and orientation based on elapsed delta time (seconds).
  void update(double dt) {
    if (isDefeated) return;

    scanPhase += dt;

    if (waypoints.length <= 1) {
      // Sentry Guard: continuously sweeps vision cone across watch perimeter
      final baseAngle = waypoints.isNotEmpty ? waypoints[0].angle : math.pi / 2;
      angle = baseAngle + math.sin(scanPhase * 1.5) * 0.45;
      return;
    }

    if (waitRemaining > 0) {
      waitRemaining -= dt;
      if (waitRemaining > 0) {
        // Active head-turning scan while halted
        final targetWp = waypoints[waypointIndex];
        angle = targetWp.angle + math.sin(scanPhase * 2.0) * 0.25;
        return;
      }
    }

    // Move smoothly towards current waypoint target
    final targetWp = waypoints[waypointIndex];
    final targetPos = Offset(targetWp.gridX, targetWp.gridY);
    final delta = targetPos - position;
    final dist = delta.distance;

    final speed = isAlert ? 1.8 : 1.1; // tiles per second
    final step = speed * dt;

    if (dist <= step) {
      position = targetPos;
      angle = targetWp.angle;
      waitRemaining = targetWp.waitTime;
      waypointIndex = (waypointIndex + 1) % waypoints.length;
    } else {
      angle = delta.direction;
      position += Offset.fromDirection(angle, step);
    }
  }

  /// Factory loading Level 0 authentic guards
  static List<ActiveGuard> createLevel0Guards() {
    return [
      // 1. South Corridor Patrol Guard
      ActiveGuard(
        id: 1,
        entityType: 1,
        position: const Offset(10.0, 21.0),
        angle: -math.pi / 2,
        waypointIndex: 1,
        waitRemaining: 1.0,
        waypoints: const [
          GuardWaypoint(gridX: 10.0, gridY: 21.0, waitTime: 2.0, direction: 2),
          GuardWaypoint(gridX: 10.0, gridY: 16.0, waitTime: 0.6, direction: 0),
          GuardWaypoint(gridX: 8.0, gridY: 16.0, waitTime: 1.8, direction: 4),
          GuardWaypoint(gridX: 8.0, gridY: 21.0, waitTime: 0.8, direction: 4),
          GuardWaypoint(gridX: 10.0, gridY: 21.0, waitTime: 1.5, direction: 2),
        ],
      ),
      // 2. North Gate Sentry Guard (Active vision cone sweeping across gate)
      ActiveGuard(
        id: 2,
        entityType: 2,
        position: const Offset(8.5, 2.2),
        angle: math.pi / 2, // Facing down
        waypoints: const [
          GuardWaypoint(gridX: 8.5, gridY: 2.2, waitTime: 0.0, direction: 4),
        ],
      ),
      // 3. Central Courtyard Patrol Guard
      ActiveGuard(
        id: 4,
        entityType: 4,
        position: const Offset(8.0, 13.0),
        angle: 0.0, // Facing right
        waypointIndex: 1,
        waitRemaining: 1.0,
        waypoints: const [
          GuardWaypoint(gridX: 8.0, gridY: 13.0, waitTime: 2.0, direction: 2),
          GuardWaypoint(gridX: 13.0, gridY: 13.0, waitTime: 2.5, direction: 6),
        ],
      ),
    ];
  }
}
