import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class IngredientSearchField extends StatefulWidget {
  final List<String> availableIngredients;
  final List<String> selectedIngredients;
  final void Function(String) onToggle;

  const IngredientSearchField({
    required this.availableIngredients,
    required this.selectedIngredients,
    required this.onToggle,
    super.key,
  });

  @override
  State<IngredientSearchField> createState() => _IngredientSearchFieldState();
}

class _IngredientSearchFieldState extends State<IngredientSearchField> {
  TextEditingController? _ingredientController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return widget.availableIngredients.where((ingredient) => 
              ingredient.toLowerCase().contains(textEditingValue.text.toLowerCase()) && 
              !widget.selectedIngredients.contains(ingredient)
            );
          },
          onSelected: (String selection) {
            widget.onToggle(selection);
            Future.delayed(Duration.zero, () {
              _ingredientController?.clear();
            });
          },
          fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
            _ingredientController = controller;
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              onEditingComplete: onEditingComplete,
              style: const TextStyle(color: AppColors.primaryText),
              decoration: InputDecoration(
                hintText: 'Wpisz składnik...',
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
                prefixIcon: const Icon(Icons.search, color: AppColors.greyText),
              ),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200,
                    maxWidth: MediaQuery.of(context).size.width - 32,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return InkWell(
                        onTap: () => onSelected(option),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(option, style: const TextStyle(color: AppColors.primaryText)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.selectedIngredients.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.selectedIngredients.map((i) => Chip(
              label: Text(i, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              backgroundColor: AppColors.primaryText,
              deleteIconColor: Colors.white70,
              onDeleted: () => widget.onToggle(i),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Colors.transparent)),
            )).toList(),
          ),
        ],
      ],
    );
  }
}
