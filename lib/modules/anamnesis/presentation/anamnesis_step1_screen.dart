//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../view_model/anamnesis_steps_view_model.dart';

class AnamnesisStep1Screen extends ConsumerWidget {
  const AnamnesisStep1Screen({super.key});

  /// Route name: `/anamnesis_step1`.
  static const String routeName = '/anamnesis_step1';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(anamnesisForm1ViewModel.notifier);
    final state = ref.watch(anamnesisForm1ViewModel);

    const sizedBox16 = SizedBox(height: 16);
    const sizedBox12 = SizedBox(height: 12);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Bienvenido a tu nuevo comienzo')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              const CustomText(
                'Completa la siguiente información',
                fontFamily: FontFamily.futuraBook,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              sizedBox16,
              const CustomText(
                'Todos los campos son obligatorios',
                isRequired: true,
              ),
              sizedBox16,
              const CustomText(
                '¿Ha tenido operaciones? ¿Cuáles y hace cuanto tiempo?',
                isRequired: true,
              ),
              sizedBox12,
              TextField(
                onChanged: viewModel.updateOperacion,
                decoration: const InputDecoration(
                  labelText: 'Escribe aquí',
                ),
              ),
              sizedBox16,
              const CustomText(
                '¿Tiene o tuvo alguna enfermedad diagnosticada o tratada por un médico?',
                isRequired: true,
              ),
              sizedBox12,
              TextField(
                onChanged: viewModel.updateEnfermedad,
                decoration: const InputDecoration(labelText: 'Escribe aquí'),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
        floatingActionButton: CustomButton(
          label: 'Siguiente',
          onTap: state.isValid
              ? () => context.push(RoutesName.anamnesisStep2)
              : null,
        ),
      ),
    );
  }
}
