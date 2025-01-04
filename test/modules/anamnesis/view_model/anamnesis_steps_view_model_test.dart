// ignore_for_file: inference_failure_on_function_invocation

import 'package:demo_test_technical_flutter_202501/modules/modules.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Form1ViewModel Tests', () {
    test('Initial state should be invalid', () {
      final container = ProviderContainer();
      final form1State = container.read(anamnesisForm1ViewModel);

      expect(form1State.isValid, false);
    });

    test('State should be valid after updates', () {
      final container = ProviderContainer();
      container.read(anamnesisForm1ViewModel.notifier)
        ..updateEnfermedad('Gripe')
        ..updateOperacion('Cirugía');

      final form1State = container.read(anamnesisForm1ViewModel);
      expect(form1State.isValid, true);
      expect(form1State.enfermedad, 'Gripe');
      expect(form1State.operacion, 'Cirugía');
    });
  });

  group('Form2ViewModel Tests', () {
    test('Initial state should be invalid', () {
      final container = ProviderContainer();
      final form2State = container.read(anamnesisForm2ViewModel);

      expect(form2State.isValid, false);
    });

    test('State should be valid after updates', () {
      final container = ProviderContainer();
      container.read(anamnesisForm2ViewModel.notifier)
        ..setDoloresFrecuentes(true)
        ..setProblemaHuesosArticulaciones(true);

      final form2State = container.read(anamnesisForm2ViewModel);
      expect(form2State.isValid, true);
      expect(form2State.doloresFrecuentes, true);
      expect(form2State.problemaHuesosArticulaciones, true);
    });
  });
}
