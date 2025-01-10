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
        ..updateDisease('Gripe')
        ..updateOperation('Cirugía');

      final form1State = container.read(anamnesisForm1ViewModel);
      expect(form1State.isValid, true);
      expect(form1State.disease, 'Gripe');
      expect(form1State.operation, 'Cirugía');
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
        ..setFrequentPain(true)
        ..setProblemBonesJoints(true);

      final form2State = container.read(anamnesisForm2ViewModel);
      expect(form2State.isValid, true);
      expect(form2State.painFrequent, true);
      expect(form2State.problemBonesJoints, true);
    });
  });
}
