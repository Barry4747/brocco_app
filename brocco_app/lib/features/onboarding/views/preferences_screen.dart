import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twoja Dieta'),
        // W go_router strzałka wstecz pojawi się tu automatycznie, bo użyliśmy context.push()!
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Co lubisz jeść?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            // Zamockowane opcje wyboru
            CheckboxListTile(
              title: const Text('Wszystko (Jestem wszystkożerny)'),
              value: true,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: const Text('Wegetariańskie'),
              value: false,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: const Text('Bez glutenu'),
              value: false,
              onChanged: (bool? value) {},
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
                context.go('/');
              },
              child: const Text('Zakończ konfigurację', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}