//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Track the previous location
String? previousLocation;

class CustomTransitionPages<T> extends CustomTransitionPage<T> {
  CustomTransitionPages({
    required super.child,
    required super.key,
    required bool isForward,
  }) : super(
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            // Define the slide transition based on the direction
            final offsetAnimation = Tween<Offset>(
              begin: isForward ? const Offset(-1, 0) : const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}

bool isForwardNavigation(String currentLocation, String previousLocation) =>
    currentLocation.length > previousLocation.length;

Page<Object?> buildCustomPage(GoRouterState state, Widget child) {
  final isForward =
      isForwardNavigation(state.matchedLocation, previousLocation ?? '');

  // Store the last location for future use
  previousLocation = state.matchedLocation;

  // Update the previous route for next comparison
  return CustomTransitionPages(
    key: state.pageKey,
    child: child,
    isForward: isForward,
  );
}
