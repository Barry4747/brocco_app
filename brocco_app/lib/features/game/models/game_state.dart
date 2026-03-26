class GameState {
  final String recipeId;
  final List<String> steps;
  final int currentStepIndex;

  bool get isFinished => steps.isNotEmpty && currentStepIndex >= steps.length;
  String? get currentStepText => 
      (steps.isEmpty || isFinished) ? null : steps[currentStepIndex];
  double get progress => steps.isEmpty ? 0.0 : currentStepIndex / steps.length;

  const GameState({
    this.recipeId = '',
    this.steps = const [],
    this.currentStepIndex = 0,
  });

  GameState copyWith({
    String? recipeId,
    List<String>? steps,
    int? currentStepIndex,
  }) {
    return GameState(
      recipeId: recipeId ?? this.recipeId,
      steps: steps ?? this.steps,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
    );
  }
}
