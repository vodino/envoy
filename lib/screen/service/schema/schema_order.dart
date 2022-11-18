import 'dart:convert';

import 'package:equatable/equatable.dart';

import '_schema.dart';

class OrderSchema extends Equatable {
  const OrderSchema({
    required this.deliveryPlace,
    required this.pickupPlace,
    this.name,
  });

  static const deliveryPlaceKey = 'delivery_place';
  static const pickupPlaceKey = 'pickup_place';
  static const nameKey = 'name';

  final PlaceSchema deliveryPlace;
  final PlaceSchema pickupPlace;
  final String? name;

  @override
  List<Object?> get props => [
        pickupPlace,
        deliveryPlace,
        name,
      ];

  OrderSchema copyWith({
    PlaceSchema? deliveryPlace,
    PlaceSchema? pickupPlace,
    String? name,
  }) {
    return OrderSchema(
      deliveryPlace: deliveryPlace ?? this.deliveryPlace,
      pickupPlace: pickupPlace ?? this.pickupPlace,
      name: name ?? this.name,
    );
  }

  OrderSchema clone() {
    return copyWith(
      deliveryPlace: deliveryPlace,
      pickupPlace: pickupPlace,
      name: name,
    );
  }

  static OrderSchema fromMap(Map<String, dynamic> data) {
    return OrderSchema(
      deliveryPlace: data[deliveryPlaceKey],
      pickupPlace: data[pickupPlaceKey],
      name: data[nameKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      deliveryPlaceKey: deliveryPlace,
      pickupPlaceKey: pickupPlace,
      nameKey: name,
    };
  }

  static List<OrderSchema> fromListJson(String source) {
    return List.of(
      (jsonDecode(source)['data'] as List).map((map) => fromMap(map)),
    );
  }

  static OrderSchema fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
