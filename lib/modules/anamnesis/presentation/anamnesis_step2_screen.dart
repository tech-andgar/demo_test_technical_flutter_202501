//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../view_model/anamnesis_steps_view_model.dart';
import 'anamnesis_steps_screen_animator.dart';

class AnamnesisStep2Screen extends StatelessWidget {
  const AnamnesisStep2Screen({super.key});

  /// Route name: `/anamnesis_step2`.
  static const String routeName = '/anamnesis_step2';

  @override
  Widget build(BuildContext context) {
    return const AnimatedAccessabilityWidget(
      child: AnamnesisStep2Content(),
    );
  }
}

class AnamnesisStep2Content extends ConsumerWidget {
  const AnamnesisStep2Content({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(anamnesisForm2ViewModel.notifier);
    final state = ref.watch(anamnesisForm2ViewModel);

    final animatedAccessabilityWidgetState =
        context.findAncestorStateOfType<AnimatedAccessabilityWidgetState>()!;
    final anamnesisStepsScreenAnimator = AnamnesisStepsScreenAnimator(
      animatedAccessabilityWidgetState.controller,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Bienvenido a tu nuevo comienzo')),
        body: CustomTemplatePage(
          content: [
            AnimatedFadeUpVisibility(
              animation: anamnesisStepsScreenAnimator.title,
              child: const CustomText(
                'Completa la siguiente información',
                fontFamily: FontFamily.futuraBook,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            sizedBoxH16,
            AnimatedFadeUpVisibility(
              animation: anamnesisStepsScreenAnimator.subtitle,
              child: const CustomText(
                'Todos los campos son obligatorios',
                isRequired: true,
              ),
            ),
            sizedBoxH16,
            AnimatedFadeUpVisibility(
              animation: anamnesisStepsScreenAnimator.question1Label,
              child: const CustomText(
                'Tiene dolores frecuentes y no ha consultado al médico?',
                isRequired: true,
              ),
            ),
            sizedBoxH12,
            AnimatedFadeUpVisibility(
              animation: anamnesisStepsScreenAnimator.question1TextField,
              child: CustomToggleButton(
                options: const ['Sí', 'No'],
                onSelectionChanged: viewModel.setFrequentPain,
              ),
            ),
            sizedBoxH16,
            AnimatedFadeUpVisibility(
              animation: anamnesisStepsScreenAnimator.question2Label,
              child: const CustomText(
                '¿Le ha dicho al médico que tiene algún problema en los huesos o en las articulaciones, que pueda desfavorecer con el ejercicio?',
                isRequired: true,
              ),
            ),
            sizedBoxH12,
            AnimatedFadeUpVisibility(
              animation: anamnesisStepsScreenAnimator.question2TextField,
              child: CustomToggleButton(
                options: const ['Sí', 'No'],
                onSelectionChanged: viewModel.setProblemBonesJoints,
              ),
            ),
            const SizedBox(height: 80),
          ],
          bottomButton: AnimatedFadeUpVisibility(
            animation: anamnesisStepsScreenAnimator.button,
            child: CustomButton(
              label: 'Siguiente',
              onTap: state.isValid ? () => openDialog(context) : null,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openDialog(BuildContext context) async {
    final router = GoRouter.of(context);

    await Navigator.of(context).push(
      AnimatedDialogRoute<void>(
        builder: (BuildContext context) {
          return Consumer(
            builder: (context, ref, _) {
              final anamnesisForm1Data = ref.watch(anamnesisForm1ViewModel);
              final anamnesisForm2Data = ref.watch(anamnesisForm2ViewModel);

              return AnimatedAlertDialogAccessabilityWidget(
                duration: const Duration(milliseconds: 300),
                child: AlertDialog(
                  backgroundColor: Colors.black87,
                  title: const CustomText(
                    'Cuestionario finalizado',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  content: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 21,
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              const CustomText(
                                '¡Gracias por completar el cuestionario!',
                              ),
                              const SizedBox(height: 16),
                              const CustomText(
                                'Resumen de respuestas:',
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(height: 8),
                              ListTile(
                                title: const CustomText(
                                  '- ¿Ha tenido operaciones? ¿Cuáles y hace cuanto tiempo?',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                                subtitle: CustomText(
                                  anamnesisForm1Data.operation,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListTile(
                                title: const CustomText(
                                  '- ¿Tiene o tuvo alguna enfermedad diagnosticada o tratada por un médico?',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                                subtitle: CustomText(
                                  anamnesisForm1Data.disease,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListTile(
                                title: const CustomText(
                                  '- ¿Tiene dolores frecuentes y no ha consultado al médico?',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                                subtitle: CustomText(
                                  anamnesisForm2Data.painFrequent ?? false
                                      ? 'Si, tiene dolores frecuentes'
                                      : 'Sin dolores frecuentes',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListTile(
                                title: const CustomText(
                                  '- ¿Le ha dicho al médico que tiene algún problema en los huesos o en las articulaciones, que pueda desfavorecer con el ejercicio?',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                                subtitle: CustomText(
                                  anamnesisForm2Data.problemBonesJoints ?? false
                                      ? 'Problema en huesos o articulaciones'
                                      : 'Sin problemas en huesos o articulaciones',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const DevelopByText(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Semantics(
                                    label: 'Hecho por Flutter',
                                    child: const ExcludeSemantics(
                                      child: Row(
                                        children: [
                                          Text('Hecho por '),
                                          FlutterLogo(size: 24),
                                          Text(' Flutter'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    CustomButton(
                      label: 'Ir a la pantalla de inicio',
                      onTap: () {
                        Navigator.of(context).pop();
                        router.pushReplacement(RoutesName.anamnesisStep1);
                      },
                      inDialog: true,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
