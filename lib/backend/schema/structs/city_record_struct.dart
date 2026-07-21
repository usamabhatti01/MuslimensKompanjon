// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CityRecordStruct extends BaseStruct {
  CityRecordStruct({
    String? name,
    double? lat,
    double? lng,
    bool? fav,
  })  : _name = name,
        _lat = lat,
        _lng = lng,
        _fav = fav;

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

  // "fav" field.
  bool? _fav;
  bool get fav => _fav ?? false;
  set fav(bool? val) => _fav = val;

  bool hasFav() => _fav != null;

  static CityRecordStruct fromMap(Map<String, dynamic> data) =>
      CityRecordStruct(
        name: data['name'] as String?,
        lat: castToType<double>(data['lat']),
        lng: castToType<double>(data['lng']),
        fav: data['fav'] as bool?,
      );

  static CityRecordStruct? maybeFromMap(dynamic data) => data is Map
      ? CityRecordStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'lat': _lat,
        'lng': _lng,
        'fav': _fav,
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
        'fav': serializeParam(
          _fav,
          ParamType.bool,
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
        fav: deserializeParam(
          data['fav'],
          ParamType.bool,
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
        lng == other.lng &&
        fav == other.fav;
  }

  @override
  int get hashCode => const ListEquality().hash([name, lat, lng, fav]);
}

CityRecordStruct createCityRecordStruct({
  String? name,
  double? lat,
  double? lng,
  bool? fav,
}) =>
    CityRecordStruct(
      name: name,
      lat: lat,
      lng: lng,
      fav: fav,
    );
