import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../services/game_manager.dart';
import '../services/level_collision.dart';
import '../models/mission.dart';
import '../models/bridge_messages.dart';
import '../models/active_guard.dart';
import '../widgets/authentic_tilemap_painter.dart';
import '../widgets/interior_room_view.dart';
import '../widgets/retro_bottom_bar.dart';
import '../widgets/retro_dialogue_box.dart';
import '../widgets/touch_sensor_joystick.dart';
import '../widgets/tactical_hud_pill.dart';
import '../widgets/combat_fire_button.dart';
import '../widgets/noise_maker_button.dart';
import '../widgets/context_action_button.dart';
import '../widgets/tactical_pause_modal.dart';
import 'mission_result_screen.dart';

class GameViewportScreen extends StatefulWidget {
  final GameManager gameManager;
  final Mission mission;

  const GameViewportScreen({
    super.key,
    required this.gameManager,
    required this.mission,
  });

  @override
  State<GameViewportScreen> createState() => _GameViewportScreenState();
}

class _GameViewportScreenState extends State<GameViewportScreen> with SingleTickerProviderStateMixin {
  late StreamSubscription<HudUpdatePayload> _hudSub;
  late StreamSubscription<ObjectiveUpdatePayload> _objSub;
  late StreamSubscription<MissionResultPayload> _resultSub;

  HudUpdatePayload _hud = HudUpdatePayload(
    currentHealth: 100,
    maxHealth: 100,
    detectionMeter: 0.0,
    alarmState: AlarmState.quiet,
    contextAction: ContextActionType.none,
    isPlayerHidden: false,
  );

  bool _isPaused = false;

  // Real-time animated player state (Outdoor snow courtyard)
  Offset _playerPos = const Offset(0.46, 0.80); // Open courtyard snow south of GM pylon
  double _playerAngle = -1.57; // facing up
  Timer? _moveTimer;
  Offset _moveDir = Offset.zero;

  // Interior Service Room state & Door Lock state (matching assets/images/room_cutaway_interior.jpg)
  bool _isInsideRoom = false;
  bool _isWestDoorUnlocked = false;
  bool _hasRetrievedDataKey = false;
  Offset _roomPlayerPos = const Offset(0.5, 0.8); // Player pos inside room (normalized 0..1)
  double _roomPlayerAngle = -1.57; // Facing up inside room
  late AnimationController _animController;

  // Compact floating toast alert at top of screen
  String? _bannerMessage;
  Color _bannerColor = const Color(0xFF1565C0);
  IconData _bannerIcon = Icons.info_outline;
  Timer? _bannerDismissTimer;

  void _showTacticalToast({
    required String message,
    required Color color,
    required IconData icon,
    Duration duration = const Duration(milliseconds: 1400),
  }) {
    _bannerDismissTimer?.cancel();
    setState(() {
      _bannerMessage = message;
      _bannerColor = color;
      _bannerIcon = icon;
    });
    _bannerDismissTimer = Timer(duration, () {
      if (mounted) {
        setState(() {
          _bannerMessage = null;
        });
      }
    });
  }

  // Real-time active patrolling guards
  final List<ActiveGuard> _activeGuards = ActiveGuard.createLevel0Guards();
  Timer? _gameLoopTimer;
  double _localDetection = 0.0;

  // Story dialogue queue (Image 4 & 5)
  int _dialogueIndex = 0;
  final List<Map<String, String>> _storyDialogues = [
    {
      'speaker': 'Falkov',
      'text': 'Get a grip, man. You are the hard boiled assassin, Ramon Spectre. And I\'m Falkov, your assistant... Damn it.',
      'avatar': 'falkov',
    },
    {
      'speaker': 'Ramon',
      'text': 'It\'s a guard. If he sees me he will sound the alarm. Let\'s practice some shooting skills.',
      'avatar': 'ramon',
    },
    {
      'speaker': 'GM Guard',
      'text': 'Control, Sector 7 perimeter check is clear. Maintaining patrol along the southern relay.',
      'avatar': 'guard',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _startMission();
    _subscribeBridge();
    _startGameLoop();
  }

  void _startGameLoop() {
    _gameLoopTimer = Timer.periodic(const Duration(milliseconds: 32), (t) {
      if (!mounted || _isPaused) return;
      _updateGamePhysics(0.032);
    });
  }

  void _updateGamePhysics(double dt) {
    final px = Offset(_playerPos.dx * 17.0, _playerPos.dy * 24.0);

    // Check if player is positioned inside the West Building Room (X: 2.7..6.2, Y: 7.0..18.8)
    final bool playerInsideRoom = _playerPos.dx >= 0.16 &&
        _playerPos.dx <= 0.38 &&
        _playerPos.dy >= 0.30 &&
        _playerPos.dy <= 0.78;

    if (playerInsideRoom != _isInsideRoom) {
      setState(() {
        _isInsideRoom = playerInsideRoom;
        // When stepping inside, lock the blast door behind the player
        if (playerInsideRoom && _isWestDoorUnlocked) {
          _isWestDoorUnlocked = false; // Lock the door
          _showTacticalToast(
            message: 'DOOR LOCKED // ENTERED SERVICE ROOM',
            color: const Color(0xFF0D47A1),
            icon: Icons.lock,
          );
        }
      });
    }

    if (_isInsideRoom) {
      // Inside room objective proximity (Center partition console at grid ~4.5, 12.0)
      final consoleDist = (px - const Offset(4.5, 12.0)).distance;
      ContextActionType action = ContextActionType.none;
      if (consoleDist < 2.5 && !_hasRetrievedDataKey) {
        action = ContextActionType.interact;
      }

      setState(() {
        _hud = _hud.copyWith(
          detectionMeter: 0.0,
          alarmState: AlarmState.quiet,
          contextAction: action,
        );
      });
      return;
    }

    // 1. Update guards along their waypoint paths (Outdoor snow yard)
    for (final guard in _activeGuards) {
      guard.update(dt);
    }

    // 2. Real-time vision detection
    bool detectedThisFrame = false;

    if (!_hud.isPlayerHidden) {
      for (final guard in _activeGuards) {
        if (guard.isDefeated) continue;

        final delta = px - guard.position;
        final dist = delta.distance;

        // Vision reach is ~5 tiles (50 px native)
        if (dist < 5.2) {
          double angleDiff = (delta.direction - guard.angle).abs() % (2 * math.pi);
          if (angleDiff > math.pi) angleDiff = 2 * math.pi - angleDiff;

          // 40-degree field of vision cone (0.70 rad)
          if (angleDiff < 0.70) {
            detectedThisFrame = true;
            guard.isAlert = true;
            _localDetection = (_localDetection + dt * 0.55).clamp(0.0, 1.0);
          }
        }
      }

      if (!detectedThisFrame) {
        _localDetection = (_localDetection - dt * 0.18).clamp(0.0, 1.0);
      }
    } else {
      // Ramon is concealed in closet
      _localDetection = (_localDetection - dt * 0.35).clamp(0.0, 1.0);
    }

    // 3. Update Alarm State based on detection
    AlarmState currentAlarm = AlarmState.quiet;
    if (_localDetection >= 0.85) {
      currentAlarm = AlarmState.alert;
    } else if (_localDetection > 0.35) {
      currentAlarm = AlarmState.suspicious;
    }

    // 4. Closet proximity check (next to door at grid (4.8, 18.5))
    ContextActionType action = ContextActionType.none;
    final closetDist = (px - const Offset(4.8, 18.5)).distance;

    if (closetDist < 1.8) {
      action = _hud.isPlayerHidden ? ContextActionType.exitCabinet : ContextActionType.hide;
    }

    setState(() {
      _hud = _hud.copyWith(
        detectionMeter: _localDetection,
        alarmState: currentAlarm,
        contextAction: action,
      );
    });
  }

  void _startMission() {
    final payload = widget.gameManager.buildStartPayload(widget.mission.id);
    widget.gameManager.bridge.startMission(payload);
  }

  void _subscribeBridge() {
    _hudSub = widget.gameManager.bridge.onHudUpdate.listen((data) {
      if (mounted) setState(() => _hud = data);
    });

    _objSub = widget.gameManager.bridge.onObjectiveUpdate.listen((data) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data.title}: ${data.isCompleted ? "COMPLETED" : "UPDATED"}'),
            duration: const Duration(seconds: 2),
            backgroundColor: const Color(0xFF1E2836),
          ),
        );
      }
    });

    _resultSub = widget.gameManager.bridge.onMissionResult.listen((data) {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => MissionResultScreen(
              gameManager: widget.gameManager,
              mission: widget.mission,
              result: data,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerDismissTimer?.cancel();
    _animController.dispose();
    _hudSub.cancel();
    _objSub.cancel();
    _resultSub.cancel();
    _moveTimer?.cancel();
    _gameLoopTimer?.cancel();
    super.dispose();
  }

  void _onDirectionChanged(Offset dir) {
    _moveDir = dir;
    _moveTimer?.cancel();

    if (dir != Offset.zero) {
      _moveTimer = Timer.periodic(const Duration(milliseconds: 32), (t) {
        if (!mounted || _hud.isPlayerHidden) return;
        setState(() {
          final double magnitude = _moveDir.distance.clamp(0.25, 1.0);
          final newPos = LevelCollision.resolveMovement(
            currentNormalizedPos: _playerPos,
            moveDir: _moveDir,
            speedPxPerSec: 54.0 * magnitude,
            dt: 0.032,
            isWestDoorUnlocked: _isWestDoorUnlocked,
          );
          _playerPos = newPos;
          _playerAngle = _moveDir.direction;
          // Sync interior room coordinates when inside
          if (_isInsideRoom) {
            // Map outdoor normalized range (0.16..0.38, 0.30..0.78) to room interior (0..1)
            _roomPlayerPos = Offset(
              ((_playerPos.dx - 0.16) / 0.22).clamp(0.0, 1.0),
              ((_playerPos.dy - 0.30) / 0.48).clamp(0.0, 1.0),
            );
            _roomPlayerAngle = _playerAngle;
          }
        });
      });
    }
  }

  void _togglePause() {
    setState(() => _isPaused = !_isPaused);
    widget.gameManager.bridge.setPaused(_isPaused);
  }

  CombatButtonMode _getCombatButtonMode() {
    final px = Offset(_playerPos.dx * 17.0, _playerPos.dy * 24.0);
    // In front of West blast door (grid 3.9, 19.2)
    final doorDist = (px - const Offset(3.9, 19.2)).distance;

    if (doorDist < 2.0) {
      return _isWestDoorUnlocked ? CombatButtonMode.lockedDoor : CombatButtonMode.unlockDoor;
    }
    return CombatButtonMode.fire;
  }

  void _onCombatButtonPressed() {
    final mode = _getCombatButtonMode();

    if (mode == CombatButtonMode.unlockDoor) {
      // Unlock the door
      setState(() {
        _isWestDoorUnlocked = true;
      });
      _showTacticalToast(
        message: 'DOOR UNLOCKED // WALK THROUGH ENTRANCE',
        color: const Color(0xFF00E676),
        icon: Icons.lock_open,
      );
      return;
    } else if (mode == CombatButtonMode.lockedDoor) {
      // Lock the door
      setState(() {
        _isWestDoorUnlocked = false;
      });
      _showTacticalToast(
        message: 'DOOR LOCKED // SEALED SECURE',
        color: const Color(0xFFFF9800),
        icon: Icons.lock,
      );
      return;
    }

    // Default Fire action
    _onFireWeapon();
  }

  void _onFireWeapon() {
    if (_isInsideRoom) {
      _showTacticalToast(
        message: 'BULLET DEFLECTED BY BULKHEAD',
        color: const Color(0xFF37474F),
        icon: Icons.shield,
      );
      return;
    }

    final px = Offset(_playerPos.dx * 17.0, _playerPos.dy * 24.0);
    ActiveGuard? targetGuard;
    double minDistance = 5.5; // reach range within 5.5 tiles

    for (final g in _activeGuards) {
      if (g.isDefeated) continue;
      final d = (g.position - px).distance;
      if (d < minDistance) {
        minDistance = d;
        targetGuard = g;
      }
    }

    if (targetGuard != null) {
      setState(() {
        targetGuard!.isDefeated = true;
        _localDetection = (_localDetection - 0.4).clamp(0.0, 1.0);
      });
      _showTacticalToast(
        message: 'SILENT TAKEDOWN // GUARD DOWN',
        color: const Color(0xFF1565C0),
        icon: Icons.flash_on,
      );
    } else {
      _showTacticalToast(
        message: 'SILENCED SHOT // EMPTY SECTOR',
        color: const Color(0xFF1E2836),
        icon: Icons.track_changes,
      );
    }
  }

  void _onMakeNoise() {
    if (_isInsideRoom) {
      _showTacticalToast(
        message: 'ACOUSTIC ECHO // REVERBERATION',
        color: const Color(0xFF455A64),
        icon: Icons.graphic_eq,
      );
      return;
    }

    final px = Offset(_playerPos.dx * 17.0, _playerPos.dy * 24.0);
    int alertedCount = 0;

    for (final g in _activeGuards) {
      if (g.isDefeated) continue;
      final d = (g.position - px).distance;
      if (d < 7.5) {
        g.isAlert = true;
        // Turn guard towards the noise source
        g.angle = (px - g.position).direction;
        alertedCount++;
      }
    }

    setState(() {
      _localDetection = (_localDetection + 0.15).clamp(0.0, 1.0);
    });

    _showTacticalToast(
      message: alertedCount > 0
          ? 'DISTRACTION // $alertedCount GUARDS ALERTED'
          : 'CLICK // DISTRACTION EMITTED',
      color: const Color(0xFFE65100),
      icon: Icons.volume_up,
    );
  }

  void _advanceDialogue() {
    setState(() {
      if (_dialogueIndex < _storyDialogues.length) {
        _dialogueIndex++;
      }
    });
  }

  void _onContextActionPressed() {
    if (_isInsideRoom) {
      if (_hud.contextAction == ContextActionType.interact) {
        // Retrieve Data Key at center partition console
        setState(() {
          _hasRetrievedDataKey = true;
        });
        widget.gameManager.bridge.triggerObjectiveComplete('obj_data_key');
        _showTacticalToast(
          message: 'DATA KEY SECURED // OBJ 1 COMPLETE',
          color: const Color(0xFF2E7D32),
          icon: Icons.vpn_key,
          duration: const Duration(seconds: 2),
        );
      }
      return;
    }

    // Outdoor closet hide/exit
    final isNowHidden = _hud.contextAction == ContextActionType.hide;
    setState(() {
      _hud = _hud.copyWith(
        isPlayerHidden: isNowHidden,
        contextAction: isNowHidden
            ? ContextActionType.exitCabinet
            : ContextActionType.hide,
      );
    });
    widget.gameManager.bridge.triggerContextAction(
      isNowHidden ? ContextActionType.hide : ContextActionType.exitCabinet,
    );
  }

  @override
  Widget build(BuildContext context) {
    final healthFraction = (_hud.currentHealth / _hud.maxHealth).clamp(0.0, 1.0);
    final isAlert = _hud.alarmState == AlarmState.alert || _hud.alarmState == AlarmState.suspicious;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _togglePause();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              // --- 1. ULTRA-HD CONSOLE HUD & BAR (Positioned Above Map Viewport) ---
              RetroBottomBar(
                healthFraction: healthFraction,
                onFireWeapon: _onFireWeapon,
                onLeftSoftkey: () {
                  if (_dialogueIndex < _storyDialogues.length) {
                    _advanceDialogue();
                  } else {
                    _onFireWeapon();
                  }
                },
                onRightSoftkey: _togglePause,
                leftLabel: _dialogueIndex < _storyDialogues.length ? 'Ok' : 'Fire',
                rightLabel: 'Menu',
              ),

              // --- 2. TOP-DOWN RETRO MAP / INTERIOR ROOM VIEWPORT ---
              Expanded(
                child: Stack(
                  children: [
                    // Siberian snow military base map OR Interior Service Room
                    Positioned.fill(
                      child: ClipRect(
                        child: _isInsideRoom
                            ? AnimatedBuilder(
                                animation: _animController,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: InteriorRoomPainter(
                                      playerPos: _roomPlayerPos,
                                      playerAngle: _roomPlayerAngle,
                                      hasDataKey: _hasRetrievedDataKey,
                                      animationValue: _animController.value,
                                    ),
                                  );
                                },
                              )
                            : CustomPaint(
                                painter: AuthenticTilemapPainter(
                                  playerPos: _playerPos,
                                  playerAngle: _playerAngle,
                                  isHidden: _hud.isPlayerHidden,
                                  alertActive: isAlert,
                                  activeGuards: _activeGuards,
                                ),
                              ),
                      ),
                    ),

                    // Top Modern Tactical HUD Pill
                    Positioned(
                      top: 10,
                      left: 14,
                      right: 14,
                      child: TacticalHudPill(
                        alarmState: _hud.alarmState,
                        detectionMeter: _hud.detectionMeter,
                      ),
                    ),

                    // Sector / Room Location Indicator
                    Positioned(
                      top: 60,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: _isInsideRoom ? const Color(0xFF00E676) : const Color(0xFF0288D1),
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isInsideRoom ? Icons.meeting_room : Icons.ac_unit,
                              color: _isInsideRoom ? const Color(0xFF00E676) : const Color(0xFF81D4FA),
                              size: 13,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _isInsideRoom
                                  ? (_hasRetrievedDataKey ? 'SERVICE ROOM [DATA KEY SECURED]' : 'SERVICE ROOM [OBJECTIVE 1]')
                                  : 'SECTOR 7 [SIBERIAN COURTYARD]',
                              style: TextStyle(
                                color: _isInsideRoom ? const Color(0xFF00E676) : Colors.white70,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'monospace',
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Compact Top Floating Tactical Toast Message (Noise / Fire / Combat telemetry)
                    if (_bannerMessage != null)
                      Positioned(
                        top: 92,
                        left: 20,
                        right: 20,
                        child: Center(
                          child: AnimatedOpacity(
                            opacity: _bannerMessage != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: _bannerColor.withValues(alpha: 0.92),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white70, width: 1.2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.5),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(_bannerIcon, color: Colors.white, size: 14),
                                  const SizedBox(width: 6),
                                  Text(
                                    _bannerMessage!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'monospace',
                                      letterSpacing: 0.9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    // Active Story / Intel Dialogue Popup
                    if (_dialogueIndex < _storyDialogues.length)
                      Positioned(
                        left: 10,
                        right: 10,
                        top: 54,
                        child: RetroDialogueBox(
                          speakerName: _storyDialogues[_dialogueIndex]['speaker']!,
                          dialogueText: _storyDialogues[_dialogueIndex]['text']!,
                          avatarType: _storyDialogues[_dialogueIndex]['avatar']!,
                          onDismiss: _advanceDialogue,
                        ),
                      ),

                    // --- TOUCH CONTROLLER SURFACE (Movement Sensor) ---
                    // Covers the middle-to-upper viewport area comfortably without overlapping bottom action buttons.
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 70,
                      bottom: 110,
                      child: TouchSensorJoystick(
                        maxRadius: 54.0,
                        deadZone: 5.0,
                        showSensorOnTouch: true,
                        onDirectionChanged: _onDirectionChanged,
                      ),
                    ),

                    // --- BOTTOM-LEFT ACTION: NOISE MAKER BUTTON ---
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: NoiseMakerButton(onTap: _onMakeNoise),
                    ),

                    // Contextual Action Button (Closet Hide / Exit above Noise Maker)
                    if (_hud.contextAction != ContextActionType.none)
                      Positioned(
                        left: 20,
                        bottom: 112,
                        child: ContextActionButton(
                          actionType: _hud.contextAction,
                          onPressed: _onContextActionPressed,
                        ),
                      ),

                    // --- BOTTOM-RIGHT ACTION: FIRE BUTTON ---
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: CombatFireButton(
                        mode: _getCombatButtonMode(),
                        onTap: _onCombatButtonPressed,
                      ),
                    ),

                    // Tactical Pause Overlay Modal (Ultra-HD Glassmorphism)
                    if (_isPaused)
                      TacticalPauseModal(
                        onResume: _togglePause,
                        onRestart: () {
                          _togglePause();
                          widget.gameManager.bridge.restartMission();
                        },
                        onAbort: () {
                          _togglePause();
                          Navigator.of(context).pop();
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
