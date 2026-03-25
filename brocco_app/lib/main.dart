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
import 'features/home/repositories/dtos/isar_category.dart';
import 'features/home/repositories/dtos/isar_unlocked_category.dart';
import 'features/roadmap/repositories/dtos/isar_roadmap_node.dart';
import 'features/roadmap/repositories/dtos/isar_completed_node.dart';
import 'features/profile/repositories/dtos/isar_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  final dir = await getApplicationDocumentsDirectory();

  final isarInstance = await Isar.open([
    IsarProfileSchema,
    IsarCategorySchema,
    IsarUnlockedCategorySchema,
    IsarRoadmapNodeSchema,
    IsarCompletedNodeSchema,
  ], directory: dir.path);
  runApp(
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isarInstance)],
      child: const BroccoApp(),
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
      title: 'Brocco',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        useMaterial3: true,
      ),
    );
  }
}
