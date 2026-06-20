// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsStruct extends BaseStruct {
  NotificationsStruct({
    NotificationCheckStruct? fazr,
    NotificationCheckStruct? shuruq,
    NotificationCheckStruct? dohr,
    NotificationCheckStruct? asr,
    NotificationCheckStruct? maghrib,
    NotificationCheckStruct? isha,
  })  : _fazr = fazr,
        _shuruq = shuruq,
        _dohr = dohr,
        _asr = asr,
        _maghrib = maghrib,
        _isha = isha;

  // "Fazr" field.
  NotificationCheckStruct? _fazr;
  NotificationCheckStruct get fazr => _fazr ?? NotificationCheckStruct();
  set fazr(NotificationCheckStruct? val) => _fazr = val;

  void updateFazr(Function(NotificationCheckStruct) updateFn) {
    updateFn(_fazr ??= NotificationCheckStruct());
  }

  bool hasFazr() => _fazr != null;

  // "Shuruq" field.
  NotificationCheckStruct? _shuruq;
  NotificationCheckStruct get shuruq => _shuruq ?? NotificationCheckStruct();
  set shuruq(NotificationCheckStruct? val) => _shuruq = val;

  void updateShuruq(Function(NotificationCheckStruct) updateFn) {
    updateFn(_shuruq ??= NotificationCheckStruct());
  }

  bool hasShuruq() => _shuruq != null;

  // "Dohr" field.
  NotificationCheckStruct? _dohr;
  NotificationCheckStruct get dohr => _dohr ?? NotificationCheckStruct();
  set dohr(NotificationCheckStruct? val) => _dohr = val;

  void updateDohr(Function(NotificationCheckStruct) updateFn) {
    updateFn(_dohr ??= NotificationCheckStruct());
  }

  bool hasDohr() => _dohr != null;

  // "Asr" field.
  NotificationCheckStruct? _asr;
  NotificationCheckStruct get asr => _asr ?? NotificationCheckStruct();
  set asr(NotificationCheckStruct? val) => _asr = val;

  void updateAsr(Function(NotificationCheckStruct) updateFn) {
    updateFn(_asr ??= NotificationCheckStruct());
  }

  bool hasAsr() => _asr != null;

  // "Maghrib" field.
  NotificationCheckStruct? _maghrib;
  NotificationCheckStruct get maghrib => _maghrib ?? NotificationCheckStruct();
  set maghrib(NotificationCheckStruct? val) => _maghrib = val;

  void updateMaghrib(Function(NotificationCheckStruct) updateFn) {
    updateFn(_maghrib ??= NotificationCheckStruct());
  }

  bool hasMaghrib() => _maghrib != null;

  // "Isha" field.
  NotificationCheckStruct? _isha;
  NotificationCheckStruct get isha => _isha ?? NotificationCheckStruct();
  set isha(NotificationCheckStruct? val) => _isha = val;

  void updateIsha(Function(NotificationCheckStruct) updateFn) {
    updateFn(_isha ??= NotificationCheckStruct());
  }

  bool hasIsha() => _isha != null;

  static NotificationsStruct fromMap(Map<String, dynamic> data) =>
      NotificationsStruct(
        fazr: data['Fazr'] is NotificationCheckStruct
            ? data['Fazr']
            : NotificationCheckStruct.maybeFromMap(data['Fazr']),
        shuruq: data['Shuruq'] is NotificationCheckStruct
            ? data['Shuruq']
            : NotificationCheckStruct.maybeFromMap(data['Shuruq']),
        dohr: data['Dohr'] is NotificationCheckStruct
            ? data['Dohr']
            : NotificationCheckStruct.maybeFromMap(data['Dohr']),
        asr: data['Asr'] is NotificationCheckStruct
            ? data['Asr']
            : NotificationCheckStruct.maybeFromMap(data['Asr']),
        maghrib: data['Maghrib'] is NotificationCheckStruct
            ? data['Maghrib']
            : NotificationCheckStruct.maybeFromMap(data['Maghrib']),
        isha: data['Isha'] is NotificationCheckStruct
            ? data['Isha']
            : NotificationCheckStruct.maybeFromMap(data['Isha']),
      );

  static NotificationsStruct? maybeFromMap(dynamic data) => data is Map
      ? NotificationsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Fazr': _fazr?.toMap(),
        'Shuruq': _shuruq?.toMap(),
        'Dohr': _dohr?.toMap(),
        'Asr': _asr?.toMap(),
        'Maghrib': _maghrib?.toMap(),
        'Isha': _isha?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Fazr': serializeParam(
          _fazr,
          ParamType.DataStruct,
        ),
        'Shuruq': serializeParam(
          _shuruq,
          ParamType.DataStruct,
        ),
        'Dohr': serializeParam(
          _dohr,
          ParamType.DataStruct,
        ),
        'Asr': serializeParam(
          _asr,
          ParamType.DataStruct,
        ),
        'Maghrib': serializeParam(
          _maghrib,
          ParamType.DataStruct,
        ),
        'Isha': serializeParam(
          _isha,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static NotificationsStruct fromSerializableMap(Map<String, dynamic> data) =>
      NotificationsStruct(
        fazr: deserializeStructParam(
          data['Fazr'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationCheckStruct.fromSerializableMap,
        ),
        shuruq: deserializeStructParam(
          data['Shuruq'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationCheckStruct.fromSerializableMap,
        ),
        dohr: deserializeStructParam(
          data['Dohr'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationCheckStruct.fromSerializableMap,
        ),
        asr: deserializeStructParam(
          data['Asr'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationCheckStruct.fromSerializableMap,
        ),
        maghrib: deserializeStructParam(
          data['Maghrib'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationCheckStruct.fromSerializableMap,
        ),
        isha: deserializeStructParam(
          data['Isha'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationCheckStruct.fromSerializableMap,
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
  NotificationCheckStruct? fazr,
  NotificationCheckStruct? shuruq,
  NotificationCheckStruct? dohr,
  NotificationCheckStruct? asr,
  NotificationCheckStruct? maghrib,
  NotificationCheckStruct? isha,
}) =>
    NotificationsStruct(
      fazr: fazr ?? NotificationCheckStruct(),
      shuruq: shuruq ?? NotificationCheckStruct(),
      dohr: dohr ?? NotificationCheckStruct(),
      asr: asr ?? NotificationCheckStruct(),
      maghrib: maghrib ?? NotificationCheckStruct(),
      isha: isha ?? NotificationCheckStruct(),
    );
