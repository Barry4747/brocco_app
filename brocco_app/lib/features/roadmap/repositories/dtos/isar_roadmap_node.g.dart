// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_roadmap_node.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarRoadmapNodeCollection on Isar {
  IsarCollection<IsarRoadmapNode> get isarRoadmapNodes => this.collection();
}

const IsarRoadmapNodeSchema = CollectionSchema(
  name: r'IsarRoadmapNode',
  id: 6717640760844026612,
  properties: {
    r'categoryId': PropertySchema(
      id: 0,
      name: r'categoryId',
      type: IsarType.string,
    ),
    r'mapColumn': PropertySchema(
      id: 1,
      name: r'mapColumn',
      type: IsarType.long,
    ),
    r'mapRow': PropertySchema(
      id: 2,
      name: r'mapRow',
      type: IsarType.long,
    ),
    r'prerequisiteIds': PropertySchema(
      id: 3,
      name: r'prerequisiteIds',
      type: IsarType.stringList,
    ),
    r'previewImageUrl': PropertySchema(
      id: 4,
      name: r'previewImageUrl',
      type: IsarType.string,
    ),
    r'recipeId': PropertySchema(
      id: 5,
      name: r'recipeId',
      type: IsarType.string,
    ),
    r'supabaseId': PropertySchema(
      id: 6,
      name: r'supabaseId',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _isarRoadmapNodeEstimateSize,
  serialize: _isarRoadmapNodeSerialize,
  deserialize: _isarRoadmapNodeDeserialize,
  deserializeProp: _isarRoadmapNodeDeserializeProp,
  idName: r'id',
  indexes: {
    r'supabaseId': IndexSchema(
      id: 2753382765909358918,
      name: r'supabaseId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'supabaseId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'categoryId': IndexSchema(
      id: -8798048739239305339,
      name: r'categoryId',
      unique: false,
      replace: false,
      properties: [
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
  getId: _isarRoadmapNodeGetId,
  getLinks: _isarRoadmapNodeGetLinks,
  attach: _isarRoadmapNodeAttach,
  version: '3.1.0+1',
);

int _isarRoadmapNodeEstimateSize(
  IsarRoadmapNode object,
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
  bytesCount += 3 + object.prerequisiteIds.length * 3;
  {
    for (var i = 0; i < object.prerequisiteIds.length; i++) {
      final value = object.prerequisiteIds[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.previewImageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.recipeId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.supabaseId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarRoadmapNodeSerialize(
  IsarRoadmapNode object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.categoryId);
  writer.writeLong(offsets[1], object.mapColumn);
  writer.writeLong(offsets[2], object.mapRow);
  writer.writeStringList(offsets[3], object.prerequisiteIds);
  writer.writeString(offsets[4], object.previewImageUrl);
  writer.writeString(offsets[5], object.recipeId);
  writer.writeString(offsets[6], object.supabaseId);
  writer.writeString(offsets[7], object.title);
}

IsarRoadmapNode _isarRoadmapNodeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarRoadmapNode();
  object.categoryId = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.mapColumn = reader.readLong(offsets[1]);
  object.mapRow = reader.readLong(offsets[2]);
  object.prerequisiteIds = reader.readStringList(offsets[3]) ?? [];
  object.previewImageUrl = reader.readStringOrNull(offsets[4]);
  object.recipeId = reader.readStringOrNull(offsets[5]);
  object.supabaseId = reader.readStringOrNull(offsets[6]);
  object.title = reader.readStringOrNull(offsets[7]);
  return object;
}

P _isarRoadmapNodeDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarRoadmapNodeGetId(IsarRoadmapNode object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarRoadmapNodeGetLinks(IsarRoadmapNode object) {
  return [];
}

void _isarRoadmapNodeAttach(
    IsarCollection<dynamic> col, Id id, IsarRoadmapNode object) {
  object.id = id;
}

extension IsarRoadmapNodeByIndex on IsarCollection<IsarRoadmapNode> {
  Future<IsarRoadmapNode?> getBySupabaseId(String? supabaseId) {
    return getByIndex(r'supabaseId', [supabaseId]);
  }

  IsarRoadmapNode? getBySupabaseIdSync(String? supabaseId) {
    return getByIndexSync(r'supabaseId', [supabaseId]);
  }

  Future<bool> deleteBySupabaseId(String? supabaseId) {
    return deleteByIndex(r'supabaseId', [supabaseId]);
  }

  bool deleteBySupabaseIdSync(String? supabaseId) {
    return deleteByIndexSync(r'supabaseId', [supabaseId]);
  }

  Future<List<IsarRoadmapNode?>> getAllBySupabaseId(
      List<String?> supabaseIdValues) {
    final values = supabaseIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'supabaseId', values);
  }

  List<IsarRoadmapNode?> getAllBySupabaseIdSync(
      List<String?> supabaseIdValues) {
    final values = supabaseIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'supabaseId', values);
  }

  Future<int> deleteAllBySupabaseId(List<String?> supabaseIdValues) {
    final values = supabaseIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'supabaseId', values);
  }

  int deleteAllBySupabaseIdSync(List<String?> supabaseIdValues) {
    final values = supabaseIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'supabaseId', values);
  }

  Future<Id> putBySupabaseId(IsarRoadmapNode object) {
    return putByIndex(r'supabaseId', object);
  }

  Id putBySupabaseIdSync(IsarRoadmapNode object, {bool saveLinks = true}) {
    return putByIndexSync(r'supabaseId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySupabaseId(List<IsarRoadmapNode> objects) {
    return putAllByIndex(r'supabaseId', objects);
  }

  List<Id> putAllBySupabaseIdSync(List<IsarRoadmapNode> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'supabaseId', objects, saveLinks: saveLinks);
  }
}

extension IsarRoadmapNodeQueryWhereSort
    on QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QWhere> {
  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarRoadmapNodeQueryWhere
    on QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QWhereClause> {
  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause> idBetween(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
      supabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
      supabaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'supabaseId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
      supabaseIdEqualTo(String? supabaseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'supabaseId',
        value: [supabaseId],
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
      supabaseIdNotEqualTo(String? supabaseId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [],
              upper: [supabaseId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [supabaseId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [supabaseId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'supabaseId',
              lower: [],
              upper: [supabaseId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
      categoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'categoryId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
      categoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'categoryId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
      categoryIdEqualTo(String? categoryId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'categoryId',
        value: [categoryId],
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterWhereClause>
      categoryIdNotEqualTo(String? categoryId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoryId',
              lower: [],
              upper: [categoryId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoryId',
              lower: [categoryId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoryId',
              lower: [categoryId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'categoryId',
              lower: [],
              upper: [categoryId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarRoadmapNodeQueryFilter
    on QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QFilterCondition> {
  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdEqualTo(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdGreaterThan(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdLessThan(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdBetween(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdStartsWith(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdEndsWith(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'categoryId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'categoryId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      categoryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'categoryId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      mapColumnEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mapColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      mapColumnGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mapColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      mapColumnLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mapColumn',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      mapColumnBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mapColumn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      mapRowEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mapRow',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      mapRowGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mapRow',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      mapRowLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mapRow',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      mapRowBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mapRow',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prerequisiteIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prerequisiteIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prerequisiteIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prerequisiteIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'prerequisiteIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'prerequisiteIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'prerequisiteIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'prerequisiteIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prerequisiteIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'prerequisiteIds',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'prerequisiteIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'prerequisiteIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'prerequisiteIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'prerequisiteIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'prerequisiteIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      prerequisiteIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'prerequisiteIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'previewImageUrl',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'previewImageUrl',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previewImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'previewImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'previewImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'previewImageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'previewImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'previewImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'previewImageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'previewImageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previewImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      previewImageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'previewImageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recipeId',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recipeId',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recipeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recipeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recipeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recipeId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      recipeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recipeId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'supabaseId',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'supabaseId',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'supabaseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'supabaseId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'supabaseId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'supabaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      supabaseIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'supabaseId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension IsarRoadmapNodeQueryObject
    on QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QFilterCondition> {}

extension IsarRoadmapNodeQueryLinks
    on QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QFilterCondition> {}

extension IsarRoadmapNodeQuerySortBy
    on QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QSortBy> {
  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByMapColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapColumn', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByMapColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapColumn', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy> sortByMapRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapRow', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByMapRowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapRow', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByPreviewImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewImageUrl', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByPreviewImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewImageUrl', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByRecipeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByRecipeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarRoadmapNodeQuerySortThenBy
    on QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QSortThenBy> {
  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByMapColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapColumn', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByMapColumnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapColumn', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy> thenByMapRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapRow', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByMapRowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mapRow', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByPreviewImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewImageUrl', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByPreviewImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previewImageUrl', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByRecipeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByRecipeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recipeId', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenBySupabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenBySupabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'supabaseId', Sort.desc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarRoadmapNodeQueryWhereDistinct
    on QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QDistinct> {
  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QDistinct>
      distinctByCategoryId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QDistinct>
      distinctByMapColumn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mapColumn');
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QDistinct> distinctByMapRow() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mapRow');
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QDistinct>
      distinctByPrerequisiteIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prerequisiteIds');
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QDistinct>
      distinctByPreviewImageUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'previewImageUrl',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QDistinct> distinctByRecipeId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recipeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QDistinct>
      distinctBySupabaseId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'supabaseId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension IsarRoadmapNodeQueryProperty
    on QueryBuilder<IsarRoadmapNode, IsarRoadmapNode, QQueryProperty> {
  QueryBuilder<IsarRoadmapNode, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarRoadmapNode, String?, QQueryOperations>
      categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<IsarRoadmapNode, int, QQueryOperations> mapColumnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mapColumn');
    });
  }

  QueryBuilder<IsarRoadmapNode, int, QQueryOperations> mapRowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mapRow');
    });
  }

  QueryBuilder<IsarRoadmapNode, List<String>, QQueryOperations>
      prerequisiteIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prerequisiteIds');
    });
  }

  QueryBuilder<IsarRoadmapNode, String?, QQueryOperations>
      previewImageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previewImageUrl');
    });
  }

  QueryBuilder<IsarRoadmapNode, String?, QQueryOperations> recipeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recipeId');
    });
  }

  QueryBuilder<IsarRoadmapNode, String?, QQueryOperations>
      supabaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'supabaseId');
    });
  }

  QueryBuilder<IsarRoadmapNode, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
