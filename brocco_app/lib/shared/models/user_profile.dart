import '../../features/profile/repositories/dtos/isar_profile.dart';

class UserProfile {
  final String? supabaseUserId;
  final String? username;
  final String? avatarUrl;
  final String? cookingLevel;
  final List<String> dietaryPreferences;
  final List<String> allergies;
  final int starsBank;
  final int totalXp;
  final int currentStreak;

  UserProfile({
    this.supabaseUserId,
    this.username,
    this.avatarUrl,
    this.cookingLevel,
    this.dietaryPreferences = const [],
    this.allergies = const [],
    this.starsBank = 0,
    this.totalXp = 0,
    this.currentStreak = 0,
  });

  factory UserProfile.fromIsar(IsarProfile isar) {
    return UserProfile(
      supabaseUserId: isar.supabaseUserId,
      username: isar.username,
      avatarUrl: isar.avatarUrl,
      cookingLevel: isar.cookingLevel,
      dietaryPreferences: isar.dietaryPreferences ?? [],
      allergies: isar.allergies ?? [],
      starsBank: isar.starsBank,
      totalXp: isar.totalXp,
      currentStreak: isar.currentStreak,
    );
  }
}
