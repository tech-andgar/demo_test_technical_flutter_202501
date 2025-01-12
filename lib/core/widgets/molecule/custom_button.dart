//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.
import 'package:flutter/material.dart';

import '../widgets.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    this.onTap,
    this.child,
    this.inDialog = false,
    super.key,
  });

  final VoidCallback? onTap;
  final Widget? child;
  final bool inDialog;
  final String label;

  @override
  Widget build(BuildContext context) {
    final widgetChild = SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: ElevatedButton(
        onPressed: onTap,
        child: child ??
            CustomText(
              label,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
      ),
    );

    return inDialog ? widgetChild : ResponsiveCenter(child: widgetChild);
  }
}
