// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TasbihStruct extends BaseStruct {
  TasbihStruct({
    int? id,
    String? titleAr,
    String? titleSv,
    String? arabic,
    String? transliteration,
    String? swedish,
    String? whyRead,
    String? reward,
    String? source,
    String? status,
    int? targetCount,
  })  : _id = id,
        _titleAr = titleAr,
        _titleSv = titleSv,
        _arabic = arabic,
        _transliteration = transliteration,
        _swedish = swedish,
        _whyRead = whyRead,
        _reward = reward,
        _source = source,
        _status = status,
        _targetCount = targetCount;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

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

  // "transliteration" field.
  String? _transliteration;
  String get transliteration => _transliteration ?? '';
  set transliteration(String? val) => _transliteration = val;

  bool hasTransliteration() => _transliteration != null;

  // "swedish" field.
  String? _swedish;
  String get swedish => _swedish ?? '';
  set swedish(String? val) => _swedish = val;

  bool hasSwedish() => _swedish != null;

  // "whyRead" field.
  String? _whyRead;
  String get whyRead => _whyRead ?? '';
  set whyRead(String? val) => _whyRead = val;

  bool hasWhyRead() => _whyRead != null;

  // "reward" field.
  String? _reward;
  String get reward => _reward ?? '';
  set reward(String? val) => _reward = val;

  bool hasReward() => _reward != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  set source(String? val) => _source = val;

  bool hasSource() => _source != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "targetCount" field.
  int? _targetCount;
  int get targetCount => _targetCount ?? 0;
  set targetCount(int? val) => _targetCount = val;

  void incrementTargetCount(int amount) => targetCount = targetCount + amount;

  bool hasTargetCount() => _targetCount != null;

  static TasbihStruct fromMap(Map<String, dynamic> data) => TasbihStruct(
        id: castToType<int>(data['id']),
        titleAr: data['titleAr'] as String?,
        titleSv: data['titleSv'] as String?,
        arabic: data['arabic'] as String?,
        transliteration: data['transliteration'] as String?,
        swedish: data['swedish'] as String?,
        whyRead: data['whyRead'] as String?,
        reward: data['reward'] as String?,
        source: data['source'] as String?,
        status: data['status'] as String?,
        targetCount: castToType<int>(data['targetCount']),
      );

  static TasbihStruct? maybeFromMap(dynamic data) =>
      data is Map ? TasbihStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'titleAr': _titleAr,
        'titleSv': _titleSv,
        'arabic': _arabic,
        'transliteration': _transliteration,
        'swedish': _swedish,
        'whyRead': _whyRead,
        'reward': _reward,
        'source': _source,
        'status': _status,
        'targetCount': _targetCount,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
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
        'transliteration': serializeParam(
          _transliteration,
          ParamType.String,
        ),
        'swedish': serializeParam(
          _swedish,
          ParamType.String,
        ),
        'whyRead': serializeParam(
          _whyRead,
          ParamType.String,
        ),
        'reward': serializeParam(
          _reward,
          ParamType.String,
        ),
        'source': serializeParam(
          _source,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'targetCount': serializeParam(
          _targetCount,
          ParamType.int,
        ),
      }.withoutNulls;

  static TasbihStruct fromSerializableMap(Map<String, dynamic> data) =>
      TasbihStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
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
        transliteration: deserializeParam(
          data['transliteration'],
          ParamType.String,
          false,
        ),
        swedish: deserializeParam(
          data['swedish'],
          ParamType.String,
          false,
        ),
        whyRead: deserializeParam(
          data['whyRead'],
          ParamType.String,
          false,
        ),
        reward: deserializeParam(
          data['reward'],
          ParamType.String,
          false,
        ),
        source: deserializeParam(
          data['source'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        targetCount: deserializeParam(
          data['targetCount'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'TasbihStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TasbihStruct &&
        id == other.id &&
        titleAr == other.titleAr &&
        titleSv == other.titleSv &&
        arabic == other.arabic &&
        transliteration == other.transliteration &&
        swedish == other.swedish &&
        whyRead == other.whyRead &&
        reward == other.reward &&
        source == other.source &&
        status == other.status &&
        targetCount == other.targetCount;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        titleAr,
        titleSv,
        arabic,
        transliteration,
        swedish,
        whyRead,
        reward,
        source,
        status,
        targetCount
      ]);
}

TasbihStruct createTasbihStruct({
  int? id,
  String? titleAr,
  String? titleSv,
  String? arabic,
  String? transliteration,
  String? swedish,
  String? whyRead,
  String? reward,
  String? source,
  String? status,
  int? targetCount,
}) =>
    TasbihStruct(
      id: id,
      titleAr: titleAr,
      titleSv: titleSv,
      arabic: arabic,
      transliteration: transliteration,
      swedish: swedish,
      whyRead: whyRead,
      reward: reward,
      source: source,
      status: status,
      targetCount: targetCount,
    );
