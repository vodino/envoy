import 'dart:convert';

import 'package:isar/isar.dart';

part 'schema_client.g.dart';

@embedded
class Client {
Client({
    this.id,
    this.avatar,
    this.fullName,
    this.accessToken,
    this.phoneNumber,
  });

  static const String idKey = 'id';
  static const String avatarKey = 'avatar';
  static const String fullNameKey = 'full_name';
  static const String accessTokenKey = 'accessToken';
  static const String phoneNumberKey = 'phone_number';

  int? id;
  String? avatar;
  String? fullName;
  String? phoneNumber;
  String? accessToken;

  @override
  String toString() {
    return toMap().toString();
  }

  Client copyWith({
    int? id,
    String? avatar,
    String? fullName,
    String? accessToken,
    String? phoneNumber,
  }) {
    return Client(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  Client clone() {
    return copyWith(
      id: id,
      avatar: avatar,
      fullName: fullName,
      phoneNumber: phoneNumber,
      accessToken: accessToken,
    );
  }

  static Client fromMap(Map<String, dynamic> value) {
    return Client(
      id: value[idKey],
      avatar: value[avatarKey],
      fullName: value[fullNameKey],
      phoneNumber: value[phoneNumberKey],
      accessToken: value[accessTokenKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idKey: id,
      avatarKey: avatar,
      fullNameKey: fullName,
      phoneNumberKey: phoneNumber,
      accessTokenKey: accessToken,
    };
  }

  static List<Client> fromServerListJson(String source) {
    return List.of((jsonDecode(source)['data'] as List).map((map) => fromMap(map)));
  }

  static Client fromServerJson(String source) {
    final data = jsonDecode(source);
    return fromMap(data['data']).copyWith(
      accessToken: data[accessTokenKey],
    );
  }

  static Client fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
