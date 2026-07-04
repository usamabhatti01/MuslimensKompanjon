// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AllahNameStruct extends BaseStruct {
  AllahNameStruct({
    int? number,
    String? arabic,
    String? transliteration,
    String? swedishTranslation,
    String? swedishExplanation,
    String? arabicExplanation,
    String? arabicAudioUrl,
    String? swedishAudioUrl,
  })  : _number = number,
        _arabic = arabic,
        _transliteration = transliteration,
        _swedishTranslation = swedishTranslation,
        _swedishExplanation = swedishExplanation,
        _arabicExplanation = arabicExplanation,
        _arabicAudioUrl = arabicAudioUrl,
        _swedishAudioUrl = swedishAudioUrl;

  // "Number" field.
  int? _number;
  int get number => _number ?? 0;
  set number(int? val) => _number = val;

  void incrementNumber(int amount) => number = number + amount;

  bool hasNumber() => _number != null;

  // "Arabic" field.
  String? _arabic;
  String get arabic => _arabic ?? '';
  set arabic(String? val) => _arabic = val;

  bool hasArabic() => _arabic != null;

  // "Transliteration" field.
  String? _transliteration;
  String get transliteration => _transliteration ?? '';
  set transliteration(String? val) => _transliteration = val;

  bool hasTransliteration() => _transliteration != null;

  // "SwedishTranslation" field.
  String? _swedishTranslation;
  String get swedishTranslation => _swedishTranslation ?? '';
  set swedishTranslation(String? val) => _swedishTranslation = val;

  bool hasSwedishTranslation() => _swedishTranslation != null;

  // "SwedishExplanation" field.
  String? _swedishExplanation;
  String get swedishExplanation => _swedishExplanation ?? '';
  set swedishExplanation(String? val) => _swedishExplanation = val;

  bool hasSwedishExplanation() => _swedishExplanation != null;

  // "ArabicExplanation" field.
  String? _arabicExplanation;
  String get arabicExplanation => _arabicExplanation ?? '';
  set arabicExplanation(String? val) => _arabicExplanation = val;

  bool hasArabicExplanation() => _arabicExplanation != null;

  // "ArabicAudioUrl" field.
  String? _arabicAudioUrl;
  String get arabicAudioUrl => _arabicAudioUrl ?? '';
  set arabicAudioUrl(String? val) => _arabicAudioUrl = val;

  bool hasArabicAudioUrl() => _arabicAudioUrl != null;

  // "SwedishAudioUrl" field.
  String? _swedishAudioUrl;
  String get swedishAudioUrl => _swedishAudioUrl ?? '';
  set swedishAudioUrl(String? val) => _swedishAudioUrl = val;

  bool hasSwedishAudioUrl() => _swedishAudioUrl != null;

  static AllahNameStruct fromMap(Map<String, dynamic> data) => AllahNameStruct(
        number: castToType<int>(data['Number']),
        arabic: data['Arabic'] as String?,
        transliteration: data['Transliteration'] as String?,
        swedishTranslation: data['SwedishTranslation'] as String?,
        swedishExplanation: data['SwedishExplanation'] as String?,
        arabicExplanation: data['ArabicExplanation'] as String?,
        arabicAudioUrl: data['ArabicAudioUrl'] as String?,
        swedishAudioUrl: data['SwedishAudioUrl'] as String?,
      );

  static AllahNameStruct? maybeFromMap(dynamic data) => data is Map
      ? AllahNameStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Number': _number,
        'Arabic': _arabic,
        'Transliteration': _transliteration,
        'SwedishTranslation': _swedishTranslation,
        'SwedishExplanation': _swedishExplanation,
        'ArabicExplanation': _arabicExplanation,
        'ArabicAudioUrl': _arabicAudioUrl,
        'SwedishAudioUrl': _swedishAudioUrl,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Number': serializeParam(
          _number,
          ParamType.int,
        ),
        'Arabic': serializeParam(
          _arabic,
          ParamType.String,
        ),
        'Transliteration': serializeParam(
          _transliteration,
          ParamType.String,
        ),
        'SwedishTranslation': serializeParam(
          _swedishTranslation,
          ParamType.String,
        ),
        'SwedishExplanation': serializeParam(
          _swedishExplanation,
          ParamType.String,
        ),
        'ArabicExplanation': serializeParam(
          _arabicExplanation,
          ParamType.String,
        ),
        'ArabicAudioUrl': serializeParam(
          _arabicAudioUrl,
          ParamType.String,
        ),
        'SwedishAudioUrl': serializeParam(
          _swedishAudioUrl,
          ParamType.String,
        ),
      }.withoutNulls;

  static AllahNameStruct fromSerializableMap(Map<String, dynamic> data) =>
      AllahNameStruct(
        number: deserializeParam(
          data['Number'],
          ParamType.int,
          false,
        ),
        arabic: deserializeParam(
          data['Arabic'],
          ParamType.String,
          false,
        ),
        transliteration: deserializeParam(
          data['Transliteration'],
          ParamType.String,
          false,
        ),
        swedishTranslation: deserializeParam(
          data['SwedishTranslation'],
          ParamType.String,
          false,
        ),
        swedishExplanation: deserializeParam(
          data['SwedishExplanation'],
          ParamType.String,
          false,
        ),
        arabicExplanation: deserializeParam(
          data['ArabicExplanation'],
          ParamType.String,
          false,
        ),
        arabicAudioUrl: deserializeParam(
          data['ArabicAudioUrl'],
          ParamType.String,
          false,
        ),
        swedishAudioUrl: deserializeParam(
          data['SwedishAudioUrl'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AllahNameStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AllahNameStruct &&
        number == other.number &&
        arabic == other.arabic &&
        transliteration == other.transliteration &&
        swedishTranslation == other.swedishTranslation &&
        swedishExplanation == other.swedishExplanation &&
        arabicExplanation == other.arabicExplanation &&
        arabicAudioUrl == other.arabicAudioUrl &&
        swedishAudioUrl == other.swedishAudioUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([
        number,
        arabic,
        transliteration,
        swedishTranslation,
        swedishExplanation,
        arabicExplanation,
        arabicAudioUrl,
        swedishAudioUrl
      ]);
}

AllahNameStruct createAllahNameStruct({
  int? number,
  String? arabic,
  String? transliteration,
  String? swedishTranslation,
  String? swedishExplanation,
  String? arabicExplanation,
  String? arabicAudioUrl,
  String? swedishAudioUrl,
}) =>
    AllahNameStruct(
      number: number,
      arabic: arabic,
      transliteration: transliteration,
      swedishTranslation: swedishTranslation,
      swedishExplanation: swedishExplanation,
      arabicExplanation: arabicExplanation,
      arabicAudioUrl: arabicAudioUrl,
      swedishAudioUrl: swedishAudioUrl,
    );
