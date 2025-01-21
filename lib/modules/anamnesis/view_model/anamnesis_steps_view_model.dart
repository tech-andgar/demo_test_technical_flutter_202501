// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter_riverpod/flutter_riverpod.dart';

final anamnesisForm1ViewModel =
    StateNotifierProvider<AnamnesisForm1ViewModel, AnamnesisForm1State>(
  (ref) => AnamnesisForm1ViewModel(),
);

class AnamnesisForm1ViewModel extends StateNotifier<AnamnesisForm1State> {
  AnamnesisForm1ViewModel() : super(AnamnesisForm1State());

  void updateDisease(String value) => state = state.copyWith(disease: value);

  void updateOperation(String value) =>
      state = state.copyWith(operation: value);

  void clean() => state = AnamnesisForm1State();
}

class AnamnesisForm1State {
  AnamnesisForm1State({this.operation = '', this.disease = ''});

  final String disease;
  final String operation;

  bool get isValid => operation.isNotEmpty && disease.isNotEmpty;

  AnamnesisForm1State copyWith({String? operation, String? disease}) {
    return AnamnesisForm1State(
      operation: operation ?? this.operation,
      disease: disease ?? this.disease,
    );
  }
}

final anamnesisForm2ViewModel =
    StateNotifierProvider<AnamnesisForm2ViewModel, AnamnesisForm2State>(
  (ref) => AnamnesisForm2ViewModel(),
);

class AnamnesisForm2ViewModel extends StateNotifier<AnamnesisForm2State> {
  AnamnesisForm2ViewModel() : super(AnamnesisForm2State());

  void setFrequentPain(bool? value) {
    state = AnamnesisForm2State(
      problemBonesJoints: state.problemBonesJoints,
      painFrequent: value,
    );
  }

  void setProblemBonesJoints(bool? value) {
    state = AnamnesisForm2State(
      problemBonesJoints: value,
      painFrequent: state.painFrequent,
    );
  }

  void clean() {
    state = AnamnesisForm2State();
  }
}

class AnamnesisForm2State {
  AnamnesisForm2State({
    this.problemBonesJoints,
    this.painFrequent,
  });

  final bool? problemBonesJoints;
  final bool? painFrequent;

  bool get isValid => problemBonesJoints != null && painFrequent != null;
}
