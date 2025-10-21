import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempoapp/features/timer/application/timer_bloc.dart';
import 'package:tiempoapp/features/timer/data/repositories/timer_repository_impl.dart';
import 'package:tiempoapp/features/timer/domain/entities/ticker.dart';
import 'package:tiempoapp/features/timer/presentation/widgets/timer_view.dart';

/// The TimerScreen class is a StatelessWidget that provides a TimerBloc to its child TimerView.
class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(timerRepository: TimerRepositoryImpl(Ticker())),
      child: const TimerView(),
    );
  }
}
