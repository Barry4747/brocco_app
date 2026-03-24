import 'package:isar/isar.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/local_db/isar_provider.dart';

part 'user_profile.g.dart';

final userProfileStreamProvider = StreamProvider<UserProfile?>((ref) {
  final isar = ref.watch(isarProvider);
  final userId = Supabase.instance.client.auth.currentUser?.id;
  if (userId == null) return Stream.value(null);

  final query = isar.userProfiles.where().supabaseUserIdEqualTo(userId);
  return query.watch(fireImmediately: true).map((results) => results.firstOrNull);
});

@collection
class UserProfile {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? supabaseUserId;

  String? username;
  String? avatarUrl;

  String? cookingLevel;
  List<String>? dietaryPreferences;
  List<String>? allergies;

  int starsBank = 0;
  int totalXp = 0;
  int currentStreak = 0;
}
