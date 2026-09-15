// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_pack.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStickerPackCollection on Isar {
  IsarCollection<StickerPack> get stickerPacks => this.collection();
}

const StickerPackSchema = CollectionSchema(
  name: r'StickerPack',
  id: 5014667020329468921,
  properties: {
    r'identifier': PropertySchema(
      id: 0,
      name: r'identifier',
      type: IsarType.string,
    ),
    r'lastEdited': PropertySchema(
      id: 1,
      name: r'lastEdited',
      type: IsarType.dateTime,
    ),
    r'licenseAgreementWebsite': PropertySchema(
      id: 2,
      name: r'licenseAgreementWebsite',
      type: IsarType.string,
    ),
    r'name': PropertySchema(id: 3, name: r'name', type: IsarType.string),
    r'privacyPolicyWebsite': PropertySchema(
      id: 4,
      name: r'privacyPolicyWebsite',
      type: IsarType.string,
    ),
    r'publisher': PropertySchema(
      id: 5,
      name: r'publisher',
      type: IsarType.string,
    ),
    r'publisherWebsite': PropertySchema(
      id: 6,
      name: r'publisherWebsite',
      type: IsarType.string,
    ),
    r'trayImagePath': PropertySchema(
      id: 7,
      name: r'trayImagePath',
      type: IsarType.string,
    ),
  },

  estimateSize: _stickerPackEstimateSize,
  serialize: _stickerPackSerialize,
  deserialize: _stickerPackDeserialize,
  deserializeProp: _stickerPackDeserializeProp,
  idName: r'isarId',
  indexes: {},
  links: {
    r'stickers': LinkSchema(
      id: 971236006178801385,
      name: r'stickers',
      target: r'StickerModel',
      single: false,
    ),
  },
  embeddedSchemas: {},

  getId: _stickerPackGetId,
  getLinks: _stickerPackGetLinks,
  attach: _stickerPackAttach,
  version: '3.3.2',
);

int _stickerPackEstimateSize(
  StickerPack object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.identifier.length * 3;
  {
    final value = object.licenseAgreementWebsite;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.privacyPolicyWebsite;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.publisher.length * 3;
  {
    final value = object.publisherWebsite;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.trayImagePath.length * 3;
  return bytesCount;
}

void _stickerPackSerialize(
  StickerPack object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.identifier);
  writer.writeDateTime(offsets[1], object.lastEdited);
  writer.writeString(offsets[2], object.licenseAgreementWebsite);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.privacyPolicyWebsite);
  writer.writeString(offsets[5], object.publisher);
  writer.writeString(offsets[6], object.publisherWebsite);
  writer.writeString(offsets[7], object.trayImagePath);
}

StickerPack _stickerPackDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StickerPack(
    identifier: reader.readString(offsets[0]),
    lastEdited: reader.readDateTime(offsets[1]),
    licenseAgreementWebsite: reader.readStringOrNull(offsets[2]),
    name: reader.readString(offsets[3]),
    privacyPolicyWebsite: reader.readStringOrNull(offsets[4]),
    publisher: reader.readString(offsets[5]),
    publisherWebsite: reader.readStringOrNull(offsets[6]),
    trayImagePath: reader.readString(offsets[7]),
  );
  object.isarId = id;
  return object;
}

P _stickerPackDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stickerPackGetId(StickerPack object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _stickerPackGetLinks(StickerPack object) {
  return [object.stickers];
}

void _stickerPackAttach(
  IsarCollection<dynamic> col,
  Id id,
  StickerPack object,
) {
  object.isarId = id;
  object.stickers.attach(
    col,
    col.isar.collection<StickerModel>(),
    r'stickers',
    id,
  );
}

extension StickerPackQueryWhereSort
    on QueryBuilder<StickerPack, StickerPack, QWhere> {
  QueryBuilder<StickerPack, StickerPack, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StickerPackQueryWhere
    on QueryBuilder<StickerPack, StickerPack, QWhereClause> {
  QueryBuilder<StickerPack, StickerPack, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<StickerPack, StickerPack, QAfterWhereClause> isarIdGreaterThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterWhereClause> isarIdBetween(
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

extension StickerPackQueryFilter
    on QueryBuilder<StickerPack, StickerPack, QFilterCondition> {
  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'identifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'identifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'identifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'identifier',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'identifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'identifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'identifier',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'identifier',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'identifier', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  identifierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'identifier', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> isarIdEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
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

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  lastEditedEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastEdited', value: value),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  lastEditedGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastEdited',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  lastEditedLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastEdited',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  lastEditedBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastEdited',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'licenseAgreementWebsite'),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'licenseAgreementWebsite'),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'licenseAgreementWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'licenseAgreementWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'licenseAgreementWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'licenseAgreementWebsite',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'licenseAgreementWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'licenseAgreementWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'licenseAgreementWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'licenseAgreementWebsite',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'licenseAgreementWebsite',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  licenseAgreementWebsiteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'licenseAgreementWebsite',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'privacyPolicyWebsite'),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'privacyPolicyWebsite'),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'privacyPolicyWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'privacyPolicyWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'privacyPolicyWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'privacyPolicyWebsite',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'privacyPolicyWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'privacyPolicyWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'privacyPolicyWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'privacyPolicyWebsite',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'privacyPolicyWebsite', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  privacyPolicyWebsiteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'privacyPolicyWebsite',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'publisher',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'publisher',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'publisher',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'publisher',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'publisher',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'publisher',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'publisher',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'publisher',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'publisher', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'publisher', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'publisherWebsite'),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'publisherWebsite'),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'publisherWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'publisherWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'publisherWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'publisherWebsite',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'publisherWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'publisherWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'publisherWebsite',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'publisherWebsite',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'publisherWebsite', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  publisherWebsiteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'publisherWebsite', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'trayImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'trayImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'trayImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'trayImagePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'trayImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'trayImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'trayImagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'trayImagePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'trayImagePath', value: ''),
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  trayImagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'trayImagePath', value: ''),
      );
    });
  }
}

extension StickerPackQueryObject
    on QueryBuilder<StickerPack, StickerPack, QFilterCondition> {}

extension StickerPackQueryLinks
    on QueryBuilder<StickerPack, StickerPack, QFilterCondition> {
  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition> stickers(
    FilterQuery<StickerModel> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stickers');
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  stickersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickers', length, true, length, true);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  stickersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickers', 0, true, 0, true);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  stickersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickers', 0, false, 999999, true);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  stickersLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickers', 0, true, length, include);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  stickersLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stickers', length, include, 999999, true);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterFilterCondition>
  stickersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'stickers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension StickerPackQuerySortBy
    on QueryBuilder<StickerPack, StickerPack, QSortBy> {
  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> sortByIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> sortByIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> sortByLastEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEdited', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> sortByLastEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEdited', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  sortByLicenseAgreementWebsite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'licenseAgreementWebsite', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  sortByLicenseAgreementWebsiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'licenseAgreementWebsite', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  sortByPrivacyPolicyWebsite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privacyPolicyWebsite', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  sortByPrivacyPolicyWebsiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privacyPolicyWebsite', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> sortByPublisher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> sortByPublisherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  sortByPublisherWebsite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisherWebsite', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  sortByPublisherWebsiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisherWebsite', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> sortByTrayImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trayImagePath', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  sortByTrayImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trayImagePath', Sort.desc);
    });
  }
}

extension StickerPackQuerySortThenBy
    on QueryBuilder<StickerPack, StickerPack, QSortThenBy> {
  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByLastEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEdited', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByLastEditedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastEdited', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  thenByLicenseAgreementWebsite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'licenseAgreementWebsite', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  thenByLicenseAgreementWebsiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'licenseAgreementWebsite', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  thenByPrivacyPolicyWebsite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privacyPolicyWebsite', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  thenByPrivacyPolicyWebsiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'privacyPolicyWebsite', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByPublisher() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByPublisherDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisher', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  thenByPublisherWebsite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisherWebsite', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  thenByPublisherWebsiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publisherWebsite', Sort.desc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy> thenByTrayImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trayImagePath', Sort.asc);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QAfterSortBy>
  thenByTrayImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trayImagePath', Sort.desc);
    });
  }
}

extension StickerPackQueryWhereDistinct
    on QueryBuilder<StickerPack, StickerPack, QDistinct> {
  QueryBuilder<StickerPack, StickerPack, QDistinct> distinctByIdentifier({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'identifier', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QDistinct> distinctByLastEdited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastEdited');
    });
  }

  QueryBuilder<StickerPack, StickerPack, QDistinct>
  distinctByLicenseAgreementWebsite({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'licenseAgreementWebsite',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QDistinct>
  distinctByPrivacyPolicyWebsite({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'privacyPolicyWebsite',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QDistinct> distinctByPublisher({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'publisher', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StickerPack, StickerPack, QDistinct> distinctByPublisherWebsite({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'publisherWebsite',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<StickerPack, StickerPack, QDistinct> distinctByTrayImagePath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'trayImagePath',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension StickerPackQueryProperty
    on QueryBuilder<StickerPack, StickerPack, QQueryProperty> {
  QueryBuilder<StickerPack, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<StickerPack, String, QQueryOperations> identifierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'identifier');
    });
  }

  QueryBuilder<StickerPack, DateTime, QQueryOperations> lastEditedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastEdited');
    });
  }

  QueryBuilder<StickerPack, String?, QQueryOperations>
  licenseAgreementWebsiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'licenseAgreementWebsite');
    });
  }

  QueryBuilder<StickerPack, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<StickerPack, String?, QQueryOperations>
  privacyPolicyWebsiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'privacyPolicyWebsite');
    });
  }

  QueryBuilder<StickerPack, String, QQueryOperations> publisherProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'publisher');
    });
  }

  QueryBuilder<StickerPack, String?, QQueryOperations>
  publisherWebsiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'publisherWebsite');
    });
  }

  QueryBuilder<StickerPack, String, QQueryOperations> trayImagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trayImagePath');
    });
  }
}
