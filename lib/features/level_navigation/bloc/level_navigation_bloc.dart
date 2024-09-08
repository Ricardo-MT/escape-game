import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bonfire/bonfire.dart';
import 'package:bonfire/map/tiled/reader/tiled_asset_reader.dart';
import 'package:equatable/equatable.dart';
import 'package:escape_game/levels/level.dart';
import 'package:escape_game/objects/spawn_object.dart';
import 'package:flutter/material.dart';

part 'level_navigation_event.dart';
part 'level_navigation_state.dart';

class LevelNavigationBloc
    extends Bloc<LevelNavigationEvent, LevelNavigationState> {
  LevelNavigationBloc() : super(const LevelNavigationInitial()) {
    on<LoadNextLevel>(_handleNextLevel);
    on<LevelFinishedLoading>(_handleLevelFinishedLoading);
    add(const LoadNextLevel(nextLevelName: '01', fromLevelName: '00'));
  }

  FutureOr<void> _handleNextLevel(
    LoadNextLevel event,
    Emitter<LevelNavigationState> emit,
  ) async {
    emit(state.copyWith(state: LevelnavigationState.loading));
    String levelPath = 'levels/level_${event.nextLevelName}.tmj';
    final level = TiledAssetReader(asset: levelPath);
    final layers = (await level.readMap()).layers;
    final spawnLayer = layers?.firstWhere(
      (element) => element.name == 'spawn',
    );
    final spawnPoints =
        ((spawnLayer?.toJson())!['objects'] as List<Map<String, dynamic>>)
            .map((json) => PlayerSpawnObject.fromTileLayerPoint(
                  json,
                  event.direction,
                ))
            .toList();
    final spawnPoint = spawnPoints.firstWhere(
      (element) =>
          element.linkToLevel == event.fromLevelName && element.isForAppearing,
    );

    await Future.delayed(
      const Duration(seconds: 0),
      () {
        emit(
          state.copyWith(
            level: MyLevel(
              levelName: event.nextLevelName,
              spawnPoint: spawnPoint,
            ),
            state: LevelnavigationState.done,
          ),
        );
      },
    );
  }

  FutureOr<void> _handleLevelFinishedLoading(
    LevelFinishedLoading event,
    Emitter<LevelNavigationState> emit,
  ) {
    emit(
      state.copyWith(state: LevelnavigationState.done),
    );
  }
}
