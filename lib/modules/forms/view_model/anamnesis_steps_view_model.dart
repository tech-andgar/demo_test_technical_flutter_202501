// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter_riverpod/flutter_riverpod.dart';

final form1ViewModel = StateNotifierProvider<Form1ViewModel, Form1State>(
  (ref) => Form1ViewModel(),
);

class Form1ViewModel extends StateNotifier<Form1State> {
  Form1ViewModel() : super(Form1State());

  void updateEnfermedad(String value) {
    state = state.copyWith(enfermedad: value);
  }

  void updateOperacion(String value) {
    state = state.copyWith(operacion: value);
  }
}

class Form1State {
  Form1State({this.operacion = '', this.enfermedad = ''});

  final String enfermedad;
  final String operacion;

  bool get isValid => operacion.isNotEmpty && enfermedad.isNotEmpty;

  Form1State copyWith({String? operacion, String? enfermedad}) {
    return Form1State(
      operacion: operacion ?? this.operacion,
      enfermedad: enfermedad ?? this.enfermedad,
    );
  }
}

final form2ViewModel = StateNotifierProvider<Form2ViewModel, Form2State>(
  (ref) => Form2ViewModel(),
);

class Form2ViewModel extends StateNotifier<Form2State> {
  Form2ViewModel() : super(Form2State());

  void setDoloresFrecuentes(bool? value) {
    state = Form2State(
      problemaHuesosArticulaciones: state.problemaHuesosArticulaciones,
      doloresFrecuentes: value,
    );
  }

  void setProblemaHuesosArticulaciones(bool? value) {
    state = Form2State(
      problemaHuesosArticulaciones: value,
      doloresFrecuentes: state.doloresFrecuentes,
    );
  }
}

class Form2State {
  Form2State({this.problemaHuesosArticulaciones, this.doloresFrecuentes});

  final bool? problemaHuesosArticulaciones;
  final bool? doloresFrecuentes;

  bool get isValid =>
      problemaHuesosArticulaciones != null && doloresFrecuentes != null;
}
