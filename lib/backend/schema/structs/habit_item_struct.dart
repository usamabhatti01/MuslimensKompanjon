// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class HabitItemStruct extends BaseStruct {
  HabitItemStruct({
    String? id,
    String? title,
    String? subtitle,
    String? categoryKey,
    Color? color,
    String? iconName,
    String? hadithQuote,
    String? hadithSource,
  })  : _id = id,
        _title = title,
        _subtitle = subtitle,
        _categoryKey = categoryKey,
        _color = color,
        _iconName = iconName,
        _hadithQuote = hadithQuote,
        _hadithSource = hadithSource;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "subtitle" field.
  String? _subtitle;
  String get subtitle => _subtitle ?? '';
  set subtitle(String? val) => _subtitle = val;

  bool hasSubtitle() => _subtitle != null;

  // "categoryKey" field.
  String? _categoryKey;
  String get categoryKey => _categoryKey ?? '';
  set categoryKey(String? val) => _categoryKey = val;

  bool hasCategoryKey() => _categoryKey != null;

  // "color" field.
  Color? _color;
  Color? get color => _color;
  set color(Color? val) => _color = val;

  bool hasColor() => _color != null;

  // "iconName" field.
  String? _iconName;
  String get iconName => _iconName ?? '';
  set iconName(String? val) => _iconName = val;

  bool hasIconName() => _iconName != null;

  // "hadithQuote" field.
  String? _hadithQuote;
  String get hadithQuote => _hadithQuote ?? '';
  set hadithQuote(String? val) => _hadithQuote = val;

  bool hasHadithQuote() => _hadithQuote != null;

  // "hadithSource" field.
  String? _hadithSource;
  String get hadithSource => _hadithSource ?? '';
  set hadithSource(String? val) => _hadithSource = val;

  bool hasHadithSource() => _hadithSource != null;

  static HabitItemStruct fromMap(Map<String, dynamic> data) => HabitItemStruct(
        id: data['id'] as String?,
        title: data['title'] as String?,
        subtitle: data['subtitle'] as String?,
        categoryKey: data['categoryKey'] as String?,
        color: getSchemaColor(data['color']),
        iconName: data['iconName'] as String?,
        hadithQuote: data['hadithQuote'] as String?,
        hadithSource: data['hadithSource'] as String?,
      );

  static HabitItemStruct? maybeFromMap(dynamic data) => data is Map
      ? HabitItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'subtitle': _subtitle,
        'categoryKey': _categoryKey,
        'color': _color,
        'iconName': _iconName,
        'hadithQuote': _hadithQuote,
        'hadithSource': _hadithSource,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'subtitle': serializeParam(
          _subtitle,
          ParamType.String,
        ),
        'categoryKey': serializeParam(
          _categoryKey,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.Color,
        ),
        'iconName': serializeParam(
          _iconName,
          ParamType.String,
        ),
        'hadithQuote': serializeParam(
          _hadithQuote,
          ParamType.String,
        ),
        'hadithSource': serializeParam(
          _hadithSource,
          ParamType.String,
        ),
      }.withoutNulls;

  static HabitItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      HabitItemStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        subtitle: deserializeParam(
          data['subtitle'],
          ParamType.String,
          false,
        ),
        categoryKey: deserializeParam(
          data['categoryKey'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.Color,
          false,
        ),
        iconName: deserializeParam(
          data['iconName'],
          ParamType.String,
          false,
        ),
        hadithQuote: deserializeParam(
          data['hadithQuote'],
          ParamType.String,
          false,
        ),
        hadithSource: deserializeParam(
          data['hadithSource'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'HabitItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is HabitItemStruct &&
        id == other.id &&
        title == other.title &&
        subtitle == other.subtitle &&
        categoryKey == other.categoryKey &&
        color == other.color &&
        iconName == other.iconName &&
        hadithQuote == other.hadithQuote &&
        hadithSource == other.hadithSource;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        title,
        subtitle,
        categoryKey,
        color,
        iconName,
        hadithQuote,
        hadithSource
      ]);
}

HabitItemStruct createHabitItemStruct({
  String? id,
  String? title,
  String? subtitle,
  String? categoryKey,
  Color? color,
  String? iconName,
  String? hadithQuote,
  String? hadithSource,
}) =>
    HabitItemStruct(
      id: id,
      title: title,
      subtitle: subtitle,
      categoryKey: categoryKey,
      color: color,
      iconName: iconName,
      hadithQuote: hadithQuote,
      hadithSource: hadithSource,
    );
