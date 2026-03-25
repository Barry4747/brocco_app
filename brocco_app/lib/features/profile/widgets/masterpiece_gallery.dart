import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../models/completed_node_data.dart';
import '../viewmodels/profile_viewmodel.dart';
import 'package:image_picker/image_picker.dart';

class MasterpieceGallery extends ConsumerWidget {
  const MasterpieceGallery({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodesAsync = ref.watch(galleryNodesProvider);

    return nodesAsync.when(
      data: (nodes) {
        if (nodes.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('Brak ukończonych przepisów', style: TextStyle(color: AppColors.greyText)),
              ),
            ),
          );
        }

        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final node = nodes[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: GestureDetector(
                  onTap: () {
                    if (!node.hasUserPhoto) {
                      _pickAndUpload(context, ref, node.id);
                    }
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _buildImage(node),
                      if (!node.hasUserPhoto)
                        Container(
                          color: AppColors.background.withValues(alpha: 0.6),
                          child: const Center(
                            child: Icon(Icons.add_a_photo_outlined, size: 40, color: AppColors.primaryOrange),
                          ),
                        ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Text(
                          node.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: nodes.length,
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
      error: (e, _) => SliverToBoxAdapter(child: Center(child: Text('Błąd: $e'))),
    );
  }

  Widget _buildImage(CompletedNodeData node) {
    if (node.imageUrl == null || node.imageUrl!.isEmpty) {
      return Container(
        color: AppColors.accentGreen.withValues(alpha: 0.2),
        child: const Icon(Icons.restaurant, size: 48, color: AppColors.accentGreen),
      );
    }
    
    final imageWidget = Image.network(
      node.imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppColors.accentGreen.withValues(alpha: 0.2),
        child: const Icon(Icons.error, color: AppColors.primaryOrange),
      ),
    );

    if (!node.hasUserPhoto) {
      return ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.saturation),
        child: imageWidget,
      );
    }
    return imageWidget;
  }

  Future<void> _pickAndUpload(BuildContext context, WidgetRef ref, String nodeId) async {
    // We can directly open bottom sheet or just camera. The user usually prefers a choice.
    // Since it's a small shortcut, we can use the same logic as level_completed.
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: AppColors.primaryOrange),
                title: const Text('Zrób zdjęcie (+50 PD)', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () async {
                  Navigator.pop(ctx);
                  final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    ref.read(profileActionProvider.notifier).uploadMissingPhoto(nodeId, File(photo.path));
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: AppColors.primaryOrange),
                title: const Text('Wybierz z galerii (+50 PD)', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () async {
                  Navigator.pop(ctx);
                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    ref.read(profileActionProvider.notifier).uploadMissingPhoto(nodeId, File(image.path));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
