import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_colors.dart';
import '../models/onboarding_data.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_screen_shell.dart';

class OnboardingStep6Screen extends ConsumerStatefulWidget {
  const OnboardingStep6Screen({super.key});

  @override
  ConsumerState<OnboardingStep6Screen> createState() =>
      _OnboardingStep6ScreenState();
}

class _OnboardingStep6ScreenState extends ConsumerState<OnboardingStep6Screen> {
  Gender? _selectedGender;
  final _heightController = TextEditingController();
  DateTime? _birthDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final d = ref.read(onboardingViewModelProvider);
      if (!mounted) return;
      setState(() {
        _selectedGender = d.gender;
        _birthDate = d.birthDate;
        if (d.heightCm != null) {
          _heightController.text = '${d.heightCm}';
        }
      });
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
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

  bool get _canProceed =>
      _selectedGender != null &&
      _birthDate != null &&
      _heightController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: OnboardingScreenShell(
        currentStep: 6,
        totalSteps: 7,
        onBack: () => context.pop(),
        scrollable: true,
        primaryButtonText: 'Kontynuuj',
        onPrimaryPressed: !_canProceed
            ? null
            : () {
                final height = int.tryParse(_heightController.text.trim());
                if (height == null || height < 50 || height > 250) {
                  _showError('Podano nieprawidłowy wzrost (50 - 250 cm).');
                  return;
                }

                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                if (_birthDate == null || !_birthDate!.isBefore(today)) {
                  _showError('Data urodzenia musi być z przeszłości.');
                  return;
                }

                ref.read(onboardingViewModelProvider.notifier).updateBiometrics(
                      gender: _selectedGender,
                      birthDate: _birthDate,
                      heightCm: height,
                    );
                context.push('/onboarding/step_7');
              },
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const OnboardingHeader(
              title: 'O Tobie',
              subtitle:
                  'Podstawowe dane pomogą nam dopasować plan żywieniowy.',
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
            _BiometricField(
              label: 'Wzrost (cm)',
              controller: _heightController,
              onChanged: () => setState(() {}),
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
