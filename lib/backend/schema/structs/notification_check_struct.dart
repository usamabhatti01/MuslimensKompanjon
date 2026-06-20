// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationCheckStruct extends BaseStruct {
  NotificationCheckStruct({
    bool? notice,
    bool? adhan,
  })  : _notice = notice,
        _adhan = adhan;

  // "Notice" field.
  bool? _notice;
  bool get notice => _notice ?? false;
  set notice(bool? val) => _notice = val;

  bool hasNotice() => _notice != null;

  // "Adhan" field.
  bool? _adhan;
  bool get adhan => _adhan ?? false;
  set adhan(bool? val) => _adhan = val;

  bool hasAdhan() => _adhan != null;

  static NotificationCheckStruct fromMap(Map<String, dynamic> data) =>
      NotificationCheckStruct(
        notice: data['Notice'] as bool?,
        adhan: data['Adhan'] as bool?,
      );

  static NotificationCheckStruct? maybeFromMap(dynamic data) => data is Map
      ? NotificationCheckStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Notice': _notice,
        'Adhan': _adhan,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Notice': serializeParam(
          _notice,
          ParamType.bool,
        ),
        'Adhan': serializeParam(
          _adhan,
          ParamType.bool,
        ),
      }.withoutNulls;

  static NotificationCheckStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      NotificationCheckStruct(
        notice: deserializeParam(
          data['Notice'],
          ParamType.bool,
          false,
        ),
        adhan: deserializeParam(
          data['Adhan'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'NotificationCheckStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NotificationCheckStruct &&
        notice == other.notice &&
        adhan == other.adhan;
  }

  @override
  int get hashCode => const ListEquality().hash([notice, adhan]);
}

NotificationCheckStruct createNotificationCheckStruct({
  bool? notice,
  bool? adhan,
}) =>
    NotificationCheckStruct(
      notice: notice,
      adhan: adhan,
    );
