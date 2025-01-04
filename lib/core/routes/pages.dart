//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/modules.dart';
import 'routes.dart';

// Global key for navigation and state tracking
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static const initial = RoutesName.anamnesisStep1;

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initial,
    routes: <RouteBase>[
      GoRoute(
        path: RoutesName.anamnesisStep1,
        pageBuilder: (_, GoRouterState state) =>
            buildCustomPage(state, const AnamnesisStep1Screen()),
      ),
      GoRoute(
        path: RoutesName.anamnesisStep2,
        pageBuilder: (_, GoRouterState state) =>
            buildCustomPage(state, const AnamnesisStep2Screen()),
      ),
    ],
  );
}
