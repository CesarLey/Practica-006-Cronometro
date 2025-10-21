import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempoapp/features/timer/application/timer_bloc.dart';

/// The TimerText class is a StatelessWidget in Dart that displays a timer in minutes and seconds
/// format, and allows editing the duration on tap when the timer is in its initial state.
class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(
          2,
          '0',
        );
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        return GestureDetector(
          onTap: state is TimerInitial
              ? () => _showEditDialog(context, duration)
              : null,
          child: Text(
            '$minutesStr:$secondsStr',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        );
      },
    );
  }

  /// Shows a dialog to edit the timer duration.
  Future<void> _showEditDialog(BuildContext context, int currentDuration) async {
    final formKey = GlobalKey<FormState>();
    final textController = TextEditingController(text: currentDuration.toString());
    final result = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final mq = MediaQuery.of(ctx);
        final bottomInset = mq.viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
            child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).dialogTheme.backgroundColor ?? Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Establecer Duración', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        labelText: 'Duración en segundos',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un valor';
                        }
                        final number = int.tryParse(value);
                        if (number == null) {
                          return 'Ingresa un número válido';
                        }
                        if (number <= 0) {
                          return 'La duración debe ser mayor a 0';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text('Cancelar'),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          child: const Text('Guardar'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final newDuration = int.parse(textController.text);
                              Navigator.of(ctx).pop(newDuration);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    if (result != null && context.mounted) {
      context.read<TimerBloc>().add(TimerStarted(duration: result));
    }
  }
}
