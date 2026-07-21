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

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '/custom_code/actions/constants.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> loadTodayHijriData() async {
  try {
    // Set Hijri locale
    HijriCalendar.setLocal("en");
    print("todayHijri");

    // Resolve timezone from selected city
    String timezoneStr = '';
    final String city = FFAppState().user.city;
    if (city.isNotEmpty) {
      try {
        final jsonString = await loadPrayerJson(city, DateTime.now().year);
        final decoded = json.decode(jsonString);
        timezoneStr = decoded['city']?['timezone'] ?? '';
      } catch (_) {}
    }

    tz.initializeTimeZones();
    DateTime now = DateTime.now();
    if (timezoneStr.isNotEmpty) {
      try {
        final loc = tz.getLocation(timezoneStr);
        now = tz.TZDateTime.now(loc);
      } catch (_) {}
    }

    // Get today Gregorian date (adjusted for city's timezone)
    final String todayGregorian = DateFormat('yyyy-MM-dd').format(now);

    // Get current Hijri year (adjusted for city's timezone)
    final hijri = HijriCalendar.fromDate(now);
    final int year = hijri.hYear;
    // Search candidate years dynamically to ensure today's Gregorian date is found
    // even if it falls on a Hijri year boundary (e.g. 1447 vs 1448)
    final List<int> candidateYears = [
      year,
      year + 1,
      year - 1,
      1447,
      1448,
    ].toSet().toList();

    Map<String, dynamic>? todayItem;

    for (final candidateYear in candidateYears) {
      final String fileName = 'Islamic_dates_$candidateYear.json';
      final String url =
          '${FileConstants.islamicDatesUrlPrefix}$candidateYear.json';
      String? jsonString;

      // 1. Download from URL first
      try {
        final response =
            await http.get(Uri.parse(url)).timeout(const Duration(seconds: 4));
        if (response.statusCode == 200 && response.body.isNotEmpty) {
          jsonString = response.body;

          // Save to local device storage for offline use
          try {
            final directory = await getApplicationDocumentsDirectory();
            final localFile = File('${directory.path}/$fileName');
            await localFile.writeAsString(jsonString);
          } catch (_) {}
        }
      } catch (_) {}

      // 2. Read from local device storage if network failed/offline
      if (jsonString == null || jsonString.isEmpty) {
        try {
          final directory = await getApplicationDocumentsDirectory();
          final localFile = File('${directory.path}/$fileName');
          if (await localFile.exists()) {
            jsonString = await localFile.readAsString();
          }
        } catch (_) {}
      }

      // 3. Fallback to bundled assets if cache and download both fail
      if (jsonString == null || jsonString.isEmpty) {
        try {
          jsonString = await rootBundle.loadString('assets/jsons/$fileName');
        } catch (_) {}
      }

      if (jsonString != null && jsonString.isNotEmpty) {
        try {
          final List<dynamic> jsonData = json.decode(jsonString);
          final dynamic found =
              jsonData.cast<Map<String, dynamic>>().firstWhere(
                    (item) => item['Gregorian_Date'] == todayGregorian,
                    orElse: () => {},
                  );
          if (found != null &&
              found is Map<String, dynamic> &&
              found.isNotEmpty) {
            todayItem = Map<String, dynamic>.from(found);
            print(
                "Successfully found today's Hijri data in $fileName: $todayItem");
            break;
          }
        } catch (_) {}
      }
    }

    // Failsafe fallback via hijri_calendar package if date not found in any JSON
    if (todayItem == null || todayItem.isEmpty) {
      print(
          "Today's Hijri data not found in JSON files, using HijriCalendar fallback");
      final fallbackHijri = HijriCalendar.fromDate(now);
      todayItem = {
        'Hijri_Year': fallbackHijri.hYear,
        'Hijri_Month_No': fallbackHijri.hMonth,
        'Hijri_Month_Name': fallbackHijri.longMonthName,
        'Hijri_Day': fallbackHijri.hDay,
        'Gregorian_Date': todayGregorian,
        'Weekday': DateFormat('EEEE').format(now),
        'Event': null,
      };
    }

    // Map to struct safely using castToType
    final HijriCalenderStruct todayHijri = HijriCalenderStruct(
      hijriYear:
          castToType<int>(todayItem['Hijri_Year'] ?? todayItem['HijriYear']),
      hijriMonthNo: castToType<int>(
          todayItem['Hijri_Month_No'] ?? todayItem['HijriMonthNo']),
      hijriMonthName: (todayItem['Hijri_Month_Name'] ??
          todayItem['HijriMonthName']) as String?,
      hijriDay:
          castToType<int>(todayItem['Hijri_Day'] ?? todayItem['HijriDay']),
      gregorianDate: todayItem['Gregorian_Date'] != null
          ? DateTime.tryParse(todayItem['Gregorian_Date'].toString())
          : null,
      weekday: (todayItem['Weekday'] ?? todayItem['weekday']) as String?,
      event: (todayItem['Event'] ?? todayItem['event']) as String?,
    );
    print("todayHijri");
    print(todayHijri);

    // Save to AppState
    FFAppState().hijriData = todayHijri;
    FFAppState().update(() {});
  } catch (e) {
    print('Error loading today Hijri data: $e');
  }
}
