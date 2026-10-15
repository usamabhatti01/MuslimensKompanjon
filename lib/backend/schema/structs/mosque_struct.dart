// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MosqueStruct extends BaseStruct {
  MosqueStruct({
    String? name,
    LatLng? latitude,
    String? address,
  })  : _name = name,
        _latitude = latitude,
        _address = address;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "latitude" field.
  LatLng? _latitude;
  LatLng? get latitude => _latitude;
  set latitude(LatLng? val) => _latitude = val;

  bool hasLatitude() => _latitude != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  static MosqueStruct fromMap(Map<String, dynamic> data) => MosqueStruct(
        name: data['name'] as String?,
        latitude: data['latitude'] as LatLng?,
        address: data['address'] as String?,
      );

  static MosqueStruct? maybeFromMap(dynamic data) =>
      data is Map ? MosqueStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'latitude': _latitude,
        'address': _address,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'latitude': serializeParam(
          _latitude,
          ParamType.LatLng,
        ),
        'address': serializeParam(
          _address,
          ParamType.String,
        ),
      }.withoutNulls;

  static MosqueStruct fromSerializableMap(Map<String, dynamic> data) =>
      MosqueStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        latitude: deserializeParam(
          data['latitude'],
          ParamType.LatLng,
          false,
        ),
        address: deserializeParam(
          data['address'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MosqueStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MosqueStruct &&
        name == other.name &&
        latitude == other.latitude &&
        address == other.address;
  }

  @override
  int get hashCode => const ListEquality().hash([name, latitude, address]);
}

MosqueStruct createMosqueStruct({
  String? name,
  LatLng? latitude,
  String? address,
}) =>
    MosqueStruct(
      name: name,
      latitude: latitude,
      address: address,
    );
