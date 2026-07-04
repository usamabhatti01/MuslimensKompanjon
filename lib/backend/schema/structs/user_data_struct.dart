// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UserDataStruct extends BaseStruct {
  UserDataStruct({
    String? name,
    String? city,
    String? languageCode,
    NotificationsStruct? notifications,
    String? mode,
    bool? onBoarding,
    int? prayerReminder,
    String? adhanSound,
    RatingTypeStruct? rating,
  })  : _name = name,
        _city = city,
        _languageCode = languageCode,
        _notifications = notifications,
        _mode = mode,
        _onBoarding = onBoarding,
        _prayerReminder = prayerReminder,
        _adhanSound = adhanSound,
        _rating = rating;

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

  // "languageCode" field.
  String? _languageCode;
  String get languageCode => _languageCode ?? '';
  set languageCode(String? val) => _languageCode = val;

  bool hasLanguageCode() => _languageCode != null;

  // "notifications" field.
  NotificationsStruct? _notifications;
  NotificationsStruct get notifications =>
      _notifications ?? NotificationsStruct();
  set notifications(NotificationsStruct? val) => _notifications = val;

  void updateNotifications(Function(NotificationsStruct) updateFn) {
    updateFn(_notifications ??= NotificationsStruct());
  }

  bool hasNotifications() => _notifications != null;

  // "mode" field.
  String? _mode;
  String get mode => _mode ?? 'System';
  set mode(String? val) => _mode = val;

  bool hasMode() => _mode != null;

  // "onBoarding" field.
  bool? _onBoarding;
  bool get onBoarding => _onBoarding ?? false;
  set onBoarding(bool? val) => _onBoarding = val;

  bool hasOnBoarding() => _onBoarding != null;

  // "prayerReminder" field.
  int? _prayerReminder;
  int get prayerReminder => _prayerReminder ?? 5;
  set prayerReminder(int? val) => _prayerReminder = val;

  void incrementPrayerReminder(int amount) =>
      prayerReminder = prayerReminder + amount;

  bool hasPrayerReminder() => _prayerReminder != null;

  // "adhanSound" field.
  String? _adhanSound;
  String get adhanSound => _adhanSound ?? 'Vibration';
  set adhanSound(String? val) => _adhanSound = val;

  bool hasAdhanSound() => _adhanSound != null;

  // "rating" field.
  RatingTypeStruct? _rating;
  RatingTypeStruct get rating => _rating ?? RatingTypeStruct();
  set rating(RatingTypeStruct? val) => _rating = val;

  void updateRating(Function(RatingTypeStruct) updateFn) {
    updateFn(_rating ??= RatingTypeStruct());
  }

  bool hasRating() => _rating != null;

  static UserDataStruct fromMap(Map<String, dynamic> data) => UserDataStruct(
        name: data['name'] as String?,
        city: data['city'] as String?,
        languageCode: data['languageCode'] as String?,
        notifications: data['notifications'] is NotificationsStruct
            ? data['notifications']
            : NotificationsStruct.maybeFromMap(data['notifications']),
        mode: data['mode'] as String?,
        onBoarding: data['onBoarding'] as bool?,
        prayerReminder: castToType<int>(data['prayerReminder']),
        adhanSound: data['adhanSound'] as String?,
        rating: data['rating'] is RatingTypeStruct
            ? data['rating']
            : RatingTypeStruct.maybeFromMap(data['rating']),
      );

  static UserDataStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserDataStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'city': _city,
        'languageCode': _languageCode,
        'notifications': _notifications?.toMap(),
        'mode': _mode,
        'onBoarding': _onBoarding,
        'prayerReminder': _prayerReminder,
        'adhanSound': _adhanSound,
        'rating': _rating?.toMap(),
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
        'languageCode': serializeParam(
          _languageCode,
          ParamType.String,
        ),
        'notifications': serializeParam(
          _notifications,
          ParamType.DataStruct,
        ),
        'mode': serializeParam(
          _mode,
          ParamType.String,
        ),
        'onBoarding': serializeParam(
          _onBoarding,
          ParamType.bool,
        ),
        'prayerReminder': serializeParam(
          _prayerReminder,
          ParamType.int,
        ),
        'adhanSound': serializeParam(
          _adhanSound,
          ParamType.String,
        ),
        'rating': serializeParam(
          _rating,
          ParamType.DataStruct,
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
        languageCode: deserializeParam(
          data['languageCode'],
          ParamType.String,
          false,
        ),
        notifications: deserializeStructParam(
          data['notifications'],
          ParamType.DataStruct,
          false,
          structBuilder: NotificationsStruct.fromSerializableMap,
        ),
        mode: deserializeParam(
          data['mode'],
          ParamType.String,
          false,
        ),
        onBoarding: deserializeParam(
          data['onBoarding'],
          ParamType.bool,
          false,
        ),
        prayerReminder: deserializeParam(
          data['prayerReminder'],
          ParamType.int,
          false,
        ),
        adhanSound: deserializeParam(
          data['adhanSound'],
          ParamType.String,
          false,
        ),
        rating: deserializeStructParam(
          data['rating'],
          ParamType.DataStruct,
          false,
          structBuilder: RatingTypeStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'UserDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserDataStruct &&
        name == other.name &&
        city == other.city &&
        languageCode == other.languageCode &&
        notifications == other.notifications &&
        mode == other.mode &&
        onBoarding == other.onBoarding &&
        prayerReminder == other.prayerReminder &&
        adhanSound == other.adhanSound &&
        rating == other.rating;
  }

  @override
  int get hashCode => const ListEquality().hash([
        name,
        city,
        languageCode,
        notifications,
        mode,
        onBoarding,
        prayerReminder,
        adhanSound,
        rating
      ]);
}

UserDataStruct createUserDataStruct({
  String? name,
  String? city,
  String? languageCode,
  NotificationsStruct? notifications,
  String? mode,
  bool? onBoarding,
  int? prayerReminder,
  String? adhanSound,
  RatingTypeStruct? rating,
}) =>
    UserDataStruct(
      name: name,
      city: city,
      languageCode: languageCode,
      notifications: notifications ?? NotificationsStruct(),
      mode: mode,
      onBoarding: onBoarding,
      prayerReminder: prayerReminder,
      adhanSound: adhanSound,
      rating: rating ?? RatingTypeStruct(),
    );
