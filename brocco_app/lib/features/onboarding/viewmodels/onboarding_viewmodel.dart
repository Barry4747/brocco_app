import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../models/onboarding_data.dart';
import '../repositories/onboarding_repository.dart';

class OnboardingViewModel extends Notifier<OnboardingData> {
  @override
  OnboardingData build() {
    return const OnboardingData();
  }

  void updateCookingProfile({
    CookingSkill? skill,
    int? maxTime,
    UsageFrequency? frequency,
  }) {
    state = state.copyWith(
      cookingSkill: skill,
      maxCookingTimeMinutes: maxTime,
      usageFrequency: frequency,
    );
  }

  void updateTastes({
    List<String>? favoriteCuisines,
    EatingStyle? eatingStyle,
    List<String>? allergies,
    List<String>? dislikedIngredients,
  }) {
    state = state.copyWith(
      favoriteCuisines: favoriteCuisines,
      eatingStyle: eatingStyle,
      allergies: allergies,
      dislikedIngredients: dislikedIngredients,
    );
  }

  void updateBiometrics({
    MainGoal? mainGoal,
    Gender? gender,
    DateTime? birthDate,
    int? heightCm,
    double? currentWeightKg,
    double? targetWeightKg,
    ActivityLevel? activityLevel,
  }) {
    state = state.copyWith(
      mainGoal: mainGoal,
      gender: gender,
      birthDate: birthDate,
      heightCm: heightCm,
      currentWeightKg: currentWeightKg,
      targetWeightKg: targetWeightKg,
      activityLevel: activityLevel,
    );
  }

  Future<void> completeOnboarding() async {
    if (state.mainGoal == null) {
      throw Exception("Brakuje celu głównego. $state");
    }

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception("Użytkownik nie jest zalogowany.");
    }

    final repository = ref.read(onboardingRepositoryProvider);
    await repository.completeOnboarding(
      userId: user.id,
      data: state,
    );

    await ref.read(authViewModelProvider.notifier).refreshProfileState();
  }
}

final onboardingViewModelProvider =
    NotifierProvider<OnboardingViewModel, OnboardingData>(
  () => OnboardingViewModel(),
);

