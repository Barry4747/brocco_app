import 'package:flutter/foundation.dart';
import 'package:brocco_app/features/auth/views/auth_screen.dart';
import 'package:brocco_app/features/auth/views/splash_screen.dart';
import 'package:brocco_app/features/home/views/main_screen.dart';
import 'package:brocco_app/features/roadmap/views/roadmap_screen.dart';
import 'package:brocco_app/features/recipe_detail/views/recipe_detail_screen.dart';
import 'package:brocco_app/features/game/views/level_completed_screen.dart';
import 'package:brocco_app/features/profile/views/profile_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_biometric_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_goals_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_skill_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_tastes_screen.dart';
import 'package:brocco_app/features/auth/viewmodels/auth_viewmodel.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref ref;
  RouterNotifier(this.ref) {
    ref.listen(authViewModelProvider, (_, _) => notifyListeners());
  }
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: notifier,

    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/onboarding/step_1',
        builder: (context, state) => const OnboardingSkillScreen(),
      ),
      GoRoute(
        path: '/onboarding/step_2',
        builder: (context, state) => const OnboardingTastesScreen(),
      ),
      GoRoute(
        path: '/onboarding/step_3',
        builder: (context, state) => const OnboardingGoalsScreen(),
      ),
      GoRoute(
        path: '/onboarding/step_4',
        builder: (context, state) => const OnboardingBiometricsScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/roadmap/:categoryId',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId']!;
          return RoadmapScreen(categoryId: categoryId);
        },
      ),
      GoRoute(
        path: '/recipe/:recipeId',
        builder: (context, state) {
          final recipeId = state.pathParameters['recipeId']!;
          final nodeId = state.uri.queryParameters['nodeId'];
          final categoryId = state.uri.queryParameters['categoryId'];
          final recipeTitle = state.uri.queryParameters['recipeTitle'];
          
          return RecipeDetailScreen(
            recipeId: recipeId,
            nodeId: nodeId,
            categoryId: categoryId,
            recipeTitle: recipeTitle,
          );
        },
      ),
      GoRoute(
        path: '/game/completed',
        builder: (context, state) {
          final nodeId = state.uri.queryParameters['nodeId']!;
          final categoryId = state.uri.queryParameters['categoryId']!;
          final recipeTitle = state.uri.queryParameters['recipeTitle'] ?? '';
          
          return LevelCompletedScreen(
            nodeId: nodeId,
            categoryId: categoryId,
            recipeTitle: recipeTitle,
          );
        },
      ),
    ],

    redirect: (context, state) {
      final authAsync = ref.read(authViewModelProvider);
      final location = state.uri.path;

      final isOnSplash = location == '/splash';
      final isOnAuth = location == '/auth';
      final isOnOnboarding = location.startsWith('/onboarding');

      if (authAsync.isLoading || !authAsync.hasValue) {
         if (isOnSplash) return null;
         return '/splash';
      }

      final authValue = authAsync.value!;

      // Niezalogowany
      if (authValue.status != AuthStatus.authenticated) {
        if (!isOnAuth) return '/auth';
        return null; // Zostaje w auth
      }

      // Zalogowany, ale dopiero odpytujemy bazę o profil - zostaje na splash (albo redirect na splash)
      if (authValue.hasProfile == null) {
        if (!isOnSplash) return '/splash';
        return null;
      }

      // Zalogowany BEZ profilu (Onboarding w toku)
      if (authValue.hasProfile == false) {
        if (!isOnOnboarding) {
          return '/onboarding/step_1';
        }
        return null; // Zostaje na ekranie onboardingu w wybranym kroku
      }

      // Zalogowany Z PROFILEM (Onboarding skończony)
      if (authValue.hasProfile == true) {
        if (isOnSplash || isOnAuth || isOnOnboarding) return '/';
        return null; // Wolnoć Tomku w swoim domku
      }

      return null;
    },
  );
});