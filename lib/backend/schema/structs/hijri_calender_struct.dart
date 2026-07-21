// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HijriCalenderStruct extends BaseStruct {
  HijriCalenderStruct({
    int? hijriYear,
    int? hijriMonthNo,
    String? hijriMonthName,
    int? hijriDay,
    DateTime? gregorianDate,
    String? weekday,
    String? event,
  })  : _hijriYear = hijriYear,
        _hijriMonthNo = hijriMonthNo,
        _hijriMonthName = hijriMonthName,
        _hijriDay = hijriDay,
        _gregorianDate = gregorianDate,
        _weekday = weekday,
        _event = event;

  // "HijriYear" field.
  int? _hijriYear;
  int get hijriYear => _hijriYear ?? 0;
  set hijriYear(int? val) => _hijriYear = val;

  void incrementHijriYear(int amount) => hijriYear = hijriYear + amount;

  bool hasHijriYear() => _hijriYear != null;

  // "HijriMonthNo" field.
  int? _hijriMonthNo;
  int get hijriMonthNo => _hijriMonthNo ?? 0;
  set hijriMonthNo(int? val) => _hijriMonthNo = val;

  void incrementHijriMonthNo(int amount) =>
      hijriMonthNo = hijriMonthNo + amount;

  bool hasHijriMonthNo() => _hijriMonthNo != null;

  // "HijriMonthName" field.
  String? _hijriMonthName;
  String get hijriMonthName => _hijriMonthName ?? '';
  set hijriMonthName(String? val) => _hijriMonthName = val;

  bool hasHijriMonthName() => _hijriMonthName != null;

  // "HijriDay" field.
  int? _hijriDay;
  int get hijriDay => _hijriDay ?? 0;
  set hijriDay(int? val) => _hijriDay = val;

  void incrementHijriDay(int amount) => hijriDay = hijriDay + amount;

  bool hasHijriDay() => _hijriDay != null;

  // "GregorianDate" field.
  DateTime? _gregorianDate;
  DateTime? get gregorianDate => _gregorianDate;
  set gregorianDate(DateTime? val) => _gregorianDate = val;

  bool hasGregorianDate() => _gregorianDate != null;

  // "Weekday" field.
  String? _weekday;
  String get weekday => _weekday ?? '';
  set weekday(String? val) => _weekday = val;

  bool hasWeekday() => _weekday != null;

  // "Event" field.
  String? _event;
  String get event => _event ?? '';
  set event(String? val) => _event = val;

  bool hasEvent() => _event != null;

  static HijriCalenderStruct fromMap(Map<String, dynamic> data) =>
      HijriCalenderStruct(
        hijriYear: castToType<int>(data['HijriYear']),
        hijriMonthNo: castToType<int>(data['HijriMonthNo']),
        hijriMonthName: data['HijriMonthName'] as String?,
        hijriDay: castToType<int>(data['HijriDay']),
        gregorianDate: data['GregorianDate'] as DateTime?,
        weekday: data['Weekday'] as String?,
        event: data['Event'] as String?,
      );

  static HijriCalenderStruct? maybeFromMap(dynamic data) => data is Map
      ? HijriCalenderStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'HijriYear': _hijriYear,
        'HijriMonthNo': _hijriMonthNo,
        'HijriMonthName': _hijriMonthName,
        'HijriDay': _hijriDay,
        'GregorianDate': _gregorianDate,
        'Weekday': _weekday,
        'Event': _event,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'HijriYear': serializeParam(
          _hijriYear,
          ParamType.int,
        ),
        'HijriMonthNo': serializeParam(
          _hijriMonthNo,
          ParamType.int,
        ),
        'HijriMonthName': serializeParam(
          _hijriMonthName,
          ParamType.String,
        ),
        'HijriDay': serializeParam(
          _hijriDay,
          ParamType.int,
        ),
        'GregorianDate': serializeParam(
          _gregorianDate,
          ParamType.DateTime,
        ),
        'Weekday': serializeParam(
          _weekday,
          ParamType.String,
        ),
        'Event': serializeParam(
          _event,
          ParamType.String,
        ),
      }.withoutNulls;

  static HijriCalenderStruct fromSerializableMap(Map<String, dynamic> data) =>
      HijriCalenderStruct(
        hijriYear: deserializeParam(
          data['HijriYear'],
          ParamType.int,
          false,
        ),
        hijriMonthNo: deserializeParam(
          data['HijriMonthNo'],
          ParamType.int,
          false,
        ),
        hijriMonthName: deserializeParam(
          data['HijriMonthName'],
          ParamType.String,
          false,
        ),
        hijriDay: deserializeParam(
          data['HijriDay'],
          ParamType.int,
          false,
        ),
        gregorianDate: deserializeParam(
          data['GregorianDate'],
          ParamType.DateTime,
          false,
        ),
        weekday: deserializeParam(
          data['Weekday'],
          ParamType.String,
          false,
        ),
        event: deserializeParam(
          data['Event'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'HijriCalenderStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HijriCalenderStruct &&
        hijriYear == other.hijriYear &&
        hijriMonthNo == other.hijriMonthNo &&
        hijriMonthName == other.hijriMonthName &&
        hijriDay == other.hijriDay &&
        gregorianDate == other.gregorianDate &&
        weekday == other.weekday &&
        event == other.event;
  }

  @override
  int get hashCode => const ListEquality().hash([
        hijriYear,
        hijriMonthNo,
        hijriMonthName,
        hijriDay,
        gregorianDate,
        weekday,
        event
      ]);
}

HijriCalenderStruct createHijriCalenderStruct({
  int? hijriYear,
  int? hijriMonthNo,
  String? hijriMonthName,
  int? hijriDay,
  DateTime? gregorianDate,
  String? weekday,
  String? event,
}) =>
    HijriCalenderStruct(
      hijriYear: hijriYear,
      hijriMonthNo: hijriMonthNo,
      hijriMonthName: hijriMonthName,
      hijriDay: hijriDay,
      gregorianDate: gregorianDate,
      weekday: weekday,
      event: event,
    );
