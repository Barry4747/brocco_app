import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/local_db/isar_provider.dart';
import '../../profile/repositories/dtos/isar_profile.dart';
import '../models/onboarding_data.dart';

class OnboardingRepository {
  final Isar _isar;
  final SupabaseClient _supabase;

  OnboardingRepository(this._isar, this._supabase);

  Future<void> completeOnboarding({
    required String userId,
    required OnboardingData data,
  }) async {
    // 1. Upsert profile in Supabase
    await _supabase.from('profiles').upsert({
      'id': userId,
      'cooking_skill': data.cookingSkill?.name,
      'max_cooking_time_minutes': data.maxCookingTimeMinutes,
      'usage_frequency': data.usageFrequency?.name,
      'eating_style': data.eatingStyle?.name,
      'main_goal': data.mainGoal?.name,
      'gender': data.gender?.name,
      'birth_date': data.birthDate?.toIso8601String(),
      'height_cm': data.heightCm,
      'current_weight_kg': data.currentWeightKg,
      'target_weight_kg': data.targetWeightKg,
      'activity_level': data.activityLevel?.name,
    });

    // 2. Handle allergies
    for (final allergyName in data.allergies) {
      final res = await _supabase
          .from('allergies')
          .select('id')
          .eq('name', allergyName)
          .maybeSingle();

      String? allergyId;
      if (res == null) {
        final inserted = await _supabase
            .from('allergies')
            .insert({'name': allergyName})
            .select('id')
            .single();
        allergyId = inserted['id'] as String;
      } else {
        allergyId = res['id'] as String;
      }
      await _supabase.from('profile_allergies').upsert({
        'profile_id': userId,
        'allergy_id': allergyId,
      });
    }

    // 3. Handle cuisines
    for (final cuisineName in data.favoriteCuisines) {
      final res = await _supabase
          .from('cuisines')
          .select('id')
          .eq('name', cuisineName)
          .maybeSingle();

      String? cuisineId;
      if (res == null) {
        final inserted = await _supabase
            .from('cuisines')
            .insert({'name': cuisineName})
            .select('id')
            .single();
        cuisineId = inserted['id'] as String;
      } else {
        cuisineId = res['id'] as String;
      }
      await _supabase.from('profile_cuisines').upsert({
        'profile_id': userId,
        'cuisine_id': cuisineId,
      });
    }

    // 4. Unlock free categories
    final freeCategories = await _supabase
        .from('categories')
        .select('id')
        .eq('unlock_cost_stars', 0);

    for (final cat in (freeCategories as List)) {
      await _supabase.from('user_unlocked_categories').upsert({
        'user_id': userId,
        'category_id': cat['id'],
      });
    }

    // 5. Update local Isar profile
    _isar.writeTxnSync(() {
      var profile = _isar.isarProfiles.where().findFirstSync();
      if (profile != null) {
        profile.supabaseUserId = userId;
        _isar.isarProfiles.putSync(profile);
      }
    });
  }
}

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepository(
    ref.read(isarProvider),
    Supabase.instance.client,
  );
});
