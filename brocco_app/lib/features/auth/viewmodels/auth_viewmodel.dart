import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

class AuthViewModel extends AsyncNotifier<AuthState> {
  final _supabase = Supabase.instance.client;

  @override
  Future<AuthState> build() async {
    await GoogleSignIn.instance.initialize(
      serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
    );

    final sub = _supabase.auth.onAuthStateChange.listen((data) async {
      final session = data.session;
      if (session != null) {
        final profileState = await _getProfileState(session.user.id);
        state = AsyncValue.data(profileState);
      } else {
        state = const AsyncValue.data(AuthState(status: AuthStatus.unauthenticated));
      }
    });

    ref.onDispose(() {
      sub.cancel();
    });

    final session = _supabase.auth.currentSession;
    if (session != null) {
      return await _getProfileState(session.user.id);
    }
    return const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<AuthState> _getProfileState(String userId) async {
    try {
      final res = await _supabase.from('profiles').select('id').eq('id', userId).maybeSingle();
      final hasProfile = res != null;

      return AuthState(
        status: AuthStatus.authenticated,
        hasProfile: hasProfile,
      );
    } catch (e) {
      return const AuthState(status: AuthStatus.authenticated, hasProfile: false);
    }
  }

  Future<void> refreshProfileState() async {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      final newState = await _getProfileState(session.user.id);
      state = AsyncValue.data(newState);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final googleAccount = await GoogleSignIn.instance.authenticate();
      final googleAuth = await googleAccount.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Brak tokena ID od Google');
      }

      await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );
    } catch (e) {
      state = AsyncValue.data(
        AuthState(status: AuthStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _supabase.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      state = AsyncValue.data(
        AuthState(status: AuthStatus.error, errorMessage: _mapAuthError(e)),
      );
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final res = await _supabase.auth.signUp(email: email, password: password);
      if (res.session == null) {
        await _supabase.auth.signInWithPassword(email: email, password: password);
      }
    } catch (e) {
      state = AsyncValue.data(
        AuthState(status: AuthStatus.error, errorMessage: _mapAuthError(e)),
      );
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    await GoogleSignIn.instance.signOut();
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
