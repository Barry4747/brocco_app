import 'package:brocco_app/features/auth/views/auth_screen.dart';
import 'package:brocco_app/features/auth/views/splash_screen.dart';
import 'package:brocco_app/features/home/views/main_screen.dart';
import 'package:brocco_app/features/roadmap/views/roadmap_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_biometric_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_goals_screen.dart';
import 'package:brocco_app/features/onboarding/views/onboarding_skill_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:brocco_app/features/onboarding/views/onboarding_tastes_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',

    routes: [
      // --- SPLASH ---
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // --- AUTH ---
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),

      // --- ONBOARDING ---
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

      // --- MAIN APP ---
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),

      // --- ROADMAP ---
      GoRoute(
        path: '/roadmap/:categoryId',
        builder: (context, state) {
          final categoryId = state.pathParameters['categoryId']!;
          return RoadmapScreen(categoryId: categoryId);
        },
      ),
    ],

    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;
      final location = state.uri.path;

      final isOnSplash = location == '/splash';
      final isOnAuth = location == '/auth';

      // Splash sam zajmuje się przekierowaniem – nie ingerujemy
      if (isOnSplash) return null;

      // Niezalogowany użytkownik trafia na /auth
      if (!isLoggedIn && !isOnAuth) return '/auth';

      // Zalogowany użytkownik nie wchodzi na /auth
      if (isLoggedIn && isOnAuth) return '/';

      return null;
    },
  );
});