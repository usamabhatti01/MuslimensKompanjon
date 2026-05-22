// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();

/// ================= MAIN FUNCTION =================
Future schedulePrayerNotifications() async {
  // ================= INIT NOTIFICATIONS =================
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

  const iosInit = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const initSettings = InitializationSettings(
    android: androidInit,
    iOS: iosInit,
  );

  await fln.initialize(initSettings);

  // ================= REQUEST IOS PERMISSIONS =================
  await fln
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

  // ================= INIT TIMEZONE =================
  tzdata.initializeTimeZones();

  // ================= CLEAR OLD NOTIFICATIONS =================
  await fln.cancelAll();

  // ================= TEST NOTIFICATION =================
  await fln.show(
    999,
    "Test Notification",
    "If you see this, notifications are working.",
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'test_channel',
        'Test Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    ),
  );

  print("TEST NOTIFICATION SENT");

  // ================= CITY =================
  final String city = FFAppState().user.city.toLowerCase().trim();

  print("CITY: $city");

  // ================= LOAD JSON =================
  final jsonString = await loadPrayerJson(city, 2026);

  final Map<String, dynamic> data = json.decode(jsonString);

  // ================= AUTO TIMEZONE =================
  final String timeZoneName = data['city']['timezone'] ?? 'UTC';

  print("TIMEZONE: $timeZoneName");

  final location = tz.getLocation(timeZoneName);

  tz.setLocalLocation(location);

  // ================= PRAYER DATA =================
  final Map<String, dynamic> prayerTimes = data['prayer_times'];

  final String todayKey = _getTodayKey();

  print("TODAY KEY: $todayKey");

  final todayData = prayerTimes[todayKey];

  if (todayData == null) {
    throw Exception(
      "No prayer data for today: $todayKey",
    );
  }

  // ================= SAFE MAP =================
  final Map<String, String> times = {};

  (todayData as Map).forEach((k, v) {
    times[k.toString()] = v.toString();
  });

  print("TODAY PRAYERS: $times");

  // ================= DEBUG INFO =================
  final enabledPrayers = _getEnabledPrayers();

  print("Enabled prayers: $enabledPrayers");

  final next = _getNextPrayer(times);

  if (next != null) {
    final now = DateTime.now();

    final diff = next.value.difference(now);

    print("Next prayer: ${next.key}");

    print(
      "Time left: ${_formatDuration(diff)}",
    );
  }

  // ================= SCHEDULE PRAYERS =================
  for (final entry in times.entries) {
    final prayer = entry.key.toLowerCase();

    final timeStr = entry.value;

    // SKIP NON-PRAYER DATA
    if (!_isPrayerKey(prayer)) continue;

    // CHECK ENABLED
    if (!_isPrayerEnabled(prayer)) {
      print("$prayer disabled");
      continue;
    }

    print("$prayer enabled");

    final prayerTime = _toDateTime(timeStr);

    final reminderTime = prayerTime.subtract(
      const Duration(minutes: 15),
    );

    print(
      "Scheduling $prayer at $reminderTime",
    );

    // SKIP PAST
    if (reminderTime.isBefore(DateTime.now())) {
      print("SKIPPED PAST: $prayer");
      continue;
    }

    // ================= SCHEDULE =================
    await fln.zonedSchedule(
      prayer.hashCode,
      "Prayer Reminder",
      "${_capitalize(prayer)} in 15 minutes",
      tz.TZDateTime.from(
        reminderTime,
        tz.local,
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'Prayer Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    print("SCHEDULED: $prayer");
  }
}

/// ================= ENABLED PRAYERS =================
List<String> _getEnabledPrayers() {
  final n = FFAppState().user.notifications;

  final List<String> enabled = [];

  if (n.fazr) enabled.add("fajr");
  if (n.shuruq) enabled.add("shuruq");
  if (n.dohr) enabled.add("dhuhr");
  if (n.asr) enabled.add("asr");
  if (n.maghrib) enabled.add("maghrib");
  if (n.isha) enabled.add("isha");

  return enabled;
}

/// ================= NEXT PRAYER =================
MapEntry<String, DateTime>? _getNextPrayer(
  Map<String, String> times,
) {
  final now = DateTime.now();

  Map<String, DateTime> parsed = {};

  times.forEach((key, value) {
    if (!_isPrayerKey(key)) return;

    parsed[key] = _toDateTime(value);
  });

  MapEntry<String, DateTime>? next;

  parsed.forEach((prayer, time) {
    if (time.isAfter(now)) {
      if (next == null || time.isBefore(next!.value)) {
        next = MapEntry(prayer, time);
      }
    }
  });

  return next;
}

/// ================= VALID PRAYER =================
bool _isPrayerKey(String prayer) {
  return [
    "fajr",
    "shuruq",
    "dhuhr",
    "asr",
    "maghrib",
    "isha",
  ].contains(prayer);
}

/// ================= TIME FORMAT =================
String _formatDuration(Duration d) {
  final hours = d.inHours;

  final minutes = d.inMinutes.remainder(60);

  return "${hours}h ${minutes}m";
}

/// ================= TIME HELPERS =================
DateTime _toDateTime(String time) {
  final now = DateTime.now();

  try {
    final parts = time.split(":");

    final hour = int.tryParse(parts[0]) ?? 0;

    final minute = int.tryParse(parts[1]) ?? 0;

    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  } catch (e) {
    print("Invalid time format: $time");

    return DateTime(
      now.year,
      now.month,
      now.day,
      0,
      0,
    );
  }
}

/// ================= CAPITALIZE =================
String _capitalize(String text) {
  if (text.isEmpty) return text;

  return text[0].toUpperCase() + text.substring(1);
}

/// ================= TODAY KEY =================
String _getTodayKey() {
  final now = DateTime.now();

  return "${now.year.toString().padLeft(4, '0')}-"
      "${now.month.toString().padLeft(2, '0')}-"
      "${now.day.toString().padLeft(2, '0')}";
}

/// ================= PRAYER SETTINGS =================
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
