// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SurahsStruct extends BaseStruct {
  SurahsStruct({
    int? number,
    String? name,
    String? englishName,
    String? swedishName,
    String? englishTranslation,
    String? revelationType,
    int? totalVerses,
    bool? fav,
  })  : _number = number,
        _name = name,
        _englishName = englishName,
        _swedishName = swedishName,
        _englishTranslation = englishTranslation,
        _revelationType = revelationType,
        _totalVerses = totalVerses,
        _fav = fav;

  // "number" field.
  int? _number;
  int get number => _number ?? 0;
  set number(int? val) => _number = val;

  void incrementNumber(int amount) => number = number + amount;

  bool hasNumber() => _number != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "englishName" field.
  String? _englishName;
  String get englishName => _englishName ?? '';
  set englishName(String? val) => _englishName = val;

  bool hasEnglishName() => _englishName != null;

  // "swedishName" field.
  String? _swedishName;
  String get swedishName => _swedishName ?? '';
  set swedishName(String? val) => _swedishName = val;

  bool hasSwedishName() => _swedishName != null;

  // "englishTranslation" field.
  String? _englishTranslation;
  String get englishTranslation => _englishTranslation ?? '';
  set englishTranslation(String? val) => _englishTranslation = val;

  bool hasEnglishTranslation() => _englishTranslation != null;

  // "revelationType" field.
  String? _revelationType;
  String get revelationType => _revelationType ?? '';
  set revelationType(String? val) => _revelationType = val;

  bool hasRevelationType() => _revelationType != null;

  // "totalVerses" field.
  int? _totalVerses;
  int get totalVerses => _totalVerses ?? 0;
  set totalVerses(int? val) => _totalVerses = val;

  void incrementTotalVerses(int amount) => totalVerses = totalVerses + amount;

  bool hasTotalVerses() => _totalVerses != null;

  // "fav" field.
  bool? _fav;
  bool get fav => _fav ?? false;
  set fav(bool? val) => _fav = val;

  bool hasFav() => _fav != null;

  static SurahsStruct fromMap(Map<String, dynamic> data) => SurahsStruct(
        number: castToType<int>(data['number']),
        name: data['name'] as String?,
        englishName: data['englishName'] as String?,
        swedishName: data['swedishName'] as String?,
        englishTranslation: data['englishTranslation'] as String?,
        revelationType: data['revelationType'] as String?,
        totalVerses: castToType<int>(data['totalVerses']),
        fav: data['fav'] as bool?,
      );

  static SurahsStruct? maybeFromMap(dynamic data) =>
      data is Map ? SurahsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'number': _number,
        'name': _name,
        'englishName': _englishName,
        'swedishName': _swedishName,
        'englishTranslation': _englishTranslation,
        'revelationType': _revelationType,
        'totalVerses': _totalVerses,
        'fav': _fav,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'number': serializeParam(
          _number,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'englishName': serializeParam(
          _englishName,
          ParamType.String,
        ),
        'swedishName': serializeParam(
          _swedishName,
          ParamType.String,
        ),
        'englishTranslation': serializeParam(
          _englishTranslation,
          ParamType.String,
        ),
        'revelationType': serializeParam(
          _revelationType,
          ParamType.String,
        ),
        'totalVerses': serializeParam(
          _totalVerses,
          ParamType.int,
        ),
        'fav': serializeParam(
          _fav,
          ParamType.bool,
        ),
      }.withoutNulls;

  static SurahsStruct fromSerializableMap(Map<String, dynamic> data) =>
      SurahsStruct(
        number: deserializeParam(
          data['number'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        englishName: deserializeParam(
          data['englishName'],
          ParamType.String,
          false,
        ),
        swedishName: deserializeParam(
          data['swedishName'],
          ParamType.String,
          false,
        ),
        englishTranslation: deserializeParam(
          data['englishTranslation'],
          ParamType.String,
          false,
        ),
        revelationType: deserializeParam(
          data['revelationType'],
          ParamType.String,
          false,
        ),
        totalVerses: deserializeParam(
          data['totalVerses'],
          ParamType.int,
          false,
        ),
        fav: deserializeParam(
          data['fav'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'SurahsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SurahsStruct &&
        number == other.number &&
        name == other.name &&
        englishName == other.englishName &&
        swedishName == other.swedishName &&
        englishTranslation == other.englishTranslation &&
        revelationType == other.revelationType &&
        totalVerses == other.totalVerses &&
        fav == other.fav;
  }

  @override
  int get hashCode => const ListEquality().hash([
        number,
        name,
        englishName,
        swedishName,
        englishTranslation,
        revelationType,
        totalVerses,
        fav
      ]);
}

SurahsStruct createSurahsStruct({
  int? number,
  String? name,
  String? englishName,
  String? swedishName,
  String? englishTranslation,
  String? revelationType,
  int? totalVerses,
  bool? fav,
}) =>
    SurahsStruct(
      number: number,
      name: name,
      englishName: englishName,
      swedishName: swedishName,
      englishTranslation: englishTranslation,
      revelationType: revelationType,
      totalVerses: totalVerses,
      fav: fav,
    );
