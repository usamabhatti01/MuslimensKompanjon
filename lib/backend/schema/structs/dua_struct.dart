// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DuaStruct extends BaseStruct {
  DuaStruct({
    String? categoryId,
    String? categoryTitleEn,
    String? categoryTitleAr,
    String? categoryTitleSv,
    List<DuaChildStruct>? dua,
  })  : _categoryId = categoryId,
        _categoryTitleEn = categoryTitleEn,
        _categoryTitleAr = categoryTitleAr,
        _categoryTitleSv = categoryTitleSv,
        _dua = dua;

  // "categoryId" field.
  String? _categoryId;
  String get categoryId => _categoryId ?? '';
  set categoryId(String? val) => _categoryId = val;

  bool hasCategoryId() => _categoryId != null;

  // "categoryTitleEn" field.
  String? _categoryTitleEn;
  String get categoryTitleEn => _categoryTitleEn ?? '';
  set categoryTitleEn(String? val) => _categoryTitleEn = val;

  bool hasCategoryTitleEn() => _categoryTitleEn != null;

  // "categoryTitleAr" field.
  String? _categoryTitleAr;
  String get categoryTitleAr => _categoryTitleAr ?? '';
  set categoryTitleAr(String? val) => _categoryTitleAr = val;

  bool hasCategoryTitleAr() => _categoryTitleAr != null;

  // "categoryTitleSv" field.
  String? _categoryTitleSv;
  String get categoryTitleSv => _categoryTitleSv ?? '';
  set categoryTitleSv(String? val) => _categoryTitleSv = val;

  bool hasCategoryTitleSv() => _categoryTitleSv != null;

  // "dua" field.
  List<DuaChildStruct>? _dua;
  List<DuaChildStruct> get dua => _dua ?? const [];
  set dua(List<DuaChildStruct>? val) => _dua = val;

  void updateDua(Function(List<DuaChildStruct>) updateFn) {
    updateFn(_dua ??= []);
  }

  bool hasDua() => _dua != null;

  static DuaStruct fromMap(Map<String, dynamic> data) => DuaStruct(
        categoryId: data['categoryId'] as String?,
        categoryTitleEn: data['categoryTitleEn'] as String?,
        categoryTitleAr: data['categoryTitleAr'] as String?,
        categoryTitleSv: data['categoryTitleSv'] as String?,
        dua: getStructList(
          data['dua'],
          DuaChildStruct.fromMap,
        ),
      );

  static DuaStruct? maybeFromMap(dynamic data) =>
      data is Map ? DuaStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'categoryId': _categoryId,
        'categoryTitleEn': _categoryTitleEn,
        'categoryTitleAr': _categoryTitleAr,
        'categoryTitleSv': _categoryTitleSv,
        'dua': _dua?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'categoryId': serializeParam(
          _categoryId,
          ParamType.String,
        ),
        'categoryTitleEn': serializeParam(
          _categoryTitleEn,
          ParamType.String,
        ),
        'categoryTitleAr': serializeParam(
          _categoryTitleAr,
          ParamType.String,
        ),
        'categoryTitleSv': serializeParam(
          _categoryTitleSv,
          ParamType.String,
        ),
        'dua': serializeParam(
          _dua,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static DuaStruct fromSerializableMap(Map<String, dynamic> data) => DuaStruct(
        categoryId: deserializeParam(
          data['categoryId'],
          ParamType.String,
          false,
        ),
        categoryTitleEn: deserializeParam(
          data['categoryTitleEn'],
          ParamType.String,
          false,
        ),
        categoryTitleAr: deserializeParam(
          data['categoryTitleAr'],
          ParamType.String,
          false,
        ),
        categoryTitleSv: deserializeParam(
          data['categoryTitleSv'],
          ParamType.String,
          false,
        ),
        dua: deserializeStructParam<DuaChildStruct>(
          data['dua'],
          ParamType.DataStruct,
          true,
          structBuilder: DuaChildStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'DuaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DuaStruct &&
        categoryId == other.categoryId &&
        categoryTitleEn == other.categoryTitleEn &&
        categoryTitleAr == other.categoryTitleAr &&
        categoryTitleSv == other.categoryTitleSv &&
        listEquality.equals(dua, other.dua);
  }

  @override
  int get hashCode => const ListEquality().hash(
      [categoryId, categoryTitleEn, categoryTitleAr, categoryTitleSv, dua]);
}

DuaStruct createDuaStruct({
  String? categoryId,
  String? categoryTitleEn,
  String? categoryTitleAr,
  String? categoryTitleSv,
}) =>
    DuaStruct(
      categoryId: categoryId,
      categoryTitleEn: categoryTitleEn,
      categoryTitleAr: categoryTitleAr,
      categoryTitleSv: categoryTitleSv,
    );
