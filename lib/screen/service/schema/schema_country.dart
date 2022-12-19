import 'dart:convert';

class Country {
  Country({
    this.name,
    this.dialCode,
    this.code,
  });

  static const dialCodeKey = 'dial_code';
  static const codeKey = 'country_code';
  static const nameKey = 'name';

  String? code;
  String? dialCode;
  String? name;

  Country copyWith({
    String? dialCode,
    String? code,
    String? name,
    int? id,
  }) {
    return Country(
      dialCode: dialCode ?? this.dialCode,
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  Country clone() {
    return copyWith(
      dialCode: dialCode,
      code: code,
      name: name,
    );
  }

  static Country fromMap(Map<String, dynamic> data) {
    return Country(
      dialCode: data[dialCodeKey],
      code: data[codeKey],
      name: data[nameKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      dialCodeKey: dialCode,
      codeKey: code,
      nameKey: name,
    };
  }

  static List<Country> fromListJson(String source) {
    return List.of((jsonDecode(source)['data'] as List).map((map) => fromMap(map)));
  }

  static Country fromJson(String source) {
    return fromMap(jsonDecode(source));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
