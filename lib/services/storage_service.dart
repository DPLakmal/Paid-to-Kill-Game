import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mission.dart';
import '../models/upgrade.dart';
import '../models/game_settings.dart';

/// Local offline persistence service for progression, upgrades, and settings.
class StorageService {
  static const String _keyWalletCredits = 'ptk_wallet_credits';
  static const String _keyMissions = 'ptk_missions_v1';
  static const String _keyUpgrades = 'ptk_upgrades_v1';
  static const String _keySettings = 'ptk_settings_v1';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Initializer with existing prefs instance (useful for unit tests with MockSharedPreferences).
  void initWithPrefs(SharedPreferences prefs) {
    _prefs = prefs;
  }

  // --- Wallet Credits ---
  int getWalletCredits() {
    return _prefs.getInt(_keyWalletCredits) ?? 500; // Starting bonus for first upgrades
  }

  Future<void> saveWalletCredits(int credits) async {
    await _prefs.setInt(_keyWalletCredits, credits);
  }

  // --- Settings ---
  GameSettings loadSettings() {
    final raw = _prefs.getString(_keySettings);
    if (raw == null) return GameSettings();
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return GameSettings.fromJson(json);
    } catch (_) {
      return GameSettings();
    }
  }

  Future<void> saveSettings(GameSettings settings) async {
    await _prefs.setString(_keySettings, jsonEncode(settings.toJson()));
  }

  // --- Missions ---
  List<Mission> loadMissions() {
    final raw = _prefs.getString(_keyMissions);
    final defaults = Mission.getCampaignMissions();
    if (raw == null) return defaults;

    try {
      final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
      final loaded = list.map((e) => Mission.fromJson(e as Map<String, dynamic>)).toList();

      // Merge with defaults in case new missions were added
      final Map<String, Mission> map = {for (var m in loaded) m.id: m};
      return defaults.map((d) {
        if (map.containsKey(d.id)) {
          final m = map[d.id]!;
          d.isUnlocked = m.isUnlocked;
          d.isCompleted = m.isCompleted;
          d.bestScore = m.bestScore;
          d.bestTimeSeconds = m.bestTimeSeconds;
        }
        return d;
      }).toList();
    } catch (_) {
      return defaults;
    }
  }

  Future<void> saveMissions(List<Mission> missions) async {
    final list = missions.map((m) => m.toJson()).toList();
    await _prefs.setString(_keyMissions, jsonEncode(list));
  }

  // --- Upgrades ---
  List<UpgradeItem> loadUpgrades() {
    final raw = _prefs.getString(_keyUpgrades);
    final defaults = UpgradeItem.getDefaultUpgrades();
    if (raw == null) return defaults;

    try {
      final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
      final Map<String, int> levelMap = {};
      for (final item in list) {
        final m = item as Map<String, dynamic>;
        levelMap[m['id'] as String] = m['currentLevel'] as int;
      }
      for (final u in defaults) {
        if (levelMap.containsKey(u.id)) {
          u.currentLevel = levelMap[u.id]!.clamp(0, u.maxLevel);
        }
      }
      return defaults;
    } catch (_) {
      return defaults;
    }
  }

  Future<void> saveUpgrades(List<UpgradeItem> upgrades) async {
    final list = upgrades.map((u) => u.toJson()).toList();
    await _prefs.setString(_keyUpgrades, jsonEncode(list));
  }

  /// Reset all local progress (for testing / new profile).
  Future<void> clearAll() async {
    await _prefs.remove(_keyWalletCredits);
    await _prefs.remove(_keyMissions);
    await _prefs.remove(_keyUpgrades);
    await _prefs.remove(_keySettings);
  }
}
