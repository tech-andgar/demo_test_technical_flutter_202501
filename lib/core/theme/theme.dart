//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:demo_test_technical_flutter_202501/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    appBarTheme: AppBarTheme(
      color: Colors.black,
      titleTextStyle: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.31,
        letterSpacing: 0.04,
        color: Colors.grey,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1.31,
        letterSpacing: 0.04,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      displayLarge: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      labelLarge: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      headlineLarge: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.disabled)
              ? const Color(0xff585853)
              : const Color.fromRGBO(230, 199, 67, 1);
        }),
        foregroundColor: const WidgetStatePropertyAll(Colors.black),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(24)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: FontFamily.futuraBook.value,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      borderRadius: const BorderRadius.all(Radius.zero),
      selectedBorderColor: Colors.lightBlueAccent[700],
      borderColor: Colors.blue[300]!.withAlpha(80),
      selectedColor: Colors.white,
      fillColor: Colors.blue.withAlpha(30),
      color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: FontFamily.futuraMediumItalic.value,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.white.withAlpha(180),
      ),
      floatingLabelStyle: TextStyle(
        fontFamily: FontFamily.futuraLightBt.value,
        fontWeight: FontWeight.w500,
        fontSize: 10,
        height: 1.31,
        letterSpacing: 0.04,
        color: Colors.white,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  );
}
