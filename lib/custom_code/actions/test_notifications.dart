// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/services.dart';

final FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();
Future<String> testNotifications() async {
  StringBuffer debugLog = StringBuffer();
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
    try {
      await fln
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestExactAlarmsPermission();
    } catch (_) {}

    // ================= LOAD USER PREFERENCE SOUND =================
    final selectedSound = FFAppState().user.adhanSound;
    debugLog.writeln('User selected sound for test: $selectedSound');
    final isVibration = selectedSound == 'Vibration';
    final playSoundActual = !isVibration;

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
          iosSoundFile = 'Adhan_1.aiff';
          break;
        case 'Adhan2':
          androidSoundResource = 'adhan_2';
          iosSoundFile = 'Adhan_2.aiff';
          break;
        case 'Adhan3':
          androidSoundResource = 'adhan_3';
          iosSoundFile = 'Adhan_3.aiff';
          break;
        case 'Adhan4':
          androidSoundResource = 'adhan_4';
          iosSoundFile = 'Adhan_4.aiff';
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
        ? (androidSoundResource != null
            ? 'Prayer Adhan Notifications'
            : 'Prayer Alerts & Reminders')
        : 'Prayer Vibration Notifications';
    final channelDesc = playSoundActual
        ? (androidSoundResource != null
            ? 'Prayer reminder notifications with Adhan sound'
            : 'Standard prayer notifications with customizable system sound')
        : 'Prayer reminder notifications with vibration only';

    // ================= ANDROID CHANNEL =================
    await fln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            channelId,
            channelName,
            description: channelDesc,
            importance: Importance.max,
            playSound: playSoundActual,
            sound: playSoundActual && androidSoundResource != null
                ? RawResourceAndroidNotificationSound(androidSoundResource)
                : null,
            enableVibration: true,
          ),
        );

    if (kIsWeb) {
      debugLog.writeln('Running on Web. Success.');
      return debugLog.toString();
    }

    // ================= TIMEZONE =================
    tzdata.initializeTimeZones();

    // Dynamically build a local Location based on the device's actual offset
    final offset = DateTime.now().timeZoneOffset;
    final hours = offset.inHours.abs().toString().padLeft(2, '0');
    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    final sign = offset.isNegative ? '-' : '+';
    final locationName = 'GMT$sign$hours:$minutes';

    final customLocation = tz.Location(
      locationName,
      [-8640000000000000],
      [0],
      [
        tz.TimeZone(
          offset.inMilliseconds,
          isDst: false,
          abbreviation: locationName,
        ),
      ],
    );
    tz.setLocalLocation(customLocation);

    final location = tz.local;
    debugLog.writeln('Location: $location');
    final now = tz.TZDateTime.now(location);
    debugLog.writeln(now);
    final testTime = now.add(const Duration(seconds: 10));

    // Check exact alarm permission at runtime before scheduling.
    // alarmClock mode bypasses Doze/screen-off entirely.
    bool canExact = false;
    final androidPlugin = fln.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    try {
      canExact = await androidPlugin?.canScheduleExactNotifications() ?? false;
    } catch (_) {
      canExact = false;
    }
    final scheduleMode = canExact
        ? AndroidScheduleMode.alarmClock
        : AndroidScheduleMode.inexactAllowWhileIdle;
    debugLog.writeln(
        'Schedule mode: ${canExact ? "alarmClock" : "inexactAllowWhileIdle"}');

    await fln.zonedSchedule(
      999,
      "Test Notification",
      "This is a standalone test notification 10 seconds from now.",
      testTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDesc,
          importance: Importance.max,
          priority: Priority.high,
          playSound: playSoundActual,
          enableVibration: true,
          sound: playSoundActual && androidSoundResource != null
              ? RawResourceAndroidNotificationSound(androidSoundResource)
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

    debugLog.writeln("TEST NOTIFICATION SCHEDULED: triggers at $testTime");
    return debugLog.toString();
  } catch (e) {
    debugLog.writeln("TEST NOTIFICATION FAILED: $e");
    debugLog.writeln(e.toString());
    return debugLog.toString();
  }
}
