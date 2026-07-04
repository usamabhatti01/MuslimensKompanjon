// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotificationsStruct extends BaseStruct {
  NotificationsStruct({
    NotificationTpyeStruct? fazr,
    NotificationTpyeStruct? shuruq,
    NotificationTpyeStruct? dohr,
    NotificationTpyeStruct? asr,
    NotificationTpyeStruct? maghrib,
    NotificationTpyeStruct? isha,
  })  : _fazr = fazr,
        _shuruq = shuruq,
        _dohr = dohr,
        _asr = asr,
        _maghrib = maghrib,
        _isha = isha;

  // "Fazr" field.
  NotificationTpyeStruct? _fazr;
  NotificationTpyeStruct get fazr => _fazr ?? NotificationTpyeStruct();
  set fazr(NotificationTpyeStruct? val) => _fazr = val;

  void updateFazr(Function(NotificationTpyeStruct) updateFn) {
    updateFn(_fazr ??= NotificationTpyeStruct());
  }

  bool hasFazr() => _fazr != null;

  // "Shuruq" field.
  NotificationTpyeStruct? _shuruq;
  NotificationTpyeStruct get shuruq => _shuruq ?? NotificationTpyeStruct();
  set shuruq(NotificationTpyeStruct? val) => _shuruq = val;

  void updateShuruq(Function(NotificationTpyeStruct) updateFn) {
    updateFn(_shuruq ??= NotificationTpyeStruct());
  }

  bool hasShuruq() => _shuruq != null;

  // "Dohr" field.
  NotificationTpyeStruct? _dohr;
  NotificationTpyeStruct get dohr => _dohr ?? NotificationTpyeStruct();
  set dohr(NotificationTpyeStruct? val) => _dohr = val;

  void updateDohr(Function(NotificationTpyeStruct) updateFn) {
    updateFn(_dohr ??= NotificationTpyeStruct());
  }

  bool hasDohr() => _dohr != null;

  // "Asr" field.
  NotificationTpyeStruct? _asr;
  NotificationTpyeStruct get asr => _asr ?? NotificationTpyeStruct();
  set asr(NotificationTpyeStruct? val) => _asr = val;

  void updateAsr(Function(NotificationTpyeStruct) updateFn) {
    updateFn(_asr ??= NotificationTpyeStruct());
  }

  bool hasAsr() => _asr != null;

  // "Maghrib" field.
  NotificationTpyeStruct? _maghrib;
  NotificationTpyeStruct get maghrib => _maghrib ?? NotificationTpyeStruct();
  set maghrib(NotificationTpyeStruct? val) => _maghrib = val;

  void updateMaghrib(Function(NotificationTpyeStruct) updateFn) {
    updateFn(_maghrib ??= NotificationTpyeStruct());
  }

  bool hasMaghrib() => _maghrib != null;

  // "Isha" field.
  NotificationTpyeStruct? _isha;
  NotificationTpyeStruct get isha => _isha ?? NotificationTpyeStruct();
  set isha(NotificationTpyeStruct? val) => _isha = val;

  void updateIsha(Function(NotificationTpyeStruct) updateFn) {
    updateFn(_isha ??= NotificationTpyeStruct());
  }

  bool hasIsha() => _isha != null;

  static NotificationsStruct fromMap(Map<String, dynamic> data) =>
      NotificationsStruct(
        fazr: data['Fazr'] is NotificationTpyeStruct
            ? data['Fazr']
            : NotificationTpyeStruct.maybeFromMap(data['Fazr']),
        shuruq: data['Shuruq'] is NotificationTpyeStruct
            ? data['Shuruq']
            : NotificationTpyeStruct.maybeFromMap(data['Shuruq']),
        dohr: data['Dohr'] is NotificationTpyeStruct
            ? data['Dohr']
            : NotificationTpyeStruct.maybeFromMap(data['Dohr']),
        asr: data['Asr'] is NotificationTpyeStruct
            ? data['Asr']
            : NotificationTpyeStruct.maybeFromMap(data['Asr']),
        maghrib: data['Maghrib'] is NotificationTpyeStruct
            ? data['Maghrib']
            : NotificationTpyeStruct.maybeFromMap(data['Maghrib']),
        isha: data['Isha'] is NotificationTpyeStruct
            ? data['Isha']
            : NotificationTpyeStruct.maybeFromMap(data['Isha']),
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
          structBuilder: NotificationTpyeStruct.fromSerializableMap,
        ),
        shuruq: deserializeStructParam(
          data['Shuruq'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationTpyeStruct.fromSerializableMap,
        ),
        dohr: deserializeStructParam(
          data['Dohr'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationTpyeStruct.fromSerializableMap,
        ),
        asr: deserializeStructParam(
          data['Asr'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationTpyeStruct.fromSerializableMap,
        ),
        maghrib: deserializeStructParam(
          data['Maghrib'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationTpyeStruct.fromSerializableMap,
        ),
        isha: deserializeStructParam(
          data['Isha'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationTpyeStruct.fromSerializableMap,
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
  NotificationTpyeStruct? fazr,
  NotificationTpyeStruct? shuruq,
  NotificationTpyeStruct? dohr,
  NotificationTpyeStruct? asr,
  NotificationTpyeStruct? maghrib,
  NotificationTpyeStruct? isha,
}) =>
    NotificationsStruct(
      fazr: fazr ?? NotificationTpyeStruct(),
      shuruq: shuruq ?? NotificationTpyeStruct(),
      dohr: dohr ?? NotificationTpyeStruct(),
      asr: asr ?? NotificationTpyeStruct(),
      maghrib: maghrib ?? NotificationTpyeStruct(),
      isha: isha ?? NotificationTpyeStruct(),
    );
