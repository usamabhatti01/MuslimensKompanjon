// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class YoutubeStruct extends BaseStruct {
  YoutubeStruct({
    String? video,
    String? title,
    String? topic,
  })  : _video = video,
        _title = title,
        _topic = topic;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  set video(String? val) => _video = val;

  bool hasVideo() => _video != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "topic" field.
  String? _topic;
  String get topic => _topic ?? '';
  set topic(String? val) => _topic = val;

  bool hasTopic() => _topic != null;

  static YoutubeStruct fromMap(Map<String, dynamic> data) => YoutubeStruct(
        video: data['video'] as String?,
        title: data['title'] as String?,
        topic: data['topic'] as String?,
      );

  static YoutubeStruct? maybeFromMap(dynamic data) =>
      data is Map ? YoutubeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'video': _video,
        'title': _title,
        'topic': _topic,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'video': serializeParam(
          _video,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'topic': serializeParam(
          _topic,
          ParamType.String,
        ),
      }.withoutNulls;

  static YoutubeStruct fromSerializableMap(Map<String, dynamic> data) =>
      YoutubeStruct(
        video: deserializeParam(
          data['video'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        topic: deserializeParam(
          data['topic'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'YoutubeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is YoutubeStruct &&
        video == other.video &&
        title == other.title &&
        topic == other.topic;
  }

  @override
  int get hashCode => const ListEquality().hash([video, title, topic]);
}

YoutubeStruct createYoutubeStruct({
  String? video,
  String? title,
  String? topic,
}) =>
    YoutubeStruct(
      video: video,
      title: title,
      topic: topic,
    );
