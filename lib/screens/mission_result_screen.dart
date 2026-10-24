import 'package:flutter/material.dart';
import '../services/game_manager.dart';
import '../models/mission.dart';
import '../models/bridge_messages.dart';
import '../theme/game_theme.dart';
import 'mission_select_screen.dart';
import 'upgrade_shop_screen.dart';
import 'game_viewport_screen.dart';

class MissionResultScreen extends StatelessWidget {
  final GameManager gameManager;
  final Mission mission;
  final MissionResultPayload result;

  const MissionResultScreen({
    super.key,
    required this.gameManager,
    required this.mission,
    required this.result,
  });

  Color _getRatingColor(StealthRating rating) {
    switch (rating) {
      case StealthRating.ghost:
        return GameTheme.terminalGreen;
      case StealthRating.operative:
        return GameTheme.quietBlue;
      case StealthRating.compromised:
        return GameTheme.suspiciousAmber;
      case StealthRating.failed:
        return GameTheme.alertRed;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSuccess = result.success;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSuccess ? GameTheme.terminalGreen : GameTheme.alertRed,
                      width: 2.5,
                    ),
                    color: GameTheme.surface,
                  ),
                  child: Icon(
                    isSuccess ? Icons.verified : Icons.dangerous,
                    size: 64,
                    color: isSuccess ? GameTheme.terminalGreen : GameTheme.alertRed,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isSuccess ? 'MISSION ACCOMPLISHED' : 'CONTRACT COMPROMISED // KIA',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: isSuccess ? GameTheme.terminalGreen : GameTheme.alertRed,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${mission.codeName} — ${mission.title}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: GameTheme.textMuted,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              // Debriefing Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: GameTheme.surface,
                  border: Border.all(color: GameTheme.border),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('STEALTH RATING:',
                            style: TextStyle(fontSize: 12, color: GameTheme.textMuted)),
                        Text(
                          result.rating.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getRatingColor(result.rating),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: GameTheme.border, height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('INFILTRATION TIME:',
                            style: TextStyle(fontSize: 12, color: GameTheme.textMuted)),
                        Text('${result.durationSeconds.toStringAsFixed(1)}s',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: GameTheme.textBright)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ALARMS TRIGGERED:',
                            style: TextStyle(fontSize: 12, color: GameTheme.textMuted)),
                        Text('${result.alertsTriggered}',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: result.alertsTriggered == 0
                                    ? GameTheme.terminalGreen
                                    : GameTheme.alertRed)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('GUARDS NEUTRALIZED:',
                            style: TextStyle(fontSize: 12, color: GameTheme.textMuted)),
                        Text('${result.guardsNeutralized}',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: GameTheme.textBright)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('DAMAGE TAKEN:',
                            style: TextStyle(fontSize: 12, color: GameTheme.textMuted)),
                        Text('${result.damageReceived} HP',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: GameTheme.textBright)),
                      ],
                    ),
                    const Divider(color: GameTheme.border, height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('BOUNTY EARNED:',
                            style: TextStyle(fontSize: 13, color: GameTheme.textMuted)),
                        Text(
                          '+\$${result.currencyEarned}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GameTheme.suspiciousAmber,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Navigation Options
              if (isSuccess) ...[
                ElevatedButton(
                  onPressed: () {
                    // Navigate to mission select
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => MissionSelectScreen(gameManager: gameManager),
                      ),
                    );
                  },
                  child: const Text('NEXT CONTRACT'),
                ),
                const SizedBox(height: 12),
              ] else ...[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: GameTheme.alertRed),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => GameViewportScreen(
                          gameManager: gameManager,
                          mission: mission,
                        ),
                      ),
                    );
                  },
                  child: const Text('RETRY INFILTRATION'),
                ),
                const SizedBox(height: 12),
              ],
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UpgradeShopScreen(gameManager: gameManager),
                    ),
                  );
                },
                child: const Text('TACTICAL UPGRADES SHOP'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('RETURN TO BASE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
