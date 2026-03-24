import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../viewmodels/level_completed_viewmodel.dart';

class LevelCompletedScreen extends ConsumerStatefulWidget {
  final String nodeId;
  final String categoryId;
  final String recipeTitle;

  const LevelCompletedScreen({
    super.key,
    required this.nodeId,
    required this.categoryId,
    required this.recipeTitle,
  });

  @override
  ConsumerState<LevelCompletedScreen> createState() =>
      _LevelCompletedScreenState();
}

class _LevelCompletedScreenState extends ConsumerState<LevelCompletedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(levelCompletedViewModelProvider.notifier)
          .completeLevel(widget.nodeId, widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2FAF5), // Light greenish background
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // Hardcoded placeholder for mascot image for now
                      Image.asset(
                        'assets/images/characters/mascot_happy.png',
                        height: 180,
                        errorBuilder: (context, error, stackTrace) =>
                            const Text(
                          '🥦',
                          style: TextStyle(fontSize: 120),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Poziom ukończony!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText, // Assuming dark green
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Ukończyłeś przepis na ${widget.recipeTitle}!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF1E5B43),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.accentGreen.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'NAGRODY DO ODEBRANIA',
                              style: TextStyle(
                                color: AppColors.greyText,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryOrange,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.star_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          '+150',
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 36,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: -1,
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'PD',
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Punkty Doświadczenia',
                                      style: TextStyle(
                                        color: AppColors.greyText,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                text: 'Odbierz nagrody i zakończ',
                onPressed: () {
                  context.go('/roadmap/${widget.categoryId}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
