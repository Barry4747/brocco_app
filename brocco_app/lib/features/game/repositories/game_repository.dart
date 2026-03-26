import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepository();
});

class GameRepository {
  List<String> parseRecipeToSteps(String plaintext) {
    if (plaintext.trim().isEmpty) return [];
    
    // Dzielimy tekst po kropce
    final rawSteps = plaintext.split('.');
    
    // Czyścimy puste ciągi znaków (np. gdy na końcu była kropka)
    final steps = rawSteps
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .map((s) => '$s.') // Dodajemy kropkę z powrotem na koniec zdania
        .toList();

    return steps;
  }
}
