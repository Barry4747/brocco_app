import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/onboarding_data.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_screen_shell.dart';

class OnboardingBiometricsScreen extends ConsumerStatefulWidget {
  const OnboardingBiometricsScreen({super.key});

  @override
  ConsumerState<OnboardingBiometricsScreen> createState() => _OnboardingBiometricsScreenState();
}

class _OnboardingBiometricsScreenState extends ConsumerState<OnboardingBiometricsScreen> {
  Gender? _selectedGender;
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  ActivityLevel _activityLevel = ActivityLevel.moderate;

  bool get _canProceed =>
      _selectedGender != null &&
      _heightController.text.isNotEmpty &&
      _weightController.text.isNotEmpty;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenShell(
      currentStep: 4,
      totalSteps: 4,
      onBack: () => context.pop(),
      scrollable: true,
      primaryButtonText: 'Zakończ i oblicz',
      onPrimaryPressed: _canProceed
          ? () async {
              ref.read(onboardingViewModelProvider.notifier).updateBiometrics(
                    gender: _selectedGender,
                    heightCm: int.tryParse(_heightController.text),
                    currentWeightKg: double.tryParse(_weightController.text),
                    activityLevel: _activityLevel,
                  );
              try {
                await ref.read(onboardingViewModelProvider.notifier).completeOnboarding();
                if (context.mounted) {
                  context.go('/');
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Błąd: $e')));
                }
              }
            }
          : null,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingHeader(
            title: 'Ostatnie szlify!',
            subtitle: 'Te dane pozwolą nam idealnie dopasować wielkość porcji do Twojego organizmu.',
          ),
          const SizedBox(height: 40),

          // Gender
          const Text('Płeć', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          SegmentedButton<Gender>(
            segments: const [
              ButtonSegment(value: Gender.female, label: Text('Kobieta')),
              ButtonSegment(value: Gender.male, label: Text('Mężczyzna')),
            ],
            selected: _selectedGender != null ? {_selectedGender!} : <Gender>{},
            emptySelectionAllowed: true,
            onSelectionChanged: (Set<Gender> newSelection) {
              if (newSelection.isNotEmpty) {
                setState(() => _selectedGender = newSelection.first);
              }
            },
          ),
          const SizedBox(height: 24),

          // Height & Weight
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Wzrost (cm)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Waga (kg)',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Activity Level
          const Text('Aktywność fizyczna',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ActivityLevel>(
                value: _activityLevel,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                      value: ActivityLevel.sedentary,
                      child: Text('Niska (Praca siedząca)')),
                  DropdownMenuItem(
                      value: ActivityLevel.moderate,
                      child: Text('Umiarkowana (Spacery, rekreacja)')),
                  DropdownMenuItem(
                      value: ActivityLevel.active,
                      child: Text('Wysoka (Regularne treningi)')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _activityLevel = val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}