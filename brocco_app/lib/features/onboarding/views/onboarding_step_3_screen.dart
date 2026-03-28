import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/pills/selectable_pill.dart';
import '../models/onboarding_data.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_screen_shell.dart';

class OnboardingStep3Screen extends ConsumerStatefulWidget {
  const OnboardingStep3Screen({super.key});

  @override
  ConsumerState<OnboardingStep3Screen> createState() =>
      _OnboardingStep3ScreenState();
}

class _OnboardingStep3ScreenState extends ConsumerState<OnboardingStep3Screen> {
  static const List<int> _timeMinutesOptions = [15, 30, 45, 60, 90, 120];

  int? _selectedTimeMinutes;
  UsageFrequency? _selectedFrequency;

  static int _nearestTimeOption(int? minutes) {
    if (minutes == null) return 30;
    return _timeMinutesOptions.reduce(
      (a, b) => (a - minutes).abs() <= (b - minutes).abs() ? a : b,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final d = ref.read(onboardingViewModelProvider);
      if (!mounted) return;
      setState(() {
        _selectedTimeMinutes = _nearestTimeOption(d.maxCookingTimeMinutes);
        _selectedFrequency = d.usageFrequency;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isFormValid =
        _selectedTimeMinutes != null && _selectedFrequency != null;

    return OnboardingScreenShell(
      currentStep: 3,
      totalSteps: 7,
      scrollable: true,
      onBack: () => context.pop(),
      primaryButtonText: 'Kontynuuj',
      onPrimaryPressed: !isFormValid
          ? null
          : () {
              ref.read(onboardingViewModelProvider.notifier).updateCookingProfile(
                    maxTime: _selectedTimeMinutes,
                    frequency: _selectedFrequency,
                  );
              context.push('/onboarding/step_4');
            },
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OnboardingHeader(
            title: 'Nawyki i czas',
            subtitle:
                'Powiedz nam, jak często gotujesz i ile czasu możesz poświęcić.',
          ),
          const SizedBox(height: 32),
          const _SectionTitle(title: 'Ile masz czasu na posiłek?'),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: _timeMinutesOptions.map((m) {
              return SelectablePill(
                text: '$m min',
                isSelected: _selectedTimeMinutes == m,
                onTap: () => setState(() => _selectedTimeMinutes = m),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          const _SectionTitle(title: 'Jak często gotujesz?'),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children: [
              SelectablePill(
                text: 'Codziennie',
                isSelected: _selectedFrequency == UsageFrequency.everyday,
                onTap: () => setState(
                  () => _selectedFrequency = UsageFrequency.everyday,
                ),
              ),
              SelectablePill(
                text: 'Kilka razy w tyg.',
                isSelected: _selectedFrequency == UsageFrequency.fewTimesAWeek,
                onTap: () => setState(
                  () => _selectedFrequency = UsageFrequency.fewTimesAWeek,
                ),
              ),
              SelectablePill(
                text: 'Tylko w weekendy',
                isSelected: _selectedFrequency == UsageFrequency.weekends,
                onTap: () => setState(
                  () => _selectedFrequency = UsageFrequency.weekends,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
