import 'package:bonfire/bonfire.dart';
import 'package:escape_game/characters/player.dart';
import 'package:escape_game/features/level_navigation/bloc/level_navigation_bloc.dart';
import 'package:escape_game/objects/spawn_object.dart';
import 'package:escape_game/objects/spawn_sensor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyLevel extends StatelessWidget {
  MyLevel({
    super.key,
    required this.levelName,
    required this.spawnPoint,
  })  : levelPath = 'levels/level_$levelName.tmj',
        player = MainPlayer(
          spawnPoint.position,
          initDirection: spawnPoint.direction,
        );
  final String levelName;
  final String levelPath;
  final PlayerSpawnObject spawnPoint;
  final MainPlayer player;

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
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
        WorldMapReader.fromAsset(levelPath),
        forceTileSize: Vector2(32, 32),
        objectsBuilder: {
          'spawn': (properties) =>
              SpawnSensor.fromTiledObjectProperties(properties)
                ..handleOnContact = (link) {
                  context.read<LevelNavigationBloc>().add(
                        LoadNextLevel(
                          nextLevelName: link,
                          fromLevelName: levelName,
                          direction: player.lastDirection,
                        ),
                      );
                },
        },
      ),
      player: player,
    );
  }
}
