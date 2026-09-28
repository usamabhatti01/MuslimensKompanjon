// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DuaChildStruct extends BaseStruct {
  DuaChildStruct({
    int? id,
    String? titleAr,
    String? arabic,
    String? translitterering,
    String? titleSv,
    String? swedish,
    String? source,
    String? status,
  })  : _id = id,
        _titleAr = titleAr,
        _arabic = arabic,
        _translitterering = translitterering,
        _titleSv = titleSv,
        _swedish = swedish,
        _source = source,
        _status = status;

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

  // "arabic" field.
  String? _arabic;
  String get arabic => _arabic ?? '';
  set arabic(String? val) => _arabic = val;

  bool hasArabic() => _arabic != null;

  // "translitterering" field.
  String? _translitterering;
  String get translitterering => _translitterering ?? '';
  set translitterering(String? val) => _translitterering = val;

  bool hasTranslitterering() => _translitterering != null;

  // "titleSv" field.
  String? _titleSv;
  String get titleSv => _titleSv ?? '';
  set titleSv(String? val) => _titleSv = val;

  bool hasTitleSv() => _titleSv != null;

  // "swedish" field.
  String? _swedish;
  String get swedish => _swedish ?? '';
  set swedish(String? val) => _swedish = val;

  bool hasSwedish() => _swedish != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  set source(String? val) => _source = val;

  bool hasSource() => _source != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static DuaChildStruct fromMap(Map<String, dynamic> data) => DuaChildStruct(
        id: castToType<int>(data['id']),
        titleAr: data['titleAr'] as String?,
        arabic: data['arabic'] as String?,
        translitterering: data['translitterering'] as String?,
        titleSv: data['titleSv'] as String?,
        swedish: data['swedish'] as String?,
        source: data['source'] as String?,
        status: data['status'] as String?,
      );

  static DuaChildStruct? maybeFromMap(dynamic data) =>
      data is Map ? DuaChildStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'titleAr': _titleAr,
        'arabic': _arabic,
        'translitterering': _translitterering,
        'titleSv': _titleSv,
        'swedish': _swedish,
        'source': _source,
        'status': _status,
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
        'arabic': serializeParam(
          _arabic,
          ParamType.String,
        ),
        'translitterering': serializeParam(
          _translitterering,
          ParamType.String,
        ),
        'titleSv': serializeParam(
          _titleSv,
          ParamType.String,
        ),
        'swedish': serializeParam(
          _swedish,
          ParamType.String,
        ),
        'source': serializeParam(
          _source,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static DuaChildStruct fromSerializableMap(Map<String, dynamic> data) =>
      DuaChildStruct(
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
        arabic: deserializeParam(
          data['arabic'],
          ParamType.String,
          false,
        ),
        translitterering: deserializeParam(
          data['translitterering'],
          ParamType.String,
          false,
        ),
        titleSv: deserializeParam(
          data['titleSv'],
          ParamType.String,
          false,
        ),
        swedish: deserializeParam(
          data['swedish'],
          ParamType.String,
          false,
        ),
        source: deserializeParam(
          data['source'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DuaChildStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DuaChildStruct &&
        id == other.id &&
        titleAr == other.titleAr &&
        arabic == other.arabic &&
        translitterering == other.translitterering &&
        titleSv == other.titleSv &&
        swedish == other.swedish &&
        source == other.source &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        titleAr,
        arabic,
        translitterering,
        titleSv,
        swedish,
        source,
        status
      ]);
}

DuaChildStruct createDuaChildStruct({
  int? id,
  String? titleAr,
  String? arabic,
  String? translitterering,
  String? titleSv,
  String? swedish,
  String? source,
  String? status,
}) =>
    DuaChildStruct(
      id: id,
      titleAr: titleAr,
      arabic: arabic,
      translitterering: translitterering,
      titleSv: titleSv,
      swedish: swedish,
      source: source,
      status: status,
    );
