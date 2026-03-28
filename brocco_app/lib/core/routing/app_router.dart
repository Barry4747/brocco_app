import 'package:flutter/foundation.dart';
import 'package:brocco_app/features/auth/views/auth_screen.dart';
import 'package:brocco_app/features/auth/views/splash_screen.dart';
import 'package:brocco_app/features/home/views/main_screen.dart';
import 'package:brocco_app/features/roadmap/views/roadmap_screen.dart';
import 'package:brocco_app/features/recipe_detail/views/recipe_detail_screen.dart';
import 'package:brocco_app/features/game/views/level_completed_screen.dart';
import 'package:brocco_app/features/game/views/game_screen.dart';
import 'package:brocco_app/features/profile/views/profile_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_step_1_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_step_2_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_step_3_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_step_4_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_step_5_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_step_6_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_step_7_screen.dart';
import 'package:brocco_app/features/settings/views/settings_screen.dart';
import 'package:brocco_app/features/browser/views/browser_screen.dart';
import 'package:brocco_app/shared/widgets/nav_shell.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      GoRoute(path: '/auth', builder: (context, state) => const AuthScreen()),
      GoRoute(
        path: '/onboarding/step_1',
        builder: (context, state) => const OnboardingStep1Screen(),
      ),
      GoRoute(
        path: '/onboarding/step_2',
        builder: (context, state) => const OnboardingStep2Screen(),
      ),
      GoRoute(
        path: '/onboarding/step_3',
        builder: (context, state) => const OnboardingStep3Screen(),
      ),
      GoRoute(
        path: '/onboarding/step_4',
        builder: (context, state) => const OnboardingStep4Screen(),
      ),
      GoRoute(
        path: '/onboarding/step_5',
        builder: (context, state) => const OnboardingStep5Screen(),
      ),
      GoRoute(
        path: '/onboarding/step_6',
        builder: (context, state) => const OnboardingStep6Screen(),
      ),
      GoRoute(
        path: '/onboarding/step_7',
        builder: (context, state) => const OnboardingStep7Screen(),
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
      GoRoute(
        path: '/game/play',
        builder: (context, state) {
          final recipeId = state.uri.queryParameters['recipeId'] ?? '';
          final recipeText = state.uri.queryParameters['recipeText'] ?? '';
          final nodeId = state.uri.queryParameters['nodeId'] ?? '';
          final categoryId = state.uri.queryParameters['categoryId'] ?? '';
          final recipeTitle = state.uri.queryParameters['recipeTitle'] ?? '';

          return GameScreen(
            recipeId: recipeId,
            recipeText: recipeText,
            nodeId: nodeId,
            categoryId: categoryId,
            recipeTitle: recipeTitle,
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavShell(
            navigationShell: navigationShell,
            children: const [
              ProfileScreen(),
              MainScreen(),
              BrowserScreen(),
              SettingsScreen(),
            ],
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const MainScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/browser',
                builder: (context, state) => const BrowserScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
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

      if (authValue.status != AuthStatus.authenticated) {
        if (!isOnAuth) return '/auth';
        return null;
      }

      if (authValue.hasProfile == null) {
        if (!isOnSplash) return '/splash';
        return null;
      }

      if (authValue.hasProfile == false) {
        if (!isOnOnboarding) {
          return '/onboarding/step_1';
        }
        return null;
      }

      if (authValue.hasProfile == true) {
        if (isOnSplash || isOnAuth || isOnOnboarding) return '/';
        return null;
      }

      return null;
    },
  );
});
