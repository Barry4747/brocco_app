import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // <--- DODAJ IMPORT
import 'package:go_router/go_router.dart';
import '../viewmodels/auth_viewmodel.dart'; // <--- DODAJ IMPORT VIEWMODELU
import 'package:sign_in_button/sign_in_button.dart';
// Zmiana na ConsumerWidget, by móc słuchać Riverpoda
class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obserwujemy stan logowania
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Twoja Dieta')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Co lubisz jeść?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            CheckboxListTile(title: const Text('Wegetariańskie'), value: false, onChanged: (bool? v) {}),
            
            const Spacer(),
            
            // Reagujemy na stan (kręcące się kółko podczas logowania)
            // Zamiast ElevatedButton wklej to:
            authState.isLoading
                ? const Center(child: CircularProgressIndicator()) // Kółko ładowania na środku
                : SizedBox(
                    height: 50, // Oficjalny przycisk wygląda lepiej, gdy jest odrobinę wyższy
                    child: SignInButton(
                      Buttons.google,
                      text: "Zaloguj przez Google",
                      onPressed: () async {
                        // 1. Odpalamy logowanie
                        await ref.read(authViewModelProvider.notifier).signInWithGoogle();
                        
                        // 2. Jeśli się udało, idziemy do Hubu!
                        final user = ref.read(authViewModelProvider).value;
                        if (user != null && context.mounted) {
                          context.go('/'); 
                        }
                      },
                    ),
                  ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}