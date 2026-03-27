import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../models/roadmap_data.dart';
import '../repositories/roadmap_repository.dart';

class RoadmapViewModel extends FamilyAsyncNotifier<RoadmapData, String> {
  @override
  Future<RoadmapData> build(String categoryId) async {
    final repository = ref.read(roadmapRepositoryProvider);
    final userId = ref.watch(userIdProvider);

    final localState = await repository.getRoadmapDataFromLocal(
      userId,
      categoryId,
    );
    state = AsyncValue.data(localState);

    if (userId != null) {
      _syncInBackground(repository, userId, categoryId);
    }

    return localState;
  }

  Future<void> _syncInBackground(
    RoadmapRepository repository,
    String userId,
    String categoryId,
  ) async {
    try {
      final updatedState = await repository.syncAndGetRoadmapData(
        userId,
        categoryId,
      );
      state = AsyncValue.data(updatedState);
    } catch (_) {}
  }
}

final roadmapViewModelProvider =
    AsyncNotifierProvider.family<RoadmapViewModel, RoadmapData, String>(
      () => RoadmapViewModel(),
    );
