// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CityRecordStruct extends BaseStruct {
  CityRecordStruct({
    String? name,
    double? lat,
    double? lng,
  })  : _name = name,
        _lat = lat,
        _lng = lng;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "lat" field.
  double? _lat;
  double get lat => _lat ?? 0.0;
  set lat(double? val) => _lat = val;

  void incrementLat(double amount) => lat = lat + amount;

  bool hasLat() => _lat != null;

  // "lng" field.
  double? _lng;
  double get lng => _lng ?? 0.0;
  set lng(double? val) => _lng = val;

  void incrementLng(double amount) => lng = lng + amount;

  bool hasLng() => _lng != null;

  static CityRecordStruct fromMap(Map<String, dynamic> data) =>
      CityRecordStruct(
        name: data['name'] as String?,
        lat: castToType<double>(data['lat']),
        lng: castToType<double>(data['lng']),
      );

  static CityRecordStruct? maybeFromMap(dynamic data) => data is Map
      ? CityRecordStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'lat': _lat,
        'lng': _lng,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'lat': serializeParam(
          _lat,
          ParamType.double,
        ),
        'lng': serializeParam(
          _lng,
          ParamType.double,
        ),
      }.withoutNulls;

  static CityRecordStruct fromSerializableMap(Map<String, dynamic> data) =>
      CityRecordStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        lat: deserializeParam(
          data['lat'],
          ParamType.double,
          false,
        ),
        lng: deserializeParam(
          data['lng'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'CityRecordStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CityRecordStruct &&
        name == other.name &&
        lat == other.lat &&
        lng == other.lng;
  }

  @override
  int get hashCode => const ListEquality().hash([name, lat, lng]);
}

CityRecordStruct createCityRecordStruct({
  String? name,
  double? lat,
  double? lng,
}) =>
    CityRecordStruct(
      name: name,
      lat: lat,
      lng: lng,
    );
