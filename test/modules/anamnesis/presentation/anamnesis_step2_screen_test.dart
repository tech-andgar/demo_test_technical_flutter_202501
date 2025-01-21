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
  late MockGoRouter mockGoRouter;

  setUp(() {
    container = ProviderContainer();
    mockGoRouter = MockGoRouter();
    when(() => mockGoRouter.pushReplacement(any()))
        .thenAnswer((_) async => null);
  });

  tearDown(() {
    container.dispose();
  });

  Widget createWidgetUnderTest({Widget? child}) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: InheritedGoRouter(
          goRouter: mockGoRouter,
          child: child ?? const AnamnesisStep2Screen(),
        ),
      ),
    );
  }

  testWidgets('AnamnesisStepScreen renders correctly', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

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
    expect(find.byType(CustomToggleButton), findsNWidgets(2));
    expect(find.byType(CustomButton), findsOneWidget);
  });

  testWidgets('CustomToggleButtons update when pressed', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final toggleButtons = find.byType(ToggleButtons);
    expect(toggleButtons, findsNWidgets(2));
    await tester.pumpAndSettle();

    final customTextWidgets = find.byWidgetPredicate(
      (widget) => widget is CustomText,
    );

    await tester.tap(customTextWidgets.at(3));
    await tester.pumpAndSettle();

    await tester.tap(customTextWidgets.at(6));
    await tester.pumpAndSettle();

    final state = container.read(anamnesisForm2ViewModel);
    expect(state.painFrequent, isTrue);
    expect(state.problemBonesJoints, isTrue);
  });

  testWidgets('Next button is disabled when form is invalid', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final button = tester.widget<CustomButton>(find.byType(CustomButton));
    expect(button.onTap, isNull);
  });

  // testWidgets(
  //   'Dialog appears when next button is tapped with valid form',
  //   (tester) async {
  //     container = ProviderContainer(
  //       overrides: [
  //         anamnesisForm2ViewModel.overrideWith(
  //           (ref) => AnamnesisForm2ViewModel()
  //             ..setDoloresFrecuentes(true)
  //             ..setProblemaHuesosArticulaciones(true),
  //         ),
  //       ],
  //     );

  //     await tester.pumpWidget(createWidgetUnderTest());

  //     await tester.tap(find.byType(CustomButton));
  //     await tester.pumpAndSettle();

  //     expect(find.byType(AlertDialog), findsOneWidget);
  //     expect(find.bySemanticsLabel('Cuestionario finalizado'), findsOneWidget);
  //     expect(
  //       find.bySemanticsLabel('Desarrollado por Andres Garcia (TECH-ANDGAR)'),
  //       findsOneWidget,
  //     );
  //     expect(find.bySemanticsLabel('Hecho por Flutter'), findsOneWidget);
  //   },
  // );

  // testWidgets('Dialog button navigates to first screen', (tester) async {
  //   container = ProviderContainer(
  //     overrides: [
  //       anamnesisForm2ViewModel.overrideWith(
  //         (ref) => AnamnesisForm2ViewModel()
  //           ..setDoloresFrecuentes(true)
  //           ..setProblemaHuesosArticulaciones(true),
  //       ),
  //     ],
  //   );

  //   await tester.pumpWidget(createWidgetUnderTest());

  //   await tester.tap(find.byType(CustomButton));
  //   await tester.pumpAndSettle();

  //   // Find and tap the dialog button
  //   final dialogButton = find.bySemanticsLabel('Ir a la pantalla de inicio');
  //   expect(dialogButton, findsOneWidget);

  //   await tester.tap(dialogButton);
  //   await tester.pumpAndSettle();

  //   verify(() => mockGoRouter.pushReplacement(RoutesName.anamnesisStep1))
  //       .called(1);
  // });
}
