//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../view_model/anamnesis_steps_view_model.dart';

class AnamnesisStep2Screen extends ConsumerWidget {
  const AnamnesisStep2Screen({super.key});

  /// Route name: `/anamnesis_step2`.
  static const String routeName = '/anamnesis_step2';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(anamnesisForm2ViewModel.notifier);
    final state = ref.watch(anamnesisForm2ViewModel);

    const sizedBox16 = SizedBox(height: 16);
    const sizedBox12 = SizedBox(height: 12);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Bienvenido a tu nuevo comienzo')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                'Tiene dolores frecuentes y no ha consultado al médico?',
                isRequired: true,
              ),
              sizedBox12,
              CustomToggleButton(
                options: const ['Sí', 'No'],
                onSelectionChanged: viewModel.setDoloresFrecuentes,
              ),
              sizedBox16,
              const CustomText(
                '¿Le ha dicho al médico que tiene algún problema en los huesos o en las articulaciones, que pueda desfavorecer con el ejercicio?',
                isRequired: true,
              ),
              sizedBox12,
              CustomToggleButton(
                options: const ['Sí', 'No'],
                onSelectionChanged: viewModel.setProblemaHuesosArticulaciones,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
        floatingActionButton: CustomButton(
          label: 'Siguiente',
          onTap: state.isValid ? () => openDialog(context) : null,
        ),
      ),
    );
  }

  Future<void> openDialog(BuildContext context) async {
    final router = GoRouter.of(context);

    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: const CustomText('Cuestionario finalizado', fontSize: 20),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Desarrollado por Andres Garcia (TECH-ANDGAR)'),
                Text('Hecho por Flutter'),
              ],
            ),
          ),
          actions: <Widget>[
            CustomButton(
              label: 'Ir a la pantalla de inicio',
              onTap: () {
                Navigator.of(dialogContext).pop();
                router.pushReplacement(RoutesName.anamnesisStep1);
              },
            ),
          ],
        );
      },
    );
  }
}
