import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Modern Touch Sensor Joystick:
/// - Completely invisible when idle ("not showing joystick").
/// - Dynamic touch sensing: Touching anywhere in the control zone dynamically
///   anchors the touch origin under the user's finger.
/// - Floating holographic sensor reticle blooms only while actively dragging.
/// - Smooth analog deadzone, dynamic origin tracking, and variable stealth/sprint speed scaling.
class TouchSensorJoystick extends StatefulWidget {
  final ValueChanged<Offset> onDirectionChanged;
  final double maxRadius;
  final double deadZone;
  final bool showSensorOnTouch;

  const TouchSensorJoystick({
    super.key,
    required this.onDirectionChanged,
    this.maxRadius = 52.0,
    this.deadZone = 5.0,
    this.showSensorOnTouch = true,
  });

  @override
  State<TouchSensorJoystick> createState() => _TouchSensorJoystickState();
}

class _TouchSensorJoystickState extends State<TouchSensorJoystick>
    with SingleTickerProviderStateMixin {
  Offset? _origin;
  Offset? _current;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _handlePanStart(DragStartDetails details) {
    setState(() {
      _origin = details.localPosition;
      _current = details.localPosition;
    });
    _fadeController.forward();
    _evaluateVector();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (_origin == null) return;

    final newPos = details.localPosition;
    final delta = newPos - _origin!;
    final dist = delta.distance;

    // Dynamic Floating Anchor: If user drags further than 1.4x maxRadius,
    // smoothly drag the origin along so controls never feel locked or out of reach.
    if (dist > widget.maxRadius * 1.35) {
      final excess = dist - (widget.maxRadius * 1.35);
      final shift = Offset.fromDirection(delta.direction, excess);
      _origin = _origin! + shift;
    }

    setState(() {
      _current = newPos;
    });

    _evaluateVector();
  }

  void _handlePanEnd([DragEndDetails? details]) {
    _fadeController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _origin = null;
          _current = null;
        });
      }
    });
    widget.onDirectionChanged(Offset.zero);
  }

  void _evaluateVector() {
    if (_origin == null || _current == null) {
      widget.onDirectionChanged(Offset.zero);
      return;
    }

    final delta = _current! - _origin!;
    final dist = delta.distance;

    if (dist < widget.deadZone) {
      widget.onDirectionChanged(Offset.zero);
      return;
    }

    // Normalized magnitude (0.0 .. 1.0)
    final clampedDist = math.min(dist, widget.maxRadius);
    final intensity = (clampedDist - widget.deadZone) / (widget.maxRadius - widget.deadZone);
    final normalized = Offset.fromDirection(delta.direction, intensity.clamp(0.0, 1.0));

    widget.onDirectionChanged(normalized);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: _handlePanStart,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      onPanCancel: _handlePanEnd,
      child: AnimatedBuilder(
        animation: _fadeController,
        builder: (context, child) {
          if (!widget.showSensorOnTouch || _origin == null || _current == null || _fadeController.value == 0.0) {
            return const SizedBox.expand();
          }

          return CustomPaint(
            size: Size.infinite,
            painter: _TouchSensorPainter(
              origin: _origin!,
              current: _current!,
              maxRadius: widget.maxRadius,
              opacity: _fadeController.value,
            ),
          );
        },
      ),
    );
  }
}

/// Custom painter for the modern, futuristic touch-sensor holographic feedback
class _TouchSensorPainter extends CustomPainter {
  final Offset origin;
  final Offset current;
  final double maxRadius;
  final double opacity;

  _TouchSensorPainter({
    required this.origin,
    required this.current,
    required this.maxRadius,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity <= 0.01) return;

    final delta = current - origin;
    final dist = delta.distance;
    final clampedDist = math.min(dist, maxRadius);
    final clampedThumb = origin + (dist > 0 ? Offset.fromDirection(delta.direction, clampedDist) : Offset.zero);

    // Color definitions with dynamic opacity
    final cyanPrimary = const Color(0xFF00E5FF).withValues(alpha: 0.85 * opacity);
    final cyanSecondary = const Color(0xFF00B0FF).withValues(alpha: 0.40 * opacity);
    final cyanSoft = const Color(0xFF00E5FF).withValues(alpha: 0.12 * opacity);

    // 1. Dynamic Outer Sensor Perimeter Ring (at origin)
    final outerRingPaint = Paint()
      ..color = cyanSecondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    canvas.drawCircle(origin, maxRadius, outerRingPaint);

    // Soft ambient glow fill inside sensor zone
    final glowFillPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          cyanSoft,
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: origin, radius: maxRadius));
    canvas.drawCircle(origin, maxRadius, glowFillPaint);

    // 4 Tactical Crosshair Notches on Perimeter
    final notchPaint = Paint()
      ..color = cyanPrimary
      ..strokeWidth = 2.0;
    const nLen = 6.0;
    canvas.drawLine(Offset(origin.dx - maxRadius, origin.dy), Offset(origin.dx - maxRadius + nLen, origin.dy), notchPaint);
    canvas.drawLine(Offset(origin.dx + maxRadius - nLen, origin.dy), Offset(origin.dx + maxRadius, origin.dy), notchPaint);
    canvas.drawLine(Offset(origin.dx, origin.dy - maxRadius), Offset(origin.dx, origin.dy - maxRadius + nLen), notchPaint);
    canvas.drawLine(Offset(origin.dx, origin.dy + maxRadius - nLen), Offset(origin.dx, origin.dy + maxRadius), notchPaint);

    // 2. Central Sensor Anchor Dot
    final centerAnchorPaint = Paint()
      ..color = cyanPrimary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(origin, 3.0, centerAnchorPaint);
    canvas.drawCircle(origin, 8.0, Paint()..color = cyanSecondary..style = PaintingStyle.stroke..strokeWidth = 0.8);

    // 3. Directional Laser Trajectory Beam
    if (dist > 3.0) {
      final beamPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            cyanSecondary,
            cyanPrimary,
          ],
        ).createShader(Rect.fromPoints(origin, clampedThumb))
        ..strokeWidth = 2.0;
      canvas.drawLine(origin, clampedThumb, beamPaint);

      // Trajectory distance dots along laser
      final dotCount = (clampedDist / 12.0).floor();
      for (int i = 1; i <= dotCount; i++) {
        final p = origin + Offset.fromDirection(delta.direction, i * 12.0);
        canvas.drawCircle(p, 1.0, Paint()..color = cyanPrimary);
      }
    }

    // 4. Futuristic Thumb Touch Sensor Puck (Dynamic)
    // Outer drop shadow
    canvas.drawCircle(clampedThumb.translate(0, 2), 18.0, Paint()..color = Colors.black.withValues(alpha: 0.5 * opacity));

    // Outer cybernetic ring
    final puckBorderPaint = Paint()
      ..color = cyanPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(clampedThumb, 18.0, puckBorderPaint);

    // Core puck fill
    final puckBodyPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.2, -0.2),
        colors: [
          const Color(0xFF1E293B).withValues(alpha: 0.9 * opacity),
          const Color(0xFF0F172A).withValues(alpha: 0.95 * opacity),
        ],
      ).createShader(Rect.fromCircle(center: clampedThumb, radius: 18.0));
    canvas.drawCircle(clampedThumb, 17.0, puckBodyPaint);

    // Central pulsing tactile node
    final nodePaint = Paint()
      ..color = cyanPrimary
      ..style = PaintingStyle.fill;
    canvas.drawCircle(clampedThumb, 4.5, nodePaint);

    // Micro concentric reticle inside puck
    canvas.drawCircle(clampedThumb, 9.0, Paint()..color = cyanSecondary..style = PaintingStyle.stroke..strokeWidth = 0.8);
  }

  @override
  bool shouldRepaint(covariant _TouchSensorPainter oldDelegate) {
    return oldDelegate.origin != origin ||
        oldDelegate.current != current ||
        oldDelegate.opacity != opacity ||
        oldDelegate.maxRadius != maxRadius;
  }
}
