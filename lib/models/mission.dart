/// Represents the status of an objective.
enum ObjectiveStatus { pending, completed, failed }

/// Represents an individual mission objective.
class MissionObjective {
  final String id;
  final String title;
  final String description;
  final bool isPrimary;
  ObjectiveStatus status;

  MissionObjective({
    required this.id,
    required this.title,
    required this.description,
    this.isPrimary = true,
    this.status = ObjectiveStatus.pending,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isPrimary': isPrimary,
        'status': status.name,
      };

  factory MissionObjective.fromJson(Map<String, dynamic> json) {
    return MissionObjective(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isPrimary: json['isPrimary'] as bool? ?? true,
      status: ObjectiveStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ObjectiveStatus.pending,
      ),
    );
  }
}

/// Represents a playable mission in the game.
class Mission {
  final String id;
  final int sequenceNumber;
  final String codeName;
  final String title;
  final String location;
  final String environment; // 'snow', 'desert', 'forest'
  final String briefingText;
  final String intelNote;
  final int rewardCurrency;
  final int targetTimeSeconds;
  final List<MissionObjective> objectives;
  bool isUnlocked;
  bool isCompleted;
  int bestScore;
  double? bestTimeSeconds;

  Mission({
    required this.id,
    required this.sequenceNumber,
    required this.codeName,
    required this.title,
    required this.location,
    required this.environment,
    required this.briefingText,
    required this.intelNote,
    required this.rewardCurrency,
    required this.targetTimeSeconds,
    required this.objectives,
    this.isUnlocked = false,
    this.isCompleted = false,
    this.bestScore = 0,
    this.bestTimeSeconds,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'sequenceNumber': sequenceNumber,
        'codeName': codeName,
        'title': title,
        'location': location,
        'environment': environment,
        'briefingText': briefingText,
        'intelNote': intelNote,
        'rewardCurrency': rewardCurrency,
        'targetTimeSeconds': targetTimeSeconds,
        'objectives': objectives.map((o) => o.toJson()).toList(),
        'isUnlocked': isUnlocked,
        'isCompleted': isCompleted,
        'bestScore': bestScore,
        'bestTimeSeconds': bestTimeSeconds,
      };

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'] as String,
      sequenceNumber: json['sequenceNumber'] as int,
      codeName: json['codeName'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      environment: json['environment'] as String,
      briefingText: json['briefingText'] as String,
      intelNote: json['intelNote'] as String,
      rewardCurrency: json['rewardCurrency'] as int,
      targetTimeSeconds: json['targetTimeSeconds'] as int,
      objectives: (json['objectives'] as List<dynamic>)
          .map((o) => MissionObjective.fromJson(o as Map<String, dynamic>))
          .toList(),
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      bestScore: json['bestScore'] as int? ?? 0,
      bestTimeSeconds: (json['bestTimeSeconds'] as num?)?.toDouble(),
    );
  }

  /// Preset campaign missions conforming to the Game Design Document.
  static List<Mission> getCampaignMissions() {
    return [
      Mission(
        id: 'mission_1_snow_relay',
        sequenceNumber: 1,
        codeName: 'OPERATION FROSTBITE',
        title: 'The Snow Relay',
        location: 'Sub-Zero Outpost, Sector 7',
        environment: 'snow',
        briefingText:
            'Infiltrate the remote communications relay outpost. Avoid visual contact with perimeter patrols and utilize storage cabinets to break line of sight. Retrieve the encrypted server data key and exfiltrate through the northern security gate.',
        intelNote:
            'Two patrol guards maintain circular routes around the transformer station. One stationary guard guards the access corridor.',
        rewardCurrency: 350,
        targetTimeSeconds: 60,
        isUnlocked: true,
        objectives: [
          MissionObjective(
            id: 'obj_retrieve_key',
            title: 'Retrieve Data Key',
            description: 'Locate the encrypted terminal in the service room.',
            isPrimary: true,
          ),
          MissionObjective(
            id: 'obj_exfiltrate',
            title: 'Exfiltrate Outpost',
            description: 'Reach the northern extraction perimeter gate.',
            isPrimary: true,
          ),
          MissionObjective(
            id: 'obj_ghost',
            title: 'Ghost Infiltration',
            description: 'Complete mission with zero alarms triggered.',
            isPrimary: false,
          ),
        ],
      ),
      Mission(
        id: 'mission_2_desert_compound',
        sequenceNumber: 2,
        codeName: 'OPERATION DUNE VIPER',
        title: 'Desert Compound',
        location: 'Red Sands Logistics Base',
        environment: 'desert',
        briefingText:
            'Enter the heavily guarded desert depot. Guard density is increased with cross-patrol vision cones. Sabotage the generator and retrieve the manifest without triggering lockdown.',
        intelNote:
            'Multiple locker cabinets available in the barracks. Guards inspect sounds faster in the open courtyard.',
        rewardCurrency: 600,
        targetTimeSeconds: 90,
        isUnlocked: false,
        objectives: [
          MissionObjective(
            id: 'obj_sabotage_generator',
            title: 'Cut Compound Power',
            description: 'Plant EMP charge at main generator.',
            isPrimary: true,
          ),
          MissionObjective(
            id: 'obj_secure_manifest',
            title: 'Secure Manifest',
            description: 'Download manifest from command bunker.',
            isPrimary: true,
          ),
          MissionObjective(
            id: 'obj_exfiltrate_desert',
            title: 'Escape Compound',
            description: 'Rendezvous at extraction transport.',
            isPrimary: true,
          ),
        ],
      ),
      Mission(
        id: 'mission_3_forest_facility',
        sequenceNumber: 3,
        codeName: 'OPERATION BLACKWOOD',
        title: 'Forest Research Facility',
        location: 'Pine Ridge Black Site',
        environment: 'forest',
        briefingText:
            'Navigate dense perimeter foliage and interior containment blocks. The facility is equipped with automated alarm sensors and veteran guards.',
        intelNote:
            'Guards are armed with high-caliber rifles. Direct confrontation is lethal; rely on quiet takedowns and closet concealment.',
        rewardCurrency: 1000,
        targetTimeSeconds: 120,
        isUnlocked: false,
        objectives: [
          MissionObjective(
            id: 'obj_eliminate_target',
            title: 'Eliminate Rogue Commander',
            description: 'Neutralize high-value target in laboratory wing.',
            isPrimary: true,
          ),
          MissionObjective(
            id: 'obj_wipe_records',
            title: 'Wipe Digital Records',
            description: 'Erase central server logs.',
            isPrimary: true,
          ),
          MissionObjective(
            id: 'obj_escape_forest',
            title: 'Forest Extraction',
            description: 'Reach helicopter LZ across the river.',
            isPrimary: true,
          ),
        ],
      ),
    ];
  }
}
