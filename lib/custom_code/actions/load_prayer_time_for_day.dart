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

// REQUIRED IMPORTS
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<PrayerTimeStruct?> loadPrayerTimeForDay(
  String cityName,
) async {
  // try {
  //   final int year = DateTime.now().year;
  //   final DateTime today = DateTime.now();

  //   final String todayKey = "${today.year.toString().padLeft(4, '0')}-"
  //       "${today.month.toString().padLeft(2, '0')}-"
  //       "${today.day.toString().padLeft(2, '0')}";

  //   print("🟡 Function started");
  //   print("📍 City name: $cityName");
  //   print("📅 Year: $year");
  //   print("📆 Today key: $todayKey");

  //   final String filePath = 'assets/jsons/alingsas_2026.json';
  //   print("📂 Loading file: $filePath");

  //   final String jsonString = await rootBundle.loadString(filePath);

  //   print("✅ File loaded successfully");

  //   final Map<String, dynamic> decoded = json.decode(jsonString);
  //   final Map<String, dynamic> prayerTimes = decoded['prayer_times'];

  //   print("📊 Total entries in prayer_times: ${prayerTimes.length}");

  //   final data = prayerTimes[todayKey];

  //   if (data == null) {
  //     print("❌ No data found for today: $todayKey");
  //     print("🔎 Available keys sample: ${prayerTimes.keys.take(5)}");
  //     return null;
  //   }

  //   print("✅ Data found for today");

  //   DateTime parseTime(String? time) {
  //     if (time == null || time.isEmpty) {
  //       print("⚠️ Empty time value detected");
  //       return today;
  //     }

  //     final parts = time.split(':');
  //     return DateTime(
  //       today.year,
  //       today.month,
  //       today.day,
  //       int.parse(parts[0]),
  //       int.parse(parts[1]),
  //     );
  //   }

  //   print("⏱ Parsing prayer times...");

  //   final result = PrayerTimeStruct(
  //     fajr: parseTime(data['fajr']?.toString(), date),
  //     shuruq: parseTime(data['shuruq']?.toString(), date),
  //     dhuhr: parseTime(data['dhuhr']?.toString(), date),
  //     asr: parseTime(data['asr']?.toString(), date),
  //     maghrib: parseTime(data['maghrib']?.toString(), date),
  //     isha: parseTime(data['isha']?.toString(), date),
  //     hijriYear: int.tryParse(data['hijri_year'].toString()) ?? 0,
  //     hijriMonthNo: int.tryParse(data['hijri_month_no'].toString()) ?? 0,
  //     hijriMonthName: data['hijri_month_name']?.toString() ?? '',
  //     hijriDay: int.tryParse(data['hijri_day'].toString()) ?? 0,
  //     weekday: data['weekday']?.toString() ?? '',
  //   );

  //   print("🎉 Prayer time loaded successfully");
  //   print("🕌 Fajr: ${result.fajr}");

  //   return result;
  // } catch (e) {
  //   print('❌ Error loading today prayer time: $e');
  return null;
  //}
}
