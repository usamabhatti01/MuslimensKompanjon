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
          androidSoundResource = 'standard_adhan';
          iosSoundFile = 'standard_adhan.aiff';
          break;
        case 'ShortAdhan':
          androidSoundResource = 'short_adhan';
          iosSoundFile = 'short_adhan.aiff';
          break;
        case 'AdhanMakkah':
          androidSoundResource = 'adhan_makkah';
          iosSoundFile = 'adhan_makkah.aiff';
          break;
        case 'AdhanMadinah':
          androidSoundResource = 'adhan_madinah';
          iosSoundFile = 'adhan_madinah.aiff';
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

    var scheduleMode = AndroidScheduleMode.exactAllowWhileIdle;
    try {
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
            //  icon: 'ic_notification',
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
    } catch (e) {
      if (e is PlatformException && e.code == 'exact_alarms_not_permitted') {
        scheduleMode = AndroidScheduleMode.inexactAllowWhileIdle;
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
              //   icon: 'ic_notification',
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
      } else {
        rethrow;
      }
    }

    debugLog.writeln("TEST NOTIFICATION SCHEDULED: triggers at $testTime");
    return debugLog.toString();
  } catch (e) {
    debugLog.writeln("TEST NOTIFICATION FAILED: $e");
    debugLog.writeln(e.toString());
    return debugLog.toString();
  }
}
