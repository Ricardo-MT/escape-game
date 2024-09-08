import 'package:bonfire/bonfire.dart';
import 'package:bonfire/map/tiled/reader/tiled_asset_reader.dart';
import 'package:escape_game/characters/player.dart';
import 'package:flutter/material.dart';

class Level01 extends StatelessWidget {
  const Level01({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Vector2>(
      future: () async {
        try {
          final level = TiledAssetReader(asset: 'levels/level_01.tmj');
          final layers = (await level.readMap()).layers;
          final spawnLayer = layers?.firstWhere(
            (element) => element.name == 'spawn',
          );
          final spawnPoints =
              (spawnLayer?.toJson())!['objects'] as List<Map<String, dynamic>>;
          final spawnPoint = spawnPoints.first;
          return Vector2(spawnPoint['x'], spawnPoint['y']);
        } catch (e) {
          print('Error on load map: $e');
        }
        return Vector2(32 * 14, 32 * 4);
      }(),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: snapshot.connectionState == ConnectionState.done
              ? BonfireWidget(
                  backgroundColor: const Color(0xFF211F30),
                  cameraConfig: CameraConfig(
                    moveOnlyMapArea: true,
                  ),
                  playerControllers: [
                    Joystick(
                      directional: JoystickDirectional(),
                    ),
                  ],
                  map: WorldMapByTiled(
                    WorldMapReader.fromAsset('levels/level_01.tmj'),
                    forceTileSize: Vector2(32, 32),
                  ),
                  player: MainPlayer(snapshot.data!),
                )
              : const Directionality(
                  textDirection: TextDirection.ltr,
                  child: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
