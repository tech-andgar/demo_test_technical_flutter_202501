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
      width: MediaQuery.sizeOf(context).width * 0.94,
      child: ElevatedButton(
        onPressed: onTap,
        child: child ??
            CustomText(
              label,
              fontFamily: FontFamily.futuraBook,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
      ),
    );
  }
}
