import 'package:escape_game/features/level_navigation/bloc/level_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EscapeGameWidget extends StatelessWidget {
  const EscapeGameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Game();
  }
}

class _Game extends StatelessWidget {
  const _Game({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LevelNavigationBloc(),
      child: const GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelNavigationBloc, LevelNavigationState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          child: state.state == LevelnavigationState.loading
              ? const Directionality(
                  textDirection: TextDirection.ltr,
                  child: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : state.level,
        );
      },
    );
  }
}
