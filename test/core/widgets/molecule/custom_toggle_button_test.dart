// ignore_for_file: no-empty-block

import 'package:demo_test_technical_flutter_202501/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomToggleButton', () {
    testWidgets(
      'should assert when options length is not 2',
      (WidgetTester tester) async {
        expect(
          () => CustomToggleButton(
            options: const ['Yes'],
            onSelectionChanged: (_) {},
          ),
          throwsAssertionError,
        );

        expect(
          () => CustomToggleButton(
            options: const ['Yes', 'No', 'Maybe'],
            onSelectionChanged: (_) {},
          ),
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'should initialize with no selection',
      (WidgetTester tester) async {
        bool? selectedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: CustomToggleButton(
              options: const ['Yes', 'No'],
              onSelectionChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        );

        // Wait for post frame callback
        await tester.pumpAndSettle();

        // Initial state should be null
        expect(selectedValue, isNull);

        // Both buttons should be unselected
        final toggleButtons = find.byType(ToggleButtons);
        expect(toggleButtons, findsOneWidget);

        final toggleButtonsWidget = tester.widget<ToggleButtons>(toggleButtons);
        expect(toggleButtonsWidget.isSelected, [false, false]);
      },
    );

    testWidgets(
      'should handle selection changes correctly',
      (WidgetTester tester) async {
        bool? selectedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomToggleButton(
                options: const ['Yes', 'No'],
                onSelectionChanged: (value) {
                  selectedValue = value;
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final richTextWidgets =
            tester.widgetList<RichText>(find.byType(RichText));

        // Tap first option (Yes)
        await tester.tap(find.byWidget(richTextWidgets.first));
        await tester.pump();
        expect(selectedValue, isTrue);

        // Tap second option (No)
        await tester.tap(find.byWidget(richTextWidgets.last));
        await tester.pump();
        expect(selectedValue, isFalse);

        // Tap selected option again to deselect
        await tester.tap(find.byWidget(richTextWidgets.last));
        await tester.pump();
        expect(selectedValue, isNull);
      },
    );

    testWidgets(
      'should handle selection changes correctly',
      (WidgetTester tester) async {
        bool? selectedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomToggleButton(
                options: const ['Yes', 'No'],
                onSelectionChanged: (value) {
                  selectedValue = value;
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Find CustomText widgets
        final customTextWidgets = find.byWidgetPredicate(
          (widget) => widget is CustomText,
        );
        expect(customTextWidgets, findsNWidgets(2));

        // Tap first option (Yes)
        await tester.tap(customTextWidgets.at(0));
        await tester.pump();
        expect(selectedValue, isTrue);

        // Tap second option (No)
        await tester.tap(customTextWidgets.at(1));
        await tester.pump();
        expect(selectedValue, isFalse);

        // Tap selected option again to deselect
        await tester.tap(customTextWidgets.at(1));
        await tester.pump();
        expect(selectedValue, isNull);
      },
    );

    testWidgets('should have correct constraints', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomToggleButton(
            options: const ['Yes', 'No'],
            onSelectionChanged: (_) {},
          ),
        ),
      );

      final toggleButtonsWidget = tester.widget<ToggleButtons>(
        find.byType(ToggleButtons),
      );

      final constraints = toggleButtonsWidget.constraints as BoxConstraints;
      expect(constraints.minHeight, 40.0);
      // Width constraint is relative to screen size, so we don't test the exact value
      expect(constraints.minWidth, isPositive);
    });

    testWidgets(
      'should display correct text for options',
      (WidgetTester tester) async {
        const options = ['Option1', 'Option2'];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomToggleButton(
                options: options,
                onSelectionChanged: (_) {},
              ),
            ),
          ),
        );

        // Find CustomText widgets and verify their text content
        final customTextWidgets = find.byWidgetPredicate(
          (widget) => widget is CustomText,
        );
        expect(customTextWidgets, findsNWidgets(2));

        for (var i = 0; i < options.length; i++) {
          final customText = tester.widget<CustomText>(customTextWidgets.at(i));
          expect(customText.text, equals(options[i]));
        }
      },
    );

    testWidgets(
      'should have correct constraints',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomToggleButton(
                options: const ['Yes', 'No'],
                onSelectionChanged: (_) {},
              ),
            ),
          ),
        );

        final toggleButtonsWidget = tester.widget<ToggleButtons>(
          find.byType(ToggleButtons),
        );

        final constraints = toggleButtonsWidget.constraints as BoxConstraints;
        expect(constraints.minHeight, 40.0);
        expect(constraints.minWidth, isPositive);
      },
    );
  });
}
