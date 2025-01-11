import 'package:flutter/animation.dart';

extension AnimationControllerExtensions on AnimationController {
  Animation<double> createAnimation(
    double begin,
    double end, {
    Curve curve = Curves.easeOut,
  }) {
    return CurvedAnimation(
      parent: this,
      curve: Interval(begin, end, curve: curve),
    );
  }
}
