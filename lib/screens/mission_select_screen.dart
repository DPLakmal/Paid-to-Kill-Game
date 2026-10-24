import 'package:flutter/material.dart';
import '../services/game_manager.dart';
import '../theme/game_theme.dart';
import 'mission_briefing_screen.dart';

class MissionSelectScreen extends StatelessWidget {
  final GameManager gameManager;

  const MissionSelectScreen({super.key, required this.gameManager});

  Color _getEnvColor(String env) {
    switch (env.toLowerCase()) {
      case 'snow':
        return Colors.cyanAccent;
      case 'desert':
        return Colors.orangeAccent;
      case 'forest':
        return Colors.lightGreenAccent;
      default:
        return GameTheme.terminalGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MISSION SELECT'),
      ),
      body: AnimatedBuilder(
        animation: gameManager,
        builder: (context, _) {
          final missions = gameManager.missions;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            itemCount: missions.length,
            itemBuilder: (context, index) {
              final mission = missions[index];
              final isUnlocked = mission.isUnlocked;

              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                color: isUnlocked ? GameTheme.surface : GameTheme.surface.withValues(alpha: 0.5),
                child: InkWell(
                  onTap: isUnlocked
                      ? () {
                          gameManager.setActiveMission(mission);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MissionBriefingScreen(
                                gameManager: gameManager,
                                mission: mission,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getEnvColor(mission.environment).withValues(alpha: 0.15),
                                border: Border.all(color: _getEnvColor(mission.environment)),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                mission.environment.toUpperCase(),
                                style: TextStyle(
                                  color: _getEnvColor(mission.environment),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (mission.isCompleted)
                              const Row(
                                children: [
                                  Icon(Icons.check_circle, color: GameTheme.terminalGreen, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    'COMPLETED',
                                    style: TextStyle(
                                      color: GameTheme.terminalGreen,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            else if (!isUnlocked)
                              const Row(
                                children: [
                                  Icon(Icons.lock, color: GameTheme.textMuted, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    'CLASSIFIED // LOCKED',
                                    style: TextStyle(
                                      color: GameTheme.textMuted,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '#0${mission.sequenceNumber} // ${mission.codeName}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isUnlocked ? GameTheme.textMuted : GameTheme.textMuted.withValues(alpha: 0.5),
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mission.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isUnlocked ? GameTheme.textBright : GameTheme.textMuted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          mission.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: GameTheme.textMuted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(color: GameTheme.border, height: 1),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.monetization_on, color: GameTheme.suspiciousAmber, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '\$${mission.rewardCurrency}',
                                  style: const TextStyle(
                                    color: GameTheme.textBright,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            if (mission.bestTimeSeconds != null)
                              Text(
                                'BEST: ${mission.bestTimeSeconds!.toStringAsFixed(1)}s',
                                style: const TextStyle(
                                  color: GameTheme.terminalGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
