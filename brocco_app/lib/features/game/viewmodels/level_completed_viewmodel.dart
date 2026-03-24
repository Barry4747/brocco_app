import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:isar/isar.dart';
import '../../../core/local_db/isar_provider.dart';
import '../../roadmap/models/local/isar_completed_node.dart';
import '../../home/models/local/isar_unlocked_category.dart';
import '../../../shared/models/user_profile.dart';
import '../../roadmap/viewmodels/roadmap_viewmodel.dart';
import '../../home/viewmodels/home_viewmodel.dart';

import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class LevelCompletedViewModel extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    return;
  }

  Future<void> uploadMealPhoto(String nodeId, String categoryId, File photoFile) async {
    final isar = ref.read(isarProvider);
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) return;

    try {
      // 1. Compress image
      final targetPath = '${photoFile.absolute.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final XFile? compressedFile = await FlutterImageCompress.compressAndGetFile(
        photoFile.absolute.path,
        targetPath,
        quality: 70,
      );

      final uploadFile = compressedFile != null ? File(compressedFile.path) : photoFile;

      // 2. Upload to Supabase Storage -> 'meal_photos' bucket
      // File Path: ${userId}/${DateTime.now().millisecondsSinceEpoch}.jpg
      final fileName = '$userId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await supabase.storage.from('meal_photos').upload(fileName, uploadFile);

      // 3. Get public URL
      final imageUrl = supabase.storage.from('meal_photos').getPublicUrl(fileName);

      // 4. Optimistic UI: update IsarCompletedNode.imageUrl and Riverpod state
      await isar.writeTxn(() async {
        final completedNode = await isar.isarCompletedNodes
            .where()
            .userIdEqualToAnyNodeId(userId)
            .findAll()
            .then((nodes) => nodes.where((n) => n.nodeId == nodeId).firstOrNull);

        if (completedNode != null) {
          completedNode.imageUrl = imageUrl;
          await isar.isarCompletedNodes.put(completedNode);
        }

        final profile = await isar.userProfiles
            .where()
            .supabaseUserIdEqualTo(userId)
            .findFirst();

        if (profile != null) {
          profile.totalXp += 50;
          await isar.userProfiles.put(profile);
        }
      });

      ref.invalidate(roadmapViewModelProvider(categoryId));
      ref.invalidate(homeViewModelProvider);

      // 5. Async Sync: Send an UPDATE to the Supabase user_completed_nodes table
      await supabase.from('user_completed_nodes').update({
        'image_url': imageUrl,
      }).eq('user_id', userId).eq('node_id', nodeId);

      final profileResponse = await supabase
          .from('profiles')
          .select('total_xp')
          .eq('id', userId)
          .single();

      await supabase.from('profiles').update({
        'total_xp': (profileResponse['total_xp'] as int) + 50,
      }).eq('id', userId);

    } catch (e) {
      print('ERROR UPLOADING MEAL PHOTO: $e');
    }
  }

  Future<void> completeLevel(String nodeId, String categoryId) async {
    final isar = ref.read(isarProvider);
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) return;

    try {
      // 1. Check if already completed to prevent duplicate rewards
      final alreadyCompleted = await isar.isarCompletedNodes
          .where()
          .userIdEqualToAnyNodeId(userId)
          .findAll()
          .then((nodes) => nodes.where((n) => n.nodeId == nodeId).firstOrNull);

      if (alreadyCompleted != null) {
        return; // Already completed, do not double-reward
      }

      // 2. Optimistic local update
      await isar.writeTxn(() async {
        // Insert IsarCompletedNode
        final completedNode = IsarCompletedNode()
          ..userId = userId
          ..nodeId = nodeId
          ..starsEarned = 3;
        await isar.isarCompletedNodes.put(completedNode);

        // Update UserProfile stats
        final profile = await isar.userProfiles
            .where()
            .supabaseUserIdEqualTo(userId)
            .findFirst();

        if (profile != null) {
          profile.starsBank += 3; // 3 stars earned
          profile.totalXp += 150; // hardcoded +150 XP per user request
          await isar.userProfiles.put(profile);
        }

        // Update category completedNodesCount locally
        final unlockedCats = await isar.isarUnlockedCategorys
            .where()
            .userIdEqualToAnyCategoryId(userId)
            .findAll();
            
        var unlockedCat = unlockedCats
            .where((c) => c.categoryId == categoryId)
            .firstOrNull;

        if (unlockedCat != null) {
          unlockedCat.completedNodesCount += 1;
          await isar.isarUnlockedCategorys.put(unlockedCat);
        } else {
          final newCat = IsarUnlockedCategory()
            ..userId = userId
            ..categoryId = categoryId
            ..unlockedAt = DateTime.now().toUtc()
            ..completedNodesCount = 1;
          await isar.isarUnlockedCategorys.put(newCat);
        }
      });

      // 3. Supabase background update
      // Insert into user_completed_nodes
      await supabase.from('user_completed_nodes').upsert({
        'user_id': userId,
        'node_id': nodeId,
        'stars_earned': 3,
      });

      // Fetch profile and update it remotely
      final profileResponse = await supabase
          .from('profiles')
          .select('stars_bank, total_xp')
          .eq('id', userId)
          .single();

      await supabase.from('profiles').update({
        'stars_bank': (profileResponse['stars_bank'] as int) + 3,
        'total_xp': (profileResponse['total_xp'] as int) + 150,
      }).eq('id', userId);

      // Fetch user_unlocked_categories and update remote count
      final catResponse = await supabase
          .from('user_unlocked_categories')
          .select('completed_nodes_count')
          .eq('user_id', userId)
          .eq('category_id', categoryId)
          .maybeSingle();

      if (catResponse != null) {
        await supabase.from('user_unlocked_categories').update({
          'completed_nodes_count':
              (catResponse['completed_nodes_count'] as int) + 1,
        }).eq('user_id', userId).eq('category_id', categoryId);
      } else {
        await supabase.from('user_unlocked_categories').insert({
          'user_id': userId,
          'category_id': categoryId,
          'completed_nodes_count': 1,
          'unlocked_at': DateTime.now().toIso8601String(),
        });
      }

      // 4. Invalidate UI providers to reflect changes
      ref.invalidate(roadmapViewModelProvider(categoryId));
      ref.invalidate(homeViewModelProvider);
    } catch (e) {
      print('ERROR COMPLETING LEVEL: $e');
    }
  }
}

final levelCompletedViewModelProvider =
    AsyncNotifierProvider<LevelCompletedViewModel, void>(
  () => LevelCompletedViewModel(),
);
