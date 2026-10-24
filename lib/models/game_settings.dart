/// User configurable gameplay & accessibility settings.
class GameSettings {
  double musicVolume;
  double sfxVolume;
  bool vibrationEnabled;
  bool leftHandedControls;
  bool showVisionCones;
  bool enableDebugOverlays;
  String joystickSize; // 'small', 'medium', 'large'

  GameSettings({
    this.musicVolume = 0.8,
    this.sfxVolume = 1.0,
    this.vibrationEnabled = true,
    this.leftHandedControls = false,
    this.showVisionCones = true,
    this.enableDebugOverlays = false,
    this.joystickSize = 'medium',
  });

  Map<String, dynamic> toJson() => {
        'musicVolume': musicVolume,
        'sfxVolume': sfxVolume,
        'vibrationEnabled': vibrationEnabled,
        'leftHandedControls': leftHandedControls,
        'showVisionCones': showVisionCones,
        'enableDebugOverlays': enableDebugOverlays,
        'joystickSize': joystickSize,
      };

  factory GameSettings.fromJson(Map<String, dynamic> json) {
    return GameSettings(
      musicVolume: (json['musicVolume'] as num?)?.toDouble() ?? 0.8,
      sfxVolume: (json['sfxVolume'] as num?)?.toDouble() ?? 1.0,
      vibrationEnabled: json['vibrationEnabled'] as bool? ?? true,
      leftHandedControls: json['leftHandedControls'] as bool? ?? false,
      showVisionCones: json['showVisionCones'] as bool? ?? true,
      enableDebugOverlays: json['enableDebugOverlays'] as bool? ?? false,
      joystickSize: json['joystickSize'] as String? ?? 'medium',
    );
  }
}
