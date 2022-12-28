import 'dart:convert';

import 'package:equatable/equatable.dart';

class RiderResultSchema extends Equatable {
  const RiderResultSchema({
    required this.available,
    required this.prices,
    required this.distance,
    required this.duration,
  });

  static const pricesKey = 'price';
  static const availableKey = 'available';
  static const distanceKey = 'distance';
  static const durationKey = 'duration';

  final List<PriceSchema> prices;
  final bool available;
  final int distance;
  final int duration;

  @override
  List<Object?> get props => [
        prices,
        available,
        distance,
        duration,
      ];

  RiderResultSchema copyWith({
    List<PriceSchema>? prices,
    bool? available,
    int? distance,
    int? duration,
  }) {
    return RiderResultSchema(
      prices: prices ?? this.prices,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      available: available ?? this.available,
    );
  }

  RiderResultSchema clone() {
    return copyWith(
      prices: prices,
      duration: duration,
      distance: distance,
      available: available,
    );
  }

  static RiderResultSchema fromMap(Map<String, dynamic> data) {
    return RiderResultSchema(
      prices: PriceSchema.fromListMap((data[pricesKey] as List).cast<Map<String, dynamic>>()),
      distance: (data[distanceKey] as num).toInt(),
      duration: (data[durationKey] as num).toInt(),
      available: data[availableKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      pricesKey: prices,
      distanceKey: distance,
      durationKey: duration,
      availableKey: available,
    };
  }

  static List<RiderResultSchema> fromListJson(String source) {
    return List.of(
      (jsonDecode(source)['data'] as List).map((map) => fromMap(map)),
    );
  }

  static RiderResultSchema fromJson(String source) {
    return fromMap(jsonDecode(source)['data']);
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

enum RiderType {
  car,
  motorbike;

  static RiderType fromString(String value) {
    switch (value) {
      case 'car':
        return car;
      default:
        return motorbike;
    }
  }
}

class PriceSchema extends Equatable {
  const PriceSchema({
    required this.price,
    required this.type,
  });

  static const typeKey = 'type';
  static const priceKey = 'price';

  final RiderType type;
  final double price;

  @override
  List<Object?> get props => [
        type,
        price,
      ];

  PriceSchema copyWith({
    RiderType? type,
    double? price,
  }) {
    return PriceSchema(
      type: type ?? this.type,
      price: price ?? this.price,
    );
  }

  PriceSchema clone() {
    return copyWith(
      type: type,
      price: price,
    );
  }

  static PriceSchema fromMap(Map<String, dynamic> data) {
    return PriceSchema(
      type: RiderType.fromString(data[typeKey]),
      price: (data[priceKey] as num).toDouble(),
    );
  }

  static List<PriceSchema> fromListMap(List<Map<String, dynamic>> data) {
    return data.map((e) => fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      typeKey: type,
      priceKey: price,
    };
  }

  static List<PriceSchema> fromListJson(String source) {
    return List.of((jsonDecode(source)['data'] as List).map((map) => fromMap(map)));
  }

  static PriceSchema fromJson(String source) {
    return fromMap(jsonDecode(source)['data']);
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
