import 'package:brocco_app/shared/widgets/cards/selection_card_with_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/onboarding_data.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_screen_shell.dart';

class OnboardingSkillScreen extends ConsumerStatefulWidget {
  const OnboardingSkillScreen({super.key});

  @override
  ConsumerState<OnboardingSkillScreen> createState() =>
      _OnboardingSkillScreenState();
}

class _OnboardingSkillScreenState extends ConsumerState<OnboardingSkillScreen> {
  CookingSkill? _selectedSkill;

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenShell(
      currentStep: 1,
      totalSteps: 4,
      onBack: () => context.pop(),
      primaryButtonText: 'Kontynuuj',
      onPrimaryPressed: _selectedSkill == null
          ? null
          : () {
              ref
                  .read(onboardingViewModelProvider.notifier)
                  .updateCookingProfile(skill: _selectedSkill);
              context.push('/onboarding/step_2');
            },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingHeader(title: 'Jaki jest Twój aktualny poziom?'),
          const SizedBox(height: 40),
          SelectionCardWithImage(
            title: 'Mistrz mikrofali',
            subtitle: 'Umiem podgrzać jedzenie... i to w zasadzie tyle.',
            emoji: '🍿',
            isSelected: _selectedSkill == CookingSkill.novice,
            onTap: () => setState(() => _selectedSkill = CookingSkill.novice),
          ),
          SelectionCardWithImage(
            title: 'Domowy kucharz',
            subtitle:
                'Gotuję regularnie i uwielbiam próbować nowych przepisów.',
            emoji: '🍳',
            isSelected: _selectedSkill == CookingSkill.homeCook,
            onTap: () => setState(() => _selectedSkill = CookingSkill.homeCook),
          ),
          SelectionCardWithImage(
            title: 'Master Chef',
            subtitle: 'Duszenie i deglazowanie nie mają przede mną tajemnic.',
            emoji: '🔪',
            isSelected: _selectedSkill == CookingSkill.masterchef,
            onTap: () =>
                setState(() => _selectedSkill = CookingSkill.masterchef),
          ),
        ],
      ),
    );
  }
}
