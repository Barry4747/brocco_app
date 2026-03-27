import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/local_db/isar_provider.dart';
import '../models/user_ux_preferences.dart';
import 'dtos/isar_user_ux_preferences.dart';

class SettingsRepository {
  final Isar _isar;
  final SupabaseClient _supabase;

  SettingsRepository(this._isar, this._supabase);

  Stream<UserUxPreferences?> watchPreferences(String userId) {
    return _isar.isarUserUxPreferences
        .where()
        .userIdEqualTo(userId)
        .watch(fireImmediately: true)
        .map((results) {
          if (results.isEmpty) return null;
          final isar = results.first;
          return UserUxPreferences(
            userId: isar.userId ?? '',
            keepScreenOn: isar.keepScreenOn,
            timerAlarms: isar.timerAlarms,
            mascotSounds: isar.mascotSounds,
          );
        });
  }

  Future<void> updatePreference({
    required String userId,
    required String key,
    required bool value,
  }) async {
    await _supabase
        .from('user_ux_preferences')
        .update({key: value, 'updated_at': DateTime.now().toIso8601String()})
        .eq('user_id', userId);

    await _isar.writeTxn(() async {
      final isar = await _isar.isarUserUxPreferences
          .where()
          .userIdEqualTo(userId)
          .findFirst();
      if (isar != null) {
        if (key == 'keep_screen_on') isar.keepScreenOn = value;
        if (key == 'timer_alarms') isar.timerAlarms = value;
        if (key == 'mascot_sounds') isar.mascotSounds = value;
        await _isar.isarUserUxPreferences.put(isar);
      }
    });
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return SettingsRepository(isar, Supabase.instance.client);
});
