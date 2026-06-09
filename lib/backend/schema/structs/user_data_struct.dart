// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserDataStruct extends BaseStruct {
  UserDataStruct({
    String? name,
    String? city,
    String? language,
    NotificationsStruct? notifications,
    bool? darkMode,
    bool? phoneDetect,
    bool? switchToEnglish,
  })  : _name = name,
        _city = city,
        _language = language,
        _notifications = notifications,
        _darkMode = darkMode,
        _phoneDetect = phoneDetect,
        _switchToEnglish = switchToEnglish;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  set city(String? val) => _city = val;

  bool hasCity() => _city != null;

  // "language" field.
  String? _language;
  String get language => _language ?? '';
  set language(String? val) => _language = val;

  bool hasLanguage() => _language != null;

  // "notifications" field.
  NotificationsStruct? _notifications;
  NotificationsStruct get notifications =>
      _notifications ?? NotificationsStruct();
  set notifications(NotificationsStruct? val) => _notifications = val;

  void updateNotifications(Function(NotificationsStruct) updateFn) {
    updateFn(_notifications ??= NotificationsStruct());
  }

  bool hasNotifications() => _notifications != null;

  // "darkMode" field.
  bool? _darkMode;
  bool get darkMode => _darkMode ?? false;
  set darkMode(bool? val) => _darkMode = val;

  bool hasDarkMode() => _darkMode != null;

  // "phoneDetect" field.
  bool? _phoneDetect;
  bool get phoneDetect => _phoneDetect ?? false;
  set phoneDetect(bool? val) => _phoneDetect = val;

  bool hasPhoneDetect() => _phoneDetect != null;

  // "switchToEnglish" field.
  bool? _switchToEnglish;
  bool get switchToEnglish => _switchToEnglish ?? false;
  set switchToEnglish(bool? val) => _switchToEnglish = val;

  bool hasSwitchToEnglish() => _switchToEnglish != null;

  static UserDataStruct fromMap(Map<String, dynamic> data) => UserDataStruct(
        name: data['name'] as String?,
        city: data['city'] as String?,
        language: data['language'] as String?,
        notifications: data['notifications'] is NotificationsStruct
            ? data['notifications']
            : NotificationsStruct.maybeFromMap(data['notifications']),
        darkMode: data['darkMode'] as bool?,
        phoneDetect: data['phoneDetect'] as bool?,
        switchToEnglish: data['switchToEnglish'] as bool?,
      );

  static UserDataStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserDataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'city': _city,
        'language': _language,
        'notifications': _notifications?.toMap(),
        'darkMode': _darkMode,
        'phoneDetect': _phoneDetect,
        'switchToEnglish': _switchToEnglish,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'city': serializeParam(
          _city,
          ParamType.String,
        ),
        'language': serializeParam(
          _language,
          ParamType.String,
        ),
        'notifications': serializeParam(
          _notifications,
          ParamType.DataStruct,
        ),
        'darkMode': serializeParam(
          _darkMode,
          ParamType.bool,
        ),
        'phoneDetect': serializeParam(
          _phoneDetect,
          ParamType.bool,
        ),
        'switchToEnglish': serializeParam(
          _switchToEnglish,
          ParamType.bool,
        ),
      }.withoutNulls;

  static UserDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserDataStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        city: deserializeParam(
          data['city'],
          ParamType.String,
          false,
        ),
        language: deserializeParam(
          data['language'],
          ParamType.String,
          false,
        ),
        notifications: deserializeStructParam(
          data['notifications'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationsStruct.fromSerializableMap,
        ),
        darkMode: deserializeParam(
          data['darkMode'],
          ParamType.bool,
          false,
        ),
        phoneDetect: deserializeParam(
          data['phoneDetect'],
          ParamType.bool,
          false,
        ),
        switchToEnglish: deserializeParam(
          data['switchToEnglish'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'UserDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserDataStruct &&
        name == other.name &&
        city == other.city &&
        language == other.language &&
        notifications == other.notifications &&
        darkMode == other.darkMode &&
        phoneDetect == other.phoneDetect &&
        switchToEnglish == other.switchToEnglish;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        city,
        language,
        notifications,
        darkMode,
        phoneDetect,
        switchToEnglish
      ]);
}

UserDataStruct createUserDataStruct({
  String? name,
  String? city,
  String? language,
  NotificationsStruct? notifications,
  bool? darkMode,
  bool? phoneDetect,
  bool? switchToEnglish,
}) =>
    UserDataStruct(
      name: name,
      city: city,
      language: language,
      notifications: notifications ?? NotificationsStruct(),
      darkMode: darkMode,
      phoneDetect: phoneDetect,
      switchToEnglish: switchToEnglish,
    );
