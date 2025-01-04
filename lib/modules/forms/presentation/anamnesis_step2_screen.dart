//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/widgets.dart';
import '../view_model/anamnesis_steps_view_model.dart';

class AnamnesisStepScreen extends ConsumerWidget {
  const AnamnesisStepScreen({super.key});

  /// Route name: `/anamnesis_step2`.
  static const String routeName = '/anamnesis_step2';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(form2ViewModel.notifier);
    final state = ref.watch(form2ViewModel);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Bienvenido a tu nuevo comienzo')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Completa la siguiente información',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const CustomTextRequired(
                'Todos los campos son obligatorios',
                isRequired: true,
              ),
              const CustomTextRequired(
                'Tiene dolores frecuentes y no ha consultado al médico?',
                isRequired: true,
              ),
              CustomToggleButton(
                options: const ['Sí', 'No'],
                onSelectionChanged: viewModel.setDoloresFrecuentes,
              ),
              const CustomTextRequired(
                '¿Le ha dicho al médico que tiene algún problema en los huesos o en las articulaciones, que pueda desfavorecer con el ejercicio?',
                isRequired: true,
              ),
              CustomToggleButton(
                options: const ['Sí', 'No'],
                onSelectionChanged: viewModel.setProblemaHuesosArticulaciones,
              ),
              const Spacer(),
              CustomButton(
                label: 'Siguiente',
                onTap: state.isValid ? () => context.push('/form1') : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
