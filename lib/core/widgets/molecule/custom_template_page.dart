//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';

import '../widgets.dart';

class CustomTemplatePage extends StatelessWidget {
  const CustomTemplatePage({
    required this.content,
    required this.bottomButton,
    super.key,
  });

  final List<Widget> content;
  final Widget bottomButton;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const factorHorizontal = 0.025;
                final widthSize = constraints.maxWidth;
                final heightSize = constraints.minHeight;

                return SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: widthSize * factorHorizontal,
                    right: widthSize * factorHorizontal,
                    top: 24,
                    bottom: heightSize * 0.5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...content,
                      // SizedBox(height: heightSize * 0.2),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: bottomButton,
          ),
        ],
      ),
    );
  }
}
