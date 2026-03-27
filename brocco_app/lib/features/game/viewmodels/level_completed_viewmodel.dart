import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../roadmap/repositories/roadmap_repository.dart';
import '../../profile/repositories/profile_repository.dart';
import '../../roadmap/viewmodels/roadmap_viewmodel.dart';
import '../../home/viewmodels/home_viewmodel.dart';

class LevelCompletedViewModel extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    return;
  }

  Future<void> uploadMealPhoto(
    String nodeId,
    String categoryId,
    File photoFile,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final profileRepository = ref.read(profileRepositoryProvider);

      await profileRepository.uploadMealPhoto(
        userId: userId,
        nodeId: nodeId,
        photoFile: photoFile,
      );

      ref.invalidate(roadmapViewModelProvider(categoryId));
      ref.invalidate(homeViewModelProvider);
    });
  }

  Future<void> completeLevel(String nodeId, String categoryId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) return;

      final roadmapRepository = ref.read(roadmapRepositoryProvider);

      await roadmapRepository.completeNode(
        userId: userId,
        nodeId: nodeId,
        categoryId: categoryId,
        starsEarned: 3,
        xpEarned: 150,
      );

      ref.invalidate(roadmapViewModelProvider(categoryId));
      ref.invalidate(homeViewModelProvider);
    });
  }
}

final levelCompletedViewModelProvider =
    AsyncNotifierProvider<LevelCompletedViewModel, void>(
      () => LevelCompletedViewModel(),
    );
