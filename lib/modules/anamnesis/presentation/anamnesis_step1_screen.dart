// ignore_for_file: avoid-returning-widgets
//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/core.dart';
import '../view_model/anamnesis_steps_view_model.dart';
import 'anamnesis_steps_screen_animator.dart';

class AnamnesisStep1Screen extends ConsumerStatefulWidget {
  const AnamnesisStep1Screen({super.key});

  /// Route name: `/anamnesis_step1`.
  static const String routeName = '/anamnesis_step1';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnamnesisStep1ScreenState();
}

class _AnamnesisStep1ScreenState extends ConsumerState<AnamnesisStep1Screen>
    with SingleTickerProviderStateMixin {
  late AnamnesisForm1ViewModel viewModel;
  late AnamnesisStepsScreenAnimator _anamnesisStepsScreenAnimator;
  late AnimationController _animationController;
  var _reduceMotion = false;

  @override
  Widget build(BuildContext context) {
    viewModel = ref.watch(anamnesisForm1ViewModel.notifier);
    late final state = ref.watch(anamnesisForm1ViewModel);

    const sizedBox16 = SizedBox(height: 16);
    const sizedBox12 = SizedBox(height: 12);

    // return const MyWidget();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Bienvenido a tu nuevo comienzo')),
        body: CustomTemplatePage(
          content: [
            AnimatedVisibility(
              animation: _anamnesisStepsScreenAnimator.title,
              child: const CustomText(
                'Completa la siguiente información',
                fontFamily: FontFamily.futuraBook,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            sizedBox16,
            AnimatedVisibility(
              animation: _anamnesisStepsScreenAnimator.subtitle,
              child: const CustomText(
                'Todos los campos son obligatorios',
                isRequired: true,
              ),
            ),
            sizedBox16,
            AnimatedVisibility(
              animation: _anamnesisStepsScreenAnimator.question1Label,
              child: const CustomText(
                '¿Ha tenido operaciones? ¿Cuáles y hace cuanto tiempo?',
                isRequired: true,
              ),
            ),
            sizedBox12,
            AnimatedVisibility(
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
            sizedBox16,
            AnimatedVisibility(
              animation: _anamnesisStepsScreenAnimator.question2Label,
              child: const CustomText(
                '¿Tiene o tuvo alguna enfermedad diagnosticada o tratada por un médico?',
                isRequired: true,
              ),
            ),
            sizedBox12,
            AnimatedVisibility(
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
          bottomButton: AnimatedVisibility(
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
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _anamnesisStepsScreenAnimator =
        AnamnesisStepsScreenAnimator(_animationController);
    _animationController.forward();

    Future.microtask(() => viewModel.clean());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = MediaQuery.of(context).disableAnimations;
    if (!_reduceMotion) {
      _animationController.forward();
    } else {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class AnimatedVisibility extends StatelessWidget {
  const AnimatedVisibility({
    required this.animation,
    required this.child,
    super.key,
    this.slideOffset = 50.0,
  });

  final Animation<double> animation;
  final Widget child;
  final double slideOffset;

  @override
  Widget build(BuildContext context) {
    // final reduceMotion = MediaQuery.of(context).disableAnimations;
    final reduceMotion =
        View.of(context).platformDispatcher.accessibilityFeatures.reduceMotion;

    return reduceMotion
        ? child
        : AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Opacity(
                opacity: animation.value.clamp(0, 1),
                child: Transform.translate(
                  offset: Offset(0, slideOffset * (1 - animation.value)),
                  child: child,
                ),
              );
            },
            child: child,
          );
  }
}
