import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/main_progress_bar.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../viewmodels/game_viewmodel.dart';

class GameScreen extends ConsumerStatefulWidget {
  final String recipeId;
  final String recipeText;
  final String nodeId;
  final String categoryId;
  final String recipeTitle;

  const GameScreen({
    super.key,
    required this.recipeId,
    required this.recipeText,
    required this.nodeId,
    required this.categoryId,
    required this.recipeTitle,
  });

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameViewModelProvider.notifier).startGame(
            widget.recipeId,
            widget.recipeText,
          );
    });
  }

  void _finishGame() {
    context.pushReplacement(
      Uri(
        path: '/game/completed',
        queryParameters: {
          'nodeId': widget.nodeId,
          'categoryId': widget.categoryId,
          'recipeTitle': widget.recipeTitle,
        },
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(widget.recipeTitle, style: const TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.primaryText),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              MainProgressBar(
                currentStep: gameState.steps.isEmpty ? 0 : gameState.currentStepIndex + 1,
                totalSteps: gameState.steps.length,
              ),
              const SizedBox(height: 48),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      gameState.currentStepText ?? 'Przetwarzanie przepisu...',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryText,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  if (gameState.currentStepIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ref.read(gameViewModelProvider.notifier).previousStep();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: AppColors.accentGreen, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Poprzedni',
                          style: TextStyle(
                            color: AppColors.accentGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  if (gameState.currentStepIndex > 0) const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      text: (gameState.steps.isNotEmpty &&
                                  gameState.currentStepIndex >= gameState.steps.length - 1)
                          ? 'Zakończ'
                          : 'Następny',
                      onPressed: () {
                        if (gameState.steps.isNotEmpty &&
                            gameState.currentStepIndex >= gameState.steps.length - 1) {
                          _finishGame();
                        } else {
                          ref.read(gameViewModelProvider.notifier).nextStep();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
