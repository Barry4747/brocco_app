import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/main_back_text_button.dart';
import '../../../shared/widgets/buttons/main_progress_bar.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../../../shared/widgets/step_timer.dart';
import '../utils/step_time_parser.dart';
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
      ref
          .read(gameViewModelProvider.notifier)
          .startGame(widget.recipeId, widget.recipeText);
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
    final stepText = gameState.currentStepText;
    final stepDuration = stepText != null ? parseStepDuration(stepText) : null;
    final stepNumber = gameState.currentStepIndex + 1;
    final totalSteps = gameState.steps.length;
    final isLastStep =
        gameState.steps.isNotEmpty &&
        gameState.currentStepIndex >= gameState.steps.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: MainProgressBar(
                currentStep: gameState.steps.isEmpty ? 0 : stepNumber,
                totalSteps: totalSteps,
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnboardingBackButton(
                    onTap: () {
                      if (gameState.currentStepIndex > 0) {
                        ref.read(gameViewModelProvider.notifier).previousStep();
                      } else {
                        context.pop();
                      }
                    },
                  ),
                  if (stepDuration != null)
                    StepTimer(
                      key: ValueKey(gameState.currentStepIndex),
                      duration: stepDuration,
                    ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text('X', style: TextStyle(fontSize: 48)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentGreen.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Krok $stepNumber:',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            stepText ?? 'Przetwarzanie przepisu...',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryText,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SKŁADNIKI DO DODANIA:',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: AppColors.greyText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: PrimaryButton(
                text: isLastStep ? 'Zakończ' : 'Gotowe! Następny Krok',
                onPressed: () {
                  if (isLastStep) {
                    _finishGame();
                  } else {
                    ref.read(gameViewModelProvider.notifier).nextStep();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
