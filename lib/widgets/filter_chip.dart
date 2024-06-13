import 'package:flutter/material.dart';

class MyFilterChip extends StatefulWidget {
  const MyFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.onSelected,
  });

  final String label;
  final bool isSelected;
  final Function(bool value)? onSelected;

  @override
  State<MyFilterChip> createState() => _MyFilterChipState();
}

class _MyFilterChipState extends State<MyFilterChip> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        widget.label,
        style: TextStyle(
          color: widget.isSelected
              ? Colors.white
              : Theme.of(context).colorScheme.outline,
        ),
      ),
      selected: widget.isSelected,
      showCheckmark: false,
      selectedColor: Theme.of(context).colorScheme.primary,
      side: BorderSide(
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
      onSelected: widget.onSelected,
    );
  }
}
