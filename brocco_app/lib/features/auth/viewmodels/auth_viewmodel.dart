import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/auth_repository.dart';
import '../../../core/local_db/global_sync_service.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final bool? hasProfile;

  const AuthState({
    this.status = AuthStatus.initial, 
    this.errorMessage,
    this.hasProfile,
  });

  AuthState copyWith({
    AuthStatus? status, 
    String? errorMessage,
    bool? hasProfile,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      hasProfile: hasProfile ?? this.hasProfile,
    );
  }
}

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, AuthState>(
  () => AuthViewModel(),
);

final userIdProvider = Provider<String?>((ref) {
  final authState = ref.watch(authViewModelProvider);
  return authState.maybeWhen(
    data: (state) => state.status == AuthStatus.authenticated 
        ? Supabase.instance.client.auth.currentUser?.id 
        : null,
    orElse: () => null,
  );
});

class AuthViewModel extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    final repository = ref.read(authRepositoryProvider);

    final sub = repository.onAuthStateChange.listen((data) async {
      final session = data.session;
      if (session != null) {
        final hasProfile = await repository.hasProfile(session.user.id);
        
        // Comprehensive sync (Profile, Categories, Progress)
        await ref.read(globalSyncServiceProvider).syncAll(session.user.id);

        state = AsyncValue.data(AuthState(
          status: AuthStatus.authenticated,
          hasProfile: hasProfile,
        ));
      } else {
        state = const AsyncValue.data(AuthState(status: AuthStatus.unauthenticated));
      }
    });

    ref.onDispose(() {
      sub.cancel();
    });

    final session = repository.currentSession;
    if (session != null) {
      final hasProfile = await repository.hasProfile(session.user.id);
      
      // Comprehensive sync (Profile, Categories, Progress)
      await ref.read(globalSyncServiceProvider).syncAll(session.user.id);

      return AuthState(
        status: AuthStatus.authenticated,
        hasProfile: hasProfile,
      );
    }
    return const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> refreshProfileState() async {
    final repository = ref.read(authRepositoryProvider);
    final session = repository.currentSession;
    if (session != null) {
      final hasProfile = await repository.hasProfile(session.user.id);
      state = AsyncValue.data(AuthState(
        status: AuthStatus.authenticated,
        hasProfile: hasProfile,
      ));
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.signInWithGoogle();
    } catch (e) {
      state = AsyncValue.data(
        AuthState(status: AuthStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.signInWithEmail(email, password);
    } catch (e) {
      state = AsyncValue.data(
        AuthState(status: AuthStatus.error, errorMessage: _mapAuthError(e)),
      );
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.signUpWithEmail(email, password);
    } catch (e) {
      state = AsyncValue.data(
        AuthState(status: AuthStatus.error, errorMessage: _mapAuthError(e)),
      );
    }
  }

  Future<void> signOut() async {
    final repository = ref.read(authRepositoryProvider);
    await repository.signOut();
    state = const AsyncValue.data(
      AuthState(status: AuthStatus.unauthenticated),
    );
  }

  String _mapAuthError(Object e) {
    print('BŁĄD SUPABASE: $e');
    final msg = e.toString().toLowerCase();
    if (msg.contains('invalid login credentials') ||
        msg.contains('invalid_credentials')) {
      return 'Nieprawidłowy email lub hasło.';
    }
    if (msg.contains('email already registered') ||
        msg.contains('user_already_exists')) {
      return 'Ten email jest już zarejestrowany.';
    }
    if (msg.contains('network')) {
      return 'Brak połączenia z internetem.';
    }
    return 'Błąd: $e';
  }
}
