import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/pills/multi_select_pill_group.dart';
import '../../../../../shared/widgets/pills/selectable_pill.dart';
import '../models/onboarding_data.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import '../viewmodels/onboarding_dictionaries_provider.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_screen_shell.dart';

class OnboardingStep4Screen extends ConsumerStatefulWidget {
  const OnboardingStep4Screen({super.key});

  @override
  ConsumerState<OnboardingStep4Screen> createState() =>
      _OnboardingStep4ScreenState();
}

class _OnboardingStep4ScreenState extends ConsumerState<OnboardingStep4Screen> {
  EatingStyle? _selectedEatingStyle;
  final List<String> _selectedCuisines = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final d = ref.read(onboardingViewModelProvider);
      if (!mounted) return;
      setState(() {
        _selectedEatingStyle = d.eatingStyle;
        _selectedCuisines
          ..clear()
          ..addAll(d.favoriteCuisines);
      });
    });
  }

  String _eatingStyleLabel(EatingStyle style) {
    switch (style) {
      case EatingStyle.omnivore:
        return 'Jem wszystko';
      case EatingStyle.flexitarian:
        return 'Mniej mięsa';
      case EatingStyle.vegetarian:
        return 'Wegetariańska';
      case EatingStyle.vegan:
        return 'Wegańska';
      case EatingStyle.pescatarian:
        return 'Tylko ryby';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFormValid = _selectedEatingStyle != null;

    return OnboardingScreenShell(
      currentStep: 4,
      totalSteps: 7,
      scrollable: true,
      onBack: () => context.pop(),
      primaryButtonText: 'Kontynuuj',
      onPrimaryPressed: !isFormValid
          ? null
          : () {
              ref.read(onboardingViewModelProvider.notifier).updateTastes(
                    eatingStyle: _selectedEatingStyle,
                    favoriteCuisines: List<String>.from(_selectedCuisines),
                  );
              context.push('/onboarding/step_5');
            },
      content: ref.watch(onboardingDictionariesProvider).when(
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text('Błąd ładowania słowników: $error'),
              ),
            ),
            data: (dictionaries) {
              final availableCuisines = dictionaries['cuisines'] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingHeader(
                    title: 'Styl i smaki',
                    subtitle:
                        'Dopasujemy przepisy do Twojego stylu i ulubionych kuchni.',
                  ),
                  const SizedBox(height: 32),
                  const _SectionTitle(title: 'Styl odżywiania'),
                  Wrap(
                    spacing: 10,
                    runSpacing: 12,
                    children: EatingStyle.values.map((style) {
                      return SelectablePill(
                        text: _eatingStyleLabel(style),
                        isSelected: _selectedEatingStyle == style,
                        onTap: () =>
                            setState(() => _selectedEatingStyle = style),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  const _SectionTitle(title: 'Ulubione kuchnie (opcjonalnie)'),
                  MultiSelectPillGroup(
                    items: availableCuisines,
                    selectedItems: _selectedCuisines,
                    onToggle: (item) {
                      setState(() {
                        if (_selectedCuisines.contains(item)) {
                          _selectedCuisines.remove(item);
                        } else {
                          _selectedCuisines.add(item);
                        }
                      });
                    },
                  ),
                ],
              );
            },
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
