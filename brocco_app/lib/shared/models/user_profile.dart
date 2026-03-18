import 'package:isar/isar.dart';

part 'user_profile.g.dart';

@collection
class UserProfile {
  Id id = Isar.autoIncrement; // Wymóg Isara

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