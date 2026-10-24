import 'package:flutter/foundation.dart';
import '../models/mission.dart';
import '../models/upgrade.dart';
import '../models/game_settings.dart';
import '../models/bridge_messages.dart';
import 'storage_service.dart';
import '../bridge/unity_bridge_controller.dart';

/// Central state manager orchestrating the game's meta-progression and bridge integration.
class GameManager extends ChangeNotifier {
  final StorageService storageService;
  final UnityBridgeController bridge;

  int _walletCredits = 0;
  List<Mission> _missions = [];
  List<UpgradeItem> _upgrades = [];
  GameSettings _settings = GameSettings();
  Mission? _activeMission;
  bool _isInitialized = false;

  GameManager({
    required this.storageService,
    required this.bridge,
  });

  bool get isInitialized => _isInitialized;
  int get walletCredits => _walletCredits;
  List<Mission> get missions => List.unmodifiable(_missions);
  List<UpgradeItem> get upgrades => List.unmodifiable(_upgrades);
  GameSettings get settings => _settings;
  Mission? get activeMission => _activeMission;

  Future<void> init() async {
    _walletCredits = storageService.getWalletCredits();
    _missions = storageService.loadMissions();
    _upgrades = storageService.loadUpgrades();
    _settings = storageService.loadSettings();

    // Listen to mission outcomes from Unity
    bridge.onMissionResult.listen(_handleMissionResult);

    _isInitialized = true;
    notifyListeners();
  }

  void setActiveMission(Mission mission) {
    _activeMission = mission;
    notifyListeners();
  }

  /// Calculates stat payload for Unity based on current upgrade levels.
  StartMissionPayload buildStartPayload(String missionId) {
    final speedUpgrade = _upgrades.firstWhere(
      (u) => u.id == 'upgrade_movement_speed',
      orElse: () => UpgradeItem.getDefaultUpgrades()[0],
    );
    final stealthUpgrade = _upgrades.firstWhere(
      (u) => u.id == 'upgrade_silent_footsteps',
      orElse: () => UpgradeItem.getDefaultUpgrades()[1],
    );
    final armorUpgrade = _upgrades.firstWhere(
      (u) => u.id == 'upgrade_body_armor',
      orElse: () => UpgradeItem.getDefaultUpgrades()[2],
    );
    final takedownUpgrade = _upgrades.firstWhere(
      (u) => u.id == 'upgrade_takedown_reach',
      orElse: () => UpgradeItem.getDefaultUpgrades()[4],
    );
    final cabinetUpgrade = _upgrades.firstWhere(
      (u) => u.id == 'upgrade_cabinet_speed',
      orElse: () => UpgradeItem.getDefaultUpgrades()[5],
    );

    return StartMissionPayload(
      missionId: missionId,
      movementSpeedMultiplier: speedUpgrade.currentStat,
      noiseRadiusMultiplier: stealthUpgrade.currentStat,
      maxHealth: armorUpgrade.currentStat,
      takedownReachMultiplier: takedownUpgrade.currentStat,
      cabinetSpeedMultiplier: cabinetUpgrade.currentStat,
      enableDebugOverlays: _settings.enableDebugOverlays,
    );
  }

  /// Attempts to purchase an upgrade. Returns true if successful.
  Future<bool> purchaseUpgrade(String upgradeId) async {
    final index = _upgrades.indexWhere((u) => u.id == upgradeId);
    if (index == -1) return false;

    final item = _upgrades[index];
    if (item.isMaxLevel) return false;

    final cost = item.nextCost;
    if (_walletCredits < cost) return false;

    _walletCredits -= cost;
    item.currentLevel += 1;

    await storageService.saveWalletCredits(_walletCredits);
    await storageService.saveUpgrades(_upgrades);

    notifyListeners();
    return true;
  }

  /// Updates settings and persists them.
  Future<void> updateSettings(GameSettings newSettings) async {
    _settings = newSettings;
    await storageService.saveSettings(_settings);
    notifyListeners();
  }

  /// Adds credits (e.g. cheats, test mode, mission rewards).
  Future<void> addCredits(int amount) async {
    _walletCredits += amount;
    await storageService.saveWalletCredits(_walletCredits);
    notifyListeners();
  }

  /// Handles incoming mission completion data from Unity runtime.
  void _handleMissionResult(MissionResultPayload result) async {
    if (!result.success) {
      notifyListeners();
      return;
    }

    // Award currency
    _walletCredits += result.currencyEarned;
    await storageService.saveWalletCredits(_walletCredits);

    // Update mission state
    final index = _missions.indexWhere((m) => m.id == result.missionId);
    if (index != -1) {
      final mission = _missions[index];
      mission.isCompleted = true;
      if (mission.bestTimeSeconds == null || result.durationSeconds < mission.bestTimeSeconds!) {
        mission.bestTimeSeconds = result.durationSeconds;
      }
      if (result.currencyEarned > mission.bestScore) {
        mission.bestScore = result.currencyEarned;
      }

      // Unlock the next mission in sequence
      final nextSeq = mission.sequenceNumber + 1;
      final nextIndex = _missions.indexWhere((m) => m.sequenceNumber == nextSeq);
      if (nextIndex != -1) {
        _missions[nextIndex].isUnlocked = true;
      }

      await storageService.saveMissions(_missions);
    }

    notifyListeners();
  }

  /// Resets progression to defaults.
  Future<void> resetProgression() async {
    await storageService.clearAll();
    _walletCredits = 500;
    _missions = Mission.getCampaignMissions();
    _upgrades = UpgradeItem.getDefaultUpgrades();
    _settings = GameSettings();
    notifyListeners();
  }
}
