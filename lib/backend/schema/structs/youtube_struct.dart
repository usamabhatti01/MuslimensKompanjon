// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class YoutubeStruct extends BaseStruct {
  YoutubeStruct({
    String? video,
    String? title,
    String? topic,
    String? views,
    String? likes,
    String? duration,
    String? thumbnail,
    DateTime? postDate,
    bool? isFav,
  })  : _video = video,
        _title = title,
        _topic = topic,
        _views = views,
        _likes = likes,
        _duration = duration,
        _thumbnail = thumbnail,
        _postDate = postDate,
        _isFav = isFav;

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

  // "views" field.
  String? _views;
  String get views => _views ?? '';
  set views(String? val) => _views = val;

  bool hasViews() => _views != null;

  // "likes" field.
  String? _likes;
  String get likes => _likes ?? '';
  set likes(String? val) => _likes = val;

  bool hasLikes() => _likes != null;

  // "duration" field.
  String? _duration;
  String get duration => _duration ?? '';
  set duration(String? val) => _duration = val;

  bool hasDuration() => _duration != null;

  // "thumbnail" field.
  String? _thumbnail;
  String get thumbnail => _thumbnail ?? '';
  set thumbnail(String? val) => _thumbnail = val;

  bool hasThumbnail() => _thumbnail != null;

  // "postDate" field.
  DateTime? _postDate;
  DateTime? get postDate => _postDate;
  set postDate(DateTime? val) => _postDate = val;

  bool hasPostDate() => _postDate != null;

  // "isFav" field.
  bool? _isFav;
  bool get isFav => _isFav ?? false;
  set isFav(bool? val) => _isFav = val;

  bool hasIsFav() => _isFav != null;

  static YoutubeStruct fromMap(Map<String, dynamic> data) => YoutubeStruct(
        video: data['video'] as String?,
        title: data['title'] as String?,
        topic: data['topic'] as String?,
        views: data['views'] as String?,
        likes: data['likes'] as String?,
        duration: data['duration'] as String?,
        thumbnail: data['thumbnail'] as String?,
        postDate: data['postDate'] as DateTime?,
        isFav: data['isFav'] as bool?,
      );

  static YoutubeStruct? maybeFromMap(dynamic data) =>
      data is Map ? YoutubeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'video': _video,
        'title': _title,
        'topic': _topic,
        'views': _views,
        'likes': _likes,
        'duration': _duration,
        'thumbnail': _thumbnail,
        'postDate': _postDate,
        'isFav': _isFav,
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
        'views': serializeParam(
          _views,
          ParamType.String,
        ),
        'likes': serializeParam(
          _likes,
          ParamType.String,
        ),
        'duration': serializeParam(
          _duration,
          ParamType.String,
        ),
        'thumbnail': serializeParam(
          _thumbnail,
          ParamType.String,
        ),
        'postDate': serializeParam(
          _postDate,
          ParamType.DateTime,
        ),
        'isFav': serializeParam(
          _isFav,
          ParamType.bool,
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
        views: deserializeParam(
          data['views'],
          ParamType.String,
          false,
        ),
        likes: deserializeParam(
          data['likes'],
          ParamType.String,
          false,
        ),
        duration: deserializeParam(
          data['duration'],
          ParamType.String,
          false,
        ),
        thumbnail: deserializeParam(
          data['thumbnail'],
          ParamType.String,
          false,
        ),
        postDate: deserializeParam(
          data['postDate'],
          ParamType.DateTime,
          false,
        ),
        isFav: deserializeParam(
          data['isFav'],
          ParamType.bool,
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
        topic == other.topic &&
        views == other.views &&
        likes == other.likes &&
        duration == other.duration &&
        thumbnail == other.thumbnail &&
        postDate == other.postDate &&
        isFav == other.isFav;
  }

  @override
  int get hashCode => const ListEquality().hash([
        video,
        title,
        topic,
        views,
        likes,
        duration,
        thumbnail,
        postDate,
        isFav
      ]);
}

YoutubeStruct createYoutubeStruct({
  String? video,
  String? title,
  String? topic,
  String? views,
  String? likes,
  String? duration,
  String? thumbnail,
  DateTime? postDate,
  bool? isFav,
}) =>
    YoutubeStruct(
      video: video,
      title: title,
      topic: topic,
      views: views,
      likes: likes,
      duration: duration,
      thumbnail: thumbnail,
      postDate: postDate,
      isFav: isFav,
    );
