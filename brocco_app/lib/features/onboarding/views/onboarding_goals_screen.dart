import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/widgets/cards/selection_card_with_image.dart';
import '../models/onboarding_data.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_screen_shell.dart';

class OnboardingGoalsScreen extends ConsumerStatefulWidget {
  const OnboardingGoalsScreen({super.key});

  @override
  ConsumerState<OnboardingGoalsScreen> createState() =>
      _OnboardingGoalsScreenState();
}

class _OnboardingGoalsScreenState extends ConsumerState<OnboardingGoalsScreen> {
  MainGoal? _selectedGoal;

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenShell(
      currentStep: 3,
      totalSteps: 4,
      scrollable: true,
      onBack: () => context.pop(),
      primaryButtonText: 'Kontynuuj',
      onPrimaryPressed: _selectedGoal == null
          ? null
          : () {
              ref
                  .read(onboardingViewModelProvider.notifier)
                  .updateBiometrics(mainGoal: _selectedGoal);
              context.push('/onboarding/step_4');
            },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingHeader(
            title: 'Co chcesz osiągnąć?',
            subtitle:
                'Dostosujemy aplikację i przepisy do Twojego głównego celu.',
          ),
          const SizedBox(height: 32),

          SelectionCardWithImage(
            title: 'Jeść zdrowiej',
            subtitle: 'Chcę wprowadzić lepsze nawyki do swojej kuchni.',
            emoji: '🥗',
            isSelected: _selectedGoal == MainGoal.eatHealthier,
            onTap: () => setState(() => _selectedGoal = MainGoal.eatHealthier),
          ),
          const SizedBox(height: 12),

          SelectionCardWithImage(
            title: 'Schudnąć',
            subtitle: 'Potrzebuję kontroli nad kaloriami i makroskładnikami.',
            emoji: '📉',
            isSelected: _selectedGoal == MainGoal.loseWeight,
            onTap: () => setState(() => _selectedGoal = MainGoal.loseWeight),
          ),
          const SizedBox(height: 12),

          SelectionCardWithImage(
            title: 'Zbudować masę mięśniową',
            subtitle: 'Zależy mi na posiłkach bogatych w białko.',
            emoji: '💪',
            isSelected: _selectedGoal == MainGoal.buildMuscle,
            onTap: () => setState(() => _selectedGoal = MainGoal.buildMuscle),
          ),
          const SizedBox(height: 12),

          SelectionCardWithImage(
            title: 'Nauczyć się gotować',
            subtitle: 'Chcę poznać nowe techniki od podstaw.',
            emoji: '👨‍🍳',
            isSelected: _selectedGoal == MainGoal.learnToCook,
            onTap: () => setState(() => _selectedGoal = MainGoal.learnToCook),
          ),
          const SizedBox(height: 12),

          SelectionCardWithImage(
            title: 'Zaoszczędzić czas',
            subtitle: 'Szukam szybkich i sprawdzonych przepisów na co dzień.',
            emoji: '⚡',
            isSelected: _selectedGoal == MainGoal.saveTime,
            onTap: () => setState(() => _selectedGoal = MainGoal.saveTime),
          ),
        ],
      ),
    );
  }
}
