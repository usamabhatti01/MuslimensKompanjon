// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AyahsStruct extends BaseStruct {
  AyahsStruct({
    String? id,
    int? surah,
    int? ayah,
    int? juz,
    String? arabic,
    String? english,
    String? swedish,
    String? audio,
    bool? fav,
  })  : _id = id,
        _surah = surah,
        _ayah = ayah,
        _juz = juz,
        _arabic = arabic,
        _english = english,
        _swedish = swedish,
        _audio = audio,
        _fav = fav;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "surah" field.
  int? _surah;
  int get surah => _surah ?? 0;
  set surah(int? val) => _surah = val;

  void incrementSurah(int amount) => surah = surah + amount;

  bool hasSurah() => _surah != null;

  // "ayah" field.
  int? _ayah;
  int get ayah => _ayah ?? 0;
  set ayah(int? val) => _ayah = val;

  void incrementAyah(int amount) => ayah = ayah + amount;

  bool hasAyah() => _ayah != null;

  // "juz" field.
  int? _juz;
  int get juz => _juz ?? 0;
  set juz(int? val) => _juz = val;

  void incrementJuz(int amount) => juz = juz + amount;

  bool hasJuz() => _juz != null;

  // "arabic" field.
  String? _arabic;
  String get arabic => _arabic ?? '';
  set arabic(String? val) => _arabic = val;

  bool hasArabic() => _arabic != null;

  // "english" field.
  String? _english;
  String get english => _english ?? '';
  set english(String? val) => _english = val;

  bool hasEnglish() => _english != null;

  // "swedish" field.
  String? _swedish;
  String get swedish => _swedish ?? '';
  set swedish(String? val) => _swedish = val;

  bool hasSwedish() => _swedish != null;

  // "audio" field.
  String? _audio;
  String get audio => _audio ?? '';
  set audio(String? val) => _audio = val;

  bool hasAudio() => _audio != null;

  // "fav" field.
  bool? _fav;
  bool get fav => _fav ?? false;
  set fav(bool? val) => _fav = val;

  bool hasFav() => _fav != null;

  static AyahsStruct fromMap(Map<String, dynamic> data) => AyahsStruct(
        id: data['id'] as String?,
        surah: castToType<int>(data['surah']),
        ayah: castToType<int>(data['ayah']),
        juz: castToType<int>(data['juz']),
        arabic: data['arabic'] as String?,
        english: data['english'] as String?,
        swedish: data['swedish'] as String?,
        audio: data['audio'] as String?,
        fav: data['fav'] as bool?,
      );

  static AyahsStruct? maybeFromMap(dynamic data) =>
      data is Map ? AyahsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'surah': _surah,
        'ayah': _ayah,
        'juz': _juz,
        'arabic': _arabic,
        'english': _english,
        'swedish': _swedish,
        'audio': _audio,
        'fav': _fav,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'surah': serializeParam(
          _surah,
          ParamType.int,
        ),
        'ayah': serializeParam(
          _ayah,
          ParamType.int,
        ),
        'juz': serializeParam(
          _juz,
          ParamType.int,
        ),
        'arabic': serializeParam(
          _arabic,
          ParamType.String,
        ),
        'english': serializeParam(
          _english,
          ParamType.String,
        ),
        'swedish': serializeParam(
          _swedish,
          ParamType.String,
        ),
        'audio': serializeParam(
          _audio,
          ParamType.String,
        ),
        'fav': serializeParam(
          _fav,
          ParamType.bool,
        ),
      }.withoutNulls;

  static AyahsStruct fromSerializableMap(Map<String, dynamic> data) =>
      AyahsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        surah: deserializeParam(
          data['surah'],
          ParamType.int,
          false,
        ),
        ayah: deserializeParam(
          data['ayah'],
          ParamType.int,
          false,
        ),
        juz: deserializeParam(
          data['juz'],
          ParamType.int,
          false,
        ),
        arabic: deserializeParam(
          data['arabic'],
          ParamType.String,
          false,
        ),
        english: deserializeParam(
          data['english'],
          ParamType.String,
          false,
        ),
        swedish: deserializeParam(
          data['swedish'],
          ParamType.String,
          false,
        ),
        audio: deserializeParam(
          data['audio'],
          ParamType.String,
          false,
        ),
        fav: deserializeParam(
          data['fav'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'AyahsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is AyahsStruct &&
        id == other.id &&
        surah == other.surah &&
        ayah == other.ayah &&
        juz == other.juz &&
        arabic == other.arabic &&
        english == other.english &&
        swedish == other.swedish &&
        audio == other.audio &&
        fav == other.fav;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, surah, ayah, juz, arabic, english, swedish, audio, fav]);
}

AyahsStruct createAyahsStruct({
  String? id,
  int? surah,
  int? ayah,
  int? juz,
  String? arabic,
  String? english,
  String? swedish,
  String? audio,
  bool? fav,
}) =>
    AyahsStruct(
      id: id,
      surah: surah,
      ayah: ayah,
      juz: juz,
      arabic: arabic,
      english: english,
      swedish: swedish,
      audio: audio,
      fav: fav,
    );
