import 'package:brocco_app/core/local_db/global_sync_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/onboarding_data.dart';

class OnboardingRepository {
  final SupabaseClient _supabase;
  final GlobalSyncService _syncService;

  OnboardingRepository(this._supabase, this._syncService);

  Future<void> completeOnboarding({
    required String userId,
    required OnboardingData data,
  }) async {
    try {
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

      if (data.allergies.isNotEmpty) {
        await Future.wait(
          data.allergies.map((allergyName) async {
            final res = await _supabase
                .from('allergies')
                .select('id')
                .eq('name', allergyName)
                .maybeSingle();
            String allergyId;
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
          }),
        );
      }

      if (data.favoriteCuisines.isNotEmpty) {
        await Future.wait(
          data.favoriteCuisines.map((cuisineName) async {
            final res = await _supabase
                .from('cuisines')
                .select('id')
                .eq('name', cuisineName)
                .maybeSingle();
            String cuisineId;
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
          }),
        );
      }

      final freeCategories = await _supabase
          .from('categories')
          .select('id')
          .eq('unlock_cost_stars', 0);

      if ((freeCategories as List).isNotEmpty) {
        final rowsToInsert = freeCategories
            .map((cat) => {'user_id': userId, 'category_id': cat['id']})
            .toList();
        await _supabase.from('user_unlocked_categories').upsert(rowsToInsert);
      }

      // Initialize default UX preferences
      await _supabase.from('user_ux_preferences').upsert({
        'user_id': userId,
        'keep_screen_on': true,
        'timer_alarms': true,
        'mascot_sounds': true,
      });

      await _syncService.syncAll(userId);
    } catch (e) {
      throw Exception(
        'Nie udało się zapisać profilu. Sprawdź połączenie z internetem.',
      );
    }
  }
}

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepository(
    Supabase.instance.client,
    ref.read(globalSyncServiceProvider),
  );
});
