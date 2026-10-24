/// Category of upgrades available to the player.
enum UpgradeCategory {
  speed,
  stealth,
  combat,
  tactical,
}

/// Represents an upgradable tactical skill or equipment item.
class UpgradeItem {
  final String id;
  final String name;
  final String description;
  final UpgradeCategory category;
  final int maxLevel;
  final List<int> costs; // Cost for each level upgrade (level 1..maxLevel)
  final List<double> statMultipliers; // Stat value or multiplier per level
  int currentLevel;

  UpgradeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.maxLevel,
    required this.costs,
    required this.statMultipliers,
    this.currentLevel = 0,
  });

  bool get isMaxLevel => currentLevel >= maxLevel;

  int get nextCost => isMaxLevel ? 0 : costs[currentLevel];

  double get currentStat =>
      currentLevel == 0 ? statMultipliers[0] : statMultipliers[currentLevel];

  double get nextStat => isMaxLevel ? currentStat : statMultipliers[currentLevel + 1];

  Map<String, dynamic> toJson() => {
        'id': id,
        'currentLevel': currentLevel,
      };

  /// Presets of upgrades aligned with Section 12 of the GDD.
  static List<UpgradeItem> getDefaultUpgrades() {
    return [
      UpgradeItem(
        id: 'upgrade_movement_speed',
        name: 'Tactical Boots',
        description: 'Increases assassin sprint and baseline movement velocity.',
        category: UpgradeCategory.speed,
        maxLevel: 3,
        costs: [200, 450, 800],
        statMultipliers: [1.0, 1.15, 1.30, 1.45],
        currentLevel: 0,
      ),
      UpgradeItem(
        id: 'upgrade_silent_footsteps',
        name: 'Padded Soles',
        description:
            'Reduces footstep noise acoustic radius, delaying guard suspicion when jogging.',
        category: UpgradeCategory.stealth,
        maxLevel: 3,
        costs: [250, 500, 900],
        statMultipliers: [1.0, 0.75, 0.50, 0.25], // Footstep acoustic footprint multiplier
        currentLevel: 0,
      ),
      UpgradeItem(
        id: 'upgrade_body_armor',
        name: 'Kevlar Vest',
        description:
            'Enhances hit tolerance and maximum HP before critical mission failure.',
        category: UpgradeCategory.combat,
        maxLevel: 3,
        costs: [300, 600, 1000],
        statMultipliers: [100.0, 125.0, 150.0, 180.0], // Max HP
        currentLevel: 0,
      ),
      UpgradeItem(
        id: 'upgrade_weapon_silencer',
        name: 'Suppressor MK-II',
        description:
            'Muffles firearm discharge, drastically shrinking alert radius when firing.',
        category: UpgradeCategory.combat,
        maxLevel: 2,
        costs: [400, 850],
        statMultipliers: [1.0, 0.5, 0.2], // Gunfire noise radius multiplier
        currentLevel: 0,
      ),
      UpgradeItem(
        id: 'upgrade_takedown_reach',
        name: 'CQC Master',
        description:
            'Lengthens the angle and trigger distance for quiet rear stealth takedowns.',
        category: UpgradeCategory.tactical,
        maxLevel: 2,
        costs: [350, 750],
        statMultipliers: [1.0, 1.25, 1.5], // Takedown trigger range multiplier
        currentLevel: 0,
      ),
      UpgradeItem(
        id: 'upgrade_cabinet_speed',
        name: 'Quick Concealment',
        description:
            'Reduces cabinet enter and exit transition time to evade fast approaching patrols.',
        category: UpgradeCategory.stealth,
        maxLevel: 2,
        costs: [250, 500],
        statMultipliers: [1.0, 0.7, 0.45], // Seconds transition duration
        currentLevel: 0,
      ),
    ];
  }
}
