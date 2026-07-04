// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RatingTypeStruct extends BaseStruct {
  RatingTypeStruct({
    int? star,
    String? review,
  })  : _star = star,
        _review = review;

  // "star" field.
  int? _star;
  int get star => _star ?? 0;
  set star(int? val) => _star = val;

  void incrementStar(int amount) => star = star + amount;

  bool hasStar() => _star != null;

  // "review" field.
  String? _review;
  String get review => _review ?? '';
  set review(String? val) => _review = val;

  bool hasReview() => _review != null;

  static RatingTypeStruct fromMap(Map<String, dynamic> data) =>
      RatingTypeStruct(
        star: castToType<int>(data['star']),
        review: data['review'] as String?,
      );

  static RatingTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? RatingTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'star': _star,
        'review': _review,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'star': serializeParam(
          _star,
          ParamType.int,
        ),
        'review': serializeParam(
          _review,
          ParamType.String,
        ),
      }.withoutNulls;

  static RatingTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      RatingTypeStruct(
        star: deserializeParam(
          data['star'],
          ParamType.int,
          false,
        ),
        review: deserializeParam(
          data['review'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RatingTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RatingTypeStruct &&
        star == other.star &&
        review == other.review;
  }

  @override
  int get hashCode => const ListEquality().hash([star, review]);
}

RatingTypeStruct createRatingTypeStruct({
  int? star,
  String? review,
}) =>
    RatingTypeStruct(
      star: star,
      review: review,
    );
