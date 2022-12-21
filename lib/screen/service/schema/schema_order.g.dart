// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema_order.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetOrderCollection on Isar {
  IsarCollection<Order> get orders => this.collection();
}

const OrderSchema = CollectionSchema(
  name: r'Order',
  id: 103494837486634173,
  properties: {
    r'amountPaidedByRider': PropertySchema(
      id: 0,
      name: r'amountPaidedByRider',
      type: IsarType.double,
    ),
    r'audioPath': PropertySchema(
      id: 1,
      name: r'audioPath',
      type: IsarType.string,
    ),
    r'client': PropertySchema(
      id: 2,
      name: r'client',
      type: IsarType.object,
      target: r'Client',
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deliveryAdditionalInfo': PropertySchema(
      id: 4,
      name: r'deliveryAdditionalInfo',
      type: IsarType.string,
    ),
    r'deliveryAdditionalInfoWords': PropertySchema(
      id: 5,
      name: r'deliveryAdditionalInfoWords',
      type: IsarType.stringList,
    ),
    r'deliveryPhoneNumber': PropertySchema(
      id: 6,
      name: r'deliveryPhoneNumber',
      type: IsarType.object,
      target: r'Contact',
    ),
    r'deliveryPlace': PropertySchema(
      id: 7,
      name: r'deliveryPlace',
      type: IsarType.object,
      target: r'Place',
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'nameWords': PropertySchema(
      id: 9,
      name: r'nameWords',
      type: IsarType.stringList,
    ),
    r'pickupAdditionalInfo': PropertySchema(
      id: 10,
      name: r'pickupAdditionalInfo',
      type: IsarType.string,
    ),
    r'pickupAdditionalInfoWords': PropertySchema(
      id: 11,
      name: r'pickupAdditionalInfoWords',
      type: IsarType.stringList,
    ),
    r'pickupPhoneNumber': PropertySchema(
      id: 12,
      name: r'pickupPhoneNumber',
      type: IsarType.object,
      target: r'Contact',
    ),
    r'pickupPlace': PropertySchema(
      id: 13,
      name: r'pickupPlace',
      type: IsarType.object,
      target: r'Place',
    ),
    r'price': PropertySchema(
      id: 14,
      name: r'price',
      type: IsarType.double,
    ),
    r'rider': PropertySchema(
      id: 15,
      name: r'rider',
      type: IsarType.object,
      target: r'Client',
    ),
    r'scheduledDate': PropertySchema(
      id: 16,
      name: r'scheduledDate',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 17,
      name: r'status',
      type: IsarType.string,
      enumMap: _OrderstatusEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 18,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _orderEstimateSize,
  serialize: _orderSerialize,
  deserialize: _orderDeserialize,
  deserializeProp: _orderDeserializeProp,
  idName: r'id',
  indexes: {
    r'price': IndexSchema(
      id: 1573330024715551856,
      name: r'price',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'price',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'updatedAt': IndexSchema(
      id: -6238191080293565125,
      name: r'updatedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'updatedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'nameWords': IndexSchema(
      id: 8960882405442787957,
      name: r'nameWords',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'nameWords',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'pickupAdditionalInfoWords': IndexSchema(
      id: -1623606668744037043,
      name: r'pickupAdditionalInfoWords',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'pickupAdditionalInfoWords',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'deliveryAdditionalInfoWords': IndexSchema(
      id: 2006085505639452403,
      name: r'deliveryAdditionalInfoWords',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'deliveryAdditionalInfoWords',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'Place': PlaceSchema,
    r'Contact': ContactSchema,
    r'Client': ClientSchema
  },
  getId: _orderGetId,
  getLinks: _orderGetLinks,
  attach: _orderAttach,
  version: '3.0.6-dev.0',
);

int _orderEstimateSize(
  Order object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.audioPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.client;
    if (value != null) {
      bytesCount +=
          3 + ClientSchema.estimateSize(value, allOffsets[Client]!, allOffsets);
    }
  }
  {
    final value = object.deliveryAdditionalInfo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.deliveryAdditionalInfoWords.length * 3;
  {
    for (var i = 0; i < object.deliveryAdditionalInfoWords.length; i++) {
      final value = object.deliveryAdditionalInfoWords[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.deliveryPhoneNumber;
    if (value != null) {
      bytesCount += 3 +
          ContactSchema.estimateSize(value, allOffsets[Contact]!, allOffsets);
    }
  }
  {
    final value = object.deliveryPlace;
    if (value != null) {
      bytesCount +=
          3 + PlaceSchema.estimateSize(value, allOffsets[Place]!, allOffsets);
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nameWords.length * 3;
  {
    for (var i = 0; i < object.nameWords.length; i++) {
      final value = object.nameWords[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.pickupAdditionalInfo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.pickupAdditionalInfoWords.length * 3;
  {
    for (var i = 0; i < object.pickupAdditionalInfoWords.length; i++) {
      final value = object.pickupAdditionalInfoWords[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.pickupPhoneNumber;
    if (value != null) {
      bytesCount += 3 +
          ContactSchema.estimateSize(value, allOffsets[Contact]!, allOffsets);
    }
  }
  {
    final value = object.pickupPlace;
    if (value != null) {
      bytesCount +=
          3 + PlaceSchema.estimateSize(value, allOffsets[Place]!, allOffsets);
    }
  }
  {
    final value = object.rider;
    if (value != null) {
      bytesCount +=
          3 + ClientSchema.estimateSize(value, allOffsets[Client]!, allOffsets);
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _orderSerialize(
  Order object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amountPaidedByRider);
  writer.writeString(offsets[1], object.audioPath);
  writer.writeObject<Client>(
    offsets[2],
    allOffsets,
    ClientSchema.serialize,
    object.client,
  );
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.deliveryAdditionalInfo);
  writer.writeStringList(offsets[5], object.deliveryAdditionalInfoWords);
  writer.writeObject<Contact>(
    offsets[6],
    allOffsets,
    ContactSchema.serialize,
    object.deliveryPhoneNumber,
  );
  writer.writeObject<Place>(
    offsets[7],
    allOffsets,
    PlaceSchema.serialize,
    object.deliveryPlace,
  );
  writer.writeString(offsets[8], object.name);
  writer.writeStringList(offsets[9], object.nameWords);
  writer.writeString(offsets[10], object.pickupAdditionalInfo);
  writer.writeStringList(offsets[11], object.pickupAdditionalInfoWords);
  writer.writeObject<Contact>(
    offsets[12],
    allOffsets,
    ContactSchema.serialize,
    object.pickupPhoneNumber,
  );
  writer.writeObject<Place>(
    offsets[13],
    allOffsets,
    PlaceSchema.serialize,
    object.pickupPlace,
  );
  writer.writeDouble(offsets[14], object.price);
  writer.writeObject<Client>(
    offsets[15],
    allOffsets,
    ClientSchema.serialize,
    object.rider,
  );
  writer.writeDateTime(offsets[16], object.scheduledDate);
  writer.writeString(offsets[17], object.status?.name);
  writer.writeDateTime(offsets[18], object.updatedAt);
}

Order _orderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Order(
    amountPaidedByRider: reader.readDoubleOrNull(offsets[0]),
    audioPath: reader.readStringOrNull(offsets[1]),
    client: reader.readObjectOrNull<Client>(
      offsets[2],
      ClientSchema.deserialize,
      allOffsets,
    ),
    createdAt: reader.readDateTimeOrNull(offsets[3]),
    deliveryAdditionalInfo: reader.readStringOrNull(offsets[4]),
    deliveryPhoneNumber: reader.readObjectOrNull<Contact>(
      offsets[6],
      ContactSchema.deserialize,
      allOffsets,
    ),
    deliveryPlace: reader.readObjectOrNull<Place>(
      offsets[7],
      PlaceSchema.deserialize,
      allOffsets,
    ),
    id: id,
    name: reader.readStringOrNull(offsets[8]),
    pickupAdditionalInfo: reader.readStringOrNull(offsets[10]),
    pickupPhoneNumber: reader.readObjectOrNull<Contact>(
      offsets[12],
      ContactSchema.deserialize,
      allOffsets,
    ),
    pickupPlace: reader.readObjectOrNull<Place>(
      offsets[13],
      PlaceSchema.deserialize,
      allOffsets,
    ),
    price: reader.readDoubleOrNull(offsets[14]),
    rider: reader.readObjectOrNull<Client>(
      offsets[15],
      ClientSchema.deserialize,
      allOffsets,
    ),
    scheduledDate: reader.readDateTimeOrNull(offsets[16]),
    status: _OrderstatusValueEnumMap[reader.readStringOrNull(offsets[17])],
    updatedAt: reader.readDateTimeOrNull(offsets[18]),
  );
  return object;
}

P _orderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<Client>(
        offset,
        ClientSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readObjectOrNull<Contact>(
        offset,
        ContactSchema.deserialize,
        allOffsets,
      )) as P;
    case 7:
      return (reader.readObjectOrNull<Place>(
        offset,
        PlaceSchema.deserialize,
        allOffsets,
      )) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringList(offset) ?? []) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringList(offset) ?? []) as P;
    case 12:
      return (reader.readObjectOrNull<Contact>(
        offset,
        ContactSchema.deserialize,
        allOffsets,
      )) as P;
    case 13:
      return (reader.readObjectOrNull<Place>(
        offset,
        PlaceSchema.deserialize,
        allOffsets,
      )) as P;
    case 14:
      return (reader.readDoubleOrNull(offset)) as P;
    case 15:
      return (reader.readObjectOrNull<Client>(
        offset,
        ClientSchema.deserialize,
        allOffsets,
      )) as P;
    case 16:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 17:
      return (_OrderstatusValueEnumMap[reader.readStringOrNull(offset)]) as P;
    case 18:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _OrderstatusEnumValueMap = {
  r'accepted': r'accepted',
  r'started': r'started',
  r'collected': r'collected',
  r'delivered': r'delivered',
};
const _OrderstatusValueEnumMap = {
  r'accepted': OrderStatus.accepted,
  r'started': OrderStatus.started,
  r'collected': OrderStatus.collected,
  r'delivered': OrderStatus.delivered,
};

Id _orderGetId(Order object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _orderGetLinks(Order object) {
  return [];
}

void _orderAttach(IsarCollection<dynamic> col, Id id, Order object) {
  object.id = id;
}

extension OrderQueryWhereSort on QueryBuilder<Order, Order, QWhere> {
  QueryBuilder<Order, Order, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Order, Order, QAfterWhere> anyPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'price'),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhere> anyUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'updatedAt'),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhere> anyNameWordsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'nameWords'),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhere>
      anyPickupAdditionalInfoWordsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'pickupAdditionalInfoWords'),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhere>
      anyDeliveryAdditionalInfoWordsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'deliveryAdditionalInfoWords'),
      );
    });
  }
}

extension OrderQueryWhere on QueryBuilder<Order, Order, QWhereClause> {
  QueryBuilder<Order, Order, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Order, Order, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> idBetween(
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

  QueryBuilder<Order, Order, QAfterWhereClause> priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'price',
        value: [null],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'price',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> priceEqualTo(double? price) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'price',
        value: [price],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> priceNotEqualTo(double? price) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'price',
              lower: [],
              upper: [price],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'price',
              lower: [price],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'price',
              lower: [price],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'price',
              lower: [],
              upper: [price],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> priceGreaterThan(
    double? price, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'price',
        lower: [price],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> priceLessThan(
    double? price, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'price',
        lower: [],
        upper: [price],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> priceBetween(
    double? lowerPrice,
    double? upperPrice, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'price',
        lower: [lowerPrice],
        includeLower: includeLower,
        upper: [upperPrice],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> createdAtEqualTo(
      DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> createdAtNotEqualTo(
      DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> createdAtGreaterThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> createdAtLessThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> createdAtBetween(
    DateTime? lowerCreatedAt,
    DateTime? upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> updatedAtEqualTo(
      DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'updatedAt',
        value: [updatedAt],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> updatedAtNotEqualTo(
      DateTime? updatedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [updatedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'updatedAt',
              lower: [],
              upper: [updatedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> updatedAtGreaterThan(
    DateTime? updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [updatedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> updatedAtLessThan(
    DateTime? updatedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [],
        upper: [updatedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> updatedAtBetween(
    DateTime? lowerUpdatedAt,
    DateTime? upperUpdatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'updatedAt',
        lower: [lowerUpdatedAt],
        includeLower: includeLower,
        upper: [upperUpdatedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> nameWordsElementEqualTo(
      String nameWordsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameWords',
        value: [nameWordsElement],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> nameWordsElementNotEqualTo(
      String nameWordsElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameWords',
              lower: [],
              upper: [nameWordsElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameWords',
              lower: [nameWordsElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameWords',
              lower: [nameWordsElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nameWords',
              lower: [],
              upper: [nameWordsElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> nameWordsElementGreaterThan(
    String nameWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nameWords',
        lower: [nameWordsElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> nameWordsElementLessThan(
    String nameWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nameWords',
        lower: [],
        upper: [nameWordsElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> nameWordsElementBetween(
    String lowerNameWordsElement,
    String upperNameWordsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nameWords',
        lower: [lowerNameWordsElement],
        includeLower: includeLower,
        upper: [upperNameWordsElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> nameWordsElementStartsWith(
      String NameWordsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'nameWords',
        lower: [NameWordsElementPrefix],
        upper: ['$NameWordsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> nameWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nameWords',
        value: [''],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause> nameWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'nameWords',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'nameWords',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'nameWords',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'nameWords',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      pickupAdditionalInfoWordsElementEqualTo(
          String pickupAdditionalInfoWordsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'pickupAdditionalInfoWords',
        value: [pickupAdditionalInfoWordsElement],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      pickupAdditionalInfoWordsElementNotEqualTo(
          String pickupAdditionalInfoWordsElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pickupAdditionalInfoWords',
              lower: [],
              upper: [pickupAdditionalInfoWordsElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pickupAdditionalInfoWords',
              lower: [pickupAdditionalInfoWordsElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pickupAdditionalInfoWords',
              lower: [pickupAdditionalInfoWordsElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'pickupAdditionalInfoWords',
              lower: [],
              upper: [pickupAdditionalInfoWordsElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      pickupAdditionalInfoWordsElementGreaterThan(
    String pickupAdditionalInfoWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pickupAdditionalInfoWords',
        lower: [pickupAdditionalInfoWordsElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      pickupAdditionalInfoWordsElementLessThan(
    String pickupAdditionalInfoWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pickupAdditionalInfoWords',
        lower: [],
        upper: [pickupAdditionalInfoWordsElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      pickupAdditionalInfoWordsElementBetween(
    String lowerPickupAdditionalInfoWordsElement,
    String upperPickupAdditionalInfoWordsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pickupAdditionalInfoWords',
        lower: [lowerPickupAdditionalInfoWordsElement],
        includeLower: includeLower,
        upper: [upperPickupAdditionalInfoWordsElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      pickupAdditionalInfoWordsElementStartsWith(
          String PickupAdditionalInfoWordsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'pickupAdditionalInfoWords',
        lower: [PickupAdditionalInfoWordsElementPrefix],
        upper: ['$PickupAdditionalInfoWordsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      pickupAdditionalInfoWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'pickupAdditionalInfoWords',
        value: [''],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      pickupAdditionalInfoWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'pickupAdditionalInfoWords',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'pickupAdditionalInfoWords',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'pickupAdditionalInfoWords',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'pickupAdditionalInfoWords',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      deliveryAdditionalInfoWordsElementEqualTo(
          String deliveryAdditionalInfoWordsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deliveryAdditionalInfoWords',
        value: [deliveryAdditionalInfoWordsElement],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      deliveryAdditionalInfoWordsElementNotEqualTo(
          String deliveryAdditionalInfoWordsElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deliveryAdditionalInfoWords',
              lower: [],
              upper: [deliveryAdditionalInfoWordsElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deliveryAdditionalInfoWords',
              lower: [deliveryAdditionalInfoWordsElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deliveryAdditionalInfoWords',
              lower: [deliveryAdditionalInfoWordsElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'deliveryAdditionalInfoWords',
              lower: [],
              upper: [deliveryAdditionalInfoWordsElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      deliveryAdditionalInfoWordsElementGreaterThan(
    String deliveryAdditionalInfoWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'deliveryAdditionalInfoWords',
        lower: [deliveryAdditionalInfoWordsElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      deliveryAdditionalInfoWordsElementLessThan(
    String deliveryAdditionalInfoWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'deliveryAdditionalInfoWords',
        lower: [],
        upper: [deliveryAdditionalInfoWordsElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      deliveryAdditionalInfoWordsElementBetween(
    String lowerDeliveryAdditionalInfoWordsElement,
    String upperDeliveryAdditionalInfoWordsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'deliveryAdditionalInfoWords',
        lower: [lowerDeliveryAdditionalInfoWordsElement],
        includeLower: includeLower,
        upper: [upperDeliveryAdditionalInfoWordsElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      deliveryAdditionalInfoWordsElementStartsWith(
          String DeliveryAdditionalInfoWordsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'deliveryAdditionalInfoWords',
        lower: [DeliveryAdditionalInfoWordsElementPrefix],
        upper: ['$DeliveryAdditionalInfoWordsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      deliveryAdditionalInfoWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'deliveryAdditionalInfoWords',
        value: [''],
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterWhereClause>
      deliveryAdditionalInfoWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'deliveryAdditionalInfoWords',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'deliveryAdditionalInfoWords',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'deliveryAdditionalInfoWords',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'deliveryAdditionalInfoWords',
              upper: [''],
            ));
      }
    });
  }
}

extension OrderQueryFilter on QueryBuilder<Order, Order, QFilterCondition> {
  QueryBuilder<Order, Order, QAfterFilterCondition>
      amountPaidedByRiderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amountPaidedByRider',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      amountPaidedByRiderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amountPaidedByRider',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> amountPaidedByRiderEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountPaidedByRider',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      amountPaidedByRiderGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountPaidedByRider',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> amountPaidedByRiderLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountPaidedByRider',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> amountPaidedByRiderBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountPaidedByRider',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'audioPath',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'audioPath',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'audioPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'audioPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'audioPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'audioPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> audioPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'audioPath',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'client',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> clientIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'client',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> createdAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deliveryAdditionalInfo',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deliveryAdditionalInfo',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryAdditionalInfo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deliveryAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deliveryAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deliveryAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deliveryAdditionalInfo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryAdditionalInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deliveryAdditionalInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryAdditionalInfoWords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'deliveryAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'deliveryAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'deliveryAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'deliveryAdditionalInfoWords',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryAdditionalInfoWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'deliveryAdditionalInfoWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deliveryAdditionalInfoWords',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deliveryAdditionalInfoWords',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deliveryAdditionalInfoWords',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deliveryAdditionalInfoWords',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deliveryAdditionalInfoWords',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryAdditionalInfoWordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'deliveryAdditionalInfoWords',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryPhoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deliveryPhoneNumber',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      deliveryPhoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deliveryPhoneNumber',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> deliveryPlaceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deliveryPlace',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> deliveryPlaceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deliveryPlace',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> idGreaterThan(
    Id? value, {
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

  QueryBuilder<Order, Order, QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<Order, Order, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<Order, Order, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nameWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nameWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nameWords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nameWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nameWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nameWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nameWords',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nameWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      nameWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nameWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nameWords',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nameWords',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nameWords',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nameWords',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nameWords',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> nameWordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'nameWords',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pickupAdditionalInfo',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pickupAdditionalInfo',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> pickupAdditionalInfoEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pickupAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pickupAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pickupAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> pickupAdditionalInfoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pickupAdditionalInfo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pickupAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pickupAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pickupAdditionalInfo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> pickupAdditionalInfoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pickupAdditionalInfo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pickupAdditionalInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pickupAdditionalInfo',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pickupAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pickupAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pickupAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pickupAdditionalInfoWords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pickupAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pickupAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pickupAdditionalInfoWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pickupAdditionalInfoWords',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pickupAdditionalInfoWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pickupAdditionalInfoWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pickupAdditionalInfoWords',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pickupAdditionalInfoWords',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pickupAdditionalInfoWords',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pickupAdditionalInfoWords',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pickupAdditionalInfoWords',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupAdditionalInfoWordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pickupAdditionalInfoWords',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> pickupPhoneNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pickupPhoneNumber',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition>
      pickupPhoneNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pickupPhoneNumber',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> pickupPlaceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pickupPlace',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> pickupPlaceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pickupPlace',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> riderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rider',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> riderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rider',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> scheduledDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scheduledDate',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> scheduledDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scheduledDate',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> scheduledDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduledDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> scheduledDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduledDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> scheduledDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduledDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> scheduledDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduledDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusEqualTo(
    OrderStatus? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusGreaterThan(
    OrderStatus? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusLessThan(
    OrderStatus? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusBetween(
    OrderStatus? lower,
    OrderStatus? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> updatedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OrderQueryObject on QueryBuilder<Order, Order, QFilterCondition> {
  QueryBuilder<Order, Order, QAfterFilterCondition> client(
      FilterQuery<Client> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'client');
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> deliveryPhoneNumber(
      FilterQuery<Contact> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'deliveryPhoneNumber');
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> deliveryPlace(
      FilterQuery<Place> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'deliveryPlace');
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> pickupPhoneNumber(
      FilterQuery<Contact> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pickupPhoneNumber');
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> pickupPlace(
      FilterQuery<Place> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'pickupPlace');
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> rider(
      FilterQuery<Client> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'rider');
    });
  }
}

extension OrderQueryLinks on QueryBuilder<Order, Order, QFilterCondition> {}

extension OrderQuerySortBy on QueryBuilder<Order, Order, QSortBy> {
  QueryBuilder<Order, Order, QAfterSortBy> sortByAmountPaidedByRider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountPaidedByRider', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByAmountPaidedByRiderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountPaidedByRider', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByAudioPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByAudioPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByDeliveryAdditionalInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryAdditionalInfo', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByDeliveryAdditionalInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryAdditionalInfo', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByPickupAdditionalInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pickupAdditionalInfo', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByPickupAdditionalInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pickupAdditionalInfo', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByScheduledDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledDate', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByScheduledDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledDate', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension OrderQuerySortThenBy on QueryBuilder<Order, Order, QSortThenBy> {
  QueryBuilder<Order, Order, QAfterSortBy> thenByAmountPaidedByRider() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountPaidedByRider', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByAmountPaidedByRiderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountPaidedByRider', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByAudioPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByAudioPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'audioPath', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByDeliveryAdditionalInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryAdditionalInfo', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByDeliveryAdditionalInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryAdditionalInfo', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByPickupAdditionalInfo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pickupAdditionalInfo', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByPickupAdditionalInfoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pickupAdditionalInfo', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByScheduledDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledDate', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByScheduledDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledDate', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Order, Order, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension OrderQueryWhereDistinct on QueryBuilder<Order, Order, QDistinct> {
  QueryBuilder<Order, Order, QDistinct> distinctByAmountPaidedByRider() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountPaidedByRider');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByAudioPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'audioPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByDeliveryAdditionalInfo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryAdditionalInfo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Order, Order, QDistinct>
      distinctByDeliveryAdditionalInfoWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryAdditionalInfoWords');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByNameWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nameWords');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByPickupAdditionalInfo(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pickupAdditionalInfo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByPickupAdditionalInfoWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pickupAdditionalInfoWords');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByScheduledDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledDate');
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Order, Order, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension OrderQueryProperty on QueryBuilder<Order, Order, QQueryProperty> {
  QueryBuilder<Order, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Order, double?, QQueryOperations> amountPaidedByRiderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountPaidedByRider');
    });
  }

  QueryBuilder<Order, String?, QQueryOperations> audioPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'audioPath');
    });
  }

  QueryBuilder<Order, Client?, QQueryOperations> clientProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'client');
    });
  }

  QueryBuilder<Order, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Order, String?, QQueryOperations>
      deliveryAdditionalInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryAdditionalInfo');
    });
  }

  QueryBuilder<Order, List<String>, QQueryOperations>
      deliveryAdditionalInfoWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryAdditionalInfoWords');
    });
  }

  QueryBuilder<Order, Contact?, QQueryOperations>
      deliveryPhoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryPhoneNumber');
    });
  }

  QueryBuilder<Order, Place?, QQueryOperations> deliveryPlaceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryPlace');
    });
  }

  QueryBuilder<Order, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Order, List<String>, QQueryOperations> nameWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nameWords');
    });
  }

  QueryBuilder<Order, String?, QQueryOperations>
      pickupAdditionalInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pickupAdditionalInfo');
    });
  }

  QueryBuilder<Order, List<String>, QQueryOperations>
      pickupAdditionalInfoWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pickupAdditionalInfoWords');
    });
  }

  QueryBuilder<Order, Contact?, QQueryOperations> pickupPhoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pickupPhoneNumber');
    });
  }

  QueryBuilder<Order, Place?, QQueryOperations> pickupPlaceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pickupPlace');
    });
  }

  QueryBuilder<Order, double?, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<Order, Client?, QQueryOperations> riderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rider');
    });
  }

  QueryBuilder<Order, DateTime?, QQueryOperations> scheduledDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledDate');
    });
  }

  QueryBuilder<Order, OrderStatus?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Order, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
