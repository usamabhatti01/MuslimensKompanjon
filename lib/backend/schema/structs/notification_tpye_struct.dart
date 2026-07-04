// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationTpyeStruct extends BaseStruct {
  NotificationTpyeStruct({
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

  static NotificationTpyeStruct fromMap(Map<String, dynamic> data) =>
      NotificationTpyeStruct(
        notice: data['Notice'] as bool?,
        adhan: data['Adhan'] as bool?,
      );

  static NotificationTpyeStruct? maybeFromMap(dynamic data) => data is Map
      ? NotificationTpyeStruct.fromMap(data.cast<String, dynamic>())
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

  static NotificationTpyeStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      NotificationTpyeStruct(
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
  String toString() => 'NotificationTpyeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NotificationTpyeStruct &&
        notice == other.notice &&
        adhan == other.adhan;
  }

  @override
  int get hashCode => const ListEquality().hash([notice, adhan]);
}

NotificationTpyeStruct createNotificationTpyeStruct({
  bool? notice,
  bool? adhan,
}) =>
    NotificationTpyeStruct(
      notice: notice,
      adhan: adhan,
    );
