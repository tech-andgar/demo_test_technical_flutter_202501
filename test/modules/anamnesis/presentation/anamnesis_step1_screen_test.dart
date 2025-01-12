import 'package:demo_test_technical_flutter_202501/core/core.dart';
import 'package:demo_test_technical_flutter_202501/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {}

void main() {
  late ProviderContainer container;
  late MockGoRouter router;

  setUp(() {
    container = ProviderContainer();
    router = MockGoRouter();
    when(() => router.push(any())).thenAnswer((_) async => Future.value(null));
  });

  tearDown(() {
    container.dispose();
  });

  Widget createWidgetUnderTest({Widget? child}) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: InheritedGoRouter(
          goRouter: router,
          child: child ?? const AnamnesisStep1Screen(),
        ),
      ),
    );
  }

  testWidgets('AnamnesisStep1Screen renders correctly', (tester) async {
    // Arrange
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.pumpAndSettle();

    // Assert
    expect(
      find.widgetWithText(AppBar, 'Bienvenido a tu nuevo comienzo'),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel('Completa la siguiente información'),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel(
        'Campo obligatorio Todos los campos son obligatorios',
      ),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel(
        'Campo obligatorio ¿Ha tenido operaciones? ¿Cuáles y hace cuanto tiempo?',
      ),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel(
        'Campo obligatorio ¿Tiene o tuvo alguna enfermedad diagnosticada o tratada por un médico?',
      ),
      findsOneWidget,
    );

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(CustomButton), findsOneWidget);
  });

  testWidgets('TextFields update when text is entered', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: AnamnesisStep1Screen(),
        ),
      ),
    );

    // Act
    await tester.enterText(find.byType(TextField).first, 'Test operation');
    await tester.enterText(find.byType(TextField).last, 'Test illness');
    await tester.pump();

    // Assert
    final state = container.read(anamnesisForm1ViewModel);
    expect(state.operation, equals('Test operation'));
    expect(state.disease, equals('Test illness'));
  });
  testWidgets('Next button is disabled when form is invalid', (tester) async {
    // Arrange
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AnamnesisStep1Screen(),
        ),
      ),
    );

    // Assert
    final button = tester.widget<CustomButton>(find.byType(CustomButton));
    expect(button.onTap, isNull);
  });

  testWidgets('Next button is enabled when form is valid', (tester) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await tester.pumpWidget(createWidgetUnderTest());

    // Act
    await tester.enterText(find.byType(TextField).first, 'Test operation');
    await tester.enterText(find.byType(TextField).last, 'Test illness');
    await tester.pump();

    // Assert
    final button = tester.widget<CustomButton>(find.byType(CustomButton));
    expect(button.onTap, isNotNull);
  });
  testWidgets(
    'Next button navigates to next screen when tapped',
    (tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      await tester.pumpWidget(createWidgetUnderTest());

      // Act
      await tester.enterText(find.byType(TextField).first, 'Test operation');
      await tester.enterText(find.byType(TextField).last, 'Test illness');
      await tester.pumpAndSettle();

      // Assert
      final button = tester.widget<CustomButton>(find.byType(CustomButton));
      expect(button.onTap, isNotNull);

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

      verify(() => router.push(RoutesName.anamnesisStep2)).called(1);
      verifyNoMoreInteractions(router);
    },
  );
}
