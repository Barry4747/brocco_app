import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../core/local_db/isar_provider.dart';
import '../../home/repositories/dtos/isar_category.dart';
import '../../home/repositories/dtos/isar_unlocked_category.dart';
import '../../roadmap/repositories/dtos/isar_roadmap_node.dart';
import '../../roadmap/repositories/dtos/isar_completed_node.dart';
import '../../profile/repositories/dtos/isar_profile.dart';

class AuthRepository {
  final SupabaseClient _supabase;
  final Isar _isar;

  AuthRepository(this._supabase, this._isar);

  Stream<AuthState> get onAuthStateChange => _supabase.auth.onAuthStateChange;

  Session? get currentSession => _supabase.auth.currentSession;

  Future<bool> hasProfile(String userId) async {
    final localProfile = await _isar.isarProfiles
        .where()
        .supabaseUserIdEqualTo(userId)
        .findFirst();

    if (localProfile != null) {
      return true;
    }
    try {
      final res = await _supabase
          .from('profiles')
          .select('id')
          .eq('id', userId)
          .maybeSingle();
      return res != null;
    } catch (_) {
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    // 1. Fetch the Web Client ID from the .env file
    final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID'];

    if (webClientId == null || webClientId.isEmpty) {
      throw Exception(
        'Błąd konfiguracji: Brak GOOGLE_WEB_CLIENT_ID w pliku .env',
      );
    }

    // 2. Initialize the Singleton (MANDATORY in v7.0.0+)
    await GoogleSignIn.instance.initialize(serverClientId: webClientId);

    // 3. Trigger the new Google Auth flow
    final googleAccount = await GoogleSignIn.instance.authenticate();

    // 4. Get the authentication tokens (synchronous in v7+)
    final googleAuth = googleAccount.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw Exception('Brak tokena ID od Google');
    }

    // 5. Authenticate with Supabase
    await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
  }

  Future<void> signInWithEmail(String email, String password) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUpWithEmail(String email, String password) async {
    final res = await _supabase.auth.signUp(email: email, password: password);
    if (res.session == null) {
      await _supabase.auth.signInWithPassword(email: email, password: password);
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();

    // Fixed for v7+: Use the singleton instance
    await GoogleSignIn.instance.signOut();

    // Clear all cached Isar data
    await _isar.writeTxn(() async {
      await _isar.isarProfiles.clear();
      await _isar.isarCategorys.clear();
      await _isar.isarUnlockedCategorys.clear();
      await _isar.isarRoadmapNodes.clear();
      await _isar.isarCompletedNodes.clear();
    });
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final isar = ref.read(isarProvider);
  return AuthRepository(Supabase.instance.client, isar);
});
