//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../view_model/form_view_model.dart';

class AnamnesisStep1Screen extends ConsumerWidget {
  const AnamnesisStep1Screen({super.key});

  /// Route name: `/anamnesis_step1`.
  static const String routeName = '/anamnesis_step1';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(form1ViewModel.notifier);
    final state = ref.watch(form1ViewModel);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Bienvenido a tu nuevo comienzo')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Completa la siguiente información',
                style: TextStyle(
                  fontFamily: FontFamily.futuraBook.value,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const CustomTextRequired(
                'Todos los campos son obligatorios',
                isRequired: true,
              ),
              const CustomTextRequired(
                '¿Ha tenido operaciones? ¿Cuáles y hace cuanto tiempo?',
                isRequired: true,
              ),
              TextField(
                onChanged: viewModel.updateOperacion,
                decoration: const InputDecoration(
                  labelText: 'Escribe aquí',
                ),
              ),
              const CustomTextRequired(
                '¿Tiene o tuvo alguna enfermedad diagnosticada o tratada por un médico?',
                isRequired: true,
              ),
              TextField(
                onChanged: viewModel.updateEnfermedad,
                decoration: const InputDecoration(labelText: 'Escribe aquí'),
              ),
              const Spacer(),
              CustomButton(
                label: 'Siguiente',
                onTap: state.isValid
                    ? () => context.push(RoutesName.anamnesisStep2)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
