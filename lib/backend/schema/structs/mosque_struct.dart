// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MosqueStruct extends BaseStruct {
  MosqueStruct({
    String? name,
    LatLng? latitude,
  })  : _name = name,
        _latitude = latitude;

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

  static MosqueStruct fromMap(Map<String, dynamic> data) => MosqueStruct(
        name: data['name'] as String?,
        latitude: data['latitude'] as LatLng?,
      );

  static MosqueStruct? maybeFromMap(dynamic data) =>
      data is Map ? MosqueStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'latitude': _latitude,
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
      );

  @override
  String toString() => 'MosqueStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is MosqueStruct &&
        name == other.name &&
        latitude == other.latitude;
  }

  @override
  int get hashCode => const ListEquality().hash([name, latitude]);
}

MosqueStruct createMosqueStruct({
  String? name,
  LatLng? latitude,
}) =>
    MosqueStruct(
      name: name,
      latitude: latitude,
    );
