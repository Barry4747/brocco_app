import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  
  // Tu w przyszłości będziemy nasłuchiwać stanu logowania z Supabase
  // final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: '/', 
    
    routes: [
     
    ],

    redirect: (context, state) {
      // Pseudo-kod: Jeśli użytkownik nie jest zalogowany i nie jest na ekranie onboardingu:
      // final isLoggedIn = authState.isAuthenticated;
      // final isGoingToOnboarding = state.matchedLocation == '/onboarding';
      
      // if (!isLoggedIn && !isGoingToOnboarding) return '/onboarding';
      // if (isLoggedIn && isGoingToOnboarding) return '/';
      
      return null; // Zwrócenie null oznacza "nie przekierowuj, idź tam gdzie chciałeś"
    },
  );
});