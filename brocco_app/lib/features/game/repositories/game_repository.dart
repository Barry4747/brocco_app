import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  return GameRepository();
});

class GameRepository {
  List<String> parseRecipeToSteps(String plaintext) {
    if (plaintext.trim().isEmpty) return [];

    final rawSteps = plaintext.split('.');

    final steps = rawSteps
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .map((s) => '$s.')
        .toList();

    return steps;
  }
}
