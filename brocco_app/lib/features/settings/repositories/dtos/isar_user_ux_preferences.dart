import 'package:isar/isar.dart';

part 'isar_user_ux_preferences.g.dart';

@collection
@Name('UserUxPreferences')
class IsarUserUxPreferences {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? userId;

  bool keepScreenOn = true;
  bool timerAlarms = true;
  bool mascotSounds = true;
}
