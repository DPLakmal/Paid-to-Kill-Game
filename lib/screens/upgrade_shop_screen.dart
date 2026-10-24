import 'package:flutter/material.dart';
import '../services/game_manager.dart';
import '../models/upgrade.dart';
import '../theme/game_theme.dart';

class UpgradeShopScreen extends StatelessWidget {
  final GameManager gameManager;

  const UpgradeShopScreen({super.key, required this.gameManager});

  String _getCategoryLabel(UpgradeCategory cat) {
    switch (cat) {
      case UpgradeCategory.speed:
        return 'MOBILITY';
      case UpgradeCategory.stealth:
        return 'CONCEALMENT';
      case UpgradeCategory.combat:
        return 'FIREARMS & ARMOR';
      case UpgradeCategory.tactical:
        return 'CQC & TACTICS';
    }
  }

  IconData _getCategoryIcon(UpgradeCategory cat) {
    switch (cat) {
      case UpgradeCategory.speed:
        return Icons.directions_run;
      case UpgradeCategory.stealth:
        return Icons.visibility_off;
      case UpgradeCategory.combat:
        return Icons.shield;
      case UpgradeCategory.tactical:
        return Icons.touch_app;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TACTICAL UPGRADES'),
      ),
      body: AnimatedBuilder(
        animation: gameManager,
        builder: (context, _) {
          final upgrades = gameManager.upgrades;
          final credits = gameManager.walletCredits;

          return Column(
            children: [
              // Credits Banner
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: const BoxDecoration(
                  color: GameTheme.surface,
                  border: Border(bottom: BorderSide(color: GameTheme.border)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'AVAILABLE OPERATIVE FUNDS:',
                      style: TextStyle(
                        fontSize: 11,
                        color: GameTheme.textMuted,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.monetization_on, color: GameTheme.suspiciousAmber, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          '\$$credits',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: GameTheme.textBright,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: upgrades.length,
                  itemBuilder: (context, index) {
                    final item = upgrades[index];
                    final isMax = item.isMaxLevel;
                    final cost = item.nextCost;
                    final canAfford = credits >= cost && !isMax;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 14.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(_getCategoryIcon(item.category),
                                    color: GameTheme.terminalGreen, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  _getCategoryLabel(item.category),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: GameTheme.terminalGreen,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const Spacer(),
                                // Level Indicator Pips
                                Row(
                                  children: List.generate(item.maxLevel, (lvl) {
                                    final isFilled = lvl < item.currentLevel;
                                    return Container(
                                      margin: const EdgeInsets.only(left: 4),
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isFilled
                                            ? GameTheme.terminalGreen
                                            : Colors.transparent,
                                        border: Border.all(
                                          color: isFilled
                                              ? GameTheme.terminalGreen
                                              : GameTheme.textMuted,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: GameTheme.textBright,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: GameTheme.textMuted,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Divider(color: GameTheme.border, height: 1),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isMax
                                      ? 'MAX LEVEL REACHED'
                                      : 'STAT: ${item.currentStat}x  ➜  ${item.nextStat}x',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isMax ? GameTheme.terminalGreen : GameTheme.textMuted,
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    backgroundColor: canAfford
                                        ? GameTheme.terminalGreen
                                        : GameTheme.surfaceLight,
                                    foregroundColor: canAfford ? Colors.black : GameTheme.textMuted,
                                  ),
                                  onPressed: canAfford
                                      ? () async {
                                          await gameManager.purchaseUpgrade(item.id);
                                        }
                                      : null,
                                  child: Text(
                                    isMax ? 'MAX' : 'UPGRADE (\$$cost)',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
