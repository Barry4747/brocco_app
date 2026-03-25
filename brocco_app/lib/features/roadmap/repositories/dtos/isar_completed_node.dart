import 'package:isar/isar.dart';

part 'isar_completed_node.g.dart';

@collection
class IsarCompletedNode {
  Id id = Isar.autoIncrement;

  @Index(composite: [CompositeIndex('nodeId')], unique: true)
  String? userId;

  String? nodeId;
  int starsEarned = 1;
  String? imageUrl;
}
