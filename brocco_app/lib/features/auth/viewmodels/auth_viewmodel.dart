import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Twój zaktualizowany pakiet
import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;

  const AuthState({this.status = AuthStatus.initial, this.errorMessage});

  AuthState copyWith({AuthStatus? status, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, AuthState>(
  () {
    return AuthViewModel();
  },
);

class AuthViewModel extends AsyncNotifier<AuthState> {
  final _supabase = Supabase.instance.client;

  @override
  Future<AuthState> build() async {
    await GoogleSignIn.instance.initialize(
      serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
    );

    final session = _supabase.auth.currentSession;
    if (session != null) {
      return const AuthState(status: AuthStatus.authenticated);
    }
    return const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final googleAccount = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleAccount.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Brak tokena ID od Google');
      }

      await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      state = const AsyncValue.data(
        AuthState(status: AuthStatus.authenticated),
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
      state = const AsyncValue.data(
        AuthState(status: AuthStatus.authenticated),
      );
    } catch (e) {
      state = AsyncValue.data(
        AuthState(status: AuthStatus.error, errorMessage: _mapAuthError(e)),
      );
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _supabase.auth.signUp(email: email, password: password);
      state = const AsyncValue.data(
        AuthState(status: AuthStatus.authenticated),
      );
    } catch (e) {
      state = AsyncValue.data(
        AuthState(status: AuthStatus.error, errorMessage: _mapAuthError(e)),
      );
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    // W nowym API odwołujemy się do instancji
    await GoogleSignIn.instance.signOut();
    state = const AsyncValue.data(
      AuthState(status: AuthStatus.unauthenticated),
    );
  }

  String _mapAuthError(Object e) {
    // --- DODAJEMY TO, ŻEBY ZOBACZYĆ BŁĄD W KONSOLI VS CODE ---
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

    // --- ZMIENIAMY DOMYŚLNĄ WIADOMOŚĆ, ŻEBY POKAZAŁA BŁĄD NA EKRANIE TELEFONU ---
    return 'Błąd: $e';
  }
}
