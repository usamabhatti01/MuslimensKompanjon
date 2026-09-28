// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FontSettingStruct extends BaseStruct {
  FontSettingStruct({
    double? arFont,
    double? swFont,
    double? enFont,
    bool? arActive,
    bool? swActive,
    bool? enActive,
    bool? landscape,
    bool? display,
    bool? audioDisplay,
    bool? adhkarSound,
  })  : _arFont = arFont,
        _swFont = swFont,
        _enFont = enFont,
        _arActive = arActive,
        _swActive = swActive,
        _enActive = enActive,
        _landscape = landscape,
        _display = display,
        _audioDisplay = audioDisplay,
        _adhkarSound = adhkarSound;

  // "arFont" field.
  double? _arFont;
  double get arFont => _arFont ?? 16.0;
  set arFont(double? val) => _arFont = val;

  void incrementArFont(double amount) => arFont = arFont + amount;

  bool hasArFont() => _arFont != null;

  // "swFont" field.
  double? _swFont;
  double get swFont => _swFont ?? 16.0;
  set swFont(double? val) => _swFont = val;

  void incrementSwFont(double amount) => swFont = swFont + amount;

  bool hasSwFont() => _swFont != null;

  // "enFont" field.
  double? _enFont;
  double get enFont => _enFont ?? 16.0;
  set enFont(double? val) => _enFont = val;

  void incrementEnFont(double amount) => enFont = enFont + amount;

  bool hasEnFont() => _enFont != null;

  // "arActive" field.
  bool? _arActive;
  bool get arActive => _arActive ?? true;
  set arActive(bool? val) => _arActive = val;

  bool hasArActive() => _arActive != null;

  // "swActive" field.
  bool? _swActive;
  bool get swActive => _swActive ?? true;
  set swActive(bool? val) => _swActive = val;

  bool hasSwActive() => _swActive != null;

  // "enActive" field.
  bool? _enActive;
  bool get enActive => _enActive ?? true;
  set enActive(bool? val) => _enActive = val;

  bool hasEnActive() => _enActive != null;

  // "landscape" field.
  bool? _landscape;
  bool get landscape => _landscape ?? false;
  set landscape(bool? val) => _landscape = val;

  bool hasLandscape() => _landscape != null;

  // "display" field.
  bool? _display;
  bool get display => _display ?? false;
  set display(bool? val) => _display = val;

  bool hasDisplay() => _display != null;

  // "audioDisplay" field.
  bool? _audioDisplay;
  bool get audioDisplay => _audioDisplay ?? false;
  set audioDisplay(bool? val) => _audioDisplay = val;

  bool hasAudioDisplay() => _audioDisplay != null;

  // "adhkarSound" field.
  bool? _adhkarSound;
  bool get adhkarSound => _adhkarSound ?? false;
  set adhkarSound(bool? val) => _adhkarSound = val;

  bool hasAdhkarSound() => _adhkarSound != null;

  static FontSettingStruct fromMap(Map<String, dynamic> data) =>
      FontSettingStruct(
        arFont: castToType<double>(data['arFont']),
        swFont: castToType<double>(data['swFont']),
        enFont: castToType<double>(data['enFont']),
        arActive: data['arActive'] as bool?,
        swActive: data['swActive'] as bool?,
        enActive: data['enActive'] as bool?,
        landscape: data['landscape'] as bool?,
        display: data['display'] as bool?,
        audioDisplay: data['audioDisplay'] as bool?,
        adhkarSound: data['adhkarSound'] as bool?,
      );

  static FontSettingStruct? maybeFromMap(dynamic data) => data is Map
      ? FontSettingStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'arFont': _arFont,
        'swFont': _swFont,
        'enFont': _enFont,
        'arActive': _arActive,
        'swActive': _swActive,
        'enActive': _enActive,
        'landscape': _landscape,
        'display': _display,
        'audioDisplay': _audioDisplay,
        'adhkarSound': _adhkarSound,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'arFont': serializeParam(
          _arFont,
          ParamType.double,
        ),
        'swFont': serializeParam(
          _swFont,
          ParamType.double,
        ),
        'enFont': serializeParam(
          _enFont,
          ParamType.double,
        ),
        'arActive': serializeParam(
          _arActive,
          ParamType.bool,
        ),
        'swActive': serializeParam(
          _swActive,
          ParamType.bool,
        ),
        'enActive': serializeParam(
          _enActive,
          ParamType.bool,
        ),
        'landscape': serializeParam(
          _landscape,
          ParamType.bool,
        ),
        'display': serializeParam(
          _display,
          ParamType.bool,
        ),
        'audioDisplay': serializeParam(
          _audioDisplay,
          ParamType.bool,
        ),
        'adhkarSound': serializeParam(
          _adhkarSound,
          ParamType.bool,
        ),
      }.withoutNulls;

  static FontSettingStruct fromSerializableMap(Map<String, dynamic> data) =>
      FontSettingStruct(
        arFont: deserializeParam(
          data['arFont'],
          ParamType.double,
          false,
        ),
        swFont: deserializeParam(
          data['swFont'],
          ParamType.double,
          false,
        ),
        enFont: deserializeParam(
          data['enFont'],
          ParamType.double,
          false,
        ),
        arActive: deserializeParam(
          data['arActive'],
          ParamType.bool,
          false,
        ),
        swActive: deserializeParam(
          data['swActive'],
          ParamType.bool,
          false,
        ),
        enActive: deserializeParam(
          data['enActive'],
          ParamType.bool,
          false,
        ),
        landscape: deserializeParam(
          data['landscape'],
          ParamType.bool,
          false,
        ),
        display: deserializeParam(
          data['display'],
          ParamType.bool,
          false,
        ),
        audioDisplay: deserializeParam(
          data['audioDisplay'],
          ParamType.bool,
          false,
        ),
        adhkarSound: deserializeParam(
          data['adhkarSound'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'FontSettingStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FontSettingStruct &&
        arFont == other.arFont &&
        swFont == other.swFont &&
        enFont == other.enFont &&
        arActive == other.arActive &&
        swActive == other.swActive &&
        enActive == other.enActive &&
        landscape == other.landscape &&
        display == other.display &&
        audioDisplay == other.audioDisplay &&
        adhkarSound == other.adhkarSound;
  }

  @override
  int get hashCode => const ListEquality().hash([
        arFont,
        swFont,
        enFont,
        arActive,
        swActive,
        enActive,
        landscape,
        display,
        audioDisplay,
        adhkarSound
      ]);
}

FontSettingStruct createFontSettingStruct({
  double? arFont,
  double? swFont,
  double? enFont,
  bool? arActive,
  bool? swActive,
  bool? enActive,
  bool? landscape,
  bool? display,
  bool? audioDisplay,
  bool? adhkarSound,
}) =>
    FontSettingStruct(
      arFont: arFont,
      swFont: swFont,
      enFont: enFont,
      arActive: arActive,
      swActive: swActive,
      enActive: enActive,
      landscape: landscape,
      display: display,
      audioDisplay: audioDisplay,
      adhkarSound: adhkarSound,
    );
