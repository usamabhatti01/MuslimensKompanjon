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

Future schedulePrayerNotifications() async {
  // ================= INIT =================

  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

  const iosInit = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,

    // ✅ FIX: THIS is how foreground display works on iOS
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
    if (!_isPrayerEnabled(prayer)) continue;

    final timeStr = times[prayer];
    if (timeStr == null) continue;

    final prayerTime = _toTZ(timeStr, location, now);

    final reminderTime = prayerTime.subtract(const Duration(minutes: 15));

    if (reminderTime.isBefore(now)) {
      print("SKIP PAST: $prayer");
      continue;
    }
    final tz.TZDateTime time =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));
    final int id = prayer.hashCode;

    await fln.zonedSchedule(
      id,
      "Prayer Reminder",
      "${_capitalize(prayer)} in 15 minutes",
      time,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'Prayer Notifications',
          channelDescription: 'Prayer reminder notifications',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          sound: const RawResourceAndroidNotificationSound('azan'),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'azan.aiff',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    print("SCHEDULED: $prayer at $reminderTime");
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

bool _isPrayerEnabled(String prayer) {
  final n = FFAppState().user.notifications;

  switch (prayer) {
    case "fajr":
      return n.fazr;
    case "shuruq":
      return n.shuruq;
    case "dhuhr":
      return n.dohr;
    case "asr":
      return n.asr;
    case "maghrib":
      return n.maghrib;
    case "isha":
      return n.isha;
    default:
      return false;
  }
}

String _capitalize(String text) => text[0].toUpperCase() + text.substring(1);
