import 'package:flutter/material.dart';

/// Modern Cyberpunk Tactical Top Status Bar
/// Matches reference UI with:
/// - Silenced weapon box with red alert indicator and ammo counter
/// - "OPERATIVE VITALITY" header with health percentage
/// - Sleek glossy neon red-to-coral vitality bar
/// - Modern neon cyan pill buttons for FIRE / MENU
class RetroBottomBar extends StatelessWidget {
  final double healthFraction; // 0.0 .. 1.0
  final VoidCallback? onLeftSoftkey;
  final VoidCallback? onRightSoftkey;
  final VoidCallback? onFireWeapon;
  final String leftLabel;
  final String rightLabel;

  const RetroBottomBar({
    super.key,
    required this.healthFraction,
    this.onLeftSoftkey,
    this.onRightSoftkey,
    this.onFireWeapon,
    this.leftLabel = 'Fire',
    this.rightLabel = 'Menu',
  });

  @override
  Widget build(BuildContext context) {
    final healthPercent = (healthFraction * 100).toInt().clamp(0, 100);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF070B11),
        border: Border(
          bottom: BorderSide(color: Color(0xFF161E2E), width: 1.5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: Weapon box & Operative Vitality
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 14, top: 10, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Weapon box
                GestureDetector(
                  onTap: onFireWeapon,
                  child: Container(
                    width: 68,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F1722),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF28364A),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.6),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Red laser dot + SILENCED text
                        Positioned(
                          top: 4,
                          left: 6,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF2A4B),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFFF2A4B),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'SILENCED',
                                style: TextStyle(
                                  color: Color(0xFF8899A6),
                                  fontSize: 7.5,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.6,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Pistol icon centered
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 6.0),
                            child: Transform.rotate(
                              angle: -0.25,
                              child: const Icon(
                                Icons.hardware,
                                color: Color(0xFFE2E8F0),
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        // Ammo counter 12/12
                        const Positioned(
                          bottom: 3,
                          right: 5,
                          child: Text(
                            '12/12',
                            style: TextStyle(
                              color: Color(0xFF00E5FF),
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'monospace',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Vitality title and glossy health bar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.favorite, color: Color(0xFFFF2A4B), size: 12),
                              SizedBox(width: 5),
                              Text(
                                'OPERATIVE VITALITY',
                                style: TextStyle(
                                  color: Color(0xFFB0BEC5),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '$healthPercent%',
                            style: const TextStyle(
                              color: Color(0xFF00E5FF),
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Glossy modern capsule health bar
                      Container(
                        height: 14,
                        padding: const EdgeInsets.all(1.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF090D14),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: const Color(0xFF222C3D),
                            width: 1.2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Stack(
                            children: [
                              // Smooth gradient fill
                              FractionallySizedBox(
                                widthFactor: healthFraction.clamp(0.0, 1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFFF9E95),
                                        Color(0xFFFF4136),
                                        Color(0xFFCC1F1F),
                                      ],
                                      stops: [0.0, 0.45, 1.0],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFF3344).withValues(alpha: 0.5),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Top highlight gloss shine
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                height: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white.withValues(alpha: 0.55),
                                        Colors.white.withValues(alpha: 0.0),
                                      ],
                                    ),
                                  ),
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

          // Row 2: Modern pill buttons for FIRE & MENU
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildModernButton(
                  label: leftLabel,
                  onTap: onLeftSoftkey,
                  isPrimary: true,
                ),
                _buildModernButton(
                  label: rightLabel,
                  onTap: onRightSoftkey,
                  isPrimary: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernButton({
    required String label,
    required VoidCallback? onTap,
    required bool isPrimary,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isPrimary
              ? const Color(0xFF031B26)
              : const Color(0xFF101620),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isPrimary
                ? const Color(0xFF00E5FF).withValues(alpha: 0.85)
                : const Color(0xFF37474F),
            width: 1.4,
          ),
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withValues(alpha: 0.25),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 4,
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isPrimary ? const Color(0xFF00E5FF) : const Color(0xFFB0BEC5),
                boxShadow: isPrimary
                    ? [
                        const BoxShadow(
                          color: Color(0xFF00E5FF),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
            ),
            const SizedBox(width: 7),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: isPrimary ? const Color(0xFF00E5FF) : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
