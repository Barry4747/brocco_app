// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_user_ux_preferences.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarUserUxPreferencesCollection on Isar {
  IsarCollection<IsarUserUxPreferences> get isarUserUxPreferences =>
      this.collection();
}

const IsarUserUxPreferencesSchema = CollectionSchema(
  name: r'UserUxPreferences',
  id: -6401440202602019277,
  properties: {
    r'keepScreenOn': PropertySchema(
      id: 0,
      name: r'keepScreenOn',
      type: IsarType.bool,
    ),
    r'mascotSounds': PropertySchema(
      id: 1,
      name: r'mascotSounds',
      type: IsarType.bool,
    ),
    r'timerAlarms': PropertySchema(
      id: 2,
      name: r'timerAlarms',
      type: IsarType.bool,
    ),
    r'userId': PropertySchema(
      id: 3,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _isarUserUxPreferencesEstimateSize,
  serialize: _isarUserUxPreferencesSerialize,
  deserialize: _isarUserUxPreferencesDeserialize,
  deserializeProp: _isarUserUxPreferencesDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarUserUxPreferencesGetId,
  getLinks: _isarUserUxPreferencesGetLinks,
  attach: _isarUserUxPreferencesAttach,
  version: '3.1.0+1',
);

int _isarUserUxPreferencesEstimateSize(
  IsarUserUxPreferences object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _isarUserUxPreferencesSerialize(
  IsarUserUxPreferences object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.keepScreenOn);
  writer.writeBool(offsets[1], object.mascotSounds);
  writer.writeBool(offsets[2], object.timerAlarms);
  writer.writeString(offsets[3], object.userId);
}

IsarUserUxPreferences _isarUserUxPreferencesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarUserUxPreferences();
  object.id = id;
  object.keepScreenOn = reader.readBool(offsets[0]);
  object.mascotSounds = reader.readBool(offsets[1]);
  object.timerAlarms = reader.readBool(offsets[2]);
  object.userId = reader.readStringOrNull(offsets[3]);
  return object;
}

P _isarUserUxPreferencesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarUserUxPreferencesGetId(IsarUserUxPreferences object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarUserUxPreferencesGetLinks(
    IsarUserUxPreferences object) {
  return [];
}

void _isarUserUxPreferencesAttach(
    IsarCollection<dynamic> col, Id id, IsarUserUxPreferences object) {
  object.id = id;
}

extension IsarUserUxPreferencesByIndex
    on IsarCollection<IsarUserUxPreferences> {
  Future<IsarUserUxPreferences?> getByUserId(String? userId) {
    return getByIndex(r'userId', [userId]);
  }

  IsarUserUxPreferences? getByUserIdSync(String? userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(String? userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(String? userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<IsarUserUxPreferences?>> getAllByUserId(
      List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<IsarUserUxPreferences?> getAllByUserIdSync(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<String?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(IsarUserUxPreferences object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(IsarUserUxPreferences object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<IsarUserUxPreferences> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<IsarUserUxPreferences> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension IsarUserUxPreferencesQueryWhereSort
    on QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QWhere> {
  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarUserUxPreferencesQueryWhere on QueryBuilder<IsarUserUxPreferences,
    IsarUserUxPreferences, QWhereClause> {
  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhereClause>
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhereClause>
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhereClause>
      userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhereClause>
      userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhereClause>
      userIdEqualTo(String? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterWhereClause>
      userIdNotEqualTo(String? userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarUserUxPreferencesQueryFilter on QueryBuilder<
    IsarUserUxPreferences, IsarUserUxPreferences, QFilterCondition> {
  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
      QAfterFilterCondition> keepScreenOnEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keepScreenOn',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
      QAfterFilterCondition> mascotSoundsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mascotSounds',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
      QAfterFilterCondition> timerAlarmsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timerAlarms',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
      QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
      QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
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

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension IsarUserUxPreferencesQueryObject on QueryBuilder<
    IsarUserUxPreferences, IsarUserUxPreferences, QFilterCondition> {}

extension IsarUserUxPreferencesQueryLinks on QueryBuilder<IsarUserUxPreferences,
    IsarUserUxPreferences, QFilterCondition> {}

extension IsarUserUxPreferencesQuerySortBy
    on QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QSortBy> {
  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      sortByKeepScreenOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keepScreenOn', Sort.asc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      sortByKeepScreenOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keepScreenOn', Sort.desc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      sortByMascotSounds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mascotSounds', Sort.asc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      sortByMascotSoundsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mascotSounds', Sort.desc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      sortByTimerAlarms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerAlarms', Sort.asc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      sortByTimerAlarmsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerAlarms', Sort.desc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension IsarUserUxPreferencesQuerySortThenBy
    on QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QSortThenBy> {
  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenByKeepScreenOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keepScreenOn', Sort.asc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenByKeepScreenOnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keepScreenOn', Sort.desc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenByMascotSounds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mascotSounds', Sort.asc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenByMascotSoundsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mascotSounds', Sort.desc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenByTimerAlarms() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerAlarms', Sort.asc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenByTimerAlarmsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timerAlarms', Sort.desc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension IsarUserUxPreferencesQueryWhereDistinct
    on QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QDistinct> {
  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QDistinct>
      distinctByKeepScreenOn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'keepScreenOn');
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QDistinct>
      distinctByMascotSounds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mascotSounds');
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QDistinct>
      distinctByTimerAlarms() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timerAlarms');
    });
  }

  QueryBuilder<IsarUserUxPreferences, IsarUserUxPreferences, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension IsarUserUxPreferencesQueryProperty on QueryBuilder<
    IsarUserUxPreferences, IsarUserUxPreferences, QQueryProperty> {
  QueryBuilder<IsarUserUxPreferences, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarUserUxPreferences, bool, QQueryOperations>
      keepScreenOnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'keepScreenOn');
    });
  }

  QueryBuilder<IsarUserUxPreferences, bool, QQueryOperations>
      mascotSoundsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mascotSounds');
    });
  }

  QueryBuilder<IsarUserUxPreferences, bool, QQueryOperations>
      timerAlarmsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timerAlarms');
    });
  }

  QueryBuilder<IsarUserUxPreferences, String?, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
