# Shadow Contract (Paid to Kill Remake)

A modern Android top-down stealth assassin game remake inspired by the 2005 J2ME classic *Paid to Kill*.

Built with a hybrid **Flutter + Unity as a Library (UaaL)** architecture:
- **Flutter (Dart)**: App lifecycle, main menu, mission briefings, equipment upgrades shop, settings, HUD overlay, and offline persistence.
- **Unity (C#)**: High-performance 2D orthographic stealth runtime, cabinet concealment mechanics, line-of-sight raycasting, guard perception & finite-state machine AI, and auto-aim firearm combat.
- **Native Bridge**: Bidirectional platform channel connecting Flutter Dart events and Unity C# singletons via JSON envelopes.

---

## Architecture & Code Structure

```
Paid-to-Kill-Game/
├── lib/
│   ├── main.dart                          # App entry point, portrait lock, theme setup
│   ├── bridge/
│   │   └── unity_bridge_controller.dart   # Bidirectional Flutter <-> Unity communication controller
│   ├── models/
│   │   ├── bridge_messages.dart           # Typed payloads (StartMission, HudUpdate, MissionResult)
│   │   ├── mission.dart                   # Campaign mission definitions & objectives
│   │   ├── upgrade.dart                   # Tactical skills & equipment upgrade tree
│   │   └── game_settings.dart             # Audio, controls, and accessibility options
│   ├── services/
│   │   ├── storage_service.dart           # Offline SharedPreferences persistence
│   │   └── game_manager.dart              # Progression orchestrator & state manager
│   ├── screens/
│   │   ├── main_menu_screen.dart          # Retro tactical main menu
│   │   ├── mission_select_screen.dart     # Sector map & contract selection
│   │   ├── mission_briefing_screen.dart   # Classified dossier & intel briefing
│   │   ├── game_viewport_screen.dart      # In-game HUD overlay & Unity surface
│   │   ├── mission_result_screen.dart     # Debriefing, stealth rating, rewards
│   │   ├── upgrade_shop_screen.dart       # Tactical gear & perk purchases
│   │   └── settings_screen.dart           # Audio sliders & control options
│   └── theme/
│       └── game_theme.dart                # Retro CRT/tactical phosphor green theme
│
├── unity/
│   └── Assets/
│       └── Scripts/
│           ├── Core/
│           │   ├── GameManager.cs         # Master game clock, alarms & bridge broadcasts
│           │   ├── FlutterBridgeReceiver.cs # C# listener for Flutter commands
│           │   └── UnityMessageDispatcher.cs # C# -> Android JNI -> Flutter dispatcher
│           ├── Player/
│           │   ├── PlayerController.cs    # 4/8-direction movement & contextual actions
│           │   └── PlayerConcealment.cs   # Cabinet hiding & safe-exit validation
│           ├── AI/
│           │   ├── GuardFSM.cs            # Guard Finite-State Machine (Patrol/Chase/Attack)
│           │   └── GuardPerception.cs     # Vision cone & raycast line-of-sight obstruction
│           ├── Interactables/
│           │   ├── CabinetController.cs   # Concealment locker & blocked exit checks
│           │   └── ExtractionZone.cs      # Mission extraction completion trigger
│           └── Combat/
│               └── AutoAimWeapon.cs       # Target acquisition & gunfire noise propagation
│
└── test/
    └── widget_test.dart                   # Automated unit & widget tests (8/8 passing)
```

---

## Running the Project

### 1. Flutter Test Suite
Run the automated test suite covering bridge serialization, upgrade rules, progression, and navigation flows:
```bash
flutter test
```

### 2. Run the Flutter App Shell
Launch on an Android device, macOS desktop, or Chrome:
```bash
flutter run
```
*Note: In desktop/simulator environments without the native Android Unity module, the app automatically switches to built-in simulation mode so all menus, briefings, HUD states, and cabinet interactions can be tested directly.*

---

## Android Unity as a Library (UaaL) Setup

To link the compiled Unity 2D runtime into the Android build:
1. In Unity Editor, open `File > Build Settings`.
2. Switch platform to **Android** and check **Export Project**.
3. Set **Scripting Backend** to **IL2CPP** and Target Architecture to **ARM64**.
4. Click **Export** and copy the resulting `unityLibrary` folder into `android/unityLibrary`.
5. In `android/settings.gradle.kts`, append:
   ```kotlin
   include(":unityLibrary")
   project(":unityLibrary").projectDir = file("unityLibrary")
   ```
6. In `android/app/build.gradle.kts`, add:
   ```kotlin
   dependencies {
       implementation(project(":unityLibrary"))
   }
   ```
7. Build and deploy:
   ```bash
   flutter run -d <android-device-id>
   ```

---

## Gameplay Mechanics Reference (GDD Aligned)

1. **Normalized Movement**: Diagonal movement velocity is normalized to prevent faster travel on diagonals ($v_x = v_y \implies |v| = 1$).
2. **Deterministic Stealth**: Guards cannot see through opaque walls, closed doors, or closed cabinets. Vision cones dynamically cast 2D obstruction rays.
3. **Cabinet Concealment**:
   - Entering conceals the assassin's sprite, disables physics collisions, and closes the cabinet.
   - Ordinary guard vision treats the closed cabinet as an opaque wall.
   - On exit, the game validates that the destination tile is free of obstacles or hostiles before restoring control.
4. **Contextual Touch Controls**: The lower-right action button dynamically changes to *Hide In Cabinet*, *Exit Cabinet*, *Quiet Takedown*, or *Interact* depending on proximity.
