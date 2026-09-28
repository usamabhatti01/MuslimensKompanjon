// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PostStruct extends BaseStruct {
  PostStruct({
    String? postDetail,
    DateTime? postedDate,
    String? comment,
    String? like,
  })  : _postDetail = postDetail,
        _postedDate = postedDate,
        _comment = comment,
        _like = like;

  // "postDetail" field.
  String? _postDetail;
  String get postDetail => _postDetail ?? '';
  set postDetail(String? val) => _postDetail = val;

  bool hasPostDetail() => _postDetail != null;

  // "postedDate" field.
  DateTime? _postedDate;
  DateTime? get postedDate => _postedDate;
  set postedDate(DateTime? val) => _postedDate = val;

  bool hasPostedDate() => _postedDate != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  // "like" field.
  String? _like;
  String get like => _like ?? '';
  set like(String? val) => _like = val;

  bool hasLike() => _like != null;

  static PostStruct fromMap(Map<String, dynamic> data) => PostStruct(
        postDetail: data['postDetail'] as String?,
        postedDate: data['postedDate'] as DateTime?,
        comment: data['comment'] as String?,
        like: data['like'] as String?,
      );

  static PostStruct? maybeFromMap(dynamic data) =>
      data is Map ? PostStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'postDetail': _postDetail,
        'postedDate': _postedDate,
        'comment': _comment,
        'like': _like,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'postDetail': serializeParam(
          _postDetail,
          ParamType.String,
        ),
        'postedDate': serializeParam(
          _postedDate,
          ParamType.DateTime,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
        'like': serializeParam(
          _like,
          ParamType.String,
        ),
      }.withoutNulls;

  static PostStruct fromSerializableMap(Map<String, dynamic> data) =>
      PostStruct(
        postDetail: deserializeParam(
          data['postDetail'],
          ParamType.String,
          false,
        ),
        postedDate: deserializeParam(
          data['postedDate'],
          ParamType.DateTime,
          false,
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
        like: deserializeParam(
          data['like'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PostStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PostStruct &&
        postDetail == other.postDetail &&
        postedDate == other.postedDate &&
        comment == other.comment &&
        like == other.like;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([postDetail, postedDate, comment, like]);
}

PostStruct createPostStruct({
  String? postDetail,
  DateTime? postedDate,
  String? comment,
  String? like,
}) =>
    PostStruct(
      postDetail: postDetail,
      postedDate: postedDate,
      comment: comment,
      like: like,
    );
