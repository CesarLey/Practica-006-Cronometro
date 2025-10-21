import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempoapp/features/timer/application/timer_bloc.dart';
import 'package:tiempoapp/features/timer/presentation/widgets/actions_buttons.dart';
import 'package:tiempoapp/features/timer/presentation/widgets/background.dart';
import 'package:tiempoapp/features/timer/presentation/widgets/timer_text.dart';

/// The TimerView class in Dart defines a widget for displaying a timer with associated actions in a
/// responsive layout.

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimerBloc, TimerState>(
      listener: (context, state) async {
        if (state is TimerFinished) {
          await _player.stop();
          await _player.play(AssetSource('audio/timer_end.mp3'));
        } else {
          await _player.stop();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Timer')),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isPortrait = constraints.maxHeight > constraints.maxWidth;
            final verticalPadding = isPortrait
                ? constraints.maxHeight * 0.1
                : constraints.maxHeight * 0.05;
            return Stack(
              fit: StackFit.expand,
              children: [
                const IgnorePointer(child: Background()),
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: verticalPadding),
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: BlocBuilder<TimerBloc, TimerState>(
                                buildWhen: (previous, current) =>
                                    previous.duration != current.duration,
                                builder: (context, state) {
                                  final double progress =
                                      (state.duration > 0 && state.initialDuration > 0)
                                          ? state.duration / state.initialDuration
                                          : 0.0;
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: CircularProgressIndicator(
                                          value: progress,
                                          strokeWidth: 15,
                                          backgroundColor: Colors.grey.shade300,
                                          valueColor: const AlwaysStoppedAnimation<Color>(
                                            Color.fromRGBO(72, 74, 126, 1),
                                          ),
                                        ),
                                      ),
                                      const TimerText(),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ActionsButtons(
                          onReset: () async {
                            await _player.stop();
                          },
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: BlocBuilder<TimerBloc, TimerState>(
                          buildWhen: (previous, current) => previous.laps != current.laps,
                          builder: (context, state) {
                            if (state.laps.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              itemCount: state.laps.length,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final lap = state.laps[index];
                                final minutesStr =
                                    ((lap / 60) % 60).floor().toString().padLeft(2, '0');
                                final secondsStr =
                                    (lap % 60).floor().toString().padLeft(2, '0');
                                return ListTile(
                                  title: Text('Lap ${index + 1}'),
                                  trailing: Text('$minutesStr:$secondsStr'),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

