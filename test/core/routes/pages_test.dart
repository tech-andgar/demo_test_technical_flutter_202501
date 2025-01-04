import 'package:demo_test_technical_flutter_202501/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('AppRoutes', () {
    late GoRouter router;

    setUp(() {
      router = AppRoutes.router;
    });

    test('initial route is set correctly', () {
      expect(AppRoutes.initial, equals(RoutesName.anamnesisStep1));
    });

    test('router is configured correctly', () {
      expect(router.configuration.navigatorKey, equals(rootNavigatorKey));
    });

    test('routes are configured correctly', () {
      final routes = router.configuration.routes;

      expect(routes.length, equals(2));

      // Test first route (anamnesisStep1)
      final route1 = routes[0] as GoRoute;
      expect(route1.path, equals(RoutesName.anamnesisStep1));
      expect(route1.pageBuilder, isNotNull);

      // Test second route (anamnesisStep2)
      final route2 = routes[1] as GoRoute;
      expect(route2.path, equals(RoutesName.anamnesisStep2));
      expect(route2.pageBuilder, isNotNull);
    });

    testWidgets(
      'pageBuilder creates CustomTransitionPages',
      (WidgetTester tester) async {
        // Create a widget to get BuildContext
        await tester.pumpWidget(
          ProviderScope(
            child: ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp.router(
                  routerConfig: router,
                );
              },
            ),
          ),
        );

        // Get BuildContext from the widget tree
        final context = tester.element(find.byType(MaterialApp));

        final state = GoRouterState(
          router.configuration,
          uri: Uri.parse(RoutesName.anamnesisStep1),
          matchedLocation: RoutesName.anamnesisStep1,
          path: RoutesName.anamnesisStep1,
          fullPath: RoutesName.anamnesisStep1,
          name: null,
          pageKey: const ValueKey('test'),
          extra: null,
          pathParameters: const <String, String>{},
        );

        final route1 = router.configuration.routes[0] as GoRoute;
        final page = route1.pageBuilder!(context, state);

        expect(page, isA<CustomTransitionPages<Object?>>());
      },
    );
    testWidgets(
      'navigation between routes works correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp.router(
                  routerConfig: router,
                );
              },
            ),
          ),
        );

        expect(
          router.routeInformationProvider.value.uri.path,
          equals(RoutesName.anamnesisStep1),
        );

        router.go(RoutesName.anamnesisStep2);
        await tester.pumpAndSettle();

        expect(
          router.routeInformationProvider.value.uri.path,
          equals(RoutesName.anamnesisStep2),
        );
      },
    );
  });
}
