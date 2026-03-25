import 'package:isar/isar.dart';

part 'isar_allergy.g.dart';

@collection
class IsarAllergy {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String supabaseId;

  late String name;
}
