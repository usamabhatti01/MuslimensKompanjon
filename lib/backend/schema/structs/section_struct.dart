// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SectionStruct extends BaseStruct {
  SectionStruct({
    String? heading,
    String? paragraphs,
  })  : _heading = heading,
        _paragraphs = paragraphs;

  // "heading" field.
  String? _heading;
  String get heading => _heading ?? '';
  set heading(String? val) => _heading = val;

  bool hasHeading() => _heading != null;

  // "paragraphs" field.
  String? _paragraphs;
  String get paragraphs => _paragraphs ?? '';
  set paragraphs(String? val) => _paragraphs = val;

  bool hasParagraphs() => _paragraphs != null;

  static SectionStruct fromMap(Map<String, dynamic> data) => SectionStruct(
        heading: data['heading'] as String?,
        paragraphs: data['paragraphs'] as String?,
      );

  static SectionStruct? maybeFromMap(dynamic data) =>
      data is Map ? SectionStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'heading': _heading,
        'paragraphs': _paragraphs,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'heading': serializeParam(
          _heading,
          ParamType.String,
        ),
        'paragraphs': serializeParam(
          _paragraphs,
          ParamType.String,
        ),
      }.withoutNulls;

  static SectionStruct fromSerializableMap(Map<String, dynamic> data) =>
      SectionStruct(
        heading: deserializeParam(
          data['heading'],
          ParamType.String,
          false,
        ),
        paragraphs: deserializeParam(
          data['paragraphs'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SectionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SectionStruct &&
        heading == other.heading &&
        paragraphs == other.paragraphs;
  }

  @override
  int get hashCode => const ListEquality().hash([heading, paragraphs]);
}

SectionStruct createSectionStruct({
  String? heading,
  String? paragraphs,
}) =>
    SectionStruct(
      heading: heading,
      paragraphs: paragraphs,
    );
