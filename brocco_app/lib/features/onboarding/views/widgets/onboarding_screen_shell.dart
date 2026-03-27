import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/buttons/main_progress_bar.dart';
import '../../../../shared/widgets/buttons/main_back_text_button.dart';
import '../../../../../shared/widgets/buttons/primary_button.dart';

class OnboardingScreenShell extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;
  final Widget content;
  final String primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final bool scrollable;

  const OnboardingScreenShell({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.onBack,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (onBack != null) ...[
              OnboardingBackButton(onTap: onBack!),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: MainProgressBar(
                currentStep: currentStep,
                totalSteps: totalSteps,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24), // Odstęp między górnym paskiem a treścią
        // POPRAWKA 2: Jeśli ekran NIE jest scrollowalny, `content` musi być owinięty
        // w Expanded, co zastępuje poprzedniego Spacera(). Dzięki temu treść wypełni
        // dostępną przestrzeń i wypchnie przycisk na sam dół bez błędów układu.
        if (scrollable) content else Expanded(child: content),

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
