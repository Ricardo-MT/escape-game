part of 'level_navigation_bloc.dart';

enum LevelnavigationState { loading, done, error }

class LevelNavigationState extends Equatable {
  const LevelNavigationState(
    this.level,
    this.state,
  );
  final Widget level;
  final LevelnavigationState state;

  LevelNavigationState copyWith({
    Widget? level,
    LevelnavigationState? state,
  }) {
    return LevelNavigationState(
      level ?? this.level,
      state ?? this.state,
    );
  }

  @override
  List<Object> get props => [level, state];
}

final class LevelNavigationInitial extends LevelNavigationState {
  const LevelNavigationInitial()
      : super(
          const SizedBox.shrink(),
          LevelnavigationState.loading,
        );
}
