import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/widgets/cards/selection_card_with_image.dart';
import '../models/onboarding_data.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_screen_shell.dart';

class OnboardingStep2Screen extends ConsumerStatefulWidget {
  const OnboardingStep2Screen({super.key});

  @override
  ConsumerState<OnboardingStep2Screen> createState() =>
      _OnboardingStep2ScreenState();
}

class _OnboardingStep2ScreenState extends ConsumerState<OnboardingStep2Screen> {
  CookingSkill? _selectedSkill;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final skill = ref.read(onboardingViewModelProvider).cookingSkill;
      if (mounted) setState(() => _selectedSkill = skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenShell(
      currentStep: 2,
      totalSteps: 7,
      scrollable: true,
      onBack: () => context.pop(),
      primaryButtonText: 'Kontynuuj',
      onPrimaryPressed: _selectedSkill == null
          ? null
          : () {
              ref
                  .read(onboardingViewModelProvider.notifier)
                  .updateCookingProfile(skill: _selectedSkill);
              context.push('/onboarding/step_3');
            },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingHeader(
            title: 'Jaki jest Twój aktualny poziom?',
            subtitle: 'Pomoże nam to dobrać odpowiednio trudne przepisy.',
          ),
          const SizedBox(height: 24),
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
