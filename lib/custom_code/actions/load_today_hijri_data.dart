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

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

Future<void> loadTodayHijriData() async {
  try {
    // Set Hijri locale
    HijriCalendar.setLocal("en");
    print("todayHijri");

    // Get today Gregorian date (IMPORTANT: must match JSON format)
    final String todayGregorian =
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Get current Hijri year
    final hijri = HijriCalendar.now();
    final int year = hijri.hYear;

    // Load correct JSON file
    final String filePath = 'assets/jsons/hijri-calendar_$year.json';
    print(filePath);
    final String jsonString = await rootBundle.loadString(filePath);
    final List<dynamic> jsonData = json.decode(jsonString);

    // Find today's record safely
    final dynamic todayItem = jsonData.cast<Map<String, dynamic>>().firstWhere(
          (item) => item['Gregorian_Date'] == todayGregorian,
          orElse: () => {},
        );

    if (todayItem == null || todayItem.isEmpty) {
      print("Today's Hijri data not found");
      return;
    }

    // Map to struct
    final HijriCalenderStruct todayHijri = HijriCalenderStruct(
      hijriYear: todayItem['Hijri_Year'],
      hijriMonthNo: todayItem['Hijri_Month_No'],
      hijriMonthName: todayItem['Hijri_Month_Name'],
      hijriDay: todayItem['Hijri_Day'],
      gregorianDate: DateTime.parse(todayItem['Gregorian_Date']),
      weekday: todayItem['Weekday'],
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
