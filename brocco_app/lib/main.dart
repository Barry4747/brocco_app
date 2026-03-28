import 'package:brocco_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/local_db/isar_provider.dart';
import 'features/home/repositories/dtos/isar_category.dart';
import 'features/home/repositories/dtos/isar_unlocked_category.dart';
import 'features/roadmap/repositories/dtos/isar_roadmap_node.dart';
import 'features/roadmap/repositories/dtos/isar_completed_node.dart';
import 'features/profile/repositories/dtos/isar_profile.dart';
import 'features/onboarding/repositories/dtos/isar_allergy.dart';
import 'features/onboarding/repositories/dtos/isar_cuisine.dart';
import 'features/onboarding/repositories/dtos/isar_ingredient.dart';
import 'features/settings/repositories/dtos/isar_user_ux_preferences.dart';
import 'shared/repositories/dtos/isar_recipe.dart';
import 'package:brocco_app/core/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  final dir = await getApplicationDocumentsDirectory();

  final isarInstance = await Isar.open([
    IsarProfileSchema,
    IsarCategorySchema,
    IsarUnlockedCategorySchema,
    IsarRoadmapNodeSchema,
    IsarCompletedNodeSchema,
    IsarAllergySchema,
    IsarCuisineSchema,
    IsarIngredientSchema,
    IsarUserUxPreferencesSchema,
    IsarRecipeSchema,
  ], directory: dir.path);
  runApp(
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isarInstance)],
      child: const BroccoApp(),
    ),
  );
}

class BroccoApp extends ConsumerWidget {
  const BroccoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Brocco',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryText,
          primary: AppColors.primaryText,
          secondary: AppColors.primaryOrange,
          surface: AppColors.background,
          error: AppColors.errorRed,
        ),

        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
    );
  }
}
