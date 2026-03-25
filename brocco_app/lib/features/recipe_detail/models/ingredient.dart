class Ingredient {
  final String id;
  final String name;
  final double? amount;
  final String? unit;
  final int sortOrder;

  const Ingredient({
    required this.id,
    required this.name,
    this.amount,
    this.unit,
    this.sortOrder = 0,
  });

  /// Formatted display string, e.g. "300 g" or "2 szt."
  String get formattedAmount {
    if (amount == null && unit == null) return '';
    final amountStr = amount != null
        ? (amount! % 1 == 0 ? amount!.toInt().toString() : amount.toString())
        : '';
    final unitStr = unit ?? '';
    return '$amountStr $unitStr'.trim();
  }
}
