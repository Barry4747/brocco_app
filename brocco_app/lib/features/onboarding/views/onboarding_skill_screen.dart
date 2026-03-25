import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/cards/selection_card_with_image.dart';
import '../../../../../shared/widgets/chips/selectable_option_chip.dart';
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
  // Stany dla wszystkich trzech wymaganych pól z tego kroku
  CookingSkill? _selectedSkill;
  UsageFrequency? _selectedFrequency;
  double _maxCookingTime = 30; // Domyślnie 30 minut

  @override
  Widget build(BuildContext context) {
    // Przycisk "Kontynuuj" jest aktywny tylko, gdy użytkownik wybierze poziom i częstotliwość
    final isFormValid = _selectedSkill != null && _selectedFrequency != null;

    return OnboardingScreenShell(
      currentStep: 1,
      totalSteps: 4,
      scrollable: true, // Zmienione na true!
      onBack: () => context.pop(),
      primaryButtonText: 'Kontynuuj',
      onPrimaryPressed: !isFormValid
          ? null
          : () {
              ref
                  .read(onboardingViewModelProvider.notifier)
                  .updateCookingProfile(
                    skill: _selectedSkill,
                    maxTime: _maxCookingTime.toInt(),
                    frequency: _selectedFrequency,
                  );
              context.push('/onboarding/step_2');
            },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. POZIOM ZAAWANSOWANIA
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

          const SizedBox(height: 40),

          // 2. CZĘSTOTLIWOŚĆ GOTOWANIA
          const Text(
            'Jak często gotujesz?',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SelectableOptionChip(
                label: 'Codziennie',
                isSelected: _selectedFrequency == UsageFrequency.everyday,
                onTap: () => setState(
                  () => _selectedFrequency = UsageFrequency.everyday,
                ),
              ),
              SelectableOptionChip(
                label: 'Kilka razy w tyg.',
                isSelected: _selectedFrequency == UsageFrequency.fewTimesAWeek,
                onTap: () => setState(
                  () => _selectedFrequency = UsageFrequency.fewTimesAWeek,
                ),
              ),
              SelectableOptionChip(
                label: 'Tylko w weekendy',
                isSelected: _selectedFrequency == UsageFrequency.weekends,
                onTap: () => setState(
                  () => _selectedFrequency = UsageFrequency.weekends,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // 3. MAKSYMALNY CZAS GOTOWANIA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ile masz czasu na posiłek?',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '${_maxCookingTime.toInt()} min',
                style: const TextStyle(
                  color: AppColors.accentGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.accentGreen,
              inactiveTrackColor: AppColors.accentGreen.withOpacity(0.2),
              thumbColor: AppColors.accentGreen,
              overlayColor: AppColors.accentGreen.withOpacity(0.1),
              trackHeight: 8.0,
              valueIndicatorTextStyle: const TextStyle(color: Colors.white),
            ),
            child: Slider(
              value: _maxCookingTime,
              min: 15,
              max: 120,
              divisions: 7, // (120-15)/15 = skoki co 15 minut
              label: '${_maxCookingTime.toInt()} min',
              onChanged: (value) => setState(() => _maxCookingTime = value),
            ),
          ),
        ],
      ),
    );
  }
}
