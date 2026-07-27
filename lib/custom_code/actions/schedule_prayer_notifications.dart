// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/services.dart';

final FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();
// Localization mapping for supported languages ('sv' and 'en')
final Map<String, Map<String, String>> _localizedStrings = {
  'en': {
    'prayer_reminder': 'Prayer Reminder',
    'in_minutes': 'in {minutes} minutes',
    'fajr': 'Fajr',
    'fazr': 'Fajr',
    'shuruq': 'Shuruq',
    'dhuhr': 'Dhuhr',
    'dohr': 'Dhuhr',
    'asr': 'Asr',
    'maghrib': 'Maghrib',
    'isha': 'Isha',
  },
  'sv': {
    'prayer_reminder': 'Bönepåminnelse',
    'in_minutes': 'om {minutes} minuter',
    'fajr': 'Fajr',
    'fazr': 'Fajr',
    'shuruq': 'Shuruq',
    'dhuhr': 'Dhuhr',
    'dohr': 'Dhuhr',
    'asr': 'Asr',
    'maghrib': 'Maghrib',
    'isha': 'Isha',
  }
};
String _translate(String key, String lang) {
  final l = (lang == 'en' || lang == 'sv') ? lang : 'sv';
  return _localizedStrings[l]?[key.toLowerCase()] ?? key;
}

bool _getPrayerSetting(String prayer, String settingType) {
  final n = FFAppState().user.notifications;
  final normPrayer = prayer.toLowerCase();
  String altPrayer = normPrayer;
  if (normPrayer == 'fajr') altPrayer = 'fazr';
  if (normPrayer == 'fazr') altPrayer = 'fajr';
  if (normPrayer == 'dhuhr') altPrayer = 'dohr';
  if (normPrayer == 'dohr') altPrayer = 'dhuhr';
  final isAdhan = settingType.toLowerCase() == 'adhan';
  switch (altPrayer) {
    case 'fazr':
      return isAdhan ? n.fazr.adhan : n.fazr.notice;
    case 'shuruq':
      return isAdhan ? n.shuruq.adhan : n.shuruq.notice;
    case 'dohr':
      return isAdhan ? n.dohr.adhan : n.dohr.notice;
    case 'asr':
      return isAdhan ? n.asr.adhan : n.asr.notice;
    case 'maghrib':
      return isAdhan ? n.maghrib.adhan : n.maghrib.notice;
    case 'isha':
      return isAdhan ? n.isha.adhan : n.isha.notice;
    default:
      return false;
  }
}

Future<String> schedulePrayerNotifications() async {
  try {
    // ================= INIT =================
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );
    const settings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await fln.initialize(settings);
    // ================= PERMISSIONS =================
    await fln
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await fln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // ================= ANDROID CHANNEL =================
    final selectedSound = FFAppState().user.adhanSound;
    final androidPlugin = fln.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        'prayer_channel_vibration',
        'Prayer Vibration Notifications',
        description: 'Prayer reminder notifications with vibration only',
        importance: Importance.max,
        playSound: false,
        enableVibration: true,
      ),
    );
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        'prayer_channel_sound',
        'Prayer Sound Notifications',
        description: 'Prayer reminder notifications with sound',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      ),
    );

    if (selectedSound == AdhanSound.Adhan1.name) {
      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          'prayer_channel_adhan_1',
          'Prayer Adhan 1 Notifications',
          description: 'Prayer reminder notifications with Adhan 1 sound',
          importance: Importance.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('adhan_1'),
          enableVibration: true,
        ),
      );
    } else if (selectedSound == AdhanSound.Adhan2.name) {
      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          'prayer_channel_adhan_2',
          'Prayer Adhan 2 Notifications',
          description: 'Prayer reminder notifications with Adhan 2 sound',
          importance: Importance.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('adhan_2'),
          enableVibration: true,
        ),
      );
    } else if (selectedSound == AdhanSound.Adhan3.name) {
      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          'prayer_channel_adhan_3',
          'Prayer Adhan 3 Notifications',
          description: 'Prayer reminder notifications with Adhan 3 sound',
          importance: Importance.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('adhan_3'),
          enableVibration: true,
        ),
      );
    } else if (selectedSound == AdhanSound.Adhan4.name) {
      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          'prayer_channel_adhan_4',
          'Prayer Adhan 4 Notifications',
          description: 'Prayer reminder notifications with Adhan 4 sound',
          importance: Importance.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound('adhan_4'),
          enableVibration: true,
        ),
      );
    }

    if (kIsWeb) return 'Web is not supported';
    // ================= TIMEZONE =================
    tzdata.initializeTimeZones();
    await fln.cancelAll();
    // ================= LOAD DATA & SCHEDULE =================
    final city = FFAppState().user.city.toLowerCase().trim();
    final initialYear = DateTime.now().year;
    final initialJsonString = await loadPrayerJson(city, initialYear);
    final initialData = json.decode(initialJsonString);
    final timeZoneName = initialData['city']['timezone'] ?? 'UTC';
    final location = tz.getLocation(timeZoneName);
    final now = tz.TZDateTime.now(location);

    final Map<int, dynamic> yearDataCache = {
      initialYear: initialData,
    };

    final List<String> order = [
      "fajr",
      "shuruq",
      "dhuhr",
      "asr",
      "maghrib",
      "isha"
    ];

    final Map<String, int> prayerIndices = {
      'fajr': 0,
      'shuruq': 1,
      'dhuhr': 2,
      'asr': 3,
      'maghrib': 4,
      'isha': 5,
    };

    final isVibration = selectedSound == 'Vibration';

    for (int dayOffset = 0; dayOffset < 10; dayOffset++) {
      final targetDate = now.add(Duration(days: dayOffset));
      final targetYear = targetDate.year;

      if (!yearDataCache.containsKey(targetYear)) {
        try {
          final jsonString = await loadPrayerJson(city, targetYear);
          yearDataCache[targetYear] = json.decode(jsonString);
        } catch (e) {
          debugPrint("Error loading JSON for year $targetYear: $e");
          continue;
        }
      }

      final data = yearDataCache[targetYear];
      final todayKey = _todayKey(targetDate);
      final todayData = data['prayer_times']?[todayKey];

      if (todayData == null) {
        debugPrint("No prayer data found for date: $todayKey");
        continue;
      }

      final Map<String, String> times = {};
      for (final p in order) {
        if (todayData[p] != null) {
          times[p] = todayData[p].toString();
        }
      }

      for (final prayer in order) {
        final noticeEnabled = _getPrayerSetting(prayer, 'notice');
        final soundEnabled = _getPrayerSetting(prayer, 'adhan');
        final playSoundActual = soundEnabled && !isVibration;

        // Skip only if both disabled
        if (!noticeEnabled && !soundEnabled) {
          continue;
        }

        final timeStr = times[prayer];
        if (timeStr == null) continue;

        final prayerTime = _toTZ(timeStr, location, targetDate);
        final offsetMinutes = FFAppState().user.prayerReminder;

        final reminderTime =
            prayerTime.subtract(Duration(minutes: offsetMinutes));

        // Skip if this reminder time is already in the past
        if (reminderTime.isBefore(now)) {
          continue;
        }

        // Generate a unique, deterministic notification ID
        final int id = dayOffset * 10 + prayerIndices[prayer]!;

        final lang = FFAppState().user.languageCode.toLowerCase().trim();
        final title = _translate('prayer_reminder', lang);
        final capitalizedPrayer = _capitalize(_translate(prayer, lang));
        final bodySuffix = _inMinutesSuffix(offsetMinutes, lang);
        final body = "$capitalizedPrayer $bodySuffix";

        String? androidSoundResource;
        String? iosSoundFile;

        if (playSoundActual) {
          switch (selectedSound) {
            case 'Standard':
              androidSoundResource = null;
              iosSoundFile = null;
              break;
            case 'Adhan1':
              androidSoundResource = 'adhan_1';
              iosSoundFile = 'short_adhan.aiff';
              break;
            case 'Adhan2':
              androidSoundResource = 'adhan_2';
              iosSoundFile = 'adhan_makkah.aiff';
              break;
            case 'Adhan3':
              androidSoundResource = 'adhan_3';
              iosSoundFile = 'adhan_madinah.aiff';
              break;
            case 'Adhan4':
              androidSoundResource = 'adhan_4';
              iosSoundFile = 'standard_adhan.aiff';
              break;
            default:
              androidSoundResource = null;
              iosSoundFile = null;
          }
        }

        final channelId = playSoundActual
            ? (androidSoundResource != null
                ? 'prayer_channel_$androidSoundResource'
                : 'prayer_channel_sound')
            : 'prayer_channel_vibration';
        final channelName = playSoundActual
            ? 'Prayer Sound Notifications'
            : 'Prayer Vibration Notifications';
        final channelDesc = playSoundActual
            ? 'Prayer reminder notifications with sound'
            : 'Prayer reminder notifications with vibration only';

        var scheduleMode = AndroidScheduleMode.exactAllowWhileIdle;
        try {
          await fln.zonedSchedule(
            id,
            title,
            body,
            reminderTime,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channelId,
                channelName,
                channelDescription: channelDesc,
                importance: Importance.max,
                priority: Priority.high,
                // icon: 'ic_notification',
                playSound: playSoundActual,
                enableVibration: true,
                sound: playSoundActual && androidSoundResource != null
                    ? RawResourceAndroidNotificationSound(
                        androidSoundResource,
                      )
                    : null,
              ),
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: playSoundActual,
                sound: iosSoundFile,
              ),
            ),
            androidScheduleMode: scheduleMode,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: null,
          );
        } catch (e) {
          if (e is PlatformException &&
              e.code == 'exact_alarms_not_permitted') {
            scheduleMode = AndroidScheduleMode.inexactAllowWhileIdle;
            await fln.zonedSchedule(
              id,
              title,
              body,
              reminderTime,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channelId,
                  channelName,
                  channelDescription: channelDesc,
                  importance: Importance.max,
                  priority: Priority.high,
                  // icon: 'ic_notification',
                  playSound: playSoundActual,
                  enableVibration: true,
                  sound: playSoundActual && androidSoundResource != null
                      ? RawResourceAndroidNotificationSound(
                          androidSoundResource,
                        )
                      : null,
                ),
                iOS: DarwinNotificationDetails(
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: playSoundActual,
                  sound: iosSoundFile,
                ),
              ),
              androidScheduleMode: scheduleMode,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
              matchDateTimeComponents: null,
            );
          } else {
            rethrow;
          }
        }
      }
    }
    return 'Success';
  } catch (e) {
    debugPrint("Error scheduling prayer notifications: $e");
    return e.toString();
  }
}

// Helper to format minutes suffix for notification body
String _inMinutesSuffix(int minutes, String lang) {
  final template = _translate('in_minutes', lang);
  return template.replaceAll('{minutes}', minutes.toString());
}

// ================= HELPERS =================
String _todayKey(tz.TZDateTime now) {
  return "${now.year.toString().padLeft(4, '0')}-"
      "${now.month.toString().padLeft(2, '0')}-"
      "${now.day.toString().padLeft(2, '0')}";
}

tz.TZDateTime _toTZ(
  String time,
  tz.Location location,
  tz.TZDateTime now,
) {
  final parts = time.split(':');
  return tz.TZDateTime(
    location,
    now.year,
    now.month,
    now.day,
    int.parse(parts[0]),
    int.parse(parts[1]),
  );
}

String _capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
