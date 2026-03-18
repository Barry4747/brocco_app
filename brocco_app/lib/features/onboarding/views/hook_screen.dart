import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HookScreen extends StatelessWidget {
  const HookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tło w stylu Duolingo (lekko zielone)
      backgroundColor: Colors.green.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(Icons.restaurant_menu, size: 100, color: Colors.green),
              const SizedBox(height: 32),
              const Text(
                'Zostań Szefem Kuchni!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Gotuj, zdobywaj gwiazdki i odblokowuj nowe przepisy. Gotowy na kulinarną przygodę?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  // Używamy PUSH: Kładziemy nowy ekran na wierzch stosu.
                  // Dzięki temu użytkownik będzie mógł cofnąć się do tego ekranu.
                  context.push('/onboarding/preferences');
                },
                child: const Text('Zaczynamy!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}