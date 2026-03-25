import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/chips/selectable_option_chip.dart'; // Stworzony w poprzednim kroku
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
  // 1. Styl odżywiania (Pojedynczy wybór, wymagane)
  EatingStyle? _selectedEatingStyle;

  // 2. Alergie / Nietolerancje (Wielokrotny wybór)
  final List<String> _selectedAllergies = [];

  // 3. Ulubione kuchnie (Wielokrotny wybór)
  final List<String> _selectedCuisines = [];

  // 4. Nielubiane składniki (Wielokrotny wybór)
  final List<String> _selectedDisliked = [];

  // Uniwersalna metoda do przełączania elementów wielokrotnego wyboru (z logiką dla opcji "Brak")
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

  // Mapowanie enum na czytelny tekst dla polskiego użytkownika
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
    // Odblokowujemy "Kontynuuj" gdy użytkownik wybierze podstawową dietę (resztę może pominąć)
    final isFormValid = _selectedEatingStyle != null;

    return OnboardingScreenShell(
      currentStep: 2,
      totalSteps: 4,
      scrollable: true, // Wymagane, bo lista jest długa
      onBack: () => context.pop(),
      primaryButtonText: 'Kontynuuj',
      onPrimaryPressed: !isFormValid
          ? null
          : () {
              // Czyścimy "Brak" przed wysłaniem do ViewModelu
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
          final availableAllergies = dictionaries['allergies'] ?? [];
          final availableCuisines = dictionaries['cuisines'] ?? [];
          final availableDisliked = dictionaries['ingredients'] ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingHeader(
                title: 'Zasady w Twojej kuchni?',
                subtitle: 'Wybierz swój styl odżywiania oraz to, czego unikasz.',
              ),
              const SizedBox(height: 32),

              // --- SEKCJA 1: Styl odżywiania ---
              const _SectionTitle(title: 'Główny styl odżywiania'),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: EatingStyle.values.map((style) {
                  return SelectableOptionChip(
                    label: _eatingStyleLabel(style),
                    isSelected: _selectedEatingStyle == style,
                    onTap: () => setState(() => _selectedEatingStyle = style),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32),

              // --- SEKCJA 2: Nielubiane składniki ---
              const _SectionTitle(title: 'Czego nie lubisz? (opcjonalnie)'),
              IngredientSearchField(
                availableIngredients: availableDisliked,
                selectedIngredients: _selectedDisliked,
                onToggle: (item) => _toggleMultiSelect(item, _selectedDisliked),
              ),

              const SizedBox(height: 32),

              // --- SEKCJA 3: Alergie ---
              const _SectionTitle(title: 'Alergie i nietolerancje'),
              MultiSelectPillGroup(
                items: availableAllergies,
                selectedItems: _selectedAllergies,
                onToggle: (item) => _toggleMultiSelect(item, _selectedAllergies),
              ),

              const SizedBox(height: 32),

              // --- SEKCJA 4: Ulubione Kuchnie ---
              const _SectionTitle(title: 'Ulubione kuchnie (opcjonalnie)'),
              CuisineDropdownField(
                availableCuisines: availableCuisines,
                selectedCuisines: _selectedCuisines,
                onToggle: (item) => _toggleMultiSelect(item, _selectedCuisines),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Mały widget tekstowy, by zachować spójność tytułów sekcji i czystość w kodzie.
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
