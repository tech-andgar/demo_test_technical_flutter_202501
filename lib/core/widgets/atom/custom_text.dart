//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';

import '../../core.dart';

class CustomTextRequired extends StatelessWidget {
  const CustomTextRequired(
    this.text, {
    this.isRequired = false,
    this.fontFamily = FontFamily.futuraBook,
    super.key,
  });

  final String text;
  final bool isRequired;
  final FontFamily fontFamily;

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
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  height: 1.5,
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
