// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DuaStruct extends BaseStruct {
  DuaStruct({
    int? categoryId,
    String? categoryTitleAr,
    List<DuaChildStruct>? duas,
    String? icon,
    String? subtitle,
    String? categoryTitleSv,
  })  : _categoryId = categoryId,
        _categoryTitleAr = categoryTitleAr,
        _duas = duas,
        _icon = icon,
        _subtitle = subtitle,
        _categoryTitleSv = categoryTitleSv;

  // "categoryId" field.
  int? _categoryId;
  int get categoryId => _categoryId ?? 0;
  set categoryId(int? val) => _categoryId = val;

  void incrementCategoryId(int amount) => categoryId = categoryId + amount;

  bool hasCategoryId() => _categoryId != null;

  // "categoryTitleAr" field.
  String? _categoryTitleAr;
  String get categoryTitleAr => _categoryTitleAr ?? '';
  set categoryTitleAr(String? val) => _categoryTitleAr = val;

  bool hasCategoryTitleAr() => _categoryTitleAr != null;

  // "duas" field.
  List<DuaChildStruct>? _duas;
  List<DuaChildStruct> get duas => _duas ?? const [];
  set duas(List<DuaChildStruct>? val) => _duas = val;

  void updateDuas(Function(List<DuaChildStruct>) updateFn) {
    updateFn(_duas ??= []);
  }

  bool hasDuas() => _duas != null;

  // "icon" field.
  String? _icon;
  String get icon => _icon ?? '';
  set icon(String? val) => _icon = val;

  bool hasIcon() => _icon != null;

  // "subtitle" field.
  String? _subtitle;
  String get subtitle => _subtitle ?? '';
  set subtitle(String? val) => _subtitle = val;

  bool hasSubtitle() => _subtitle != null;

  // "categoryTitleSv" field.
  String? _categoryTitleSv;
  String get categoryTitleSv => _categoryTitleSv ?? '';
  set categoryTitleSv(String? val) => _categoryTitleSv = val;

  bool hasCategoryTitleSv() => _categoryTitleSv != null;

  static DuaStruct fromMap(Map<String, dynamic> data) => DuaStruct(
        categoryId: castToType<int>(data['categoryId']),
        categoryTitleAr: data['categoryTitleAr'] as String?,
        duas: getStructList(
          data['duas'],
          DuaChildStruct.fromMap,
        ),
        icon: data['icon'] as String?,
        subtitle: data['subtitle'] as String?,
        categoryTitleSv: data['categoryTitleSv'] as String?,
      );

  static DuaStruct? maybeFromMap(dynamic data) =>
      data is Map ? DuaStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'categoryId': _categoryId,
        'categoryTitleAr': _categoryTitleAr,
        'duas': _duas?.map((e) => e.toMap()).toList(),
        'icon': _icon,
        'subtitle': _subtitle,
        'categoryTitleSv': _categoryTitleSv,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'categoryId': serializeParam(
          _categoryId,
          ParamType.int,
        ),
        'categoryTitleAr': serializeParam(
          _categoryTitleAr,
          ParamType.String,
        ),
        'duas': serializeParam(
          _duas,
          ParamType.DataStruct,
          isList: true,
        ),
        'icon': serializeParam(
          _icon,
          ParamType.String,
        ),
        'subtitle': serializeParam(
          _subtitle,
          ParamType.String,
        ),
        'categoryTitleSv': serializeParam(
          _categoryTitleSv,
          ParamType.String,
        ),
      }.withoutNulls;

  static DuaStruct fromSerializableMap(Map<String, dynamic> data) => DuaStruct(
        categoryId: deserializeParam(
          data['categoryId'],
          ParamType.int,
          false,
        ),
        categoryTitleAr: deserializeParam(
          data['categoryTitleAr'],
          ParamType.String,
          false,
        ),
        duas: deserializeStructParam<DuaChildStruct>(
          data['duas'],
          ParamType.DataStruct,
          true,
          structBuilder: DuaChildStruct.fromSerializableMap,
        ),
        icon: deserializeParam(
          data['icon'],
          ParamType.String,
          false,
        ),
        subtitle: deserializeParam(
          data['subtitle'],
          ParamType.String,
          false,
        ),
        categoryTitleSv: deserializeParam(
          data['categoryTitleSv'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DuaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DuaStruct &&
        categoryId == other.categoryId &&
        categoryTitleAr == other.categoryTitleAr &&
        listEquality.equals(duas, other.duas) &&
        icon == other.icon &&
        subtitle == other.subtitle &&
        categoryTitleSv == other.categoryTitleSv;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [categoryId, categoryTitleAr, duas, icon, subtitle, categoryTitleSv]);
}

DuaStruct createDuaStruct({
  int? categoryId,
  String? categoryTitleAr,
  String? icon,
  String? subtitle,
  String? categoryTitleSv,
}) =>
    DuaStruct(
      categoryId: categoryId,
      categoryTitleAr: categoryTitleAr,
      icon: icon,
      subtitle: subtitle,
      categoryTitleSv: categoryTitleSv,
    );
