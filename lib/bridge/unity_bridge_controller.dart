import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/bridge_messages.dart';

/// Callback signatures for Unity engine events.
typedef OnHudUpdateCallback = void Function(HudUpdatePayload hud);
typedef OnObjectiveUpdateCallback = void Function(ObjectiveUpdatePayload obj);
typedef OnMissionResultCallback = void Function(MissionResultPayload result);
typedef OnGameReadyCallback = void Function();

/// Bidirectional bridge coordinator connecting Flutter Dart logic to Unity C# scripts.
class UnityBridgeController {
  static const MethodChannel _platformChannel =
      MethodChannel('com.retrogames.shadowcontract/unity_bridge');

  // Event stream controllers
  final StreamController<HudUpdatePayload> _hudStream =
      StreamController<HudUpdatePayload>.broadcast();
  final StreamController<ObjectiveUpdatePayload> _objectiveStream =
      StreamController<ObjectiveUpdatePayload>.broadcast();
  final StreamController<MissionResultPayload> _resultStream =
      StreamController<MissionResultPayload>.broadcast();
  final StreamController<void> _readyStream =
      StreamController<void>.broadcast();

  Stream<HudUpdatePayload> get onHudUpdate => _hudStream.stream;
  Stream<ObjectiveUpdatePayload> get onObjectiveUpdate => _objectiveStream.stream;
  Stream<MissionResultPayload> get onMissionResult => _resultStream.stream;
  Stream<void> get onGameReady => _readyStream.stream;

  bool isUnityReady = false;
  bool isSimulationMode = false;
  Timer? _simulationTimer;

  UnityBridgeController() {
    _initChannelHandler();
  }

  void _initChannelHandler() {
    _platformChannel.setMethodCallHandler((MethodCall call) async {
      try {
        if (call.method == 'onUnityMessage') {
          final String raw = call.arguments as String;
          handleIncomingUnityMessage(raw);
        }
      } catch (e) {
        debugPrint('Error handling Unity channel message: $e');
      }
    });
  }

  /// Processes raw JSON messages dispatched from Unity C# (UnitySendMessage / UnityMessageDispatcher).
  void handleIncomingUnityMessage(String rawJson) {
    try {
      final msg = BridgeMessage.deserialize(rawJson);
      switch (msg.type) {
        case 'ON_GAME_READY':
          isUnityReady = true;
          _readyStream.add(null);
          break;
        case 'ON_HUD_UPDATE':
          final hud = HudUpdatePayload.fromJson(msg.data);
          _hudStream.add(hud);
          break;
        case 'ON_OBJECTIVE_UPDATE':
          final obj = ObjectiveUpdatePayload.fromJson(msg.data);
          _objectiveStream.add(obj);
          break;
        case 'ON_MISSION_RESULT':
          final result = MissionResultPayload.fromJson(msg.data);
          _resultStream.add(result);
          break;
        default:
          debugPrint('Unknown bridge message type: ${msg.type}');
      }
    } catch (e) {
      debugPrint('Failed to parse incoming Unity message: $rawJson (Error: $e)');
    }
  }

  /// Dispatches a command from Flutter into the Unity engine runtime.
  Future<void> sendToUnity(String messageType, Map<String, dynamic> data) async {
    final payload = jsonEncode({'type': messageType, 'data': data});

    if (isSimulationMode) {
      _handleSimulatedCommand(messageType, data);
      return;
    }

    try {
      await _platformChannel.invokeMethod('sendToUnity', {
        'gameObject': 'FlutterBridgeReceiver',
        'methodName': 'OnReceiveMessageFromFlutter',
        'message': payload,
      });
    } on MissingPluginException {
      // In local development or desktop where the native plugin isn't linked, fallback to simulation
      debugPrint('Native bridge channel not found. Auto-activating simulation mode.');
      isSimulationMode = true;
      _handleSimulatedCommand(messageType, data);
    } catch (e) {
      debugPrint('Error dispatching message to Unity: $e');
    }
  }

  /// Commands:
  Future<void> startMission(StartMissionPayload payload) async {
    await sendToUnity('START_MISSION', payload.toJson());
  }

  Future<void> setPaused(bool isPaused) async {
    await sendToUnity('SET_PAUSED', {'isPaused': isPaused});
  }

  Future<void> restartMission() async {
    await sendToUnity('RESTART_MISSION', {});
  }

  Future<void> triggerContextAction(ContextActionType action) async {
    await sendToUnity('TRIGGER_ACTION', {'action': action.name});
  }

  Future<void> triggerObjectiveComplete(String objectiveId) async {
    await sendToUnity('COMPLETE_OBJECTIVE', {'objectiveId': objectiveId});
  }

  /// Built-in simulator for rapid desktop & test-driven UI verification.
  void _handleSimulatedCommand(String type, Map<String, dynamic> data) {
    if (type == 'START_MISSION') {
      _simulationTimer?.cancel();
      isUnityReady = true;
      _readyStream.add(null);

      // Emit starting HUD state
      _hudStream.add(HudUpdatePayload(
        currentHealth: (data['maxHealth'] as num?)?.toDouble() ?? 100.0,
        maxHealth: (data['maxHealth'] as num?)?.toDouble() ?? 100.0,
        detectionMeter: 0.0,
        alarmState: AlarmState.quiet,
        contextAction: ContextActionType.none,
        isPlayerHidden: false,
      ));

      // Simulate a cabinet approach after 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        if (_simulationTimer == null) return;
        _hudStream.add(HudUpdatePayload(
          currentHealth: 100.0,
          maxHealth: 100.0,
          detectionMeter: 0.25,
          alarmState: AlarmState.suspicious,
          contextAction: ContextActionType.hide,
          isPlayerHidden: false,
        ));
      });

      _simulationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // Active simulation heartbeat
      });
    } else if (type == 'TRIGGER_ACTION') {
      final action = data['action'] as String;
      if (action == 'hide') {
        _hudStream.add(HudUpdatePayload(
          currentHealth: 100.0,
          maxHealth: 100.0,
          detectionMeter: 0.0,
          alarmState: AlarmState.quiet,
          contextAction: ContextActionType.exitCabinet,
          isPlayerHidden: true,
        ));
      } else if (action == 'exitCabinet') {
        _hudStream.add(HudUpdatePayload(
          currentHealth: 100.0,
          maxHealth: 100.0,
          detectionMeter: 0.0,
          alarmState: AlarmState.quiet,
          contextAction: ContextActionType.none,
          isPlayerHidden: false,
        ));
      }
    }
  }

  void dispose() {
    _simulationTimer?.cancel();
    _hudStream.close();
    _objectiveStream.close();
    _resultStream.close();
    _readyStream.close();
  }
}
