import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../models/home_data.dart';
import '../repositories/home_repository.dart';

class HomeViewModel extends AsyncNotifier<HomeData> {
  @override
  Future<HomeData> build() async {
    final repository = ref.read(homeRepositoryProvider);
    final userId = ref.watch(userIdProvider);

    final localState = await repository.getHomeDataFromLocal(userId);
    state = AsyncValue.data(localState);

    if (userId != null) {
      _syncInBackground(repository, userId);
    }

    return localState;
  }

  Future<void> _syncInBackground(
    HomeRepository repository,
    String userId,
  ) async {
    try {
      final updatedState = await repository.syncAndGetHomeData(userId);
      state = AsyncValue.data(updatedState);
    } catch (_) {}
  }

  Future<void> unlockCategory(String categoryId) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final cat = current.categories.firstWhere((c) => c.id == categoryId);
    if (current.currentStars < cat.unlockCostStars) return;

    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    state = AsyncValue.data(
      current.copyWith(
        currentStars: current.currentStars - cat.unlockCostStars,
        unlockedIds: {...current.unlockedIds, categoryId},
      ),
    );

    final repository = ref.read(homeRepositoryProvider);
    await repository.unlockCategory(
      userId: userId,
      categoryId: categoryId,
      starsCost: cat.unlockCostStars,
    );
  }
}

final homeViewModelProvider = AsyncNotifierProvider<HomeViewModel, HomeData>(
  () => HomeViewModel(),
);
