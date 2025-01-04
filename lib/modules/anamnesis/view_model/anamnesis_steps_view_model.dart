// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter_riverpod/flutter_riverpod.dart';

final anamnesisForm1ViewModel =
    StateNotifierProvider<AnamnesisForm1ViewModel, AnamnesisForm1State>(
  (ref) => AnamnesisForm1ViewModel(),
);

class AnamnesisForm1ViewModel extends StateNotifier<AnamnesisForm1State> {
  AnamnesisForm1ViewModel() : super(AnamnesisForm1State());

  void updateEnfermedad(String value) {
    state = state.copyWith(enfermedad: value);
  }

  void updateOperacion(String value) {
    state = state.copyWith(operacion: value);
  }
}

class AnamnesisForm1State {
  AnamnesisForm1State({this.operacion = '', this.enfermedad = ''});

  final String enfermedad;
  final String operacion;

  bool get isValid => operacion.isNotEmpty && enfermedad.isNotEmpty;

  AnamnesisForm1State copyWith({String? operacion, String? enfermedad}) {
    return AnamnesisForm1State(
      operacion: operacion ?? this.operacion,
      enfermedad: enfermedad ?? this.enfermedad,
    );
  }
}

final anamnesisForm2ViewModel =
    StateNotifierProvider<AnamnesisForm2ViewModel, AnamnesisForm2State>(
  (ref) => AnamnesisForm2ViewModel(),
);

class AnamnesisForm2ViewModel extends StateNotifier<AnamnesisForm2State> {
  AnamnesisForm2ViewModel() : super(AnamnesisForm2State());

  void setDoloresFrecuentes(bool? value) {
    state = AnamnesisForm2State(
      problemaHuesosArticulaciones: state.problemaHuesosArticulaciones,
      doloresFrecuentes: value,
    );
  }

  void setProblemaHuesosArticulaciones(bool? value) {
    state = AnamnesisForm2State(
      problemaHuesosArticulaciones: value,
      doloresFrecuentes: state.doloresFrecuentes,
    );
  }
}

class AnamnesisForm2State {
  AnamnesisForm2State({
    this.problemaHuesosArticulaciones,
    this.doloresFrecuentes,
  });

  final bool? problemaHuesosArticulaciones;
  final bool? doloresFrecuentes;

  bool get isValid =>
      problemaHuesosArticulaciones != null && doloresFrecuentes != null;
}
