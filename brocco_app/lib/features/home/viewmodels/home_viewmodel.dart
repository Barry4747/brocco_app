import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/local_db/isar_provider.dart';
import '../../../core/local_db/global_sync_service.dart';
import '../../../core/local_db/collections/isar_category.dart';
import '../../../core/local_db/collections/isar_unlocked_category.dart';
import '../../../shared/models/user_profile.dart';
import '../models/category.dart';

class HomeState {
  final List<Category> categories;
  final int currentStars;
  final Map<String, int> completedMeals;
  final Map<String, int> totalMeals;
  final Set<String> unlockedIds;

  const HomeState({
    this.categories = const [],
    this.currentStars = 0,
    this.completedMeals = const {},
    this.totalMeals = const {},
    this.unlockedIds = const {},
  });

  HomeState copyWith({
    List<Category>? categories,
    int? currentStars,
    Map<String, int>? completedMeals,
    Map<String, int>? totalMeals,
    Set<String>? unlockedIds,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      currentStars: currentStars ?? this.currentStars,
      completedMeals: completedMeals ?? this.completedMeals,
      totalMeals: totalMeals ?? this.totalMeals,
      unlockedIds: unlockedIds ?? this.unlockedIds,
    );
  }

  bool isCategoryLocked(Category cat) =>
      cat.unlockCostStars > 0 && !unlockedIds.contains(cat.id);

  int completedFor(String categoryId) => completedMeals[categoryId] ?? 0;

  int totalFor(String categoryId) => totalMeals[categoryId] ?? 0;
}

class HomeViewModel extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    final isar = ref.read(isarProvider);
    final userId = Supabase.instance.client.auth.currentUser?.id;

    final localState = await _readFromIsar(isar, userId);
    state = AsyncValue.data(localState);

    if (userId != null) {
      _syncInBackground(isar, userId);
    }

    return localState;
  }

  Future<HomeState> _readFromIsar(Isar isar, String? userId) async {
    final isarCats = await isar.isarCategorys.where().findAll();
    final categories = isarCats
        .where((c) => c.supabaseId != null)
        .map((c) => Category(
              id: c.supabaseId!,
              title: c.title ?? '',
              imageUrl: c.imageUrl,
              unlockCostStars: c.unlockCostStars,
              totalNodes: c.totalNodes,
            ))
        .toList()
      ..sort((a, b) => a.unlockCostStars.compareTo(b.unlockCostStars));

    int stars = 0;
    Set<String> unlockedIds = {};
    List<IsarUnlockedCategory> unlockedList = [];

    if (userId != null) {
      final profile = await isar.userProfiles
          .where()
          .supabaseUserIdEqualTo(userId)
          .findFirst();
      stars = profile?.starsBank ?? 0;

      unlockedList = await isar.isarUnlockedCategorys
          .where()
          .userIdEqualToAnyCategoryId(userId)
          .findAll();
      unlockedIds = unlockedList
          .where((u) => u.categoryId != null)
          .map((u) => u.categoryId!)
          .toSet();
    }

    final completed = <String, int>{};
    final totals = <String, int>{};
    for (final cat in categories) {
      totals[cat.id] = cat.totalNodes;

      final unlockedCat = unlockedList
          .where((u) => u.categoryId == cat.id)
          .firstOrNull;
      completed[cat.id] = unlockedCat?.completedNodesCount ?? 0;
    }

    return HomeState(
      categories: categories,
      currentStars: stars,
      completedMeals: completed,
      totalMeals: totals,
      unlockedIds: unlockedIds,
    );
  }

  Future<void> _syncInBackground(Isar isar, String userId) async {
    try {
      final syncService = ref.read(globalSyncServiceProvider);
      await syncService.syncAll(userId);

      final updatedState = await _readFromIsar(isar, userId);
      state = AsyncValue.data(updatedState);
    } catch (_) {}
  }

  Future<void> unlockCategory(String categoryId) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final cat = current.categories.firstWhere((c) => c.id == categoryId);
    if (current.currentStars < cat.unlockCostStars) return;

    final isar = ref.read(isarProvider);
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    state = AsyncValue.data(
      current.copyWith(
        currentStars: current.currentStars - cat.unlockCostStars,
        unlockedIds: {...current.unlockedIds, categoryId},
      ),
    );

    await isar.writeTxn(() async {
      final profile = await isar.userProfiles
          .where()
          .supabaseUserIdEqualTo(userId)
          .findFirst();
      if (profile != null) {
        profile.starsBank -= cat.unlockCostStars;
        await isar.userProfiles.put(profile);
      }

      final entry = IsarUnlockedCategory()
        ..userId = userId
        ..categoryId = categoryId
        ..unlockedAt = DateTime.now().toUtc();
      await isar.isarUnlockedCategorys.put(entry);
    });

    try {
      await Supabase.instance.client.rpc(
        'unlock_category_secure',
        params: {'target_category_id': categoryId},
      );
    } catch (_) {}
  }
}

final homeViewModelProvider = AsyncNotifierProvider<HomeViewModel, HomeState>(
  () => HomeViewModel(),
);
