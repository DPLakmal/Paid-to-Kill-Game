import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../services/game_manager.dart';
import 'mission_select_screen.dart';
import 'settings_screen.dart';

/// Ultra-HD Paid to Kill Main Menu:
/// Cybernetic blueprint circuit grid, illuminated neon amber selector bar with glossy glass reflection,
/// high-resolution typography, and tactile softkeys.
class MainMenuScreen extends StatefulWidget {
  final GameManager gameManager;

  const MainMenuScreen({super.key, required this.gameManager});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  int _selectedIndex = 0;

  final List<String> _menuOptions = [
    'New game',
    'Settings',
    'Help',
    'About',
    'Exit',
  ];

  void _onSelect() {
    switch (_selectedIndex) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MissionSelectScreen(gameManager: widget.gameManager),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SettingsScreen(gameManager: widget.gameManager),
          ),
        );
        break;
      case 2:
        _showHDDialog(
          'OPERATIVE HANDBOOK',
          'Use the virtual joystick on the right to maneuver Ramon Spectre. Conceal inside closets to break guard vision cones. Tap the left Fire button for automatic silent neutralization.',
        );
        break;
      case 3:
        _showHDDialog(
          'CLASSIFIED INTEL',
          'PAID TO KILL // SHADOW CONTRACT\nUltra-HD Remake Edition.\nOriginal Design by Rovio Mobile Ltd (2005).\nRebuilt with Flutter & Unity as a Library.',
        );
        break;
      case 4:
        _showHDDialog(
          'ABORT CONTRACT',
          'Close app window to terminate the operation session.',
        );
        break;
    }
  }

  void _showHDDialog(String title, String body) {
    showDialog(
      context: context,
      builder: (ctx) => BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          backgroundColor: const Color(0xFF161F2C).withValues(alpha: 0.92),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
          ),
          title: Row(
            children: [
              const Icon(Icons.shield, color: Color(0xFF00E5FF), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF00E5FF),
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          content: Text(
            body,
            style: const TextStyle(
              color: Color(0xFFCFD8DC),
              fontSize: 13,
              height: 1.45,
              fontFamily: 'monospace',
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E5FF),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text('DISMISS', style: TextStyle(fontWeight: FontWeight.w900)),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080B10),
      body: SafeArea(
        child: Column(
          children: [
            // Menu Playfield with architectural grid lines
            Expanded(
              child: Stack(
                children: [
                  // High-tech blueprint circuit backdrop
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _HDMenuBackgroundPainter(),
                    ),
                  ),

                  // Menu Title & Items
                  Column(
                    children: [
                      const SizedBox(height: 36),
                      // Glowing Insignia & Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFFF9800).withValues(alpha: 0.15),
                              border: Border.all(color: const Color(0xFFFF9800), width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF9800).withValues(alpha: 0.4),
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.track_changes, color: Color(0xFFFF9800), size: 26),
                          ),
                          const SizedBox(width: 12),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PAID TO KILL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.5,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              Text(
                                'SHADOW CONTRACT // HD REMAKE',
                                style: TextStyle(
                                  color: Color(0xFF90A4AE),
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.8,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),

                      // Ultra-HD Menu items list
                      ...List.generate(_menuOptions.length, (index) {
                        final isSelected = index == _selectedIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedIndex = index);
                            _onSelect();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFFFFB74D),
                                        Color(0xFFFF9800),
                                        Color(0xFFF57C00),
                                      ],
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(8),
                              border: isSelected
                                  ? Border.all(color: Colors.white, width: 2.0)
                                  : Border.all(color: Colors.white.withValues(alpha: 0.08), width: 1.0),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFFFF9800).withValues(alpha: 0.5),
                                        blurRadius: 16,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                              color: isSelected ? null : Colors.white.withValues(alpha: 0.03),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (isSelected) ...[
                                  const Icon(Icons.arrow_right, color: Colors.black, size: 24),
                                  const SizedBox(width: 4),
                                ],
                                Text(
                                  _menuOptions[index].toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isSelected ? Colors.black : const Color(0xFFCFD8DC),
                                    fontSize: 16,
                                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                                    fontFamily: 'monospace',
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),

            // Ultra-HD Bottom Softkeys Bar
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Color(0xFF0F131A),
                border: Border(top: BorderSide(color: Color(0xFF263238), width: 1.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _onSelect,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF9800).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFFF9800).withValues(alpha: 0.5)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: Color(0xFFFF9800), size: 16),
                          SizedBox(width: 6),
                          Text(
                            'SELECT',
                            style: TextStyle(
                              color: Color(0xFFFF9800),
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
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() => _selectedIndex = _menuOptions.length - 1);
                      _onSelect();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFF455A64)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.close, color: Colors.white70, size: 16),
                          SizedBox(width: 6),
                          Text(
                            'EXIT',
                            style: TextStyle(
                              color: Colors.white,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HDMenuBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Dark sleek tactical blueprint
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), Paint()..color = const Color(0xFF090D14));

    final boxPaint = Paint()..color = const Color(0xFF101722);
    final linePaint = Paint()
      ..color = const Color(0xFF1E2A3A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final rects = [
      Rect.fromLTWH(w * 0.06, h * 0.05, w * 0.88, h * 0.22),
      Rect.fromLTWH(w * 0.35, h * 0.02, w * 0.30, h * 0.30),
      Rect.fromLTWH(w * 0.10, h * 0.32, w * 0.32, h * 0.25),
      Rect.fromLTWH(w * 0.58, h * 0.36, w * 0.32, h * 0.28),
      Rect.fromLTWH(w * 0.26, h * 0.58, w * 0.48, h * 0.14),
      Rect.fromLTWH(w * 0.34, h * 0.70, w * 0.32, h * 0.22),
      Rect.fromLTWH(w * 0.05, h * 0.72, w * 0.28, h * 0.20),
      Rect.fromLTWH(w * 0.67, h * 0.72, w * 0.28, h * 0.20),
    ];

    for (final r in rects) {
      canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(4)), boxPaint);
      canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(4)), linePaint);
    }

    // High-tech laser grid lines
    final scanPaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.18)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(0, h * 0.48), Offset(w, h * 0.48), scanPaint);
    canvas.drawLine(Offset(0, h * 0.78), Offset(w, h * 0.78), scanPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
