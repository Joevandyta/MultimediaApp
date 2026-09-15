// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStickerModelCollection on Isar {
  IsarCollection<StickerModel> get stickerModels => this.collection();
}

const StickerModelSchema = CollectionSchema(
  name: r'StickerModel',
  id: -3420117257359591185,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'emojis': PropertySchema(
      id: 1,
      name: r'emojis',
      type: IsarType.stringList,
    ),
    r'imagePath': PropertySchema(
      id: 2,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'savedStickerId': PropertySchema(
      id: 3,
      name: r'savedStickerId',
      type: IsarType.string,
    ),
  },

  estimateSize: _stickerModelEstimateSize,
  serialize: _stickerModelSerialize,
  deserialize: _stickerModelDeserialize,
  deserializeProp: _stickerModelDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {
    r'pack': LinkSchema(
      id: 744617758366573550,
      name: r'pack',
      target: r'StickerPack',
      single: true,
      linkName: r'stickers',
    ),
  },
  embeddedSchemas: {},

  getId: _stickerModelGetId,
  getLinks: _stickerModelGetLinks,
  attach: _stickerModelAttach,
  version: '3.3.2',
);

int _stickerModelEstimateSize(
  StickerModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.emojis.length * 3;
  {
    for (var i = 0; i < object.emojis.length; i++) {
      final value = object.emojis[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.imagePath.length * 3;
  bytesCount += 3 + object.savedStickerId.length * 3;
  return bytesCount;
}

void _stickerModelSerialize(
  StickerModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeStringList(offsets[1], object.emojis);
  writer.writeString(offsets[2], object.imagePath);
  writer.writeString(offsets[3], object.savedStickerId);
}

StickerModel _stickerModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StickerModel(
    createdAt: reader.readDateTime(offsets[0]),
    emojis: reader.readStringList(offsets[1]) ?? const [],
    imagePath: reader.readString(offsets[2]),
    savedStickerId: reader.readString(offsets[3]),
  );
  object.isarId = id;
  return object;
}

P _stickerModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? const []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stickerModelGetId(StickerModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _stickerModelGetLinks(StickerModel object) {
  return [object.pack];
}

void _stickerModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  StickerModel object,
) {
  object.isarId = id;
  object.pack.attach(col, col.isar.collection<StickerPack>(), r'pack', id);
}

extension StickerModelQueryWhereSort
    on QueryBuilder<StickerModel, StickerModel, QWhere> {
  QueryBuilder<StickerModel, StickerModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StickerModelQueryWhere
    on QueryBuilder<StickerModel, StickerModel, QWhereClause> {
  QueryBuilder<StickerModel, StickerModel, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterWhereClause> isarIdNotEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterWhereClause> isarIdGreaterThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension StickerModelQueryFilter
    on QueryBuilder<StickerModel, StickerModel, QFilterCondition> {
  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'createdAt', value: value),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  createdAtGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  createdAtLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'createdAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'createdAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'emojis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'emojis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'emojis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'emojis',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'emojis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'emojis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'emojis',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'emojis',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'emojis', value: ''),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'emojis', value: ''),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'emojis', length, true, length, true);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'emojis', 0, true, 0, true);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'emojis', 0, false, 999999, true);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'emojis', 0, true, length, include);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'emojis', length, include, 999999, true);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  emojisLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'emojis',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'imagePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'imagePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition> isarIdEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'savedStickerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'savedStickerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'savedStickerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'savedStickerId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'savedStickerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'savedStickerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'savedStickerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'savedStickerId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'savedStickerId', value: ''),
      );
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition>
  savedStickerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'savedStickerId', value: ''),
      );
    });
  }
}

extension StickerModelQueryObject
    on QueryBuilder<StickerModel, StickerModel, QFilterCondition> {}

extension StickerModelQueryLinks
    on QueryBuilder<StickerModel, StickerModel, QFilterCondition> {
  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition> pack(
    FilterQuery<StickerPack> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'pack');
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterFilterCondition> packIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'pack', 0, true, 0, true);
    });
  }
}

extension StickerModelQuerySortBy
    on QueryBuilder<StickerModel, StickerModel, QSortBy> {
  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy>
  sortBySavedStickerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedStickerId', Sort.asc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy>
  sortBySavedStickerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedStickerId', Sort.desc);
    });
  }
}

extension StickerModelQuerySortThenBy
    on QueryBuilder<StickerModel, StickerModel, QSortThenBy> {
  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy>
  thenBySavedStickerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedStickerId', Sort.asc);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QAfterSortBy>
  thenBySavedStickerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'savedStickerId', Sort.desc);
    });
  }
}

extension StickerModelQueryWhereDistinct
    on QueryBuilder<StickerModel, StickerModel, QDistinct> {
  QueryBuilder<StickerModel, StickerModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<StickerModel, StickerModel, QDistinct> distinctByEmojis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emojis');
    });
  }

  QueryBuilder<StickerModel, StickerModel, QDistinct> distinctByImagePath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StickerModel, StickerModel, QDistinct> distinctBySavedStickerId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'savedStickerId',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension StickerModelQueryProperty
    on QueryBuilder<StickerModel, StickerModel, QQueryProperty> {
  QueryBuilder<StickerModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<StickerModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<StickerModel, List<String>, QQueryOperations> emojisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emojis');
    });
  }

  QueryBuilder<StickerModel, String, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<StickerModel, String, QQueryOperations>
  savedStickerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'savedStickerId');
    });
  }
}
