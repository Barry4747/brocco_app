import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../../../core/local_db/isar_provider.dart';
import '../../../shared/models/user_profile.dart';
import '../models/onboarding_data.dart';

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

    await supabase.from('profiles').upsert({
      'id': user.id,
      'cooking_skill': state.cookingSkill?.name,
      'max_cooking_time_minutes': state.maxCookingTimeMinutes,
      'usage_frequency': state.usageFrequency?.name,
      'eating_style': state.eatingStyle?.name,
      'main_goal': state.mainGoal?.name,
      'gender': state.gender?.name,
      'birth_date': state.birthDate?.toIso8601String(),
      'height_cm': state.heightCm,
      'current_weight_kg': state.currentWeightKg,
      'target_weight_kg': state.targetWeightKg,
      'activity_level': state.activityLevel?.name,
    });

    for (final allergyName in state.allergies) {
      final res = await supabase
          .from('allergies')
          .select('id')
          .eq('name', allergyName)
          .maybeSingle();
      String? allergyId;
      if (res == null) {
        final inserted = await supabase
            .from('allergies')
            .insert({'name': allergyName})
            .select('id')
            .single();
        allergyId = inserted['id'] as String;
      } else {
        allergyId = res['id'] as String;
      }
      await supabase.from('profile_allergies').upsert({
        'profile_id': user.id,
        'allergy_id': allergyId,
      });
    }

    for (final cuisineName in state.favoriteCuisines) {
      final res = await supabase
          .from('cuisines')
          .select('id')
          .eq('name', cuisineName)
          .maybeSingle();
      String? cuisineId;
      if (res == null) {
        final inserted = await supabase
            .from('cuisines')
            .insert({'name': cuisineName})
            .select('id')
            .single();
        cuisineId = inserted['id'] as String;
      } else {
        cuisineId = res['id'] as String;
      }
      await supabase.from('profile_cuisines').upsert({
        'profile_id': user.id,
        'cuisine_id': cuisineId,
      });
    }

    final isar = ref.read(isarProvider);
    isar.writeTxnSync(() {
      var profile = isar.userProfiles.where().findFirstSync();
      if (profile != null) {
        profile.supabaseUserId = user.id;
        isar.userProfiles.putSync(profile);
      }
    });

    final freeCategories = await supabase
        .from('categories')
        .select('id')
        .eq('unlock_cost_stars', 0);

    for (final cat in (freeCategories as List)) {
      await supabase.from('user_unlocked_categories').upsert({
        'user_id': user.id,
        'category_id': cat['id'],
      });
    }

    await ref.read(authViewModelProvider.notifier).refreshProfileState();
  }
}

final onboardingViewModelProvider =
    NotifierProvider<OnboardingViewModel, OnboardingData>(
      () => OnboardingViewModel(),
    );

extension UserProfileMapper on UserProfile {
  OnboardingData toOnboardingData() {
    return OnboardingData(
      cookingSkill: cookingLevel != null 
          ? CookingSkill.values.asNameMap()[cookingLevel!] 
          : null,
      allergies: allergies ?? const [],
      eatingStyle: dietaryPreferences?.isNotEmpty == true
          ? EatingStyle.values.asNameMap()[dietaryPreferences!.first]
          : null,
    );
  }

  void updateFromOnboardingData(OnboardingData data) {
    cookingLevel = data.cookingSkill?.name;
    allergies = data.allergies.isNotEmpty ? data.allergies : null;
    dietaryPreferences = [
      if (data.eatingStyle != null) data.eatingStyle!.name,
      ...data.favoriteCuisines,
    ];
  }
}
