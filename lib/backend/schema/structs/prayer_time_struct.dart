// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PrayerTimeStruct extends BaseStruct {
  PrayerTimeStruct({
    DateTime? fajr,
    DateTime? shuruq,
    DateTime? dhuhr,
    DateTime? asr,
    DateTime? maghrib,
    DateTime? isha,
    int? hijriYear,
    int? hijriMonthNo,
    String? hijriMonthName,
    int? hijriDay,
    String? weekday,
  })  : _fajr = fajr,
        _shuruq = shuruq,
        _dhuhr = dhuhr,
        _asr = asr,
        _maghrib = maghrib,
        _isha = isha,
        _hijriYear = hijriYear,
        _hijriMonthNo = hijriMonthNo,
        _hijriMonthName = hijriMonthName,
        _hijriDay = hijriDay,
        _weekday = weekday;

  // "fajr" field.
  DateTime? _fajr;
  DateTime? get fajr => _fajr;
  set fajr(DateTime? val) => _fajr = val;

  bool hasFajr() => _fajr != null;

  // "shuruq" field.
  DateTime? _shuruq;
  DateTime? get shuruq => _shuruq;
  set shuruq(DateTime? val) => _shuruq = val;

  bool hasShuruq() => _shuruq != null;

  // "dhuhr" field.
  DateTime? _dhuhr;
  DateTime? get dhuhr => _dhuhr;
  set dhuhr(DateTime? val) => _dhuhr = val;

  bool hasDhuhr() => _dhuhr != null;

  // "asr" field.
  DateTime? _asr;
  DateTime? get asr => _asr;
  set asr(DateTime? val) => _asr = val;

  bool hasAsr() => _asr != null;

  // "maghrib" field.
  DateTime? _maghrib;
  DateTime? get maghrib => _maghrib;
  set maghrib(DateTime? val) => _maghrib = val;

  bool hasMaghrib() => _maghrib != null;

  // "isha" field.
  DateTime? _isha;
  DateTime? get isha => _isha;
  set isha(DateTime? val) => _isha = val;

  bool hasIsha() => _isha != null;

  // "hijriYear" field.
  int? _hijriYear;
  int get hijriYear => _hijriYear ?? 0;
  set hijriYear(int? val) => _hijriYear = val;

  void incrementHijriYear(int amount) => hijriYear = hijriYear + amount;

  bool hasHijriYear() => _hijriYear != null;

  // "hijriMonthNo" field.
  int? _hijriMonthNo;
  int get hijriMonthNo => _hijriMonthNo ?? 0;
  set hijriMonthNo(int? val) => _hijriMonthNo = val;

  void incrementHijriMonthNo(int amount) =>
      hijriMonthNo = hijriMonthNo + amount;

  bool hasHijriMonthNo() => _hijriMonthNo != null;

  // "hijriMonthName" field.
  String? _hijriMonthName;
  String get hijriMonthName => _hijriMonthName ?? '';
  set hijriMonthName(String? val) => _hijriMonthName = val;

  bool hasHijriMonthName() => _hijriMonthName != null;

  // "hijriDay" field.
  int? _hijriDay;
  int get hijriDay => _hijriDay ?? 0;
  set hijriDay(int? val) => _hijriDay = val;

  void incrementHijriDay(int amount) => hijriDay = hijriDay + amount;

  bool hasHijriDay() => _hijriDay != null;

  // "weekday" field.
  String? _weekday;
  String get weekday => _weekday ?? '';
  set weekday(String? val) => _weekday = val;

  bool hasWeekday() => _weekday != null;

  static PrayerTimeStruct fromMap(Map<String, dynamic> data) =>
      PrayerTimeStruct(
        fajr: data['fajr'] as DateTime?,
        shuruq: data['shuruq'] as DateTime?,
        dhuhr: data['dhuhr'] as DateTime?,
        asr: data['asr'] as DateTime?,
        maghrib: data['maghrib'] as DateTime?,
        isha: data['isha'] as DateTime?,
        hijriYear: castToType<int>(data['hijriYear']),
        hijriMonthNo: castToType<int>(data['hijriMonthNo']),
        hijriMonthName: data['hijriMonthName'] as String?,
        hijriDay: castToType<int>(data['hijriDay']),
        weekday: data['weekday'] as String?,
      );

  static PrayerTimeStruct? maybeFromMap(dynamic data) => data is Map
      ? PrayerTimeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'fajr': _fajr,
        'shuruq': _shuruq,
        'dhuhr': _dhuhr,
        'asr': _asr,
        'maghrib': _maghrib,
        'isha': _isha,
        'hijriYear': _hijriYear,
        'hijriMonthNo': _hijriMonthNo,
        'hijriMonthName': _hijriMonthName,
        'hijriDay': _hijriDay,
        'weekday': _weekday,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'fajr': serializeParam(
          _fajr,
          ParamType.DateTime,
        ),
        'shuruq': serializeParam(
          _shuruq,
          ParamType.DateTime,
        ),
        'dhuhr': serializeParam(
          _dhuhr,
          ParamType.DateTime,
        ),
        'asr': serializeParam(
          _asr,
          ParamType.DateTime,
        ),
        'maghrib': serializeParam(
          _maghrib,
          ParamType.DateTime,
        ),
        'isha': serializeParam(
          _isha,
          ParamType.DateTime,
        ),
        'hijriYear': serializeParam(
          _hijriYear,
          ParamType.int,
        ),
        'hijriMonthNo': serializeParam(
          _hijriMonthNo,
          ParamType.int,
        ),
        'hijriMonthName': serializeParam(
          _hijriMonthName,
          ParamType.String,
        ),
        'hijriDay': serializeParam(
          _hijriDay,
          ParamType.int,
        ),
        'weekday': serializeParam(
          _weekday,
          ParamType.String,
        ),
      }.withoutNulls;

  static PrayerTimeStruct fromSerializableMap(Map<String, dynamic> data) =>
      PrayerTimeStruct(
        fajr: deserializeParam(
          data['fajr'],
          ParamType.DateTime,
          false,
        ),
        shuruq: deserializeParam(
          data['shuruq'],
          ParamType.DateTime,
          false,
        ),
        dhuhr: deserializeParam(
          data['dhuhr'],
          ParamType.DateTime,
          false,
        ),
        asr: deserializeParam(
          data['asr'],
          ParamType.DateTime,
          false,
        ),
        maghrib: deserializeParam(
          data['maghrib'],
          ParamType.DateTime,
          false,
        ),
        isha: deserializeParam(
          data['isha'],
          ParamType.DateTime,
          false,
        ),
        hijriYear: deserializeParam(
          data['hijriYear'],
          ParamType.int,
          false,
        ),
        hijriMonthNo: deserializeParam(
          data['hijriMonthNo'],
          ParamType.int,
          false,
        ),
        hijriMonthName: deserializeParam(
          data['hijriMonthName'],
          ParamType.String,
          false,
        ),
        hijriDay: deserializeParam(
          data['hijriDay'],
          ParamType.int,
          false,
        ),
        weekday: deserializeParam(
          data['weekday'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PrayerTimeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PrayerTimeStruct &&
        fajr == other.fajr &&
        shuruq == other.shuruq &&
        dhuhr == other.dhuhr &&
        asr == other.asr &&
        maghrib == other.maghrib &&
        isha == other.isha &&
        hijriYear == other.hijriYear &&
        hijriMonthNo == other.hijriMonthNo &&
        hijriMonthName == other.hijriMonthName &&
        hijriDay == other.hijriDay &&
        weekday == other.weekday;
  }

  @override
  int get hashCode => const ListEquality().hash([
        fajr,
        shuruq,
        dhuhr,
        asr,
        maghrib,
        isha,
        hijriYear,
        hijriMonthNo,
        hijriMonthName,
        hijriDay,
        weekday
      ]);
}

PrayerTimeStruct createPrayerTimeStruct({
  DateTime? fajr,
  DateTime? shuruq,
  DateTime? dhuhr,
  DateTime? asr,
  DateTime? maghrib,
  DateTime? isha,
  int? hijriYear,
  int? hijriMonthNo,
  String? hijriMonthName,
  int? hijriDay,
  String? weekday,
}) =>
    PrayerTimeStruct(
      fajr: fajr,
      shuruq: shuruq,
      dhuhr: dhuhr,
      asr: asr,
      maghrib: maghrib,
      isha: isha,
      hijriYear: hijriYear,
      hijriMonthNo: hijriMonthNo,
      hijriMonthName: hijriMonthName,
      hijriDay: hijriDay,
      weekday: weekday,
    );
