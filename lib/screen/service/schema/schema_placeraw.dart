part of 'schema_place.dart';

class _PlaceResult {
  _PlaceResult({
    required this.features,
  });
  final List<_Feature>? features;

  static const featuresKey = 'features';

  static _PlaceResult fromMap(Map<String, dynamic> value) {
    return _PlaceResult(
      features: List.of(value[featuresKey].map<_Feature>((e) {
        return _Feature.fromMap(e.cast<String, dynamic>());
      })),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      featuresKey: features?.map((e) => e.toMap()),
    };
  }

  static _PlaceResult fromJson(String value) {
    return _PlaceResult.fromMap(jsonDecode(value));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class _Feature {
  _Feature({
    required this.type,
    required this.geometry,
    required this.properties,
  });

  final String? type;
  final _Geometry? geometry;
  final _Properties? properties;

  static const typeKey = 'type';
  static const geometryKey = 'geometry';
  static const propertiesKey = 'properties';

  static _Feature fromMap(Map<String, dynamic> value) {
    return _Feature(
      type: value[typeKey],
      geometry: _Geometry.fromMap(
        value[geometryKey].cast<String, dynamic>(),
      ),
      properties: _Properties.fromMap(
        value[propertiesKey].cast<String, dynamic>(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      typeKey: type,
      geometryKey: geometry?.toMap(),
      propertiesKey: properties?.toMap(),
    };
  }
}

class _Properties {
  _Properties({
    required this.type,
    required this.name,
    required this.city,
    required this.osmId,
    required this.state,
    required this.extent,
    required this.street,
    required this.osmKey,
    required this.osmType,
    required this.country,
    required this.osmValue,
    required this.postcode,
    required this.district,
    required this.locality,
    required this.houseNumber,
    required this.countryCode,
  });

  final int? osmId;
  final String? osmKey;
  final String? osmType;
  final String? osmValue;

  final String? type;
  final String? name;
  final String? city;
  final String? state;
  final String? street;
  final String? postcode;
  final String? country;
  final String? locality;
  final String? district;

  final String? houseNumber;
  final String? countryCode;
  final List<double>? extent;

  static const osmIdKey = 'osm_id';
  static const osmKeyKey = 'osm_key';
  static const osmTypeKey = 'osm_type';
  static const osmValueKey = 'osm_value';

  static const typeKey = 'type';
  static const nameKey = 'name';
  static const cityKey = 'city';
  static const stateKey = 'state';
  static const streetKey = 'street';
  static const extentKey = 'extent';
  static const countryKey = 'country';
  static const postcodeKey = 'postcode';
  static const districtKey = 'district';
  static const localityKey = 'locality';
  static const houseNumberKey = 'housenumber';
  static const countryCodeKey = 'countrycode';

  static _Properties fromMap(Map<String, dynamic> value) {
    return _Properties(
      type: value[typeKey],
      name: value[nameKey],
      city: value[cityKey],
      osmId: value[osmIdKey],
      state: value[stateKey],
      osmKey: value[osmKeyKey],
      street: value[streetKey],
      country: value[countryKey],
      osmType: value[osmTypeKey],
      osmValue: value[osmValueKey],
      postcode: value[postcodeKey],
      district: value[districtKey],
      locality: value[localityKey],
      houseNumber: value[houseNumberKey],
      countryCode: value[countryCodeKey],
      extent: value[extentKey]?.cast<double>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      typeKey: type,
      nameKey: name,
      cityKey: city,
      osmIdKey: osmId,
      stateKey: state,
      osmKeyKey: osmKey,
      extentKey: extent,
      streetKey: street,
      osmTypeKey: osmType,
      countryKey: country,
      osmValueKey: osmValue,
      postcodeKey: postcode,
      districtKey: district,
      localityKey: locality,
      houseNumberKey: houseNumber,
      countryCodeKey: countryCode,
    };
  }
}

class _Geometry {
  _Geometry({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<double>? coordinates;

  static const typeKey = 'type';
  static const coordinatesKey = 'coordinates';

  static _Geometry fromMap(Map<String, dynamic> value) {
    return _Geometry(
      type: value[typeKey],
      coordinates: value[coordinatesKey]?.cast<double>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      typeKey: type,
      coordinatesKey: coordinates,
    };
  }
}
