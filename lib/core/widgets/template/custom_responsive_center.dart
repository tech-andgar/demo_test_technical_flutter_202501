// ignore_for_file: format-comment
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const factorHorizontal = .95;

/// A responsive centered scrollable layout that solves the problem described
/// here: https://rydmike.com/blog_layout_and_theming
/// Note that if a non-null ScrollController is given, it must be passed as
/// a controller to the child widget otherwise you will get this error:
/// "ScrollController not attached to any scroll views.".
///
/// Example usage:
///
/// ```dart
/// final controller = ScrollController();
/// return ResponsiveCenterScrollable(
///   controller: controller,
///   child: ListView.builder(
///     controller: controller,
///     ...
///   ),
/// )
/// ```
///
/// Here's a GPT-4 chat explaining how the code was obtained:
/// https://cloud.typingmind.com/share/cb35afba-1141-4db7-9201-e2fea9a92b16
class ResponsiveCenterScrollable extends StatelessWidget {
  const ResponsiveCenterScrollable({
    required this.child,
    super.key,
    this.maxContentWidth,
    this.padding = EdgeInsets.zero,
    this.controller,
  });

  final Widget child;
  final ScrollController? controller;
  final double? maxContentWidth;
  final EdgeInsetsGeometry padding;

  void _onPointerSignal(PointerSignalEvent pointerSignal) {
    final c = controller;
    if (pointerSignal is PointerScrollEvent && c != null) {
      final newOffset = c.offset + pointerSignal.scrollDelta.dy;
      if (newOffset < c.position.minScrollExtent) {
        c.jumpTo(c.position.minScrollExtent);
      } else if (newOffset > c.position.maxScrollExtent) {
        c.jumpTo(c.position.maxScrollExtent);
      } else {
        c.jumpTo(newOffset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: _onPointerSignal,
      child: Scrollbar(
        controller: controller,
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final responsiveWidth = (constraints.maxWidth > 1080)
                  ? constraints.maxWidth * .5
                  : constraints.maxWidth * factorHorizontal;

              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxContentWidth ?? responsiveWidth,
                ),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: Padding(
                    padding: padding,
                    child: child,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A simpler variant of ResponsiveCenterScrollable for non-scrollable layouts.
/// Shows a child with a maximum content width constraint.
/// If available width is larger than the maximum width, the child will be
/// centered.
/// If available width is smaller than the maximum width, the child use all the
/// available width.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    required this.child,
    super.key,
    this.maxContentWidth,
    this.padding = EdgeInsets.zero,
  });

  final Widget child;
  final double? maxContentWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    // Use Center as layout has unconstrained width (loose constraints),
    // together with SizedBox to specify the max width (tight constraints)
    // Also add a Scrollbar outside the Center widget and disable the inner one
    // See this article for more info:
    // https://rydmike.com/blog_layout_and_theming
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final responsiveWidth = (constraints.maxWidth > 1080)
              ? constraints.maxWidth * 0.5
              : constraints.maxWidth * factorHorizontal;

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxContentWidth ?? responsiveWidth,
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
