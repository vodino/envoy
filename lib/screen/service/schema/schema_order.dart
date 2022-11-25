import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '_schema.dart';

class OrderSchema extends Equatable {
  const OrderSchema({
    required this.deliveryPlace,
    required this.pickupPlace,
    this.name,
    this.description,
    this.pickupPhoneNumber,
    this.deliveryPhoneNumber,
    this.price,
    this.scheduledDate,
  });

  static const deliveryPlaceKey = 'delivery_place';
  static const pickupPlaceKey = 'pickup_place';
  static const nameKey = 'name';
  static const descriptionKey = 'description';
  static const pickupPhoneNumberKey = 'pickup_phone_number';
  static const deliveryPhoneNumberKey = 'delivery_phone_number';
  static const priceKey = 'price';
  static const scheduledDateKey = 'scheduled_date';

  final PlaceSchema deliveryPlace;
  final PlaceSchema pickupPlace;
  final String? name;
  final String? description;
  final Contact? pickupPhoneNumber;
  final Contact? deliveryPhoneNumber;
  final double? price;
  final DateTime? scheduledDate;

  @override
  List<Object?> get props => [
        pickupPlace,
        deliveryPlace,
        name,
        description,
        pickupPhoneNumber,
        deliveryPhoneNumber,
        price,
        scheduledDate,
      ];

  OrderSchema copyWith({
    PlaceSchema? deliveryPlace,
    PlaceSchema? pickupPlace,
    String? name,
    String? description,
    Contact? pickupPhoneNumber,
    Contact? deliveryPhoneNumber,
    double? price,
    DateTime? scheduledDate,
  }) {
    return OrderSchema(
      deliveryPlace: deliveryPlace ?? this.deliveryPlace,
      pickupPlace: pickupPlace ?? this.pickupPlace,
      name: name ?? this.name,
      description: description ?? this.description,
      pickupPhoneNumber: pickupPhoneNumber ?? this.pickupPhoneNumber,
      deliveryPhoneNumber: deliveryPhoneNumber ?? this.deliveryPhoneNumber,
      price: price ?? this.price,
      scheduledDate: scheduledDate ?? this.scheduledDate,
    );
  }

  OrderSchema clone() {
    return copyWith(
      deliveryPlace: deliveryPlace,
      pickupPlace: pickupPlace,
      name: name,
      description: description,
      pickupPhoneNumber: pickupPhoneNumber,
      deliveryPhoneNumber: deliveryPhoneNumber,
      price: price,
      scheduledDate: scheduledDate,
    );
  }

  static OrderSchema fromMap(Map<String, dynamic> data) {
    return OrderSchema(
      deliveryPlace: data[deliveryPlaceKey],
      pickupPlace: data[pickupPlaceKey],
      name: data[nameKey],
      description: data[descriptionKey],
      deliveryPhoneNumber: Contact(
        phones: (data[deliveryPhoneNumberKey] as String).split(', ').map((e) => Phone(e)).toList(),
      ),
      pickupPhoneNumber: Contact(
        phones: (data[pickupPhoneNumberKey] as String).split(', ').map((e) => Phone(e)).toList(),
      ),
      price: (data[priceKey] as num).toDouble(),
      scheduledDate: DateTime.parse(data[scheduledDateKey]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      deliveryPlaceKey: deliveryPlace,
      pickupPlaceKey: pickupPlace,
      nameKey: name,
      descriptionKey: description,
      pickupPhoneNumberKey: pickupPhoneNumber,
      deliveryPhoneNumberKey: deliveryPhoneNumber,
      priceKey: price,
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
