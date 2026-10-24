import 'package:flutter/material.dart';
import '../services/game_manager.dart';
import '../models/game_settings.dart';
import '../theme/game_theme.dart';

class SettingsScreen extends StatefulWidget {
  final GameManager gameManager;

  const SettingsScreen({super.key, required this.gameManager});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late GameSettings _settings;

  @override
  void initState() {
    super.initState();
    _settings = widget.gameManager.settings;
  }

  void _save() {
    widget.gameManager.updateSettings(_settings);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTINGS // SYSTEM'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'AUDIO & HAPTICS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: GameTheme.terminalGreen,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          // Music Volume Slider
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('BGM Music Volume', style: TextStyle(fontSize: 13)),
                      Text('${(_settings.musicVolume * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: _settings.musicVolume,
                    activeColor: GameTheme.terminalGreen,
                    inactiveColor: GameTheme.border,
                    onChanged: (val) {
                      _settings.musicVolume = val;
                      _save();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // SFX Volume Slider
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('SFX Volume', style: TextStyle(fontSize: 13)),
                      Text('${(_settings.sfxVolume * 100).toInt()}%',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: _settings.sfxVolume,
                    activeColor: GameTheme.terminalGreen,
                    inactiveColor: GameTheme.border,
                    onChanged: (val) {
                      _settings.sfxVolume = val;
                      _save();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Vibration toggle
          Card(
            child: SwitchListTile(
              title: const Text('Haptic Vibration Feedback', style: TextStyle(fontSize: 13)),
              value: _settings.vibrationEnabled,
              activeThumbColor: GameTheme.terminalGreen,
              onChanged: (val) {
                _settings.vibrationEnabled = val;
                _save();
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'CONTROLS & VISUALS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: GameTheme.terminalGreen,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          // Left-handed layout toggle
          Card(
            child: SwitchListTile(
              title: const Text('Left-Handed Joystick Mode', style: TextStyle(fontSize: 13)),
              subtitle: const Text('Swaps virtual joystick and contextual action buttons',
                  style: TextStyle(fontSize: 11, color: GameTheme.textMuted)),
              value: _settings.leftHandedControls,
              activeThumbColor: GameTheme.terminalGreen,
              onChanged: (val) {
                _settings.leftHandedControls = val;
                _save();
              },
            ),
          ),
          const SizedBox(height: 8),
          // Show vision cones toggle
          Card(
            child: SwitchListTile(
              title: const Text('Display Guard Vision Cones', style: TextStyle(fontSize: 13)),
              subtitle: const Text('Renders subtle translucent perception wedges on guards',
                  style: TextStyle(fontSize: 11, color: GameTheme.textMuted)),
              value: _settings.showVisionCones,
              activeThumbColor: GameTheme.terminalGreen,
              onChanged: (val) {
                _settings.showVisionCones = val;
                _save();
              },
            ),
          ),
          const SizedBox(height: 8),
          // Debug overlays
          Card(
            child: SwitchListTile(
              title: const Text('Enable Tactical Debug Overlays', style: TextStyle(fontSize: 13)),
              subtitle: const Text('Renders collision boxes, hearing radius & patrol paths',
                  style: TextStyle(fontSize: 11, color: GameTheme.textMuted)),
              value: _settings.enableDebugOverlays,
              activeThumbColor: GameTheme.terminalGreen,
              onChanged: (val) {
                _settings.enableDebugOverlays = val;
                _save();
              },
            ),
          ),
          const SizedBox(height: 8),
          // Joystick size
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Virtual Joystick Size', style: TextStyle(fontSize: 13)),
                  DropdownButton<String>(
                    value: _settings.joystickSize,
                    dropdownColor: GameTheme.surface,
                    style: const TextStyle(
                      color: GameTheme.terminalGreen,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                    underline: const SizedBox(),
                    items: const [
                      DropdownMenuItem(value: 'small', child: Text('COMPACT')),
                      DropdownMenuItem(value: 'medium', child: Text('STANDARD')),
                      DropdownMenuItem(value: 'large', child: Text('LARGE')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        _settings.joystickSize = val;
                        _save();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Danger zone
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: GameTheme.alertRed,
              side: const BorderSide(color: GameTheme.alertRed),
            ),
            icon: const Icon(Icons.delete_forever),
            label: const Text('PURGE // RESET PROGRESSION'),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: GameTheme.surface,
                  title: const Text('PURGE ALL DATA?',
                      style: TextStyle(color: GameTheme.alertRed, fontWeight: FontWeight.bold)),
                  content: const Text(
                      'This will reset all completed contracts, acquired upgrades, and credits back to baseline recruits.'),
                  actions: [
                    TextButton(
                      child: const Text('CANCEL', style: TextStyle(color: GameTheme.textMuted)),
                      onPressed: () => Navigator.of(ctx).pop(false),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: GameTheme.alertRed),
                      child: const Text('PURGE'),
                      onPressed: () => Navigator.of(ctx).pop(true),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                await widget.gameManager.resetProgression();
                if (!mounted) return;
                setState(() {
                  _settings = widget.gameManager.settings;
                });
                messenger.showSnackBar(
                  const SnackBar(content: Text('Operative data reset to defaults.')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
