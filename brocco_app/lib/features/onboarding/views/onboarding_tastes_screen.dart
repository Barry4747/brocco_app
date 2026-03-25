import 'package:brocco_app/shared/widgets/pills/selectable_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_screen_shell.dart';

class OnboardingTastesScreen extends ConsumerStatefulWidget {
  const OnboardingTastesScreen({super.key});

  @override
  ConsumerState<OnboardingTastesScreen> createState() => _OnboardingTastesScreenState();
}

class _OnboardingTastesScreenState extends ConsumerState<OnboardingTastesScreen> {
  final List<String> _selectedRules = [];
  final List<String> _availableRules = ['Vegan', 'Keto', 'Bez glutenu', 'Brak'];

  void _toggleRule(String rule) {
    setState(() {
      if (rule == 'Brak') {
        _selectedRules.clear();
        _selectedRules.add('Brak');
        return;
      }
      if (_selectedRules.contains('Brak')) {
        _selectedRules.remove('Brak');
      }
      if (_selectedRules.contains(rule)) {
        _selectedRules.remove(rule);
      } else {
        _selectedRules.add(rule);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenShell(
      currentStep: 2,
      totalSteps: 4,
      onBack: () => context.pop(),
      primaryButtonText: 'Kontynuuj',
      onPrimaryPressed: _selectedRules.isEmpty
          ? null
          : () {
              ref.read(onboardingViewModelProvider.notifier).updateTastes(
                    allergies: _selectedRules,
                  );
              context.push('/onboarding/step_3');
            },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingHeader(
            title: 'Zasady w Twojej kuchni?',
            subtitle: 'Wybierz wszystkie pasujące. Możesz to zmienić później.',
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 12,
            runSpacing: 16,
            children: _availableRules.map((rule) {
              return SelectablePill(
                text: rule,
                isSelected: _selectedRules.contains(rule),
                onTap: () => _toggleRule(rule),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}