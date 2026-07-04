// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TasbihStruct extends BaseStruct {
  TasbihStruct({
    int? id,
    String? arabic,
    String? transliteration,
    String? swedishMeaning,
    String? arabicMeaning,
    int? counter,
  })  : _id = id,
        _arabic = arabic,
        _transliteration = transliteration,
        _swedishMeaning = swedishMeaning,
        _arabicMeaning = arabicMeaning,
        _counter = counter;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "arabic" field.
  String? _arabic;
  String get arabic => _arabic ?? '';
  set arabic(String? val) => _arabic = val;

  bool hasArabic() => _arabic != null;

  // "transliteration" field.
  String? _transliteration;
  String get transliteration => _transliteration ?? '';
  set transliteration(String? val) => _transliteration = val;

  bool hasTransliteration() => _transliteration != null;

  // "swedishMeaning" field.
  String? _swedishMeaning;
  String get swedishMeaning => _swedishMeaning ?? '';
  set swedishMeaning(String? val) => _swedishMeaning = val;

  bool hasSwedishMeaning() => _swedishMeaning != null;

  // "arabicMeaning" field.
  String? _arabicMeaning;
  String get arabicMeaning => _arabicMeaning ?? '';
  set arabicMeaning(String? val) => _arabicMeaning = val;

  bool hasArabicMeaning() => _arabicMeaning != null;

  // "counter" field.
  int? _counter;
  int get counter => _counter ?? 0;
  set counter(int? val) => _counter = val;

  void incrementCounter(int amount) => counter = counter + amount;

  bool hasCounter() => _counter != null;

  static TasbihStruct fromMap(Map<String, dynamic> data) => TasbihStruct(
        id: castToType<int>(data['id']),
        arabic: data['arabic'] as String?,
        transliteration: data['transliteration'] as String?,
        swedishMeaning: data['swedishMeaning'] as String?,
        arabicMeaning: data['arabicMeaning'] as String?,
        counter: castToType<int>(data['counter']),
      );

  static TasbihStruct? maybeFromMap(dynamic data) =>
      data is Map ? TasbihStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'arabic': _arabic,
        'transliteration': _transliteration,
        'swedishMeaning': _swedishMeaning,
        'arabicMeaning': _arabicMeaning,
        'counter': _counter,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'arabic': serializeParam(
          _arabic,
          ParamType.String,
        ),
        'transliteration': serializeParam(
          _transliteration,
          ParamType.String,
        ),
        'swedishMeaning': serializeParam(
          _swedishMeaning,
          ParamType.String,
        ),
        'arabicMeaning': serializeParam(
          _arabicMeaning,
          ParamType.String,
        ),
        'counter': serializeParam(
          _counter,
          ParamType.int,
        ),
      }.withoutNulls;

  static TasbihStruct fromSerializableMap(Map<String, dynamic> data) =>
      TasbihStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        arabic: deserializeParam(
          data['arabic'],
          ParamType.String,
          false,
        ),
        transliteration: deserializeParam(
          data['transliteration'],
          ParamType.String,
          false,
        ),
        swedishMeaning: deserializeParam(
          data['swedishMeaning'],
          ParamType.String,
          false,
        ),
        arabicMeaning: deserializeParam(
          data['arabicMeaning'],
          ParamType.String,
          false,
        ),
        counter: deserializeParam(
          data['counter'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'TasbihStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TasbihStruct &&
        id == other.id &&
        arabic == other.arabic &&
        transliteration == other.transliteration &&
        swedishMeaning == other.swedishMeaning &&
        arabicMeaning == other.arabicMeaning &&
        counter == other.counter;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [id, arabic, transliteration, swedishMeaning, arabicMeaning, counter]);
}

TasbihStruct createTasbihStruct({
  int? id,
  String? arabic,
  String? transliteration,
  String? swedishMeaning,
  String? arabicMeaning,
  int? counter,
}) =>
    TasbihStruct(
      id: id,
      arabic: arabic,
      transliteration: transliteration,
      swedishMeaning: swedishMeaning,
      arabicMeaning: arabicMeaning,
      counter: counter,
    );
