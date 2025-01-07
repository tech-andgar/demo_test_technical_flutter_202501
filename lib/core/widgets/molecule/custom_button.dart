//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.
import 'package:flutter/material.dart';

import '../../core.dart';

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
    final sizedBox = Padding(
      padding: inDialog ? EdgeInsets.zero : const EdgeInsets.only(left: 32),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
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
        ),
      ),
    );

    return inDialog ? sizedBox : ResponsiveCenter(child: sizedBox);
  }
}
