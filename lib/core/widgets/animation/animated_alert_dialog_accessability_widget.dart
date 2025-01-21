import 'package:flutter/material.dart';

import 'animated_fade_up_visibility.dart';

class AnimatedAlertDialogAccessabilityWidget extends StatefulWidget {
  const AnimatedAlertDialogAccessabilityWidget({
    required this.child,
    super.key,
    this.duration = const Duration(milliseconds: 1300),
  });

  final Widget child;
  final Duration duration;

  @override
  State<AnimatedAlertDialogAccessabilityWidget> createState() =>
      AnimatedAlertDialogAccessabilityWidgetState();
}

class AnimatedAlertDialogAccessabilityWidgetState
    extends State<AnimatedAlertDialogAccessabilityWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeUpVisibility(
      animation: _animationController,
      slideOffset: 30,
      child: widget.child,
    );
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
    final reduceMotion =
        View.of(context).platformDispatcher.accessibilityFeatures.reduceMotion;
    if (!reduceMotion) {
      _animationController
        ..reset()
        ..forward();
    } else {
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

class AnimatedDialogRoute<T> extends PageRoute<T> {
  AnimatedDialogRoute({
    required this.builder,
    super.settings,
    super.fullscreenDialog = false,
  });

  final WidgetBuilder builder;

  @override
  Color? get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Dismiss';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      builder(context);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Reverse the animation for exit
    return ScaleTransition(
      scale: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0), // Start off-screen below
          end: Offset.zero, // End at the original position
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut, // Use a different curve for exit
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: child,
      ),
    );
  }
}
