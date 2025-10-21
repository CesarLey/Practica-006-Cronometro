import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempoapp/features/timer/application/timer_bloc.dart';

/// The `ActionsButtons` class in Dart is a stateless widget that displays different action buttons
/// based on the state of a `TimerBloc` in a Flutter application.

class ActionsButtons extends StatelessWidget {
  final Future<void> Function()? onReset;
  const ActionsButtons({super.key, this.onReset});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context.read<TimerBloc>().add(
                      TimerStarted(duration: state.duration),
                    ),
                  ),
                ],
              TimerTicking() => [
                  FloatingActionButton(
                    child: const Icon(Icons.pause),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerOnPaused()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.flag),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerLapPressed()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () async {
                      final bloc = context.read<TimerBloc>();
                      if (onReset != null) await onReset!();
                      bloc.add(const TimerReset());
                    },
                  ),
                ],
              TimerPause() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerResumed()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () async {
                      final bloc = context.read<TimerBloc>();
                      if (onReset != null) await onReset!();
                      bloc.add(const TimerReset());
                    },
                  ),
                ],
              TimerFinished() => [
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () async {
                      final bloc = context.read<TimerBloc>();
                      if (onReset != null) await onReset!();
                      bloc.add(const TimerReset());
                    },
                  ),
                ],
            },
          ],
        );
      },
    );
  }
}
