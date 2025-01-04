import 'package:demo_test_technical_flutter_202501/core/routes/page_route_builder/page_route_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('CustomTransitionPages', () {
    testWidgets(
      'creates forward slide transition',
      (WidgetTester tester) async {
        final page = CustomTransitionPages<Object?>(
          key: const ValueKey('test'),
          child: const SizedBox(),
          isForward: true,
        );

        final controller = AnimationController(
          vsync: const TestVSync(),
          duration: const Duration(milliseconds: 300),
        );

        final animation = CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => page.transitionsBuilder(
                context,
                animation,
                const AlwaysStoppedAnimation(0),
                const SizedBox(),
              ),
            ),
          ),
        );

        final slideTransition = tester.widget<SlideTransition>(
          find.byType(SlideTransition),
        );

        expect(slideTransition, isNotNull);
        expect(
          slideTransition.position.value,
          const Offset(-1, 0),
        );

        controller.dispose();
      },
    );

    testWidgets(
      'creates backward slide transition',
      (WidgetTester tester) async {
        final page = CustomTransitionPages<Object?>(
          key: const ValueKey('test'),
          child: const SizedBox(),
          isForward: false,
        );

        final controller = AnimationController(
          vsync: const TestVSync(),
          duration: const Duration(milliseconds: 300),
        );

        final animation = CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) => page.transitionsBuilder(
                context,
                animation,
                const AlwaysStoppedAnimation(0),
                const SizedBox(),
              ),
            ),
          ),
        );

        final slideTransition = tester.widget<SlideTransition>(
          find.byType(SlideTransition),
        );

        expect(slideTransition, isNotNull);
        expect(
          slideTransition.position.value,
          const Offset(1, 0),
        );

        controller.dispose();
      },
    );
  });

  group('isForwardNavigation', () {
    test('returns true when current location is longer', () {
      expect(
        isForwardNavigation('/home/details', '/home'),
        isTrue,
      );
    });

    test('returns false when current location is shorter', () {
      expect(
        isForwardNavigation('/home', '/home/details'),
        isFalse,
      );
    });

    test('returns false when locations are equal length', () {
      expect(
        isForwardNavigation('/home/1', '/home/2'),
        isFalse,
      );
    });
  });

  group('buildCustomPage', () {
    late GoRouter router;
    late Widget app;

    setUp(() {
      router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const SizedBox(),
          ),
          GoRoute(
            path: '/home/details',
            builder: (context, state) => const SizedBox(),
          ),
        ],
      );

      app = MaterialApp.router(
        routerConfig: router,
      );
    });
    testWidgets(
      'updates previousLocation after building page',
      (WidgetTester tester) async {
        await tester.pumpWidget(app);

        // Reset previousLocation
        previousLocation = null;

        final state1 = GoRouterState(
          router.configuration,
          uri: Uri.parse('/home'),
          matchedLocation: '/home',
          path: '/home',
          fullPath: '/home',
          name: null,
          pageKey: const ValueKey('/home'),
          extra: null,
          pathParameters: const <String, String>{},
        );

        // Navigate to /home
        router.go('/home');
        await tester.pumpAndSettle();

        final page1 = buildCustomPage(
          state1,
          const SizedBox(),
        );
        expect(previousLocation, '/home');

        final state2 = GoRouterState(
          router.configuration,
          uri: Uri.parse('/home/details'),
          matchedLocation: '/home/details',
          path: '/home/details',
          fullPath: '/home/details',
          name: null,
          pageKey: const ValueKey('/home/details'),
          extra: null,
          pathParameters: const <String, String>{},
        );

        // Navigate to /home/details
        router.go('/home/details');
        await tester.pumpAndSettle();

        final page2 = buildCustomPage(
          state2,
          const SizedBox(),
        );
        expect(previousLocation, '/home/details');

        expect(page1, isA<CustomTransitionPages<Object?>>());
        expect(page2, isA<CustomTransitionPages<Object?>>());
      },
    );
  });
}

// Helper class for animation testing
class TestVSync implements TickerProvider {
  const TestVSync();

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
