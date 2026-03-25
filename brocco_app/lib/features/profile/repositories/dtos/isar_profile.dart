import 'package:isar/isar.dart';

part 'isar_profile.g.dart';

@collection
@Name('UserProfile')
class IsarProfile {
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
