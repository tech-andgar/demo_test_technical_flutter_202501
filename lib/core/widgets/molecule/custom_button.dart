//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.
import 'package:flutter/material.dart';

import '../../core.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    this.onTap,
    this.child,
    super.key,
  });

  final VoidCallback? onTap;
  final Widget? child;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: child ??
            Text(
              label,
              style: TextStyle(
                fontFamily: FontFamily.futuraBook.value,
                fontWeight: FontWeight.w700,
              ),
            ),
      ),
    );
  }
}
