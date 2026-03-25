import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../viewmodels/level_completed_viewmodel.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
  File? _capturedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(levelCompletedViewModelProvider.notifier)
          .completeLevel(widget.nodeId, widget.categoryId);
    });
  }

  Future<void> _pickMedia() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.primaryOrange),
                title: const Text('Zrób zdjęcie', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    setState(() {
                      _capturedImage = File(photo.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.primaryOrange),
                title: const Text('Wybierz z galerii', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _capturedImage = File(image.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
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
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: _pickMedia,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppColors.accentGreen.withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                          child: _capturedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.file(
                                    _capturedImage!,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      width: 64,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: AppColors.accentGreen.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          color: AppColors.primaryOrange,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Uwiecznij swoje arcydzieło!',
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Dodaj zdjęcie lub wideo swojego dania,\naby zdobyć dodatkowe +50 PD.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.greyText,
                                        fontSize: 13,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
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
                  if (_capturedImage != null) {
                    ref.read(levelCompletedViewModelProvider.notifier).uploadMealPhoto(
                      widget.nodeId,
                      widget.categoryId,
                      _capturedImage!,
                    );
                  }
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
