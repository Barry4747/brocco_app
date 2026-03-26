class UserUxPreferences {
  final String userId;
  final bool keepScreenOn;
  final bool timerAlarms;
  final bool mascotSounds;

  const UserUxPreferences({
    required this.userId,
    this.keepScreenOn = true,
    this.timerAlarms = true,
    this.mascotSounds = true,
  });

  UserUxPreferences copyWith({
    bool? keepScreenOn,
    bool? timerAlarms,
    bool? mascotSounds,
  }) {
    return UserUxPreferences(
      userId: userId,
      keepScreenOn: keepScreenOn ?? this.keepScreenOn,
      timerAlarms: timerAlarms ?? this.timerAlarms,
      mascotSounds: mascotSounds ?? this.mascotSounds,
    );
  }
}
