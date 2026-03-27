import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../../../shared/models/user_profile.dart';
import '../models/completed_node_data.dart';
import '../repositories/profile_repository.dart';

final userProfileLogicProvider = StreamProvider.autoDispose<UserProfile?>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  final userId = ref.watch(userIdProvider);
  if (userId == null) return Stream.value(null);

  return repository.watchUserProfile(userId);
});

final galleryNodesProvider = StreamProvider.autoDispose<List<CompletedNodeData>>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  final userId = ref.watch(userIdProvider);
  if (userId == null) return Stream.value([]);

  return repository.watchGalleryNodes(userId);
});

class ProfileActionViewModel extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> uploadMissingPhoto(String nodeId, File photoFile) async {
    final repository = ref.read(profileRepositoryProvider);
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    try {
      state = const AsyncValue.loading();
      await repository.uploadMealPhoto(
        userId: userId,
        nodeId: nodeId,
        photoFile: photoFile,
      );
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateAvatar(File photoFile) async {
    final repository = ref.read(profileRepositoryProvider);
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    try {
      state = const AsyncValue.loading();
      await repository.updateAvatar(
        userId: userId,
        photoFile: photoFile,
      );
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final profileActionProvider = AsyncNotifierProvider<ProfileActionViewModel, void>(
  () => ProfileActionViewModel(),
);
