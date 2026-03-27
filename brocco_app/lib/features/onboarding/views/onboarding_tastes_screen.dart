import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/chips/selectable_option_chip.dart';
import '../../../../../shared/widgets/pills/multi_select_pill_group.dart';
import '../models/onboarding_data.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import '../viewmodels/onboarding_dictionaries_provider.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_screen_shell.dart';
import 'widgets/cuisine_dropdown_field.dart';
import 'widgets/ingredient_search_field.dart';

class OnboardingTastesScreen extends ConsumerStatefulWidget {
  const OnboardingTastesScreen({super.key});

  @override
  ConsumerState<OnboardingTastesScreen> createState() =>
      _OnboardingTastesScreenState();
}

class _OnboardingTastesScreenState
    extends ConsumerState<OnboardingTastesScreen> {
  EatingStyle? _selectedEatingStyle;

  final List<String> _selectedAllergies = [];

  final List<String> _selectedCuisines = [];

  final List<String> _selectedDisliked = [];

  void _toggleMultiSelect(String item, List<String> list) {
    setState(() {
      if (item == 'Brak') {
        list.clear();
        list.add('Brak');
        return;
      }

      if (list.contains('Brak')) {
        list.remove('Brak');
      }

      if (list.contains(item)) {
        list.remove(item);
      } else {
        list.add(item);
      }
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
      currentStep: 2,
      totalSteps: 4,
      scrollable: true,
      onBack: () => context.pop(),
      primaryButtonText: 'Kontynuuj',
      onPrimaryPressed: !isFormValid
          ? null
          : () {
              final allergies = _selectedAllergies
                  .where((e) => e != 'Brak')
                  .toList();
              final disliked = _selectedDisliked
                  .where((e) => e != 'Brak')
                  .toList();

              ref
                  .read(onboardingViewModelProvider.notifier)
                  .updateTastes(
                    eatingStyle: _selectedEatingStyle,
                    allergies: allergies,
                    favoriteCuisines: _selectedCuisines,
                    dislikedIngredients: disliked,
                  );
              context.push('/onboarding/step_3');
            },
      content: ref
          .watch(onboardingDictionariesProvider)
          .when(
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
              final availableAllergies = dictionaries['allergies'] ?? [];
              final availableCuisines = dictionaries['cuisines'] ?? [];
              final availableDisliked = dictionaries['ingredients'] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingHeader(
                    title: 'Zasady w Twojej kuchni?',
                    subtitle:
                        'Wybierz swój styl odżywiania oraz to, czego unikasz.',
                  ),
                  const SizedBox(height: 32),

                  const _SectionTitle(title: 'Główny styl odżywiania'),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: EatingStyle.values.map((style) {
                      return SelectableOptionChip(
                        label: _eatingStyleLabel(style),
                        isSelected: _selectedEatingStyle == style,
                        onTap: () =>
                            setState(() => _selectedEatingStyle = style),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 32),

                  const _SectionTitle(title: 'Czego nie lubisz? (opcjonalnie)'),
                  IngredientSearchField(
                    availableIngredients: availableDisliked,
                    selectedIngredients: _selectedDisliked,
                    onToggle: (item) =>
                        _toggleMultiSelect(item, _selectedDisliked),
                  ),

                  const SizedBox(height: 32),

                  const _SectionTitle(title: 'Alergie i nietolerancje'),
                  MultiSelectPillGroup(
                    items: availableAllergies,
                    selectedItems: _selectedAllergies,
                    onToggle: (item) =>
                        _toggleMultiSelect(item, _selectedAllergies),
                  ),

                  const SizedBox(height: 32),

                  const _SectionTitle(title: 'Ulubione kuchnie (opcjonalnie)'),
                  CuisineDropdownField(
                    availableCuisines: availableCuisines,
                    selectedCuisines: _selectedCuisines,
                    onToggle: (item) =>
                        _toggleMultiSelect(item, _selectedCuisines),
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
