// ignore_for_file: avoid-returning-widgets
//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../view_model/anamnesis_steps_view_model.dart';
import 'anamnesis_steps_screen_animator.dart';

class AnamnesisStep1Screen extends StatelessWidget {
  const AnamnesisStep1Screen({super.key});

  /// Route name: `/anamnesis_step1`.
  static const String routeName = '/anamnesis_step1';

  @override
  Widget build(BuildContext context) {
    return const AnimatedAccessabilityWidget(
      child: AnamnesisStep1Content(),
    );
  }
}

class AnamnesisStep1Content extends ConsumerStatefulWidget {
  const AnamnesisStep1Content({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyWidgetContentState();
}

class _MyWidgetContentState extends ConsumerState<AnamnesisStep1Content> {
  late AnamnesisForm1ViewModel viewModel;
  late AnamnesisStepsScreenAnimator _anamnesisStepsScreenAnimator;

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(anamnesisForm1ViewModel.notifier);
    late final state = ref.watch(anamnesisForm1ViewModel);

    final animatedScreenState =
        context.findAncestorStateOfType<AnimatedAccessabilityWidgetState>()!;
    _anamnesisStepsScreenAnimator =
        AnamnesisStepsScreenAnimator(animatedScreenState.controller);

    // return const MyWidget();
    return AnimatedAccessabilityWidget(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Bienvenido a tu nuevo comienzo')),
          body: CustomTemplatePage(
            content: [
              AnimatedFadeUpVisibility(
                animation: _anamnesisStepsScreenAnimator.title,
                child: const CustomText(
                  'Completa la siguiente información',
                  fontFamily: FontFamily.futuraBook,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              sizedBoxH16,
              AnimatedFadeUpVisibility(
                animation: _anamnesisStepsScreenAnimator.subtitle,
                child: const CustomText(
                  'Todos los campos son obligatorios',
                  isRequired: true,
                ),
              ),
              sizedBoxH16,
              AnimatedFadeUpVisibility(
                animation: _anamnesisStepsScreenAnimator.question1Label,
                child: const CustomText(
                  '¿Ha tenido operaciones? ¿Cuáles y hace cuanto tiempo?',
                  isRequired: true,
                ),
              ),
              sizedBoxH12,
              AnimatedFadeUpVisibility(
                animation: _anamnesisStepsScreenAnimator.question1TextField,
                child: TextField(
                  onChanged: viewModel.updateOperation,
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: const InputDecoration(
                    labelText: 'Escribe aquí',
                  ),
                ),
              ),
              sizedBoxH16,
              AnimatedFadeUpVisibility(
                animation: _anamnesisStepsScreenAnimator.question2Label,
                child: const CustomText(
                  '¿Tiene o tuvo alguna enfermedad diagnosticada o tratada por un médico?',
                  isRequired: true,
                ),
              ),
              sizedBoxH12,
              AnimatedFadeUpVisibility(
                animation: _anamnesisStepsScreenAnimator.question2TextField,
                child: TextField(
                  onChanged: viewModel.updateDisease,
                  onTapOutside: (_) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: const InputDecoration(labelText: 'Escribe aquí'),
                ),
              ),
            ],
            bottomButton: AnimatedFadeUpVisibility(
              animation: _anamnesisStepsScreenAnimator.button,
              child: CustomButton(
                label: 'Siguiente',
                onTap: state.isValid
                    ? () => context.push(RoutesName.anamnesisStep2)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.microtask(() => viewModel.clean());
    super.initState();
  }
}
