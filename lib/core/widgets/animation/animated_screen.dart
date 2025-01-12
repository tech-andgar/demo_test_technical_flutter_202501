//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';

class AnimatedAccessabilityWidget extends StatefulWidget {
  const AnimatedAccessabilityWidget({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 1200),
  });

  final Widget child;
  final Duration duration;

  @override
  State<AnimatedAccessabilityWidget> createState() =>
      AnimatedAccessabilityWidgetState();
}

class AnimatedAccessabilityWidgetState
    extends State<AnimatedAccessabilityWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkMotionPreference();
  }

  void _checkMotionPreference() {
    // _reduceMotion = MediaQuery.of(context).disableAnimations;
    final reduceMotion =
        View.of(context).platformDispatcher.accessibilityFeatures.reduceMotion;
    if (!reduceMotion) {
      _animationController
        ..reset()
        ..forward();
    } else {
      // _animationController.stop();
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  AnimationController get controller => _animationController;
}
