import 'package:demo_test_technical_flutter_202501/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppTheme Tests', () {
    testWidgets(
      'Theme components should be initialized correctly',
      (WidgetTester tester) async {
        // Build a test widget with ScreenUtil initialization
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                // Initialize ScreenUtil with test values
                ScreenUtil.init(
                  context,
                  designSize: const Size(375, 812),
                  minTextAdapt: true,
                  splitScreenMode: true,
                );

                // Create a dummy widget to test the theme
                return MaterialApp(
                  theme: AppTheme.darkTheme,
                  home: const Scaffold(),
                );
              },
            ),
          ),
        );

        // Wait for the next frame
        await tester.pumpAndSettle();

        final darkTheme = AppTheme.darkTheme;

        // Test Theme initialization
        expect(darkTheme, isA<ThemeData>());
        expect(darkTheme.brightness, equals(Brightness.dark));
        expect(darkTheme.useMaterial3, isTrue);

        // Test AppBar theme
        final appBarTheme = darkTheme.appBarTheme;
        expect(appBarTheme.backgroundColor, equals(Colors.black));
        expect(appBarTheme.iconTheme?.color, equals(Colors.white));
        expect(appBarTheme.actionsIconTheme?.color, equals(Colors.white));

        // Test Text theme without sp values
        final textTheme = darkTheme.textTheme;
        expect(
          textTheme.bodyLarge?.fontFamily,
          equals(FontFamily.futuraLightBt.value),
        );
        expect(
          textTheme.bodyMedium?.fontFamily,
          equals(FontFamily.futuraLightBt.value),
        );
        expect(
          textTheme.bodySmall?.fontFamily,
          equals(FontFamily.futuraLightBt.value),
        );

        // Test ElevatedButton theme
        final buttonTheme = darkTheme.elevatedButtonTheme;
        final backgroundColor =
            buttonTheme.style?.backgroundColor as WidgetStateProperty<Color?>;
        final foregroundColor =
            buttonTheme.style?.foregroundColor as WidgetStateProperty<Color?>;

        expect(
          backgroundColor.resolve({WidgetState.disabled}),
          equals(const Color(0xff585853)),
        );
        expect(
          backgroundColor.resolve({}),
          equals(const Color.fromRGBO(230, 199, 67, 1)),
        );
        expect(
          foregroundColor.resolve({}),
          equals(Colors.black),
        );

        // Test ToggleButtons theme
        final toggleTheme = darkTheme.toggleButtonsTheme;
        expect(
          toggleTheme.borderRadius,
          equals(const BorderRadius.all(Radius.zero)),
        );
        expect(toggleTheme.selectedColor, equals(Colors.white));

        // Test Input decoration theme
        final inputTheme = darkTheme.inputDecorationTheme;
        expect(
          inputTheme.labelStyle?.color,
          equals(Colors.white.withAlpha(180)),
        );
        expect(inputTheme.border, isA<OutlineInputBorder>());
      },
    );
  });
}
