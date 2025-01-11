import 'package:flutter/widgets.dart';

import '../../../core/extensions/extensions.dart';

class AnamnesisStepsScreenAnimator {
  AnamnesisStepsScreenAnimator(this.controller)
      : title = controller.createAnimation(0.0, 0.2),
        subtitle = controller.createAnimation(0.15, 0.35),
        question1Label = controller.createAnimation(0.3, 0.5),
        question1TextField = controller.createAnimation(0.45, 0.65),
        question2Label = controller.createAnimation(0.6, 0.8),
        question2TextField = controller.createAnimation(0.75, 0.95),
        button = controller.createAnimation(0.85, 1.0, curve: Curves.easeInOut);

  final Animation<double> title;
  final Animation<double> subtitle;
  final Animation<double> question1Label;
  final Animation<double> question1TextField;
  final Animation<double> question2Label;
  final Animation<double> question2TextField;
  final Animation<double> button;
  final AnimationController controller;
}
