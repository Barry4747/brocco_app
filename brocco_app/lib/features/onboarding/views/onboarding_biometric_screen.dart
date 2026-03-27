import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_colors.dart';
import '../models/onboarding_data.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_screen_shell.dart';

class OnboardingBiometricsScreen extends ConsumerStatefulWidget {
  const OnboardingBiometricsScreen({super.key});

  @override
  ConsumerState<OnboardingBiometricsScreen> createState() =>
      _OnboardingBiometricsScreenState();
}

class _OnboardingBiometricsScreenState
    extends ConsumerState<OnboardingBiometricsScreen> {
  Gender? _selectedGender;
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  DateTime? _birthDate;
  ActivityLevel _activityLevel = ActivityLevel.moderate;

  bool _isLoading = false;

  bool _canProceed(bool showTargetWeight) {
    return _selectedGender != null &&
        _birthDate != null &&
        _heightController.text.trim().isNotEmpty &&
        _weightController.text.trim().isNotEmpty &&
        (!showTargetWeight || _targetWeightController.text.trim().isNotEmpty);
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.accentGreen,
              onPrimary: Colors.white,
              onSurface: AppColors.primaryText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final onboardingData = ref.watch(onboardingViewModelProvider);
    final showTargetWeight =
        onboardingData.mainGoal == MainGoal.loseWeight ||
        onboardingData.mainGoal == MainGoal.buildMuscle;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: OnboardingScreenShell(
        currentStep: 4,
        totalSteps: 4,
        onBack: () => context.pop(),
        scrollable: true,
        primaryButtonText: _isLoading ? 'Zapisywanie...' : 'Zakończ i oblicz',
        onPrimaryPressed: !_canProceed(showTargetWeight) || _isLoading
            ? null
            : () async {
                final height = int.tryParse(_heightController.text.trim());
                if (height == null || height < 50 || height > 250) {
                  _showError('Podano nieprawidłowy wzrost (50 - 250 cm).');
                  return;
                }

                final weight = double.tryParse(
                  _weightController.text.replaceAll(',', '.').trim(),
                );
                if (weight == null || weight < 20 || weight > 300) {
                  _showError('Podano nieprawidłową wagę (20 - 300 kg).');
                  return;
                }

                double? targetWeight;
                if (showTargetWeight) {
                  targetWeight = double.tryParse(
                    _targetWeightController.text.replaceAll(',', '.').trim(),
                  );
                  if (targetWeight == null ||
                      targetWeight < 20 ||
                      targetWeight > 300) {
                    _showError(
                      'Podano nieprawidłową wagę docelową (20 - 300 kg).',
                    );
                    return;
                  }
                }

                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                if (_birthDate == null || !_birthDate!.isBefore(today)) {
                  _showError('Data urodzenia musi być z przeszłości.');
                  return;
                }

                setState(() => _isLoading = true);

                ref
                    .read(onboardingViewModelProvider.notifier)
                    .updateBiometrics(
                      gender: _selectedGender,
                      birthDate: _birthDate,
                      heightCm: int.tryParse(_heightController.text),
                      currentWeightKg: double.tryParse(
                        _weightController.text.replaceAll(',', '.'),
                      ),
                      targetWeightKg: double.tryParse(
                        _targetWeightController.text.replaceAll(',', '.'),
                      ),
                      activityLevel: _activityLevel,
                    );
                try {
                  await ref
                      .read(onboardingViewModelProvider.notifier)
                      .completeOnboarding();
                  if (context.mounted) {
                    context.go('/');
                  }
                } catch (e) {
                  setState(() => _isLoading = false);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                }
              },
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OnboardingHeader(
              title: 'Ostatnie szlify!',
              subtitle: 'Te dane pozwolą nam wyliczyć Twój profil kaloryczny.',
            ),
            const SizedBox(height: 32),

            const _Label('Płeć'),
            SegmentedButton<Gender>(
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: AppColors.accentGreen.withOpacity(0.2),
                selectedForegroundColor: AppColors.accentGreen,
                side: const BorderSide(color: AppColors.accentGreen),
              ),
              segments: const [
                ButtonSegment(value: Gender.female, label: Text('Kobieta')),
                ButtonSegment(value: Gender.male, label: Text('Mężczyzna')),
                ButtonSegment(value: Gender.other, label: Text('Inna')),
              ],
              selected: _selectedGender != null
                  ? {_selectedGender!}
                  : <Gender>{},
              emptySelectionAllowed: true,
              showSelectedIcon: false,
              onSelectionChanged: (Set<Gender> newSelection) {
                if (newSelection.isNotEmpty) {
                  setState(() => _selectedGender = newSelection.first);
                }
              },
            ),
            const SizedBox(height: 24),

            const _Label('Data urodzenia'),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.greyText.withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryText.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _birthDate == null
                          ? 'Wybierz datę'
                          : DateFormat('dd.MM.yyyy').format(_birthDate!),
                      style: TextStyle(
                        color: _birthDate == null
                            ? AppColors.greyText
                            : AppColors.primaryText,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      Icons.calendar_today,
                      color: AppColors.accentGreen,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _BiometricField(
                    label: 'Wzrost (cm)',
                    controller: _heightController,
                    onChanged: () => setState(() {}),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _BiometricField(
                    label: 'Waga (kg)',
                    controller: _weightController,
                    onChanged: () => setState(() {}),
                  ),
                ),
              ],
            ),

            if (showTargetWeight) ...[
              const SizedBox(height: 16),
              _BiometricField(
                label: 'Waga docelowa (kg)',
                controller: _targetWeightController,
                onChanged: () => setState(() {}),
              ),
            ],

            const SizedBox(height: 24),

            const _Label('Aktywność fizyczna'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.greyText.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryText.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ActivityLevel>(
                  value: _activityLevel,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.accentGreen,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: ActivityLevel.sedentary,
                      child: Text('Niska (Praca siedząca)'),
                    ),
                    DropdownMenuItem(
                      value: ActivityLevel.moderate,
                      child: Text('Umiarkowana (Spacery, rekreacja)'),
                    ),
                    DropdownMenuItem(
                      value: ActivityLevel.active,
                      child: Text('Wysoka (Regularne treningi)'),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _activityLevel = val);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class _BiometricField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onChanged;

  const _BiometricField({
    required this.label,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (_) => onChanged(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.greyText, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.greyText.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.greyText.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.accentGreen, width: 2),
        ),
      ),
    );
  }
}
