import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/buttons/main_progress_bar.dart';
import 'onboarding_back_button.dart';
import '../../../../../shared/widgets/buttons/primary_button.dart';

/// Wspólna otoczka dla wszystkich ekranów onboardingu.
/// Zapewnia spójny układ: back button → progress bar → content → button.
class OnboardingScreenShell extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onBack;
  final Widget content;
  final String primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final bool scrollable;

  const OnboardingScreenShell({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onBack,
    required this.content,
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final inner = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnboardingBackButton(onTap: onBack),
        const SizedBox(height: 24),
        MainProgressBar(currentStep: currentStep, totalSteps: totalSteps),
        const SizedBox(height: 40),
        content,
        if (!scrollable) const Spacer(),
        if (scrollable) const SizedBox(height: 40),
        PrimaryButton(text: primaryButtonText, onPressed: onPrimaryPressed),
        const SizedBox(height: 24),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: scrollable
            ? SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: inner,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: inner,
              ),
      ),
    );
  }
}
