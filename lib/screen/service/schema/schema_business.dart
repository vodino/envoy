import 'dart:convert';

class RequestSchema {
  RequestSchema({
    this.id,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  static const String idKey = 'id';
  static const String titleKey = 'title';

  static const String createdAtKey = 'created_at';
  static const String updatedAtKey = 'updated_at';

  int? id;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;

  RequestSchema copyWith({
    int? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RequestSchema(
      title: title ?? this.title,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  RequestSchema clone() {
    return copyWith(
      title: title,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static RequestSchema fromMap(Map<String, dynamic> data) {
    return RequestSchema(
      id: data[idKey],
      title: data[titleKey],
      createdAt: data[createdAtKey] != null ? DateTime.parse(data[createdAtKey]) : null,
      updatedAt: data[updatedAtKey] != null ? DateTime.parse(data[updatedAtKey]) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      titleKey: title,
      idKey: id,
      createdAtKey: createdAt?.toString(),
      updatedAtKey: updatedAt?.toString(),
    };
  }

  static List<RequestSchema> fromListJson(String source) {
    return List.of(
      (jsonDecode(source)['data'] as List).map((map) => fromMap(map)),
    );
  }

  static RequestSchema fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
