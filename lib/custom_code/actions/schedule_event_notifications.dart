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
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> scheduleEventNotifications(
  String eventTitle,
  DateTime? eventDate,
  bool isEnable,
  String? hijriDate,
) async {
  try {
    if (kIsWeb) return false;

    final eventFln = FlutterLocalNotificationsPlugin();
    final prefs = await SharedPreferences.getInstance();
    final prefKey = 'holiday_notif_$eventTitle';

    // Unique ID for this event notification (range 50000 - 99999)
    final notificationId = 50000 + (eventTitle.hashCode.abs() % 49000);

    // Save toggle preference
    await prefs.setBool(prefKey, isEnable);

    // If disabled, cancel the notification
    if (!isEnable) {
      await eventFln.cancel(notificationId);
      await eventFln.cancel(notificationId + 1);
      return true;
    }

    if (eventDate == null) {
      return false;
    }

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
    await eventFln.initialize(settings);

    // Permissions
    await eventFln
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    await eventFln
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Create Channel for Islamic Holidays
    const channelId = 'islamic_events_channel';
    const channelName = 'Islamska Högtider & Händelser';
    const channelDesc = 'Påminnelser inför islamska högtider och viktiga dagar';

    final androidPlugin = eventFln.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    try {
      await androidPlugin?.requestExactAlarmsPermission();
    } catch (_) {}
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

    tzdata.initializeTimeZones();
    tz.Location location;
    try {
      location = tz.getLocation('Europe/Stockholm');
    } catch (_) {
      location = tz.local;
    }

    final nowTz = tz.TZDateTime.now(location);

    // Notification Details
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDesc,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    final dateDesc =
        hijriDate != null && hijriDate.isNotEmpty ? ' ($hijriDate)' : '';

    // 1. Schedule evening-before reminder at 20:00 (8:00 PM) Swedish time
    // The Islamic day starts at sunset (Maghrib), ideal for fasting prep
    final tzEvening = tz.TZDateTime(
      location,
      eventDate.year,
      eventDate.month,
      eventDate.day - 1,
      20,
      0,
    );

    if (tzEvening.isAfter(nowTz)) {
      await eventFln.zonedSchedule(
        notificationId,
        'Påminnelse: $eventTitle',
        'I morgon infaller $eventTitle$dateDesc. Glöm inte eventuell fasta eller förberedelser!',
        tzEvening,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }

    // 2. Schedule morning-of reminder at 08:00 (8:00 AM) Swedish time
    final tzMorning = tz.TZDateTime(
      location,
      eventDate.year,
      eventDate.month,
      eventDate.day,
      8,
      0,
    );

    if (tzMorning.isAfter(nowTz)) {
      await eventFln.zonedSchedule(
        notificationId + 1,
        'Idag: $eventTitle',
        'Idag infaller $eventTitle$dateDesc.',
        tzMorning,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }

    return true;
  } catch (e) {
    debugPrint('Error in scheduleEventNotifications: $e');
    return false;
  }
}
