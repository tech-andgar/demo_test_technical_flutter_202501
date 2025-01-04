//  Created in Dart by Andres Garcia (TECH-ANDGAR) on 2025-01-03.

import 'package:flutter/material.dart';

import '../widgets.dart';

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({
    required this.options,
    required this.onSelectionChanged,
    super.key,
  }) : assert(
          options.length == 2,
          'El número de opciones debe ser 2. (e.g., "Sí", "No")',
        );

  final List<String> options;
  final ValueChanged<bool?> onSelectionChanged;

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  int? _selectedIndex;
  bool _isFirstBuild = true;

  @override
  Widget build(BuildContext context) {
    if (_isFirstBuild) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onSelectionChanged(null);
      });
      _isFirstBuild = false;
    }

    final isSelected =
        List<bool>.generate(widget.options.length, (i) => i == _selectedIndex);

    return Column(
      children: [
        ToggleButtons(
          onPressed: (index) {
            setState(() {
              if (_selectedIndex == index) {
                _selectedIndex = null;
                widget.onSelectionChanged(null);
              } else {
                _selectedIndex = index;
                bool? selectedValue;
                if (index == 0) {
                  selectedValue = true;
                } else if (index == 1) {
                  selectedValue = false;
                } else {
                  selectedValue = null;
                }
                widget.onSelectionChanged(selectedValue);
              }
            });
          },
          constraints: BoxConstraints(
            minHeight: 40.0,
            minWidth: MediaQuery.sizeOf(context).width * .4325,
          ),
          isSelected: isSelected,
          children: widget.options.map(CustomText.new).toList(),
        ),
      ],
    );
  }
}
