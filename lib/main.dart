import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'services/storage_service.dart';
import 'services/game_manager.dart';
import 'services/original_asset_loader.dart';
import 'bridge/unity_bridge_controller.dart';
import 'theme/game_theme.dart';
import 'screens/main_menu_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enforce portrait-first orientation for classic retro phone framing (GDD Section 2)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set immersive dark UI overlay styles
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: GameTheme.background,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Initialize offline storage & services
  final storageService = StorageService();
  await storageService.init();

  // Load authentic reverse-engineered J2ME assets (sprites, strings, level 0)
  await OriginalAssetLoader.instance.load();

  final bridgeController = UnityBridgeController();

  final gameManager = GameManager(
    storageService: storageService,
    bridge: bridgeController,
  );
  await gameManager.init();

  runApp(ShadowContractApp(gameManager: gameManager));
}

class ShadowContractApp extends StatelessWidget {
  final GameManager gameManager;

  const ShadowContractApp({super.key, required this.gameManager});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shadow Contract',
      debugShowCheckedModeBanner: false,
      theme: GameTheme.theme,
      home: MainMenuScreen(gameManager: gameManager),
    );
  }
}
