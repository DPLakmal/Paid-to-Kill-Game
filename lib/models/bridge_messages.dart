import 'dart:convert';

/// High-level alarm states from GDD Section 10.
enum AlarmState { quiet, suspicious, alert, searching, resetting }

/// Contextual actions available to the player based on proximity (GDD Section 5 & 7).
enum ContextActionType { none, hide, exitCabinet, takedown, interact, plantCharge }

/// Stealth rating achieved at mission end.
enum StealthRating { ghost, operative, compromised, failed }

/// Payload sent from Flutter to Unity to initiate a mission.
class StartMissionPayload {
  final String missionId;
  final double movementSpeedMultiplier;
  final double noiseRadiusMultiplier;
  final double maxHealth;
  final double takedownReachMultiplier;
  final double cabinetSpeedMultiplier;
  final bool enableDebugOverlays;

  StartMissionPayload({
    required this.missionId,
    this.movementSpeedMultiplier = 1.0,
    this.noiseRadiusMultiplier = 1.0,
    this.maxHealth = 100.0,
    this.takedownReachMultiplier = 1.0,
    this.cabinetSpeedMultiplier = 1.0,
    this.enableDebugOverlays = false,
  });

  Map<String, dynamic> toJson() => {
        'missionId': missionId,
        'movementSpeedMultiplier': movementSpeedMultiplier,
        'noiseRadiusMultiplier': noiseRadiusMultiplier,
        'maxHealth': maxHealth,
        'takedownReachMultiplier': takedownReachMultiplier,
        'cabinetSpeedMultiplier': cabinetSpeedMultiplier,
        'enableDebugOverlays': enableDebugOverlays,
      };

  factory StartMissionPayload.fromJson(Map<String, dynamic> json) {
    return StartMissionPayload(
      missionId: json['missionId'] as String,
      movementSpeedMultiplier:
          (json['movementSpeedMultiplier'] as num?)?.toDouble() ?? 1.0,
      noiseRadiusMultiplier:
          (json['noiseRadiusMultiplier'] as num?)?.toDouble() ?? 1.0,
      maxHealth: (json['maxHealth'] as num?)?.toDouble() ?? 100.0,
      takedownReachMultiplier:
          (json['takedownReachMultiplier'] as num?)?.toDouble() ?? 1.0,
      cabinetSpeedMultiplier:
          (json['cabinetSpeedMultiplier'] as num?)?.toDouble() ?? 1.0,
      enableDebugOverlays: json['enableDebugOverlays'] as bool? ?? false,
    );
  }
}

/// Periodic HUD payload sent from Unity to Flutter.
class HudUpdatePayload {
  final double currentHealth;
  final double maxHealth;
  final double detectionMeter; // 0.0 to 1.0
  final AlarmState alarmState;
  final ContextActionType contextAction;
  final bool isPlayerHidden;

  HudUpdatePayload({
    required this.currentHealth,
    required this.maxHealth,
    required this.detectionMeter,
    required this.alarmState,
    required this.contextAction,
    required this.isPlayerHidden,
  });

  Map<String, dynamic> toJson() => {
        'currentHealth': currentHealth,
        'maxHealth': maxHealth,
        'detectionMeter': detectionMeter,
        'alarmState': alarmState.name,
        'contextAction': contextAction.name,
        'isPlayerHidden': isPlayerHidden,
      };

  factory HudUpdatePayload.fromJson(Map<String, dynamic> json) {
    return HudUpdatePayload(
      currentHealth: (json['currentHealth'] as num?)?.toDouble() ?? 100.0,
      maxHealth: (json['maxHealth'] as num?)?.toDouble() ?? 100.0,
      detectionMeter: (json['detectionMeter'] as num?)?.toDouble() ?? 0.0,
      alarmState: AlarmState.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['alarmState'] as String? ?? '').toLowerCase(),
        orElse: () => AlarmState.quiet,
      ),
      contextAction: ContextActionType.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['contextAction'] as String? ?? '').toLowerCase(),
        orElse: () => ContextActionType.none,
      ),
      isPlayerHidden: json['isPlayerHidden'] as bool? ?? false,
    );
  }

  HudUpdatePayload copyWith({
    double? currentHealth,
    double? maxHealth,
    double? detectionMeter,
    AlarmState? alarmState,
    ContextActionType? contextAction,
    bool? isPlayerHidden,
  }) {
    return HudUpdatePayload(
      currentHealth: currentHealth ?? this.currentHealth,
      maxHealth: maxHealth ?? this.maxHealth,
      detectionMeter: detectionMeter ?? this.detectionMeter,
      alarmState: alarmState ?? this.alarmState,
      contextAction: contextAction ?? this.contextAction,
      isPlayerHidden: isPlayerHidden ?? this.isPlayerHidden,
    );
  }
}

/// Payload sent when an objective's state updates in Unity.
class ObjectiveUpdatePayload {
  final String objectiveId;
  final bool isCompleted;
  final String title;

  ObjectiveUpdatePayload({
    required this.objectiveId,
    required this.isCompleted,
    required this.title,
  });

  Map<String, dynamic> toJson() => {
        'objectiveId': objectiveId,
        'isCompleted': isCompleted,
        'title': title,
      };

  factory ObjectiveUpdatePayload.fromJson(Map<String, dynamic> json) {
    return ObjectiveUpdatePayload(
      objectiveId: json['objectiveId'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      title: json['title'] as String? ?? '',
    );
  }
}

/// Payload sent when the mission concludes (Victory or Defeat).
class MissionResultPayload {
  final bool success;
  final String missionId;
  final double durationSeconds;
  final int alertsTriggered;
  final int guardsNeutralized;
  final int damageReceived;
  final int currencyEarned;
  final StealthRating rating;
  final String failureReason;

  MissionResultPayload({
    required this.success,
    required this.missionId,
    required this.durationSeconds,
    required this.alertsTriggered,
    required this.guardsNeutralized,
    required this.damageReceived,
    required this.currencyEarned,
    required this.rating,
    this.failureReason = '',
  });

  Map<String, dynamic> toJson() => {
        'success': success,
        'missionId': missionId,
        'durationSeconds': durationSeconds,
        'alertsTriggered': alertsTriggered,
        'guardsNeutralized': guardsNeutralized,
        'damageReceived': damageReceived,
        'currencyEarned': currencyEarned,
        'rating': rating.name,
        'failureReason': failureReason,
      };

  factory MissionResultPayload.fromJson(Map<String, dynamic> json) {
    return MissionResultPayload(
      success: json['success'] as bool? ?? false,
      missionId: json['missionId'] as String? ?? '',
      durationSeconds: (json['durationSeconds'] as num?)?.toDouble() ?? 0.0,
      alertsTriggered: json['alertsTriggered'] as int? ?? 0,
      guardsNeutralized: json['guardsNeutralized'] as int? ?? 0,
      damageReceived: json['damageReceived'] as int? ?? 0,
      currencyEarned: json['currencyEarned'] as int? ?? 0,
      rating: StealthRating.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['rating'] as String? ?? '').toLowerCase(),
        orElse: () => StealthRating.operative,
      ),
      failureReason: json['failureReason'] as String? ?? '',
    );
  }
}

/// Standardized message wrapper for JSON transport across the bridge.
class BridgeMessage {
  final String type;
  final Map<String, dynamic> data;

  BridgeMessage({required this.type, required this.data});

  String serialize() => jsonEncode({'type': type, 'data': data});

  static BridgeMessage deserialize(String rawJson) {
    final parsed = jsonDecode(rawJson) as Map<String, dynamic>;
    return BridgeMessage(
      type: parsed['type'] as String,
      data: parsed['data'] as Map<String, dynamic>,
    );
  }
}
