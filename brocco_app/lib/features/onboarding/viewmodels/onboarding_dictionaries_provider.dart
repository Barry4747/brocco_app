import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../core/local_db/isar_provider.dart';
import '../repositories/dtos/isar_allergy.dart';
import '../repositories/dtos/isar_cuisine.dart';
import '../repositories/dtos/isar_ingredient.dart';

final onboardingDictionariesProvider = FutureProvider.autoDispose<Map<String, List<String>>>((ref) async {
  final isar = ref.read(isarProvider);
  
  final allergies = await isar.isarAllergys.where().findAll();
  final cuisines = await isar.isarCuisines.where().findAll();
  final ingredients = await isar.isarIngredients.where().findAll();
  
  final allergyNames = ['Brak', ...allergies.where((e) => e.name != 'Brak').map((e) => e.name)];
  final ingredientNames = ['Brak', ...ingredients.where((e) => e.name != 'Brak').map((e) => e.name)];
  final cuisineNames = cuisines.map((e) => e.name).toList();
  
  return {
    'allergies': allergyNames,
    'cuisines': cuisineNames,
    'ingredients': ingredientNames,
  };
});
