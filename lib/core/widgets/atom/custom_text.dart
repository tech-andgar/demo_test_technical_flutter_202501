//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';

import '../../core.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    this.isRequired = false,
    this.fontFamily = FontFamily.futuraBook,
    this.fontSize = 16,
    this.height = 1.5,
    this.fontWeight = FontWeight.w300,
    this.color = Colors.white,
    super.key,
  });

  final String text;
  final bool isRequired;
  final FontFamily fontFamily;
  final double fontSize;
  final double height;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${isRequired ? "Campo obligatorio " : ""}$text',
      child: ExcludeSemantics(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: text,
                style: TextStyle(
                  fontFamily: fontFamily.value,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  height: height,
                  color: color,
                ),
              ),
              if (isRequired)
                const TextSpan(
                  text: '*',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
