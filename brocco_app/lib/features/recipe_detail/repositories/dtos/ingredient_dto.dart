class IngredientDto {
  final String id;
  final String? recipeId;
  final String name;
  final double? amount;
  final String? unit;
  final int sortOrder;

  const IngredientDto({
    required this.id,
    this.recipeId,
    required this.name,
    this.amount,
    this.unit,
    this.sortOrder = 0,
  });

  factory IngredientDto.fromJson(Map<String, dynamic> json) {
    return IngredientDto(
      id: json['id'] as String,
      recipeId: json['recipe_id'] as String?,
      name: json['name'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      sortOrder: (json['sort_order'] as int?) ?? 0,
    );
  }
}
