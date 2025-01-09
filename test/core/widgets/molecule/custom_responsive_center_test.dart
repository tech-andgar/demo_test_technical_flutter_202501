import 'package:demo_test_technical_flutter_202501/core/widgets/molecule/custom_responsive_center.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockScrollController extends Mock implements ScrollController {}

class MockScrollPosition extends Mock implements ScrollPosition {}

void main() {
  group('ResponsiveCenterScrollable', () {
    late MockScrollController mockScrollController;
    late MockScrollPosition mockScrollPosition;

    setUp(() {
      mockScrollController = MockScrollController();
      mockScrollPosition = MockScrollPosition();

      // Simulate an initial offset value in the ScrollController
      when(() => mockScrollController.offset)
          .thenReturn(0.0); // Initial offset value is 0.0

      // Simulate the properties of the position
      when(() => mockScrollController.position).thenReturn(mockScrollPosition);

      // Simulate the minScrollExtent and maxScrollExtent values
      when(() => mockScrollPosition.minScrollExtent).thenReturn(0.0);
      when(() => mockScrollPosition.maxScrollExtent).thenReturn(1000.0);
    });

    testWidgets(
      'should apply 50% of screen width for large screens (maxWidth > 1080)',
      (tester) async {
        // Simulate a large screen size (> 1080px)
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: ResponsiveCenterScrollable(
              controller: mockScrollController,
              child: const SizedBox(width: 500, height: 200),
            ),
          ),
        );

        // Find the ConstrainedBox inside the ResponsiveCenterScrollable widget
        final constrainedBox = tester.widget<ConstrainedBox>(
          find.descendant(
            of: find.byType(ResponsiveCenterScrollable),
            matching: find.byType(ConstrainedBox),
          ),
        );

        // Since the screen width is 1200, responsiveWidth should be 50% of it (1200 * 0.5)
        const expectedWidth = 1200 * 0.5;
        expect(constrainedBox.constraints.maxWidth, expectedWidth);
      },
    );

    testWidgets(
      'should apply factorHorizontal for small screens (maxWidth <= 1080)',
      (tester) async {
        // Simulate a small screen size (< 1080px)
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            home: ResponsiveCenterScrollable(
              controller: mockScrollController,
              child: const SizedBox(width: 500, height: 200),
            ),
          ),
        );

        // Find the ConstrainedBox inside the ResponsiveCenterScrollable widget
        final constrainedBox = tester.widget<ConstrainedBox>(
          find.descendant(
            of: find.byType(ResponsiveCenterScrollable),
            matching: find.byType(ConstrainedBox),
          ),
        );

        // Since the screen width is 800, responsiveWidth should be 800 * factorHorizontal
        const expectedWidth = 800 * factorHorizontal;
        expect(constrainedBox.constraints.maxWidth, expectedWidth);
      },
    );

    testWidgets('should use maxContentWidth if provided', (tester) async {
      // Simulate a screen size where maxContentWidth is used
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      const maxContentWidth = 600.0;

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveCenterScrollable(
            controller: mockScrollController,
            maxContentWidth: maxContentWidth,
            child: const SizedBox(width: 500, height: 200),
          ),
        ),
      );

      // Find the ConstrainedBox inside the ResponsiveCenterScrollable widget
      final constrainedBox = tester.widget<ConstrainedBox>(
        find.descendant(
          of: find.byType(ResponsiveCenterScrollable),
          matching: find.byType(ConstrainedBox),
        ),
      );

      // The maxWidth should be the provided maxContentWidth (600)
      expect(constrainedBox.constraints.maxWidth, maxContentWidth);
    });

    testWidgets('should handle pointer signals and scrolling', (tester) async {
      // Prepare the scroll event (PointerScrollEvent)
      const pointerSignal = PointerScrollEvent(
        position: Offset(0, 0),
        scrollDelta: Offset(0, 100), // Scroll by 100 in the Y direction
      );

      // Verify that the scroll controller receives the scroll event
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveCenterScrollable(
            controller: mockScrollController,
            child: const SizedBox(width: 500, height: 200),
          ),
        ),
      );

      // Simulate the scroll event
      await tester.sendEventToBinding(pointerSignal);

      verify(() => mockScrollController.jumpTo(any())).called(1);
    });
    testWidgets('should handle pointer scroll within bounds', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveCenterScrollable(
            controller: mockScrollController,
            child: const SizedBox(width: 500, height: 200),
          ),
        ),
      );

      // Simulate a scroll down event
      const pointerSignal = PointerScrollEvent(
        position: Offset(0, 0),
        scrollDelta: Offset(0, 100), // Scroll down
      );

      // Trigger the pointer event
      await tester.sendEventToBinding(pointerSignal);

      // Verify that jumpTo was called with the updated offset (100)
      verify(() => mockScrollController.jumpTo(100)).called(1);
    });

    testWidgets(
      'should clamp scroll to minScrollExtent when below bounds',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResponsiveCenterScrollable(
              controller: mockScrollController,
              child: const SizedBox(width: 500, height: 200),
            ),
          ),
        );

        // Simulate a scroll up event that exceeds the minimum extent
        const pointerSignal = PointerScrollEvent(
          position: Offset(0, 0),
          scrollDelta: Offset(0, -200), // Scroll up, more than initial offset
        );

        // Trigger the pointer event
        await tester.sendEventToBinding(pointerSignal);

        // Verify that jumpTo was called with the minScrollExtent (0.0)
        verify(() => mockScrollController.jumpTo(0.0)).called(1);
      },
    );

    testWidgets(
      'should clamp scroll to maxScrollExtent when exceeding max bounds',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResponsiveCenterScrollable(
              controller: mockScrollController,
              child: const SizedBox(width: 500, height: 200),
            ),
          ),
        );

        // Simulate a scroll down event that exceeds the maximum extent
        const pointerSignal = PointerScrollEvent(
          position: Offset(0, 0),
          scrollDelta: Offset(0, 2000), // Scroll down, exceeds maxScrollExtent
        );

        // Trigger the pointer event
        await tester.sendEventToBinding(pointerSignal);

        // Verify that jumpTo was called with the maxScrollExtent (1000.0)
        verify(() => mockScrollController.jumpTo(1000.0)).called(1);
      },
    );

    testWidgets(
      'should update offset correctly within valid bounds',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: ResponsiveCenterScrollable(
              controller: mockScrollController,
              child: const SizedBox(width: 500, height: 200),
            ),
          ),
        );

        // Simulate a scroll event within valid bounds (scroll down by 100)
        const pointerSignal = PointerScrollEvent(
          position: Offset(0, 0),
          scrollDelta: Offset(0, 150), // Scroll down by 150
        );

        // Trigger the pointer event
        await tester.sendEventToBinding(pointerSignal);

        // Verify that jumpTo was called with the correct updated offset (150)
        verify(() => mockScrollController.jumpTo(150)).called(1);
      },
    );
  });

  group('ResponsiveCenter Widget', () {
    testWidgets(
      'ResponsiveCenter applies correct width and padding',
      (tester) async {
        const testWidget = ResponsiveCenter(
          child: Text('Test'),
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: testWidget),
          ),
        );

        final textFinder = find.text('Test');
        expect(textFinder, findsOneWidget);

        // Check that the text is inside a Center widget.
        final centerWidget = tester.widget<Center>(find.byType(Center));
        expect(centerWidget.child, isA<LayoutBuilder>());

        final layoutBuilder =
            tester.widget<LayoutBuilder>(find.byType(LayoutBuilder));
        expect(
          layoutBuilder.builder,
          isNotNull,
        );
      },
    );

    testWidgets(
      'ResponsiveCenter uses maxContentWidth when provided',
      (tester) async {
        const testWidget = ResponsiveCenter(
          maxContentWidth: 500,
          child: Text('Test'),
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: testWidget),
          ),
        );

        final textFinder = find.text('Test');
        expect(textFinder, findsOneWidget);

        final responsiveCenter = find.byType(ResponsiveCenter);
        final constrainedBox = tester.widget<ConstrainedBox>(
          find.descendant(
            of: responsiveCenter,
            matching: find.byType(ConstrainedBox),
          ),
        );
        expect(
          constrainedBox.constraints.maxWidth,
          500,
        );
      },
    );

    testWidgets(
      'ResponsiveCenter calculates responsive width correctly',
      (tester) async {
        const testWidget = ResponsiveCenter(
          child: Text('Test'),
        );

        // Now simulate a smaller screen (< 1080px in width)
        tester.view.physicalSize = const Size(800, 600);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: testWidget),
          ),
        );
        await tester.pumpAndSettle();

        final textFinder = find.text('Test');
        expect(textFinder, findsOneWidget);

        // Find the ResponsiveCenter widget, then look for the ConstrainedBox inside it
        final responsiveCenter = find.byType(ResponsiveCenter);
        final constrainedBox = tester.widget<ConstrainedBox>(
          find.descendant(
            of: responsiveCenter,
            matching: find.byType(ConstrainedBox),
          ),
        );
        const responsiveWidth = 800 * factorHorizontal;
        expect(constrainedBox.constraints.maxWidth, responsiveWidth);

        // Test for simulate a large screen size (maxWidth > 1080)
        tester.view.physicalSize = const Size(1200, 800);
        await tester.pumpAndSettle();

        final largeScreenConstrainedBox = tester.widget<ConstrainedBox>(
          find.descendant(
            of: responsiveCenter,
            matching: find.byType(ConstrainedBox),
          ),
        );

        // With maxWidth of 1200, the responsive width should be 50% of the screen width.
        const largeScreenResponsiveWidth = 1200 * 0.5;
        expect(
          largeScreenConstrainedBox.constraints.maxWidth,
          largeScreenResponsiveWidth,
        );
      },
    );

    testWidgets('ResponsiveCenter applies padding correctly', (tester) async {
      const testWidget = ResponsiveCenter(
        padding: EdgeInsets.all(16),
        child: Text('Test'),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: testWidget),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(
        padding.padding,
        const EdgeInsets.all(16),
      );
    });

    testWidgets(
      'ResponsiveCenter wraps child in a Center widget',
      (tester) async {
        const testWidget = ResponsiveCenter(
          child: Text('Test'),
        );

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: testWidget),
          ),
        );

        final centerWidget = tester.widget<Center>(find.byType(Center));
        expect(centerWidget.child, isA<LayoutBuilder>());
      },
    );
  });
}
