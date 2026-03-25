// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_profile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarProfileCollection on Isar {
  IsarCollection<IsarProfile> get isarProfiles => this.collection();
}

const IsarProfileSchema = CollectionSchema(
  name: r'UserProfile',
  id: 4738427352541298891,
  properties: {
    r'allergies': PropertySchema(
      id: 0,
      name: r'allergies',
      type: IsarType.stringList,
    ),
    r'avatarUrl': PropertySchema(
      id: 1,
      name: r'avatarUrl',
      type: IsarType.string,
    ),
    r'cookingLevel': PropertySchema(
      id: 2,
      name: r'cookingLevel',
      type: IsarType.string,
    ),
    r'currentStreak': PropertySchema(
      id: 3,
      name: r'currentStreak',
      type: IsarType.long,
    ),
    r'dietaryPreferences': PropertySchema(
      id: 4,
      name: r'dietaryPreferences',
      type: IsarType.stringList,
    ),
    r'starsBank': PropertySchema(
      id: 5,
      name: r'starsBank',
      type: IsarType.long,
    ),
    r'supabaseUserId': PropertySchema(
      id: 6,
      name: r'supabaseUserId',
      type: IsarType.string,
    ),
    r'totalXp': PropertySchema(
      id: 7,
      name: r'totalXp',
      type: IsarType.long,
    ),
    r'username': PropertySchema(
      id: 8,
      name: r'username',
      type: IsarType.string,
    )
  },
  estimateSize: _isarProfileEstimateSize,
  serialize: _isarProfileSerialize,
  deserialize: _isarProfileDeserialize,
  deserializeProp: _isarProfileDeserializeProp,
  idName: r'id',
  indexes: {
    r'supabaseUserId': IndexSchema(
      id: -536050839130063521,
      name: r'supabaseUserId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'supabaseUserId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarProfileGetId,
  getLinks: _isarProfileGetLinks,
  attach: _isarProfileAttach,
  version: '3.1.0+1',
);

int _isarProfileEstimateSize(
  IsarProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.allergies;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.avatarUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cookingLevel;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.dietaryPreferences;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final value = object.supabaseUserId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.username;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarProfileSerialize(
  IsarProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.allergies);
  writer.writeString(offsets[1], object.avatarUrl);
  writer.writeString(offsets[2], object.cookingLevel);
  writer.writeLong(offsets[3], object.currentStreak);
  writer.writeStringList(offsets[4], object.dietaryPreferences);
  writer.writeLong(offsets[5], object.starsBank);
  writer.writeString(offsets[6], object.supabaseUserId);
  writer.writeLong(offsets[7], object.totalXp);
  writer.writeString(offsets[8], object.username);
}

IsarProfile _isarProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarProfile();
  object.allergies = reader.readStringList(offsets[0]);
  object.avatarUrl = reader.readStringOrNull(offsets[1]);
  object.cookingLevel = reader.readStringOrNull(offsets[2]);
  object.currentStreak = reader.readLong(offsets[3]);
  object.dietaryPreferences = reader.readStringList(offsets[4]);
  object.id = id;
  object.starsBank = reader.readLong(offsets[5]);
  object.supabaseUserId = reader.readStringOrNull(offsets[6]);
  object.totalXp = reader.readLong(offsets[7]);
  object.username = reader.readStringOrNull(offsets[8]);
  return object;
}

P _isarProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readStringList(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarProfileGetId(IsarProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarProfileGetLinks(IsarProfile object) {
  return [];
}

void _isarProfileAttach(
    IsarCollection<dynamic> col, Id id, IsarProfile object) {
  object.id = id;
}

extension IsarProfileByIndex on IsarCollection<IsarProfile> {
  Future<IsarProfile?> getBySupabaseUserId(String? supabaseUserId) {
    return getByIndex(r'supabaseUserId', [supabaseUserId]);
  }

  IsarProfile? getBySupabaseUserIdSync(String? supabaseUserId) {
    return getByIndexSync(r'supabaseUserId', [supabaseUserId]);
  }

  Future<bool> deleteBySupabaseUserId(String? supabaseUserId) {
    return deleteByIndex(r'supabaseUserId', [supabaseUserId]);
  }

  bool deleteBySupabaseUserIdSync(String? supabaseUserId) {
    return deleteByIndexSync(r'supabaseUserId', [supabaseUserId]);
  }

  Future<List<IsarProfile?>> getAllBySupabaseUserId(
      List<String?> supabaseUserIdValues) {
    final values = supabaseUserIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'supabaseUserId', values);
  }

  List<IsarProfile?> getAllBySupabaseUserIdSync(
      List<String?> supabaseUserIdValues) {
    final values = supabaseUserIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'supabaseUserId', values);
  }

  Future<int> deleteAllBySupabaseUserId(List<String?> supabaseUserIdValues) {
    final values = supabaseUserIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'supabaseUserId', values);
  }

  int deleteAllBySupabaseUserIdSync(List<String?> supabaseUserIdValues) {
    final values = supabaseUserIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'supabaseUserId', values);
  }

  Future<Id> putBySupabaseUserId(IsarProfile object) {
    return putByIndex(r'supabaseUserId', object);
  }

  Id putBySupabaseUserIdSync(IsarProfile object, {bool saveLinks = true}) {
    return putByIndexSync(r'supabaseUserId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySupabaseUserId(List<IsarProfile> objects) {
    return putAllByIndex(r'supabaseUserId', objects);
  }

  List<Id> putAllBySupabaseUserIdSync(List<IsarProfile> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'supabaseUserId', objects, saveLinks: saveLinks);
  }
}

extension IsarProfileQueryWhereSort
    on QueryBuilder<IsarProfile, IsarProfile, QWhere> {
  QueryBuilder<IsarProfile, IsarProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarProfileQueryWhere
    on QueryBuilder<IsarProfile, IsarProfile, QWhereClause> {
  QueryBuilder<IsarProfile, IsarProfile, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterWhereClause>
      supabaseUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseUserId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterWhereClause>
      supabaseUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supabaseUserId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterWhereClause>
      supabaseUserIdEqualTo(String? supabaseUserId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseUserId',
        value: [supabaseUserId],
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterWhereClause>
      supabaseUserIdNotEqualTo(String? supabaseUserId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseUserId',
              lower: [],
              upper: [supabaseUserId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseUserId',
              lower: [supabaseUserId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseUserId',
              lower: [supabaseUserId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseUserId',
              lower: [],
              upper: [supabaseUserId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarProfileQueryFilter
    on QueryBuilder<IsarProfile, IsarProfile, QFilterCondition> {
  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allergies',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allergies',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allergies',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'allergies',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allergies',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'allergies',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allergies',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allergies',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allergies',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allergies',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allergies',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      allergiesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allergies',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avatarUrl',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avatarUrl',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      avatarUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cookingLevel',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cookingLevel',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cookingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cookingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cookingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cookingLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cookingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cookingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cookingLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cookingLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cookingLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      cookingLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cookingLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      currentStreakEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      currentStreakGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      currentStreakLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStreak',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      currentStreakBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStreak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dietaryPreferences',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dietaryPreferences',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dietaryPreferences',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dietaryPreferences',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietaryPreferences',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dietaryPreferences',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryPreferences',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryPreferences',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryPreferences',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryPreferences',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryPreferences',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      dietaryPreferencesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'dietaryPreferences',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      starsBankEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'starsBank',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      starsBankGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'starsBank',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      starsBankLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'starsBank',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      starsBankBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'starsBank',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'supabaseUserId',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'supabaseUserId',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supabaseUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supabaseUserId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supabaseUserId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      supabaseUserIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supabaseUserId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> totalXpEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalXp',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      totalXpGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalXp',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> totalXpLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalXp',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> totalXpBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalXp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      usernameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      usernameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'username',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> usernameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      usernameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      usernameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> usernameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'username',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      usernameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      usernameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      usernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'username',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition> usernameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'username',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'username',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterFilterCondition>
      usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'username',
        value: '',
      ));
    });
  }
}

extension IsarProfileQueryObject
    on QueryBuilder<IsarProfile, IsarProfile, QFilterCondition> {}

extension IsarProfileQueryLinks
    on QueryBuilder<IsarProfile, IsarProfile, QFilterCondition> {}

extension IsarProfileQuerySortBy
    on QueryBuilder<IsarProfile, IsarProfile, QSortBy> {
  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByCookingLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookingLevel', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy>
      sortByCookingLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookingLevel', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy>
      sortByCurrentStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByStarsBank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starsBank', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByStarsBankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starsBank', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortBySupabaseUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUserId', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy>
      sortBySupabaseUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUserId', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByTotalXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalXp', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByTotalXpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalXp', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension IsarProfileQuerySortThenBy
    on QueryBuilder<IsarProfile, IsarProfile, QSortThenBy> {
  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByAvatarUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByAvatarUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarUrl', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByCookingLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookingLevel', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy>
      thenByCookingLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cookingLevel', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy>
      thenByCurrentStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreak', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByStarsBank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starsBank', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByStarsBankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starsBank', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenBySupabaseUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUserId', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy>
      thenBySupabaseUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseUserId', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByTotalXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalXp', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByTotalXpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalXp', Sort.desc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QAfterSortBy> thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension IsarProfileQueryWhereDistinct
    on QueryBuilder<IsarProfile, IsarProfile, QDistinct> {
  QueryBuilder<IsarProfile, IsarProfile, QDistinct> distinctByAllergies() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allergies');
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QDistinct> distinctByAvatarUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QDistinct> distinctByCookingLevel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cookingLevel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QDistinct> distinctByCurrentStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStreak');
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QDistinct>
      distinctByDietaryPreferences() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dietaryPreferences');
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QDistinct> distinctByStarsBank() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'starsBank');
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QDistinct> distinctBySupabaseUserId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseUserId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QDistinct> distinctByTotalXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalXp');
    });
  }

  QueryBuilder<IsarProfile, IsarProfile, QDistinct> distinctByUsername(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension IsarProfileQueryProperty
    on QueryBuilder<IsarProfile, IsarProfile, QQueryProperty> {
  QueryBuilder<IsarProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarProfile, List<String>?, QQueryOperations>
      allergiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allergies');
    });
  }

  QueryBuilder<IsarProfile, String?, QQueryOperations> avatarUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarUrl');
    });
  }

  QueryBuilder<IsarProfile, String?, QQueryOperations> cookingLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cookingLevel');
    });
  }

  QueryBuilder<IsarProfile, int, QQueryOperations> currentStreakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStreak');
    });
  }

  QueryBuilder<IsarProfile, List<String>?, QQueryOperations>
      dietaryPreferencesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dietaryPreferences');
    });
  }

  QueryBuilder<IsarProfile, int, QQueryOperations> starsBankProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'starsBank');
    });
  }

  QueryBuilder<IsarProfile, String?, QQueryOperations>
      supabaseUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseUserId');
    });
  }

  QueryBuilder<IsarProfile, int, QQueryOperations> totalXpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalXp');
    });
  }

  QueryBuilder<IsarProfile, String?, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}
