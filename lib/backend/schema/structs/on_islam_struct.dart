// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OnIslamStruct extends BaseStruct {
  OnIslamStruct({
    String? title,
    int? part,
    int? totalParts,
    int? estimatedReadingTimeMinutes,
    String? introduction,
    List<SectionStruct>? sections,
    String? videoUrl,
    String? playlistUrl,
    bool? alreadyRead,
  })  : _title = title,
        _part = part,
        _totalParts = totalParts,
        _estimatedReadingTimeMinutes = estimatedReadingTimeMinutes,
        _introduction = introduction,
        _sections = sections,
        _videoUrl = videoUrl,
        _playlistUrl = playlistUrl,
        _alreadyRead = alreadyRead;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "part" field.
  int? _part;
  int get part => _part ?? 0;
  set part(int? val) => _part = val;

  void incrementPart(int amount) => part = part + amount;

  bool hasPart() => _part != null;

  // "total_parts" field.
  int? _totalParts;
  int get totalParts => _totalParts ?? 0;
  set totalParts(int? val) => _totalParts = val;

  void incrementTotalParts(int amount) => totalParts = totalParts + amount;

  bool hasTotalParts() => _totalParts != null;

  // "estimated_reading_time_minutes" field.
  int? _estimatedReadingTimeMinutes;
  int get estimatedReadingTimeMinutes => _estimatedReadingTimeMinutes ?? 0;
  set estimatedReadingTimeMinutes(int? val) =>
      _estimatedReadingTimeMinutes = val;

  void incrementEstimatedReadingTimeMinutes(int amount) =>
      estimatedReadingTimeMinutes = estimatedReadingTimeMinutes + amount;

  bool hasEstimatedReadingTimeMinutes() => _estimatedReadingTimeMinutes != null;

  // "introduction" field.
  String? _introduction;
  String get introduction => _introduction ?? '';
  set introduction(String? val) => _introduction = val;

  bool hasIntroduction() => _introduction != null;

  // "sections" field.
  List<SectionStruct>? _sections;
  List<SectionStruct> get sections => _sections ?? const [];
  set sections(List<SectionStruct>? val) => _sections = val;

  void updateSections(Function(List<SectionStruct>) updateFn) {
    updateFn(_sections ??= []);
  }

  bool hasSections() => _sections != null;

  // "videoUrl" field.
  String? _videoUrl;
  String get videoUrl => _videoUrl ?? '';
  set videoUrl(String? val) => _videoUrl = val;

  bool hasVideoUrl() => _videoUrl != null;

  // "playlistUrl" field.
  String? _playlistUrl;
  String get playlistUrl => _playlistUrl ?? '';
  set playlistUrl(String? val) => _playlistUrl = val;

  bool hasPlaylistUrl() => _playlistUrl != null;

  // "alreadyRead" field.
  bool? _alreadyRead;
  bool get alreadyRead => _alreadyRead ?? true;
  set alreadyRead(bool? val) => _alreadyRead = val;

  bool hasAlreadyRead() => _alreadyRead != null;

  static OnIslamStruct fromMap(Map<String, dynamic> data) => OnIslamStruct(
        title: data['title'] as String?,
        part: castToType<int>(data['part']),
        totalParts: castToType<int>(data['total_parts']),
        estimatedReadingTimeMinutes:
            castToType<int>(data['estimated_reading_time_minutes']),
        introduction: data['introduction'] as String?,
        sections: getStructList(
          data['sections'],
          SectionStruct.fromMap,
        ),
        videoUrl: data['videoUrl'] as String?,
        playlistUrl: data['playlistUrl'] as String?,
        alreadyRead: data['alreadyRead'] as bool?,
      );

  static OnIslamStruct? maybeFromMap(dynamic data) =>
      data is Map ? OnIslamStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'part': _part,
        'total_parts': _totalParts,
        'estimated_reading_time_minutes': _estimatedReadingTimeMinutes,
        'introduction': _introduction,
        'sections': _sections?.map((e) => e.toMap()).toList(),
        'videoUrl': _videoUrl,
        'playlistUrl': _playlistUrl,
        'alreadyRead': _alreadyRead,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'part': serializeParam(
          _part,
          ParamType.int,
        ),
        'total_parts': serializeParam(
          _totalParts,
          ParamType.int,
        ),
        'estimated_reading_time_minutes': serializeParam(
          _estimatedReadingTimeMinutes,
          ParamType.int,
        ),
        'introduction': serializeParam(
          _introduction,
          ParamType.String,
        ),
        'sections': serializeParam(
          _sections,
          ParamType.DataStruct,
          isList: true,
        ),
        'videoUrl': serializeParam(
          _videoUrl,
          ParamType.String,
        ),
        'playlistUrl': serializeParam(
          _playlistUrl,
          ParamType.String,
        ),
        'alreadyRead': serializeParam(
          _alreadyRead,
          ParamType.bool,
        ),
      }.withoutNulls;

  static OnIslamStruct fromSerializableMap(Map<String, dynamic> data) =>
      OnIslamStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        part: deserializeParam(
          data['part'],
          ParamType.int,
          false,
        ),
        totalParts: deserializeParam(
          data['total_parts'],
          ParamType.int,
          false,
        ),
        estimatedReadingTimeMinutes: deserializeParam(
          data['estimated_reading_time_minutes'],
          ParamType.int,
          false,
        ),
        introduction: deserializeParam(
          data['introduction'],
          ParamType.String,
          false,
        ),
        sections: deserializeStructParam<SectionStruct>(
          data['sections'],
          ParamType.DataStruct,
          true,
          structBuilder: SectionStruct.fromSerializableMap,
        ),
        videoUrl: deserializeParam(
          data['videoUrl'],
          ParamType.String,
          false,
        ),
        playlistUrl: deserializeParam(
          data['playlistUrl'],
          ParamType.String,
          false,
        ),
        alreadyRead: deserializeParam(
          data['alreadyRead'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'OnIslamStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is OnIslamStruct &&
        title == other.title &&
        part == other.part &&
        totalParts == other.totalParts &&
        estimatedReadingTimeMinutes == other.estimatedReadingTimeMinutes &&
        introduction == other.introduction &&
        listEquality.equals(sections, other.sections) &&
        videoUrl == other.videoUrl &&
        playlistUrl == other.playlistUrl &&
        alreadyRead == other.alreadyRead;
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        part,
        totalParts,
        estimatedReadingTimeMinutes,
        introduction,
        sections,
        videoUrl,
        playlistUrl,
        alreadyRead
      ]);
}

OnIslamStruct createOnIslamStruct({
  String? title,
  int? part,
  int? totalParts,
  int? estimatedReadingTimeMinutes,
  String? introduction,
  String? videoUrl,
  String? playlistUrl,
  bool? alreadyRead,
}) =>
    OnIslamStruct(
      title: title,
      part: part,
      totalParts: totalParts,
      estimatedReadingTimeMinutes: estimatedReadingTimeMinutes,
      introduction: introduction,
      videoUrl: videoUrl,
      playlistUrl: playlistUrl,
      alreadyRead: alreadyRead,
    );
