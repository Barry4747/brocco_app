import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class CuisineDropdownField extends StatelessWidget {
  final List<String> availableCuisines;
  final List<String> selectedCuisines;
  final void Function(String) onToggle;

  const CuisineDropdownField({
    required this.availableCuisines,
    required this.selectedCuisines,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: 'Wybierz z listy...',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.greyText),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.greyText, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryText, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          value: null,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryText),
          items: availableCuisines
              .where((c) => !selectedCuisines.contains(c))
              .map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(color: AppColors.primaryText))))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onToggle(value);
            }
          },
        ),
        if (selectedCuisines.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedCuisines.map((c) => Chip(
              label: Text(c, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              backgroundColor: AppColors.primaryText,
              deleteIconColor: Colors.white70,
              onDeleted: () => onToggle(c),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Colors.transparent)),
            )).toList(),
          ),
        ],
      ],
    );
  }
}
