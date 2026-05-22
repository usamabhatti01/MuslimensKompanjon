// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsStruct extends BaseStruct {
  NotificationsStruct({
    bool? fazr,
    bool? shuruq,
    bool? dohr,
    bool? asr,
    bool? maghrib,
    bool? isha,
  })  : _fazr = fazr,
        _shuruq = shuruq,
        _dohr = dohr,
        _asr = asr,
        _maghrib = maghrib,
        _isha = isha;

  // "Fazr" field.
  bool? _fazr;
  bool get fazr => _fazr ?? false;
  set fazr(bool? val) => _fazr = val;

  bool hasFazr() => _fazr != null;

  // "Shuruq" field.
  bool? _shuruq;
  bool get shuruq => _shuruq ?? false;
  set shuruq(bool? val) => _shuruq = val;

  bool hasShuruq() => _shuruq != null;

  // "Dohr" field.
  bool? _dohr;
  bool get dohr => _dohr ?? false;
  set dohr(bool? val) => _dohr = val;

  bool hasDohr() => _dohr != null;

  // "Asr" field.
  bool? _asr;
  bool get asr => _asr ?? false;
  set asr(bool? val) => _asr = val;

  bool hasAsr() => _asr != null;

  // "Maghrib" field.
  bool? _maghrib;
  bool get maghrib => _maghrib ?? false;
  set maghrib(bool? val) => _maghrib = val;

  bool hasMaghrib() => _maghrib != null;

  // "Isha" field.
  bool? _isha;
  bool get isha => _isha ?? false;
  set isha(bool? val) => _isha = val;

  bool hasIsha() => _isha != null;

  static NotificationsStruct fromMap(Map<String, dynamic> data) =>
      NotificationsStruct(
        fazr: data['Fazr'] as bool?,
        shuruq: data['Shuruq'] as bool?,
        dohr: data['Dohr'] as bool?,
        asr: data['Asr'] as bool?,
        maghrib: data['Maghrib'] as bool?,
        isha: data['Isha'] as bool?,
      );

  static NotificationsStruct? maybeFromMap(dynamic data) => data is Map
      ? NotificationsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Fazr': _fazr,
        'Shuruq': _shuruq,
        'Dohr': _dohr,
        'Asr': _asr,
        'Maghrib': _maghrib,
        'Isha': _isha,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Fazr': serializeParam(
          _fazr,
          ParamType.bool,
        ),
        'Shuruq': serializeParam(
          _shuruq,
          ParamType.bool,
        ),
        'Dohr': serializeParam(
          _dohr,
          ParamType.bool,
        ),
        'Asr': serializeParam(
          _asr,
          ParamType.bool,
        ),
        'Maghrib': serializeParam(
          _maghrib,
          ParamType.bool,
        ),
        'Isha': serializeParam(
          _isha,
          ParamType.bool,
        ),
      }.withoutNulls;

  static NotificationsStruct fromSerializableMap(Map<String, dynamic> data) =>
      NotificationsStruct(
        fazr: deserializeParam(
          data['Fazr'],
          ParamType.bool,
          false,
        ),
        shuruq: deserializeParam(
          data['Shuruq'],
          ParamType.bool,
          false,
        ),
        dohr: deserializeParam(
          data['Dohr'],
          ParamType.bool,
          false,
        ),
        asr: deserializeParam(
          data['Asr'],
          ParamType.bool,
          false,
        ),
        maghrib: deserializeParam(
          data['Maghrib'],
          ParamType.bool,
          false,
        ),
        isha: deserializeParam(
          data['Isha'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'NotificationsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NotificationsStruct &&
        fazr == other.fazr &&
        shuruq == other.shuruq &&
        dohr == other.dohr &&
        asr == other.asr &&
        maghrib == other.maghrib &&
        isha == other.isha;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([fazr, shuruq, dohr, asr, maghrib, isha]);
}

NotificationsStruct createNotificationsStruct({
  bool? fazr,
  bool? shuruq,
  bool? dohr,
  bool? asr,
  bool? maghrib,
  bool? isha,
}) =>
    NotificationsStruct(
      fazr: fazr,
      shuruq: shuruq,
      dohr: dohr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
    );
