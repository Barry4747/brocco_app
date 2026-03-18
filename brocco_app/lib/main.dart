import 'package:brocco_app/core/routing/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/local_db/isar_provider.dart';
import 'shared/models/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  final dir = await getApplicationDocumentsDirectory();
  
  final isarInstance = await Isar.open(
    [UserProfileSchema],
    directory: dir.path,
  );
  // Przed samym wydaniem do Google Play / App Store trzeba usunac DevicePreview:
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => ProviderScope(
        overrides: [
          isarProvider.overrideWithValue(isarInstance),
        ],
        child: const BroccoApp(),
      ),
    ),
  );
}

class BroccoApp extends ConsumerWidget {
  const BroccoApp({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      // Przed samym wydaniem do Google Play / App Store usunac te dwie linijki
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      // 
      title: 'Brocco',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 0, 0)),
        useMaterial3: true,
      ),
    );
  }
}