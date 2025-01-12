import 'package:demo_test_technical_flutter_202501/core/widgets/atom/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  group('CustomText Widget Tests', () {
    testWidgets(
      'renders text correctly without required indicator',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CustomText(
                'Hello World',
                isRequired: false,
              ),
            ),
          ),
        );

        final richTextWidget = tester.widget<RichText>(find.byType(RichText));
        final textSpan = richTextWidget.text as TextSpan;
        expect((textSpan.children?[0] as TextSpan).text, 'Hello World');
        expect(textSpan.children?.length, 1);
        expect(find.bySemanticsLabel('Hello World'), findsOneWidget);
      },
    );

    testWidgets(
      'renders text correctly with required indicator',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CustomText(
                'Hello World',
                isRequired: true,
              ),
            ),
          ),
        );

        final richTextWidget = tester.widget<RichText>(find.byType(RichText));
        final textSpan = richTextWidget.text as TextSpan;
        expect((textSpan.children?[0] as TextSpan).text, 'Hello World');
        expect(textSpan.children?.length, 2);
        expect((textSpan.children?[1] as TextSpan).text, '*');
        expect(
          find.bySemanticsLabel('Campo obligatorio Hello World'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'applies custom font size and color correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CustomText(
                'Custom Style',
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ),
        );

        final richTextWidget = tester.widget<RichText>(find.byType(RichText));
        final textStyle = (richTextWidget.text as TextSpan).children?[0].style;

        expect(textStyle?.fontSize, 20);
        expect(textStyle?.color, Colors.blue);
      },
    );
  });
}
