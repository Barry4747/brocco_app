class CompletedNodeData {
  final String id;
  final String title;
  final String? imageUrl;
  final bool hasUserPhoto;

  CompletedNodeData({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.hasUserPhoto,
  });
}
