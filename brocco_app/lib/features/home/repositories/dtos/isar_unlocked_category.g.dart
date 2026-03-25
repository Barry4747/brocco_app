// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_unlocked_category.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarUnlockedCategoryCollection on Isar {
  IsarCollection<IsarUnlockedCategory> get isarUnlockedCategorys =>
      this.collection();
}

const IsarUnlockedCategorySchema = CollectionSchema(
  name: r'IsarUnlockedCategory',
  id: 8450421972454174131,
  properties: {
    r'categoryId': PropertySchema(
      id: 0,
      name: r'categoryId',
      type: IsarType.string,
    ),
    r'completedNodesCount': PropertySchema(
      id: 1,
      name: r'completedNodesCount',
      type: IsarType.long,
    ),
    r'unlockedAt': PropertySchema(
      id: 2,
      name: r'unlockedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 3,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _isarUnlockedCategoryEstimateSize,
  serialize: _isarUnlockedCategorySerialize,
  deserialize: _isarUnlockedCategoryDeserialize,
  deserializeProp: _isarUnlockedCategoryDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId_categoryId': IndexSchema(
      id: -4976914777000700541,
      name: r'userId_categoryId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'categoryId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarUnlockedCategoryGetId,
  getLinks: _isarUnlockedCategoryGetLinks,
  attach: _isarUnlockedCategoryAttach,
  version: '3.1.0+1',
);

int _isarUnlockedCategoryEstimateSize(
  IsarUnlockedCategory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.categoryId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarUnlockedCategorySerialize(
  IsarUnlockedCategory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.categoryId);
  writer.writeLong(offsets[1], object.completedNodesCount);
  writer.writeDateTime(offsets[2], object.unlockedAt);
  writer.writeString(offsets[3], object.userId);
}

IsarUnlockedCategory _isarUnlockedCategoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarUnlockedCategory();
  object.categoryId = reader.readStringOrNull(offsets[0]);
  object.completedNodesCount = reader.readLong(offsets[1]);
  object.id = id;
  object.unlockedAt = reader.readDateTimeOrNull(offsets[2]);
  object.userId = reader.readStringOrNull(offsets[3]);
  return object;
}

P _isarUnlockedCategoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarUnlockedCategoryGetId(IsarUnlockedCategory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarUnlockedCategoryGetLinks(
    IsarUnlockedCategory object) {
  return [];
}

void _isarUnlockedCategoryAttach(
    IsarCollection<dynamic> col, Id id, IsarUnlockedCategory object) {
  object.id = id;
}

extension IsarUnlockedCategoryByIndex on IsarCollection<IsarUnlockedCategory> {
  Future<IsarUnlockedCategory?> getByUserIdCategoryId(
      String? userId, String? categoryId) {
    return getByIndex(r'userId_categoryId', [userId, categoryId]);
  }

  IsarUnlockedCategory? getByUserIdCategoryIdSync(
      String? userId, String? categoryId) {
    return getByIndexSync(r'userId_categoryId', [userId, categoryId]);
  }

  Future<bool> deleteByUserIdCategoryId(String? userId, String? categoryId) {
    return deleteByIndex(r'userId_categoryId', [userId, categoryId]);
  }

  bool deleteByUserIdCategoryIdSync(String? userId, String? categoryId) {
    return deleteByIndexSync(r'userId_categoryId', [userId, categoryId]);
  }

  Future<List<IsarUnlockedCategory?>> getAllByUserIdCategoryId(
      List<String?> userIdValues, List<String?> categoryIdValues) {
    final len = userIdValues.length;
    assert(categoryIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([userIdValues[i], categoryIdValues[i]]);
    }

    return getAllByIndex(r'userId_categoryId', values);
  }

  List<IsarUnlockedCategory?> getAllByUserIdCategoryIdSync(
      List<String?> userIdValues, List<String?> categoryIdValues) {
    final len = userIdValues.length;
    assert(categoryIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([userIdValues[i], categoryIdValues[i]]);
    }

    return getAllByIndexSync(r'userId_categoryId', values);
  }

  Future<int> deleteAllByUserIdCategoryId(
      List<String?> userIdValues, List<String?> categoryIdValues) {
    final len = userIdValues.length;
    assert(categoryIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([userIdValues[i], categoryIdValues[i]]);
    }

    return deleteAllByIndex(r'userId_categoryId', values);
  }

  int deleteAllByUserIdCategoryIdSync(
      List<String?> userIdValues, List<String?> categoryIdValues) {
    final len = userIdValues.length;
    assert(categoryIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([userIdValues[i], categoryIdValues[i]]);
    }

    return deleteAllByIndexSync(r'userId_categoryId', values);
  }

  Future<Id> putByUserIdCategoryId(IsarUnlockedCategory object) {
    return putByIndex(r'userId_categoryId', object);
  }

  Id putByUserIdCategoryIdSync(IsarUnlockedCategory object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'userId_categoryId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserIdCategoryId(
      List<IsarUnlockedCategory> objects) {
    return putAllByIndex(r'userId_categoryId', objects);
  }

  List<Id> putAllByUserIdCategoryIdSync(List<IsarUnlockedCategory> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId_categoryId', objects,
        saveLinks: saveLinks);
  }
}

extension IsarUnlockedCategoryQueryWhereSort
    on QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QWhere> {
  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarUnlockedCategoryQueryWhere
    on QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QWhereClause> {
  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      userIdIsNullAnyCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId_categoryId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      userIdIsNotNullAnyCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId_categoryId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      userIdEqualToAnyCategoryId(String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId_categoryId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      userIdNotEqualToAnyCategoryId(String? userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_categoryId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_categoryId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_categoryId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_categoryId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      userIdEqualToCategoryIdIsNull(String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId_categoryId',
        value: [userId, null],
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      userIdEqualToCategoryIdIsNotNull(String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId_categoryId',
        lower: [userId, null],
        includeLower: false,
        upper: [
          userId,
        ],
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      userIdCategoryIdEqualTo(String? userId, String? categoryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId_categoryId',
        value: [userId, categoryId],
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterWhereClause>
      userIdEqualToCategoryIdNotEqualTo(String? userId, String? categoryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_categoryId',
              lower: [userId],
              upper: [userId, categoryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_categoryId',
              lower: [userId, categoryId],
              includeLower: false,
              upper: [userId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_categoryId',
              lower: [userId, categoryId],
              includeLower: false,
              upper: [userId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_categoryId',
              lower: [userId],
              upper: [userId, categoryId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarUnlockedCategoryQueryFilter on QueryBuilder<IsarUnlockedCategory,
    IsarUnlockedCategory, QFilterCondition> {
  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
          QAfterFilterCondition>
      categoryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
          QAfterFilterCondition>
      categoryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> categoryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> completedNodesCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedNodesCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> completedNodesCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedNodesCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> completedNodesCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedNodesCount',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> completedNodesCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedNodesCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> unlockedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unlockedAt',
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> unlockedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unlockedAt',
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> unlockedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unlockedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> unlockedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unlockedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> unlockedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unlockedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> unlockedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unlockedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
          QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
          QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension IsarUnlockedCategoryQueryObject on QueryBuilder<IsarUnlockedCategory,
    IsarUnlockedCategory, QFilterCondition> {}

extension IsarUnlockedCategoryQueryLinks on QueryBuilder<IsarUnlockedCategory,
    IsarUnlockedCategory, QFilterCondition> {}

extension IsarUnlockedCategoryQuerySortBy
    on QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QSortBy> {
  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      sortByCompletedNodesCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedNodesCount', Sort.asc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      sortByCompletedNodesCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedNodesCount', Sort.desc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      sortByUnlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      sortByUnlockedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension IsarUnlockedCategoryQuerySortThenBy
    on QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QSortThenBy> {
  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenByCompletedNodesCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedNodesCount', Sort.asc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenByCompletedNodesCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedNodesCount', Sort.desc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenByUnlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedAt', Sort.asc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenByUnlockedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedAt', Sort.desc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension IsarUnlockedCategoryQueryWhereDistinct
    on QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QDistinct> {
  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QDistinct>
      distinctByCategoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QDistinct>
      distinctByCompletedNodesCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedNodesCount');
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QDistinct>
      distinctByUnlockedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unlockedAt');
    });
  }

  QueryBuilder<IsarUnlockedCategory, IsarUnlockedCategory, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension IsarUnlockedCategoryQueryProperty on QueryBuilder<
    IsarUnlockedCategory, IsarUnlockedCategory, QQueryProperty> {
  QueryBuilder<IsarUnlockedCategory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarUnlockedCategory, String?, QQueryOperations>
      categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<IsarUnlockedCategory, int, QQueryOperations>
      completedNodesCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedNodesCount');
    });
  }

  QueryBuilder<IsarUnlockedCategory, DateTime?, QQueryOperations>
      unlockedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unlockedAt');
    });
  }

  QueryBuilder<IsarUnlockedCategory, String?, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
