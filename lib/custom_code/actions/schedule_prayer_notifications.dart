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

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
// DO NOT REMOVE ABOVE

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();
// Localization mapping for supported languages ('sv' and 'en')
final Map<String, Map<String, String>> _localizedStrings = {
  'en': {
    'prayer_reminder': 'Prayer Reminder',
    'in_15_minutes': 'in 15 minutes',
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
    'in_15_minutes': 'om 15 minuter',
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

Future schedulePrayerNotifications() async {
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
  await fln
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(
        const AndroidNotificationChannel(
          'prayer_channel',
          'Prayer Notifications',
          description: 'Prayer reminder notifications',
          importance: Importance.max,
        ),
      );
  if (kIsWeb) return;
  // ================= TIMEZONE =================
  tzdata.initializeTimeZones();
  await fln.cancelAll();
  // ================= LOAD DATA =================
  final city = FFAppState().user.city.toLowerCase().trim();
  final jsonString = await loadPrayerJson(city, DateTime.now().year);
  final data = json.decode(jsonString);
  final timeZoneName = data['city']['timezone'] ?? 'UTC';
  final location = tz.getLocation(timeZoneName);
  final now = tz.TZDateTime.now(location);
  final todayKey = _todayKey(now);
  final todayData = data['prayer_times']?[todayKey];
  if (todayData == null) {
    throw Exception("No prayer data for $todayKey");
  }
  // ================= ORDER =================
  final List<String> order = [
    "fajr",
    "shuruq",
    "dhuhr",
    "asr",
    "maghrib",
    "isha"
  ];
  final Map<String, String> times = {};
  for (final p in order) {
    if (todayData[p] != null) {
      times[p] = todayData[p].toString();
    }
  }
  print("PRAYER TIMES: $times");
  // ================= SCHEDULING =================
  for (final prayer in order) {
    final noticeEnabled = _getPrayerSetting(prayer, 'notice');
    final soundEnabled = _getPrayerSetting(prayer, 'adhan');
    // If both are false, we do not schedule anything for this prayer
    if (!noticeEnabled && !soundEnabled) {
      print("SKIP (Notice and Adhan both disabled): $prayer");
      continue;
    }
    final timeStr = times[prayer];
    if (timeStr == null) continue;
    final prayerTime = _toTZ(timeStr, location, now);
    final reminderTime = prayerTime.subtract(const Duration(minutes: 15));
    if (reminderTime.isBefore(now)) {
      print("SKIP PAST: $prayer");
      continue;
    }
    final int id = prayer.hashCode;

    final lang = FFAppState().user.language.toLowerCase().trim();
    final title = _translate('prayer_reminder', lang);
    final capitalizedPrayer = _capitalize(_translate(prayer, lang));
    final bodySuffix = _translate('in_15_minutes', lang);
    final body = "$capitalizedPrayer $bodySuffix";
    await fln.zonedSchedule(
      id,
      title,
      body,
      reminderTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'Prayer Notifications',
          channelDescription: 'Prayer reminder notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: soundEnabled
              ? const RawResourceAndroidNotificationSound('azan')
              : null,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: soundEnabled ? 'azan 2.aiff' : null,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    print(
        "SCHEDULED: $prayer at $reminderTime (Sound: $soundEnabled, Notice: $noticeEnabled)");
  }
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
