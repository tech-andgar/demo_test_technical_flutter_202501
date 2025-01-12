import 'package:demo_test_technical_flutter_202501/core/widgets/molecule/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  group('CustomButton Widget Tests', () {
    testWidgets(
      'renders button with label and triggers tap',
      (WidgetTester tester) async {
        var tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(
                label: 'Press Me',
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        );

        final richTextWidget = tester.widget<RichText>(find.byType(RichText));
        final textSpan = richTextWidget.text as TextSpan;
        expect((textSpan.children?[0] as TextSpan).text, 'Press Me');
        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();
        expect(tapped, isTrue);
      },
    );

    testWidgets(
      'renders button with custom child widget',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CustomButton(
                label: 'Press Me',
                child: Icon(Icons.star),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.text('Press Me'), findsNothing);
      },
    );

    testWidgets(
      'button should be disabled when onTap is null',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CustomButton(
                label: 'Press Me',
                onTap: null,
              ),
            ),
          ),
        );

        final elevatedButton =
            tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(elevatedButton.onPressed, isNull);
      },
    );
  });
}
