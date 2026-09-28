// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdhkarStruct extends BaseStruct {
  AdhkarStruct({
    int? id,
    String? translitterering,
    String? arabic,
    String? swedish,
    int? counter,
    String? audio,
    bool? morning,
    bool? evening,
  })  : _id = id,
        _translitterering = translitterering,
        _arabic = arabic,
        _swedish = swedish,
        _counter = counter,
        _audio = audio,
        _morning = morning,
        _evening = evening;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "translitterering" field.
  String? _translitterering;
  String get translitterering => _translitterering ?? '';
  set translitterering(String? val) => _translitterering = val;

  bool hasTranslitterering() => _translitterering != null;

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

  // "morning" field.
  bool? _morning;
  bool get morning => _morning ?? false;
  set morning(bool? val) => _morning = val;

  bool hasMorning() => _morning != null;

  // "evening" field.
  bool? _evening;
  bool get evening => _evening ?? false;
  set evening(bool? val) => _evening = val;

  bool hasEvening() => _evening != null;

  static AdhkarStruct fromMap(Map<String, dynamic> data) => AdhkarStruct(
        id: castToType<int>(data['id']),
        translitterering: data['translitterering'] as String?,
        arabic: data['arabic'] as String?,
        swedish: data['swedish'] as String?,
        counter: castToType<int>(data['counter']),
        audio: data['audio'] as String?,
        morning: data['morning'] as bool?,
        evening: data['evening'] as bool?,
      );

  static AdhkarStruct? maybeFromMap(dynamic data) =>
      data is Map ? AdhkarStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'translitterering': _translitterering,
        'arabic': _arabic,
        'swedish': _swedish,
        'counter': _counter,
        'audio': _audio,
        'morning': _morning,
        'evening': _evening,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'translitterering': serializeParam(
          _translitterering,
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
        'morning': serializeParam(
          _morning,
          ParamType.bool,
        ),
        'evening': serializeParam(
          _evening,
          ParamType.bool,
        ),
      }.withoutNulls;

  static AdhkarStruct fromSerializableMap(Map<String, dynamic> data) =>
      AdhkarStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        translitterering: deserializeParam(
          data['translitterering'],
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
        morning: deserializeParam(
          data['morning'],
          ParamType.bool,
          false,
        ),
        evening: deserializeParam(
          data['evening'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'AdhkarStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AdhkarStruct &&
        id == other.id &&
        translitterering == other.translitterering &&
        arabic == other.arabic &&
        swedish == other.swedish &&
        counter == other.counter &&
        audio == other.audio &&
        morning == other.morning &&
        evening == other.evening;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        translitterering,
        arabic,
        swedish,
        counter,
        audio,
        morning,
        evening
      ]);
}

AdhkarStruct createAdhkarStruct({
  int? id,
  String? translitterering,
  String? arabic,
  String? swedish,
  int? counter,
  String? audio,
  bool? morning,
  bool? evening,
}) =>
    AdhkarStruct(
      id: id,
      translitterering: translitterering,
      arabic: arabic,
      swedish: swedish,
      counter: counter,
      audio: audio,
      morning: morning,
      evening: evening,
    );
