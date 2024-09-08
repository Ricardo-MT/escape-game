part of 'level_navigation_bloc.dart';

sealed class LevelNavigationEvent extends Equatable {
  const LevelNavigationEvent();

  @override
  List<Object> get props => [];
}

final class LoadNextLevel extends LevelNavigationEvent {
  const LoadNextLevel({
    required this.nextLevelName,
    required this.fromLevelName,
    this.direction,
  });
  final String nextLevelName;
  final String fromLevelName;
  final Direction? direction;
}

final class LevelFinishedLoading extends LevelNavigationEvent {
  const LevelFinishedLoading();
}
