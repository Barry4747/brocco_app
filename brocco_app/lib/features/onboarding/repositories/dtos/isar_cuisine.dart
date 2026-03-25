import 'package:isar/isar.dart';

part 'isar_cuisine.g.dart';

@collection
class IsarCuisine {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String supabaseId;

  late String name;
}
