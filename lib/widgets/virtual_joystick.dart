import 'package:flutter/material.dart';

/// Ultra-HD Virtual Analog Joystick:
/// Diamond knurled metallic thumbpad, laser-etched precision rings,
/// and responsive neon amber direction glow.
class VirtualJoystick extends StatefulWidget {
  final ValueChanged<Offset> onDirectionChanged;
  final double radius;
  final double thumbRadius;

  const VirtualJoystick({
    super.key,
    required this.onDirectionChanged,
    this.radius = 72.0, // 144px diameter
    this.thumbRadius = 32.0, // 64px diameter thumb
  });

  @override
  State<VirtualJoystick> createState() => _VirtualJoystickState();
}

class _VirtualJoystickState extends State<VirtualJoystick> {
  Offset _thumbPosition = Offset.zero;
  bool _isDragging = false;

  void _updatePosition(Offset localOffset) {
    final center = Offset(widget.radius, widget.radius);
    final delta = localOffset - center;
    final distance = delta.distance;

    final maxDistance = widget.radius - widget.thumbRadius * 0.45;
    Offset clampedDelta;
    if (distance > maxDistance) {
      clampedDelta = Offset.fromDirection(delta.direction, maxDistance);
    } else {
      clampedDelta = delta;
    }

    setState(() {
      _thumbPosition = clampedDelta;
      _isDragging = true;
    });

    final normalized = Offset(
      clampedDelta.dx / maxDistance,
      clampedDelta.dy / maxDistance,
    );
    widget.onDirectionChanged(normalized);
  }

  void _resetPosition() {
    setState(() {
      _thumbPosition = Offset.zero;
      _isDragging = false;
    });
    widget.onDirectionChanged(Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.radius * 2;

    return GestureDetector(
      onPanStart: (details) => _updatePosition(details.localPosition),
      onPanUpdate: (details) => _updatePosition(details.localPosition),
      onPanEnd: (_) => _resetPosition(),
      onPanCancel: () => _resetPosition(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              const Color(0xFF161F2C).withValues(alpha: 0.8),
              const Color(0xFF0B1017).withValues(alpha: 0.9),
            ],
          ),
          border: Border.all(
            color: _isDragging
                ? const Color(0xFFFFB74D)
                : const Color(0xFFFF9800).withValues(alpha: 0.5),
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.7),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
            if (_isDragging)
              BoxShadow(
                color: const Color(0xFFFF9800).withValues(alpha: 0.35),
                blurRadius: 20,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Laser-etched reticle guide
            CustomPaint(
              size: Size(size, size),
              painter: _HDJoystickReticlePainter(isDragging: _isDragging),
            ),

            // Ultra-HD Draggable Thumbstick
            Transform.translate(
              offset: _thumbPosition,
              child: Container(
                width: widget.thumbRadius * 2,
                height: widget.thumbRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    center: Alignment(-0.2, -0.3),
                    radius: 0.85,
                    colors: [
                      Color(0xFFFFCC80),
                      Color(0xFFFF9800),
                      Color(0xFFE65100),
                      Color(0xFFBF360C),
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF9800).withValues(alpha: 0.6),
                      blurRadius: 14,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.8),
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: widget.thumbRadius * 0.9,
                    height: widget.thumbRadius * 0.9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black38, width: 1.5),
                      gradient: const RadialGradient(
                        colors: [
                          Color(0xFFFFE0B2),
                          Color(0xFFFF9800),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.navigation,
                      color: Color(0xFF1E2836),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HDJoystickReticlePainter extends CustomPainter {
  final bool isDragging;
  _HDJoystickReticlePainter({required this.isDragging});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = (isDragging ? const Color(0xFFFFB74D) : Colors.white).withValues(alpha: 0.25)
      ..strokeWidth = 1.5;

    // Crosshairs
    canvas.drawLine(Offset(center.dx, 8), Offset(center.dx, 22), paint);
    canvas.drawLine(Offset(center.dx, size.height - 22), Offset(center.dx, size.height - 8), paint);
    canvas.drawLine(Offset(8, center.dy), Offset(22, center.dy), paint);
    canvas.drawLine(Offset(size.width - 22, center.dy), Offset(size.width - 8, center.dy), paint);

    // Inner orbital rings
    final ringPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.10)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawCircle(center, size.width * 0.32, ringPaint);
    canvas.drawCircle(center, size.width * 0.16, ringPaint);
  }

  @override
  bool shouldRepaint(covariant _HDJoystickReticlePainter oldDelegate) => oldDelegate.isDragging != isDragging;
}
