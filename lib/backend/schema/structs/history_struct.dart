// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HistoryStruct extends BaseStruct {
  HistoryStruct({
    String? cityName,
    int? id,
  })  : _cityName = cityName,
        _id = id;

  // "cityName" field.
  String? _cityName;
  String get cityName => _cityName ?? '';
  set cityName(String? val) => _cityName = val;

  bool hasCityName() => _cityName != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 1;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  static HistoryStruct fromMap(Map<String, dynamic> data) => HistoryStruct(
        cityName: data['cityName'] as String?,
        id: castToType<int>(data['id']),
      );

  static HistoryStruct? maybeFromMap(dynamic data) =>
      data is Map ? HistoryStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'cityName': _cityName,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'cityName': serializeParam(
          _cityName,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
      }.withoutNulls;

  static HistoryStruct fromSerializableMap(Map<String, dynamic> data) =>
      HistoryStruct(
        cityName: deserializeParam(
          data['cityName'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'HistoryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HistoryStruct &&
        cityName == other.cityName &&
        id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([cityName, id]);
}

HistoryStruct createHistoryStruct({
  String? cityName,
  int? id,
}) =>
    HistoryStruct(
      cityName: cityName,
      id: id,
    );
