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

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

/// Schedules or cancels a local notification for a custom calendar activity
Future<bool> scheduleActivityNotification(
  String activityId,
  String title,
  DateTime date,
  String time,
  String reminderDay,
  String reminderTime,
  String? sound,
  String? notes,
  bool isCancel,
) async {
  try {
    if (kIsWeb) return false;

    final fln = FlutterLocalNotificationsPlugin();

    // Unique ID in 100000 - 899999 range to avoid collisions with prayer/holiday notifs
    final notificationId = 100000 + (activityId.hashCode.abs() % 800000);

    // If cancelled, remove notification immediately
    if (isCancel) {
      await fln.cancel(notificationId);
      return true;
    }

    // Initialize notification plugin
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

    // Request permissions
    await fln
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    await fln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Parse reminder hour and minute from string e.g. "kl. 17:00" or "17:00"
    int rHour = 17;
    int rMinute = 0;
    final cleanTime =
        reminderTime.replaceAll('kl.', '').replaceAll('kl', '').trim();
    if (cleanTime.contains(':')) {
      final parts = cleanTime.split(':');
      rHour = int.tryParse(parts[0].trim()) ?? 17;
      rMinute = int.tryParse(parts[1].trim()) ?? 0;
    }

    // Determine target notification date based on reminderDay setting
    DateTime targetDate = DateTime(date.year, date.month, date.day);
    final reminderDayLower = reminderDay.toLowerCase();
    if (reminderDayLower.contains('1 dag')) {
      targetDate = targetDate.subtract(const Duration(days: 1));
    } else if (reminderDayLower.contains('2 dag')) {
      targetDate = targetDate.subtract(const Duration(days: 2));
    }

    // Timezone setup
    tzdata.initializeTimeZones();
    tz.Location location;
    try {
      location = tz.getLocation('Europe/Stockholm');
    } catch (_) {
      location = tz.local;
    }

    final scheduledTz = tz.TZDateTime(
      location,
      targetDate.year,
      targetDate.month,
      targetDate.day,
      rHour,
      rMinute,
    );

    final nowTz = tz.TZDateTime.now(location);
    if (!scheduledTz.isAfter(nowTz)) {
      debugPrint('Custom activity reminder time is in the past: $scheduledTz');
      return false;
    }

    // Sound configuration
    const channelId = 'custom_activities_channel';
    const channelName = 'Egna Aktiviteter & Påminnelser';
    const channelDesc =
        'Påminnelser för dina schemalagda aktiviteter i kalendern';

    final androidPlugin = fln.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    try {
      await androidPlugin?.requestExactAlarmsPermission();
    } catch (_) {}

    final soundTrim = (sound ?? 'Standard (Systemljud)').trim();
    final bool isVibrationOnly = soundTrim.toLowerCase().contains('vibration');
    String? androidSoundResource;
    String? iosSoundFile;

    if (!isVibrationOnly && soundTrim.toLowerCase().contains('adhan')) {
      if (soundTrim.contains('2')) {
        androidSoundResource = 'adhan_2';
        iosSoundFile = 'Adhan_2.aiff';
      } else if (soundTrim.contains('3')) {
        androidSoundResource = 'adhan_3';
        iosSoundFile = 'Adhan_3.aiff';
      } else if (soundTrim.contains('4')) {
        androidSoundResource = 'adhan_4';
        iosSoundFile = 'Adhan_4.aiff';
      } else {
        androidSoundResource = 'adhan_1';
        iosSoundFile = 'Adhan_1.aiff';
      }
    }

    final AndroidNotificationDetails androidDetails;
    final DarwinNotificationDetails iosDetails;

    if (isVibrationOnly) {
      const vibChannelId = 'custom_activities_vibration_channel';
      const vibChannelName = 'Egna Aktiviteter (Vibration)';
      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          vibChannelId,
          vibChannelName,
          description: channelDesc,
          importance: Importance.high,
          playSound: false,
          enableVibration: true,
        ),
      );
      androidDetails = const AndroidNotificationDetails(
        vibChannelId,
        vibChannelName,
        channelDescription: channelDesc,
        importance: Importance.high,
        priority: Priority.high,
        playSound: false,
        enableVibration: true,
      );
      iosDetails = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: false,
      );
    } else if (androidSoundResource != null && iosSoundFile != null) {
      final customChannelId =
          'custom_activities_${androidSoundResource}_channel';
      final customChannelName = 'Egna Aktiviteter ($soundTrim)';

      await androidPlugin?.createNotificationChannel(
        AndroidNotificationChannel(
          customChannelId,
          customChannelName,
          description: channelDesc,
          importance: Importance.max,
          playSound: true,
          sound: RawResourceAndroidNotificationSound(androidSoundResource),
          enableVibration: true,
        ),
      );
      androidDetails = AndroidNotificationDetails(
        customChannelId,
        customChannelName,
        channelDescription: channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound(androidSoundResource),
        enableVibration: true,
      );
      iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        sound: iosSoundFile,
      );
    } else {
      // Standard notification sound
      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          channelId,
          channelName,
          description: channelDesc,
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        ),
      );
      androidDetails = const AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDesc,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      );
      iosDetails = const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
    }

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final notificationBody = (notes != null && notes.trim().isNotEmpty)
        ? '$time - ${notes.trim()}'
        : 'Kl. $time har du schemalagt: $title';

    await fln.zonedSchedule(
      notificationId,
      title,
      notificationBody,
      scheduledTz,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    debugPrint(
        'Scheduled custom activity notification #$notificationId for $scheduledTz: $title');
    return true;
  } catch (e) {
    debugPrint('Error scheduling custom activity notification: $e');
    return false;
  }
}

/// Helper to cancel a custom activity notification
Future<void> cancelActivityNotification(String activityId) async {
  try {
    if (kIsWeb) return;
    final fln = FlutterLocalNotificationsPlugin();
    final notificationId = 100000 + (activityId.hashCode.abs() % 800000);
    await fln.cancel(notificationId);
    debugPrint(
        'Cancelled notification #$notificationId for activity $activityId');
  } catch (e) {
    debugPrint('Error cancelling notification: $e');
  }
}
