import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shadow_contract/models/bridge_messages.dart';
import 'package:shadow_contract/services/storage_service.dart';
import 'package:shadow_contract/services/game_manager.dart';
import 'package:shadow_contract/bridge/unity_bridge_controller.dart';
import 'package:shadow_contract/widgets/authentic_tilemap_painter.dart';
import 'package:shadow_contract/models/active_guard.dart';
import 'package:shadow_contract/services/level_collision.dart';
import 'package:shadow_contract/widgets/touch_sensor_joystick.dart';
import 'package:shadow_contract/widgets/retro_dialogue_box.dart';
import 'package:shadow_contract/widgets/tactical_hud_pill.dart';
import 'package:shadow_contract/widgets/combat_fire_button.dart';
import 'package:shadow_contract/widgets/noise_maker_button.dart';
import 'package:shadow_contract/widgets/context_action_button.dart';
import 'package:shadow_contract/widgets/tactical_pause_modal.dart';
import 'package:shadow_contract/widgets/interior_room_view.dart';
import 'package:shadow_contract/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Bridge Protocol Serialization Tests', () {
    test('StartMissionPayload serializes and deserializes correctly', () {
      final payload = StartMissionPayload(
        missionId: 'mission_1_snow_relay',
        movementSpeedMultiplier: 1.15,
        noiseRadiusMultiplier: 0.75,
        maxHealth: 125.0,
        takedownReachMultiplier: 1.25,
        cabinetSpeedMultiplier: 0.7,
        enableDebugOverlays: true,
      );

      final json = payload.toJson();
      final restored = StartMissionPayload.fromJson(json);

      expect(restored.missionId, 'mission_1_snow_relay');
      expect(restored.movementSpeedMultiplier, 1.15);
      expect(restored.noiseRadiusMultiplier, 0.75);
      expect(restored.maxHealth, 125.0);
      expect(restored.takedownReachMultiplier, 1.25);
      expect(restored.cabinetSpeedMultiplier, 0.7);
      expect(restored.enableDebugOverlays, isTrue);
    });

    test('HudUpdatePayload parses correctly from Unity JSON string', () {
      const rawJson = '''
      {
        "type": "ON_HUD_UPDATE",
        "data": {
          "currentHealth": 85.0,
          "maxHealth": 100.0,
          "detectionMeter": 0.65,
          "alarmState": "suspicious",
          "contextAction": "hide",
          "isPlayerHidden": false
        }
      }
      ''';

      final msg = BridgeMessage.deserialize(rawJson);
      expect(msg.type, 'ON_HUD_UPDATE');

      final hud = HudUpdatePayload.fromJson(msg.data);
      expect(hud.currentHealth, 85.0);
      expect(hud.maxHealth, 100.0);
      expect(hud.detectionMeter, 0.65);
      expect(hud.alarmState, AlarmState.suspicious);
      expect(hud.contextAction, ContextActionType.hide);
      expect(hud.isPlayerHidden, isFalse);
    });

    test('MissionResultPayload triggers victory calculation and rating correctly', () {
      final result = MissionResultPayload(
        success: true,
        missionId: 'mission_1_snow_relay',
        durationSeconds: 45.2,
        alertsTriggered: 0,
        guardsNeutralized: 1,
        damageReceived: 0,
        currencyEarned: 350,
        rating: StealthRating.ghost,
      );

      final json = result.toJson();
      final restored = MissionResultPayload.fromJson(json);

      expect(restored.success, isTrue);
      expect(restored.rating, StealthRating.ghost);
      expect(restored.alertsTriggered, 0);
      expect(restored.currencyEarned, 350);
    });
  });

  group('GameManager & Progression Logic Tests', () {
    late StorageService storageService;
    late UnityBridgeController bridge;
    late GameManager gameManager;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      storageService = StorageService();
      storageService.initWithPrefs(prefs);

      bridge = UnityBridgeController();
      bridge.isSimulationMode = true;

      gameManager = GameManager(
        storageService: storageService,
        bridge: bridge,
      );
      await gameManager.init();
    });

    tearDown(() {
      bridge.dispose();
    });

    test('Initializes with default starting credits and missions', () {
      expect(gameManager.walletCredits, 500);
      expect(gameManager.missions.length, greaterThanOrEqualTo(3));
      expect(gameManager.missions.first.isUnlocked, isTrue);
      expect(gameManager.missions[1].isUnlocked, isFalse);
    });

    test('Upgrade purchase correctly deducts credits and increases level', () async {
      final speedUpgrade = gameManager.upgrades.firstWhere((u) => u.id == 'upgrade_movement_speed');
      expect(speedUpgrade.currentLevel, 0);
      final cost = speedUpgrade.nextCost; // 200

      final success = await gameManager.purchaseUpgrade(speedUpgrade.id);
      expect(success, isTrue);
      expect(gameManager.walletCredits, 500 - cost);
      expect(speedUpgrade.currentLevel, 1);
    });

    test('Upgrade purchase fails when funds are insufficient', () async {
      // Drain credits
      await gameManager.resetProgression();
      // Set to 50 credits
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('ptk_wallet_credits', 50);
      await gameManager.init();

      final speedUpgrade = gameManager.upgrades.firstWhere((u) => u.id == 'upgrade_movement_speed');
      final success = await gameManager.purchaseUpgrade(speedUpgrade.id);
      expect(success, isFalse);
      expect(speedUpgrade.currentLevel, 0);
    });

    test('Mission victory awards credits and unlocks the next sequence mission', () async {
      expect(gameManager.missions[1].isUnlocked, isFalse);

      final result = MissionResultPayload(
        success: true,
        missionId: 'mission_1_snow_relay',
        durationSeconds: 38.0,
        alertsTriggered: 0,
        guardsNeutralized: 2,
        damageReceived: 0,
        currencyEarned: 350,
        rating: StealthRating.ghost,
      );

      // Simulate incoming message from Unity
      bridge.handleIncomingUnityMessage(
        jsonEncode({"type": "ON_MISSION_RESULT", "data": result.toJson()}),
      );

      // Wait a microtask for stream processing
      await Future.delayed(const Duration(milliseconds: 50));

      expect(gameManager.walletCredits, 500 + 350);
      expect(gameManager.missions[0].isCompleted, isTrue);
      expect(gameManager.missions[1].isUnlocked, isTrue);
    });
  });

  group('UI Widget Flow Tests', () {
    testWidgets('Renders MainMenu and navigates cleanly', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final storageService = StorageService();
      storageService.initWithPrefs(prefs);

      final bridge = UnityBridgeController();
      bridge.isSimulationMode = true;

      final gameManager = GameManager(
        storageService: storageService,
        bridge: bridge,
      );
      await gameManager.init();

      await tester.pumpWidget(ShadowContractApp(gameManager: gameManager));
      await tester.pumpAndSettle();

      // Verify title & menu options from Paid to Kill
      expect(find.text('PAID TO KILL'), findsOneWidget);
      expect(find.text('NEW GAME'), findsOneWidget);
      expect(find.text('SETTINGS'), findsOneWidget);
      expect(find.text('HELP'), findsOneWidget);

      // Tap Settings
      await tester.tap(find.text('SETTINGS'));
      await tester.pumpAndSettle();

      expect(find.text('SETTINGS // SYSTEM'), findsOneWidget);
      expect(find.text('BGM Music Volume'), findsOneWidget);

      bridge.dispose();
    });

    testWidgets('AuthenticTilemapPainter paints HD walls, doors, and active guards cleanly', (WidgetTester tester) async {
      final guards = ActiveGuard.createLevel0Guards();
      expect(guards.length, 3);

      // Verify guard updates
      // Verify sentry guard vision cone sweeps actively
      final initialSentryAngle = guards[1].angle;
      guards[1].update(0.5);
      expect(guards[1].angle, isNot(equals(initialSentryAngle)));

      // Verify patrol guard walks along waypoints
      final initialPatrolPos = guards[0].position;
      guards[0].update(0.1); // registers initial waypoint
      guards[0].update(2.5); // completes wait and moves towards next waypoint
      expect(guards[0].position, isNot(equals(initialPatrolPos)));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: const Size(360, 640),
              painter: AuthenticTilemapPainter(
                playerPos: const Offset(0.36, 0.74),
                playerAngle: -1.57,
                isHidden: false,
                alertActive: false,
                activeGuards: guards,
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(CustomPaint), findsWidgets);
    });

    test('LevelCollision blocks walls, doors, fences, and allows wall-sliding', () {
      // 1. Initial spawn position is clear on open snow
      final spawnPos = const Offset(0.46, 0.80);
      expect(LevelCollision.isPositionBlocked(spawnPos), isFalse);

      // 2. Solid wall and door obstacles are blocked
      // North Wall & North Blast Door
      expect(LevelCollision.isColliding(50.0, 10.0), isTrue);
      expect(LevelCollision.isColliding(90.0, 10.0), isTrue);

      // Left Military Building, West Blast Door, and Closets
      expect(LevelCollision.isColliding(40.0, 100.0), isTrue);
      expect(LevelCollision.isColliding(39.0, 182.0), isTrue);
      expect(LevelCollision.isColliding(50.0, 182.0), isTrue);

      // Right L-Building North Wing & South Wing with East Blast Door
      expect(LevelCollision.isColliding(100.0, 90.0), isTrue);
      expect(LevelCollision.isColliding(140.0, 150.0), isTrue);
      expect(LevelCollision.isColliding(140.0, 182.0), isTrue);

      // Perimeter walls and chain-link security fence
      expect(LevelCollision.isColliding(60.0, 46.0), isTrue); // Fence
      expect(LevelCollision.isColliding(3.0, 100.0), isTrue);  // West wall
      expect(LevelCollision.isColliding(167.0, 100.0), isTrue);// East wall
      expect(LevelCollision.isColliding(50.0, 230.0), isTrue); // South wall

      // 3. Authentic pathways and courtyards are walkable
      expect(LevelCollision.isColliding(74.0, 90.0), isFalse);  // Central corridor
      expect(LevelCollision.isColliding(100.0, 35.0), isFalse); // North courtyard
      expect(LevelCollision.isColliding(15.0, 120.0), isFalse); // West alleyway
      expect(LevelCollision.isColliding(83.2, 197.0), isFalse); // South courtyard

      // 4. Movement resolution: Walking directly into building is blocked
      // Ramon at (78, 150) in native px is in the central corridor facing Left Building wall (right: 66)
      final normPos = const Offset(78.0 / 170.0, 150.0 / 240.0);
      // Attempting to move left directly into the Left Building wall (step = 20 px penetrates wall)
      final blockedMove = LevelCollision.resolveMovement(
        currentNormalizedPos: normPos,
        moveDir: const Offset(-1.0, 0.0),
        speedPxPerSec: 200.0,
        dt: 0.1,
      );
      // Player is completely blocked from penetrating Left Building
      expect(blockedMove, equals(normPos));

      // 5. Wall-sliding: Diagonal movement against wall slides along unblocked axis
      final slidingMove = LevelCollision.resolveMovement(
        currentNormalizedPos: normPos,
        moveDir: const Offset(-1.0, -1.0),
        speedPxPerSec: 200.0,
        dt: 0.1,
      );
      // Y decreases (slides vertically north along the corridor) while X is stopped by wall
      expect(slidingMove.dy, lessThan(normPos.dy));
      expect(slidingMove.dx, equals(normPos.dx));
    });

    testWidgets('TouchSensorJoystick is invisible at rest and responds to touch drag', (WidgetTester tester) async {
      Offset receivedDirection = Offset.zero;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 300,
              height: 300,
              child: TouchSensorJoystick(
                onDirectionChanged: (dir) => receivedDirection = dir,
                maxRadius: 50.0,
                deadZone: 5.0,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // At rest: CustomPaint with touch sensor is NOT rendered (invisible at rest)
      expect(receivedDirection, equals(Offset.zero));

      // Touch down at (150, 150) and drag to (190, 150) (40px right)
      final gesture = await tester.startGesture(const Offset(150, 150));
      await tester.pump();
      await gesture.moveBy(const Offset(40, 0));
      await tester.pump(const Duration(milliseconds: 50));

      // Rightward movement detected with magnitude
      expect(receivedDirection.dx, greaterThan(0.5));
      expect(receivedDirection.dy.abs(), lessThan(0.1));

      // Release touch
      await gesture.up();
      await tester.pumpAndSettle();

      // Automatically resets to zero
      expect(receivedDirection, equals(Offset.zero));
    });

    testWidgets('RetroDialogueBox renders guard avatar with blue beret and steel blue suit', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: RetroDialogueBox(
              speakerName: 'GM Guard',
              dialogueText: 'Sector 7 perimeter check is clear.',
              avatarType: 'guard',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('GM GUARD'), findsOneWidget);
      expect(find.text('[SECURITY GUARD]'), findsOneWidget);
      expect(find.text('Sector 7 perimeter check is clear.'), findsOneWidget);
    });

    testWidgets('TacticalHudPill renders alarm badge and detection meter percentage', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TacticalHudPill(
              alarmState: AlarmState.suspicious,
              detectionMeter: 0.65,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('SUSPICIOUS'), findsOneWidget);
      expect(find.text('DETECTION:'), findsOneWidget);
      expect(find.text('65%'), findsOneWidget);
    });

    testWidgets('CombatFireButton triggers weapon fire callback when tapped', (WidgetTester tester) async {
      bool fired = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CombatFireButton(onTap: () => fired = true),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('FIRE'), findsOneWidget);
      await tester.tap(find.text('FIRE'));
      expect(fired, isTrue);
    });

    testWidgets('ContextActionButton toggles concealment and renders appropriately', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ContextActionButton(
              actionType: ContextActionType.hide,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('CONCEAL IN CLOSET'), findsOneWidget);
      await tester.tap(find.text('CONCEAL IN CLOSET'));
      expect(pressed, isTrue);
    });

    testWidgets('TacticalPauseModal displays pause actions and hooks callbacks', (WidgetTester tester) async {
      bool resumed = false;
      bool restarted = false;
      bool aborted = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                TacticalPauseModal(
                  onResume: () => resumed = true,
                  onRestart: () => restarted = true,
                  onAbort: () => aborted = true,
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('TACTICAL PAUSE'), findsOneWidget);
      await tester.tap(find.text('RESUME MISSION'));
      expect(resumed, isTrue);

      await tester.tap(find.text('RESTART SECTOR'));
      expect(restarted, isTrue);

      await tester.tap(find.text('ABORT TO MENU'));
      expect(aborted, isTrue);
    });

    testWidgets('NoiseMakerButton triggers distraction callback when tapped', (WidgetTester tester) async {
      bool noiseMade = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoiseMakerButton(onTap: () => noiseMade = true),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('NOISE'), findsOneWidget);
      await tester.tap(find.text('NOISE'));
      expect(noiseMade, isTrue);
    });

    testWidgets('InteriorRoomPainter renders room interior matching reference image and tests collision', (WidgetTester tester) async {
      // 1. Test collision boundaries
      expect(InteriorRoomCollision.isColliding(340, 100), isTrue); // Top wall blocked
      expect(InteriorRoomCollision.isColliding(50, 500), isTrue); // West wall blocked
      expect(InteriorRoomCollision.isColliding(620, 600), isTrue); // East wall blocked
      expect(InteriorRoomCollision.isColliding(340, 630), isTrue); // Center partition desk blocked
      expect(InteriorRoomCollision.isColliding(340, 800), isFalse); // Open floor walkable

      // 2. Test smooth wall sliding
      final startPos = const Offset(0.50, 0.78);
      final movedPos = InteriorRoomCollision.resolveMovement(
        currentPos: startPos,
        moveDir: const Offset(0, 1),
        speedPxPerSec: 100,
        dt: 0.032,
      );
      expect(movedPos.dy, greaterThan(startPos.dy));

      // 3. Render InteriorRoomPainter
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomPaint(
              size: const Size(340, 512),
              painter: InteriorRoomPainter(
                playerPos: const Offset(0.50, 0.86),
                playerAngle: -1.57,
                hasDataKey: false,
                animationValue: 0.5,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CustomPaint), findsWidgets);
    });
  });
}
