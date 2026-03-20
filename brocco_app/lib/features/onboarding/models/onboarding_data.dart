enum CookingSkill { novice, homeCook, masterchef }
enum UsageFrequency { weekends, fewTimesAWeek, everyday }
enum EatingStyle { omnivore, flexitarian, vegetarian, vegan, pescatarian }
enum MainGoal { eatHealthier, saveTime, learnToCook, loseWeight, buildMuscle }
enum Gender { female, male, other }
enum ActivityLevel { sedentary, moderate, active }


class OnboardingData {
  final CookingSkill? cookingSkill;
  final int? maxCookingTimeMinutes;
  final UsageFrequency? usageFrequency;

  final List<String> favoriteCuisines;
  final EatingStyle? eatingStyle;
  final List<String> allergies;
  final List<String> dislikedIngredients;

  final MainGoal? mainGoal;
  final Gender? gender;
  final DateTime? birthDate; 
  final int? heightCm;
  final double? currentWeightKg;
  final double? targetWeightKg;
  final ActivityLevel? activityLevel;

  const OnboardingData({
    this.cookingSkill,
    this.maxCookingTimeMinutes,
    this.usageFrequency,
    this.favoriteCuisines = const [], 
    this.eatingStyle,
    this.allergies = const [],        
    this.dislikedIngredients = const [], 
    this.mainGoal,
    this.gender,
    this.birthDate,
    this.heightCm,
    this.currentWeightKg,
    this.targetWeightKg,
    this.activityLevel,
  });

  OnboardingData copyWith({
    CookingSkill? cookingSkill,
    int? maxCookingTimeMinutes,
    UsageFrequency? usageFrequency,
    List<String>? favoriteCuisines,
    EatingStyle? eatingStyle,
    List<String>? allergies,
    List<String>? dislikedIngredients,
    MainGoal? mainGoal,
    Gender? gender,
    DateTime? birthDate,
    int? heightCm,
    double? currentWeightKg,
    double? targetWeightKg,
    ActivityLevel? activityLevel,
  }) {
    return OnboardingData(
      cookingSkill: cookingSkill ?? this.cookingSkill,
      maxCookingTimeMinutes: maxCookingTimeMinutes ?? this.maxCookingTimeMinutes,
      usageFrequency: usageFrequency ?? this.usageFrequency,
      favoriteCuisines: favoriteCuisines ?? this.favoriteCuisines,
      eatingStyle: eatingStyle ?? this.eatingStyle,
      allergies: allergies ?? this.allergies,
      dislikedIngredients: dislikedIngredients ?? this.dislikedIngredients,
      mainGoal: mainGoal ?? this.mainGoal,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      heightCm: heightCm ?? this.heightCm,
      currentWeightKg: currentWeightKg ?? this.currentWeightKg,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }
}