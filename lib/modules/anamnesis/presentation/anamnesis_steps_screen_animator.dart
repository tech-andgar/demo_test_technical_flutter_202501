import 'package:flutter/widgets.dart';

class AnamnesisStepsScreenAnimator {
  AnamnesisStepsScreenAnimator(this.controller)
      : title = _createAnimation(controller, 0.0, 0.2),
        subtitle = _createAnimation(controller, 0.15, 0.35),
        question1Label = _createAnimation(controller, 0.3, 0.5),
        question1TextField = _createAnimation(controller, 0.45, 0.65),
        question2Label = _createAnimation(controller, 0.6, 0.8),
        question2TextField = _createAnimation(controller, 0.75, 0.95),
        button =
            _createAnimation(controller, 0.85, 1.0, curve: Curves.easeInOut);

  static Animation<double> _createAnimation(
    AnimationController controller,
    double begin,
    double end, {
    Curve curve = Curves.easeOut,
  }) {
    return CurvedAnimation(
      parent: controller,
      curve: Interval(begin, end, curve: curve),
    );
  }

  final Animation<double> title;
  final Animation<double> subtitle;
  final Animation<double> question1Label;
  final Animation<double> question1TextField;
  final Animation<double> question2Label;
  final Animation<double> question2TextField;
  final Animation<double> button;
  final AnimationController controller;
}
