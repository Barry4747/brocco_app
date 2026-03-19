import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/supabase_provider.dart'; 

class AuthViewModel extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    return ref.watch(supabaseProvider).auth.currentUser;
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    
    try {
      final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];

      // 1. NOWE API: Inicjalizacja instancji Google Sign In
      await GoogleSignIn.instance.initialize(
        serverClientId: webClientId,
      );

      // 2. NOWE API: Wywołanie natywnego okienka logowania
      // Teraz metoda nazywa się authenticate() zamiast signIn()
      final googleUser = await GoogleSignIn.instance.authenticate();

      // 3. Pobranie tokenu tożsamości
      // W nowym API to jest właściwość synchroniczna, nie potrzebuje 'await'
      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        throw 'Brak tokenu ID od Google.';
      }

      // 4. Przekazanie tokenu do Supabase 
      // W najnowszym standardzie Google 'accessToken' nie jest już wymagany do uwierzytelniania
      final supabase = ref.read(supabaseProvider);
      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      // 5. Sukces! Zapisujemy usera w stanie Riverpoda
      state = AsyncValue.data(response.user);

    } catch (e, stack) {
      // W nowej wersji, jeśli użytkownik zamknie okienko (anuluje),
      // rzucany jest błąd. Możemy to przechwycić i po prostu zignorować.
      if (e is GoogleSignInException && e.code == GoogleSignInExceptionCode.canceled) {
        state = const AsyncValue.data(null);
        return;
      }
      
      print('Błąd logowania: $e'); 
      state = AsyncValue.error(e, stack);
    }
  }
}

// Globalny Provider dla naszego logowania
final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, User?>(
  () => AuthViewModel(),
);