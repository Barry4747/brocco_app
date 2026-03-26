import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../models/user_ux_preferences.dart';
import '../repositories/settings_repository.dart';

final settingsViewModelProvider = StreamProvider.autoDispose<UserUxPreferences?>((ref) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) return Stream.value(null);

  final repository = ref.watch(settingsRepositoryProvider);
  return repository.watchPreferences(userId);
});

class SettingsActionViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<void> updatePreference(String key, bool value) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    final repository = ref.read(settingsRepositoryProvider);
    
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => 
      repository.updatePreference(userId: userId, key: key, value: value)
    );
  }
}

final settingsActionProvider = AsyncNotifierProvider<SettingsActionViewModel, void>(
  () => SettingsActionViewModel(),
);
