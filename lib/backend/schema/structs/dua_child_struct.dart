// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DuaChildStruct extends BaseStruct {
  DuaChildStruct({
    String? id,
    String? titleEn,
    String? titleAr,
    String? titleSv,
    String? arabic,
    String? swedish,
  })  : _id = id,
        _titleEn = titleEn,
        _titleAr = titleAr,
        _titleSv = titleSv,
        _arabic = arabic,
        _swedish = swedish;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "titleEn" field.
  String? _titleEn;
  String get titleEn => _titleEn ?? '';
  set titleEn(String? val) => _titleEn = val;

  bool hasTitleEn() => _titleEn != null;

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

  static DuaChildStruct fromMap(Map<String, dynamic> data) => DuaChildStruct(
        id: data['id'] as String?,
        titleEn: data['titleEn'] as String?,
        titleAr: data['titleAr'] as String?,
        titleSv: data['titleSv'] as String?,
        arabic: data['arabic'] as String?,
        swedish: data['swedish'] as String?,
      );

  static DuaChildStruct? maybeFromMap(dynamic data) =>
      data is Map ? DuaChildStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'titleEn': _titleEn,
        'titleAr': _titleAr,
        'titleSv': _titleSv,
        'arabic': _arabic,
        'swedish': _swedish,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'titleEn': serializeParam(
          _titleEn,
          ParamType.String,
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
      }.withoutNulls;

  static DuaChildStruct fromSerializableMap(Map<String, dynamic> data) =>
      DuaChildStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        titleEn: deserializeParam(
          data['titleEn'],
          ParamType.String,
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
      );

  @override
  String toString() => 'DuaChildStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DuaChildStruct &&
        id == other.id &&
        titleEn == other.titleEn &&
        titleAr == other.titleAr &&
        titleSv == other.titleSv &&
        arabic == other.arabic &&
        swedish == other.swedish;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, titleEn, titleAr, titleSv, arabic, swedish]);
}

DuaChildStruct createDuaChildStruct({
  String? id,
  String? titleEn,
  String? titleAr,
  String? titleSv,
  String? arabic,
  String? swedish,
}) =>
    DuaChildStruct(
      id: id,
      titleEn: titleEn,
      titleAr: titleAr,
      titleSv: titleSv,
      arabic: arabic,
      swedish: swedish,
    );
