//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';

class AnimatedFadeUpVisibility extends StatelessWidget {
  const AnimatedFadeUpVisibility({
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

    // return reduceMotion
    //     ? child
    //     : FadeTransition(
    //         opacity: animation,
    //         child: SlideTransition(
    //           position: Tween<Offset>(
    //             begin: const Offset(0, 0.2),
    //             end: Offset.zero,
    //           ).animate(animation),
    //           child: child,
    //         ),
    //       );

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
