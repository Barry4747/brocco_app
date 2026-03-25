import 'package:isar/isar.dart';

part 'isar_ingredient.g.dart';

@collection
class IsarIngredient {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String supabaseId;

  late String name;
}
