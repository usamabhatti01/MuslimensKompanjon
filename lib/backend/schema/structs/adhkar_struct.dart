// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdhkarStruct extends BaseStruct {
  AdhkarStruct({
    int? id,
    String? titleAr,
    String? titleSv,
    String? arabic,
    String? swedish,
    int? counter,
    String? audio,
  })  : _id = id,
        _titleAr = titleAr,
        _titleSv = titleSv,
        _arabic = arabic,
        _swedish = swedish,
        _counter = counter,
        _audio = audio;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "titleAr" field.
  String? _titleAr;
  String get titleAr => _titleAr ?? '';
  set titleAr(String? val) => _titleAr = val;

  bool hasTitleAr() => _titleAr != null;

  // "titleSv" field.
  String? _titleSv;
  String get titleSv => _titleSv ?? '';
  set titleSv(String? val) => _titleSv = val;

  bool hasTitleSv() => _titleSv != null;

  // "arabic" field.
  String? _arabic;
  String get arabic => _arabic ?? '';
  set arabic(String? val) => _arabic = val;

  bool hasArabic() => _arabic != null;

  // "swedish" field.
  String? _swedish;
  String get swedish => _swedish ?? '';
  set swedish(String? val) => _swedish = val;

  bool hasSwedish() => _swedish != null;

  // "counter" field.
  int? _counter;
  int get counter => _counter ?? 0;
  set counter(int? val) => _counter = val;

  void incrementCounter(int amount) => counter = counter + amount;

  bool hasCounter() => _counter != null;

  // "audio" field.
  String? _audio;
  String get audio => _audio ?? '';
  set audio(String? val) => _audio = val;

  bool hasAudio() => _audio != null;

  static AdhkarStruct fromMap(Map<String, dynamic> data) => AdhkarStruct(
        id: castToType<int>(data['id']),
        titleAr: data['titleAr'] as String?,
        titleSv: data['titleSv'] as String?,
        arabic: data['arabic'] as String?,
        swedish: data['swedish'] as String?,
        counter: castToType<int>(data['counter']),
        audio: data['audio'] as String?,
      );

  static AdhkarStruct? maybeFromMap(dynamic data) =>
      data is Map ? AdhkarStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'titleAr': _titleAr,
        'titleSv': _titleSv,
        'arabic': _arabic,
        'swedish': _swedish,
        'counter': _counter,
        'audio': _audio,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'titleAr': serializeParam(
          _titleAr,
          ParamType.String,
        ),
        'titleSv': serializeParam(
          _titleSv,
          ParamType.String,
        ),
        'arabic': serializeParam(
          _arabic,
          ParamType.String,
        ),
        'swedish': serializeParam(
          _swedish,
          ParamType.String,
        ),
        'counter': serializeParam(
          _counter,
          ParamType.int,
        ),
        'audio': serializeParam(
          _audio,
          ParamType.String,
        ),
      }.withoutNulls;

  static AdhkarStruct fromSerializableMap(Map<String, dynamic> data) =>
      AdhkarStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        titleAr: deserializeParam(
          data['titleAr'],
          ParamType.String,
          false,
        ),
        titleSv: deserializeParam(
          data['titleSv'],
          ParamType.String,
          false,
        ),
        arabic: deserializeParam(
          data['arabic'],
          ParamType.String,
          false,
        ),
        swedish: deserializeParam(
          data['swedish'],
          ParamType.String,
          false,
        ),
        counter: deserializeParam(
          data['counter'],
          ParamType.int,
          false,
        ),
        audio: deserializeParam(
          data['audio'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'AdhkarStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AdhkarStruct &&
        id == other.id &&
        titleAr == other.titleAr &&
        titleSv == other.titleSv &&
        arabic == other.arabic &&
        swedish == other.swedish &&
        counter == other.counter &&
        audio == other.audio;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, titleAr, titleSv, arabic, swedish, counter, audio]);
}

AdhkarStruct createAdhkarStruct({
  int? id,
  String? titleAr,
  String? titleSv,
  String? arabic,
  String? swedish,
  int? counter,
  String? audio,
}) =>
    AdhkarStruct(
      id: id,
      titleAr: titleAr,
      titleSv: titleSv,
      arabic: arabic,
      swedish: swedish,
      counter: counter,
      audio: audio,
    );
