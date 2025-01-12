//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';

import '../widgets.dart';

class DevelopByText extends StatelessWidget {
  const DevelopByText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: 'Desarrollado por Andrés García ',
              style: Theme.of(context).textTheme.bodyLarge,
              children: const <InlineSpan>[
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: LinkButton(
                    urlLabel: '(TECH-ANDGAR)',
                    url: 'https://tech-andgar.me',
                  ),
                ),
                TextSpan(
                  text: ' ® 2025.\nTodos los derechos reservados. ',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
