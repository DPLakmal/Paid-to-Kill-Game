import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class SpriteDef {
  final int id;
  final String image;
  final int imageIdx;
  final int srcX;
  final int srcY;
  final int width;
  final int height;
  final int anchorX;
  final int anchorY;

  SpriteDef({
    required this.id,
    required this.image,
    required this.imageIdx,
    required this.srcX,
    required this.srcY,
    required this.width,
    required this.height,
    required this.anchorX,
    required this.anchorY,
  });

  factory SpriteDef.fromJson(Map<String, dynamic> json) {
    return SpriteDef(
      id: json['id'] as int,
      image: json['image'] as String,
      imageIdx: json['imageIdx'] as int,
      srcX: json['srcX'] as int,
      srcY: json['srcY'] as int,
      width: json['width'] as int,
      height: json['height'] as int,
      anchorX: json['anchorX'] as int,
      anchorY: json['anchorY'] as int,
    );
  }
}

class LevelData {
  final int levelIndex;
  final String name;
  final String subtitle;
  final int width;
  final int height;
  final int tileSize;
  final int compositeBase;
  final List<int> tiles;
  final List<Map<String, dynamic>> entities;

  LevelData({
    required this.levelIndex,
    required this.name,
    required this.subtitle,
    required this.width,
    required this.height,
    required this.tileSize,
    required this.compositeBase,
    required this.tiles,
    required this.entities,
  });

  factory LevelData.fromJson(Map<String, dynamic> json) {
    return LevelData(
      levelIndex: json['levelIndex'] as int,
      name: json['name'] as String,
      subtitle: json['subtitle'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      tileSize: json['tileSize'] as int,
      compositeBase: json['compositeBase'] as int,
      tiles: (json['tiles'] as List<dynamic>).cast<int>(),
      entities: (json['entities'] as List<dynamic>).cast<Map<String, dynamic>>(),
    );
  }
}

/// Reverse-engineered asset manager loading authentic Rovio Paid to Kill spritesheets and levels.
class OriginalAssetLoader {
  static final OriginalAssetLoader instance = OriginalAssetLoader._internal();
  OriginalAssetLoader._internal();

  final Map<int, SpriteDef> _sprites = {};
  final Map<String, ui.Image> _images = {};
  List<String> _stringsEn = [];
  LevelData? _level0;
  bool isLoaded = false;

  Map<int, SpriteDef> get sprites => _sprites;
  Map<String, ui.Image> get images => _images;
  List<String> get strings => _stringsEn;
  LevelData? get level0 => _level0;

  Future<void> load() async {
    if (isLoaded) return;

    // 1. Load sprite coordinate definitions
    final spritesRaw = await rootBundle.loadString('assets/data/sprites.json');
    final Map<String, dynamic> spritesMap = jsonDecode(spritesRaw);
    spritesMap.forEach((key, val) {
      final s = SpriteDef.fromJson(val as Map<String, dynamic>);
      _sprites[s.id] = s;
    });

    // 2. Load strings
    final stringsRaw = await rootBundle.loadString('assets/data/strings_en.json');
    _stringsEn = (jsonDecode(stringsRaw) as List<dynamic>).cast<String>();

    // 3. Load level 0
    final levelRaw = await rootBundle.loadString('assets/data/level_0.json');
    _level0 = LevelData.fromJson(jsonDecode(levelRaw) as Map<String, dynamic>);

    // 4. Decode PNG textures
    final pngFiles = [
      'aa.png', 'ab.png', 'ac.png', 'ad.png', 'ae.png', 'af.png', 'ag.png', 'ah.png', 'icon.png'
    ];
    for (final filename in pngFiles) {
      final data = await rootBundle.load('assets/images/$filename');
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      _images[filename] = frame.image;
    }

    try {
      final roomData = await rootBundle.load('assets/images/room_cutaway_interior.jpg');
      final roomCodec = await ui.instantiateImageCodec(roomData.buffer.asUint8List());
      final roomFrame = await roomCodec.getNextFrame();
      _images['room_cutaway_interior.jpg'] = roomFrame.image;
    } catch (e) {
      // Graceful fallback if in environment without image bundle
    }

    isLoaded = true;
  }

  /// Exact 1:1 implementation of J2ME b.a(x, y, spriteId, graphics)
  void drawSprite(ui.Canvas canvas, int spriteId, double x, double y, {ui.Paint? customPaint}) {
    final sprite = _sprites[spriteId];
    if (sprite == null) return;

    final img = _images[sprite.image];
    if (img == null) return;

    final srcRect = ui.Rect.fromLTWH(
      sprite.srcX.toDouble(),
      sprite.srcY.toDouble(),
      sprite.width.toDouble(),
      sprite.height.toDouble(),
    );

    // Apply exact J2ME anchor offset: n2 - sArray[4], n3 - sArray[5]
    final destRect = ui.Rect.fromLTWH(
      x - sprite.anchorX,
      y - sprite.anchorY,
      sprite.width.toDouble(),
      sprite.height.toDouble(),
    );

    final paint = customPaint ?? (ui.Paint()..filterQuality = ui.FilterQuality.none); // Nearest neighbor pixel art
    canvas.drawImageRect(img, srcRect, destRect, paint);
  }
}
