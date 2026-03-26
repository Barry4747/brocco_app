import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';
import '../repositories/game_repository.dart';

final gameViewModelProvider = NotifierProvider<GameViewModel, GameState>(() {
  return GameViewModel();
});

class GameViewModel extends Notifier<GameState> {
  @override
  GameState build() {
    return const GameState();
  }

  void startGame(String recipeId, String recipeText) {
    final repo = ref.read(gameRepositoryProvider);
    final steps = repo.parseRecipeToSteps(recipeText);
    
    state = GameState(
      recipeId: recipeId,
      steps: steps,
      currentStepIndex: 0,
    );
  }

  void nextStep() {
    if (!state.isFinished) {
      state = state.copyWith(currentStepIndex: state.currentStepIndex + 1);
    }
  }

  void previousStep() {
    if (state.currentStepIndex > 0) {
      state = state.copyWith(currentStepIndex: state.currentStepIndex - 1);
    }
  }

  void resetGame() {
    state = const GameState();
  }
}
