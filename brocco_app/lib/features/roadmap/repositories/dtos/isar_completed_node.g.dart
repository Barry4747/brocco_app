// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_completed_node.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarCompletedNodeCollection on Isar {
  IsarCollection<IsarCompletedNode> get isarCompletedNodes => this.collection();
}

const IsarCompletedNodeSchema = CollectionSchema(
  name: r'IsarCompletedNode',
  id: 3021209247914724669,
  properties: {
    r'imageUrl': PropertySchema(
      id: 0,
      name: r'imageUrl',
      type: IsarType.string,
    ),
    r'nodeId': PropertySchema(
      id: 1,
      name: r'nodeId',
      type: IsarType.string,
    ),
    r'starsEarned': PropertySchema(
      id: 2,
      name: r'starsEarned',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 3,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _isarCompletedNodeEstimateSize,
  serialize: _isarCompletedNodeSerialize,
  deserialize: _isarCompletedNodeDeserialize,
  deserializeProp: _isarCompletedNodeDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId_nodeId': IndexSchema(
      id: -1342910900730570622,
      name: r'userId_nodeId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'nodeId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarCompletedNodeGetId,
  getLinks: _isarCompletedNodeGetLinks,
  attach: _isarCompletedNodeAttach,
  version: '3.1.0+1',
);

int _isarCompletedNodeEstimateSize(
  IsarCompletedNode object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imageUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nodeId;
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

void _isarCompletedNodeSerialize(
  IsarCompletedNode object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.imageUrl);
  writer.writeString(offsets[1], object.nodeId);
  writer.writeLong(offsets[2], object.starsEarned);
  writer.writeString(offsets[3], object.userId);
}

IsarCompletedNode _isarCompletedNodeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarCompletedNode();
  object.id = id;
  object.imageUrl = reader.readStringOrNull(offsets[0]);
  object.nodeId = reader.readStringOrNull(offsets[1]);
  object.starsEarned = reader.readLong(offsets[2]);
  object.userId = reader.readStringOrNull(offsets[3]);
  return object;
}

P _isarCompletedNodeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarCompletedNodeGetId(IsarCompletedNode object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarCompletedNodeGetLinks(
    IsarCompletedNode object) {
  return [];
}

void _isarCompletedNodeAttach(
    IsarCollection<dynamic> col, Id id, IsarCompletedNode object) {
  object.id = id;
}

extension IsarCompletedNodeByIndex on IsarCollection<IsarCompletedNode> {
  Future<IsarCompletedNode?> getByUserIdNodeId(String? userId, String? nodeId) {
    return getByIndex(r'userId_nodeId', [userId, nodeId]);
  }

  IsarCompletedNode? getByUserIdNodeIdSync(String? userId, String? nodeId) {
    return getByIndexSync(r'userId_nodeId', [userId, nodeId]);
  }

  Future<bool> deleteByUserIdNodeId(String? userId, String? nodeId) {
    return deleteByIndex(r'userId_nodeId', [userId, nodeId]);
  }

  bool deleteByUserIdNodeIdSync(String? userId, String? nodeId) {
    return deleteByIndexSync(r'userId_nodeId', [userId, nodeId]);
  }

  Future<List<IsarCompletedNode?>> getAllByUserIdNodeId(
      List<String?> userIdValues, List<String?> nodeIdValues) {
    final len = userIdValues.length;
    assert(nodeIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([userIdValues[i], nodeIdValues[i]]);
    }

    return getAllByIndex(r'userId_nodeId', values);
  }

  List<IsarCompletedNode?> getAllByUserIdNodeIdSync(
      List<String?> userIdValues, List<String?> nodeIdValues) {
    final len = userIdValues.length;
    assert(nodeIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([userIdValues[i], nodeIdValues[i]]);
    }

    return getAllByIndexSync(r'userId_nodeId', values);
  }

  Future<int> deleteAllByUserIdNodeId(
      List<String?> userIdValues, List<String?> nodeIdValues) {
    final len = userIdValues.length;
    assert(nodeIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([userIdValues[i], nodeIdValues[i]]);
    }

    return deleteAllByIndex(r'userId_nodeId', values);
  }

  int deleteAllByUserIdNodeIdSync(
      List<String?> userIdValues, List<String?> nodeIdValues) {
    final len = userIdValues.length;
    assert(nodeIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([userIdValues[i], nodeIdValues[i]]);
    }

    return deleteAllByIndexSync(r'userId_nodeId', values);
  }

  Future<Id> putByUserIdNodeId(IsarCompletedNode object) {
    return putByIndex(r'userId_nodeId', object);
  }

  Id putByUserIdNodeIdSync(IsarCompletedNode object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId_nodeId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserIdNodeId(List<IsarCompletedNode> objects) {
    return putAllByIndex(r'userId_nodeId', objects);
  }

  List<Id> putAllByUserIdNodeIdSync(List<IsarCompletedNode> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId_nodeId', objects, saveLinks: saveLinks);
  }
}

extension IsarCompletedNodeQueryWhereSort
    on QueryBuilder<IsarCompletedNode, IsarCompletedNode, QWhere> {
  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarCompletedNodeQueryWhere
    on QueryBuilder<IsarCompletedNode, IsarCompletedNode, QWhereClause> {
  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      userIdIsNullAnyNodeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId_nodeId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      userIdIsNotNullAnyNodeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId_nodeId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      userIdEqualToAnyNodeId(String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId_nodeId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      userIdNotEqualToAnyNodeId(String? userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_nodeId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_nodeId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_nodeId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_nodeId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      userIdEqualToNodeIdIsNull(String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId_nodeId',
        value: [userId, null],
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      userIdEqualToNodeIdIsNotNull(String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId_nodeId',
        lower: [userId, null],
        includeLower: false,
        upper: [
          userId,
        ],
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      userIdNodeIdEqualTo(String? userId, String? nodeId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId_nodeId',
        value: [userId, nodeId],
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterWhereClause>
      userIdEqualToNodeIdNotEqualTo(String? userId, String? nodeId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_nodeId',
              lower: [userId],
              upper: [userId, nodeId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_nodeId',
              lower: [userId, nodeId],
              includeLower: false,
              upper: [userId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_nodeId',
              lower: [userId, nodeId],
              includeLower: false,
              upper: [userId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId_nodeId',
              lower: [userId],
              upper: [userId, nodeId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarCompletedNodeQueryFilter
    on QueryBuilder<IsarCompletedNode, IsarCompletedNode, QFilterCondition> {
  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageUrl',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      imageUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nodeId',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nodeId',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nodeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nodeId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nodeId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nodeId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      nodeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nodeId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      starsEarnedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'starsEarned',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      starsEarnedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'starsEarned',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      starsEarnedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'starsEarned',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      starsEarnedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'starsEarned',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdEqualTo(
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdGreaterThan(
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdLessThan(
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdBetween(
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdStartsWith(
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdEndsWith(
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

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension IsarCompletedNodeQueryObject
    on QueryBuilder<IsarCompletedNode, IsarCompletedNode, QFilterCondition> {}

extension IsarCompletedNodeQueryLinks
    on QueryBuilder<IsarCompletedNode, IsarCompletedNode, QFilterCondition> {}

extension IsarCompletedNodeQuerySortBy
    on QueryBuilder<IsarCompletedNode, IsarCompletedNode, QSortBy> {
  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      sortByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      sortByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      sortByNodeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeId', Sort.asc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      sortByNodeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeId', Sort.desc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      sortByStarsEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starsEarned', Sort.asc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      sortByStarsEarnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starsEarned', Sort.desc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension IsarCompletedNodeQuerySortThenBy
    on QueryBuilder<IsarCompletedNode, IsarCompletedNode, QSortThenBy> {
  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      thenByImageUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.asc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      thenByImageUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageUrl', Sort.desc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      thenByNodeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeId', Sort.asc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      thenByNodeIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nodeId', Sort.desc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      thenByStarsEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starsEarned', Sort.asc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      thenByStarsEarnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'starsEarned', Sort.desc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension IsarCompletedNodeQueryWhereDistinct
    on QueryBuilder<IsarCompletedNode, IsarCompletedNode, QDistinct> {
  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QDistinct>
      distinctByImageUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QDistinct>
      distinctByNodeId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nodeId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QDistinct>
      distinctByStarsEarned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'starsEarned');
    });
  }

  QueryBuilder<IsarCompletedNode, IsarCompletedNode, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension IsarCompletedNodeQueryProperty
    on QueryBuilder<IsarCompletedNode, IsarCompletedNode, QQueryProperty> {
  QueryBuilder<IsarCompletedNode, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarCompletedNode, String?, QQueryOperations>
      imageUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageUrl');
    });
  }

  QueryBuilder<IsarCompletedNode, String?, QQueryOperations> nodeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nodeId');
    });
  }

  QueryBuilder<IsarCompletedNode, int, QQueryOperations> starsEarnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'starsEarned');
    });
  }

  QueryBuilder<IsarCompletedNode, String?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
