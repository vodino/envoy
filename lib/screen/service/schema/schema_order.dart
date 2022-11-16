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
      pickupPlace: pickupPlace ?? this.pickupPlace,
      deliveryPlace: deliveryPlace ?? this.deliveryPlace,
      name: name ?? this.name,
    );
  }

  OrderSchema clone() {
    return copyWith(
      pickupPlace: pickupPlace,
      deliveryPlace: deliveryPlace,
      name: name,
    );
  }

  static OrderSchema fromMap(Map<String, dynamic> data) {
    return OrderSchema(
      pickupPlace: data[pickupPlaceKey],
      deliveryPlace: data[deliveryPlaceKey],
      name: data[nameKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      pickupPlaceKey: pickupPlace,
      deliveryPlaceKey: deliveryPlace,
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
