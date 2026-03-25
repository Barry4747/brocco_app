import 'package:flutter/material.dart';
import 'selectable_pill.dart';

class MultiSelectPillGroup extends StatelessWidget {
  final List<String> items;
  final List<String> selectedItems;
  final Function(String) onToggle;

  const MultiSelectPillGroup({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 12,
      children: items.map((item) {
        final isSelected = selectedItems.contains(item);
        return SelectablePill(
          text: item,
          isSelected: isSelected,
          onTap: () => onToggle(item),
        );
      }).toList(),
    );
  }
}
