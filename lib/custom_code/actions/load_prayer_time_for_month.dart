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

Future<List<PrayerTimeStruct>> loadPrayerTimeForMonth(
  String cityName,
  String month,
  int year,
) async {
  try {
    final String jsonString = await rootBundle
        .loadString('assets/jsons/${cityName.toLowerCase()}_$year.json');

    final Map<String, dynamic> decoded = json.decode(jsonString);

    final Map<String, dynamic> prayerTimes =
        decoded['prayer_times'] as Map<String, dynamic>;

    final List<PrayerTimeStruct> result = [];

    final int monthInt = int.tryParse(month) ?? 1;

    // ✅ SAFE TIME PARSER
    DateTime? parseTime(String? value, DateTime date) {
      if (value == null || value.isEmpty) return null;

      try {
        final parts = value.split(':');

        if (parts.length < 2) return null;

        return DateTime(
          date.year,
          date.month,
          date.day,
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
      } catch (e) {
        return null;
      }
    }

    // ✅ FORMAT TIME => 06:27
    String formatPrayerTime(DateTime? time) {
      if (time == null) return '--:--';

      return DateFormat('HH:mm').format(time);
    }

    prayerTimes.forEach((dateStr, data) {
      try {
        final DateTime date = DateTime.parse(dateStr);

        // ✅ FILTER MONTH + YEAR
        if (date.year != year || date.month != monthInt) return;

        // ✅ PARSE TIMES
        final fajrTime = parseTime(data['fajr']?.toString(), date);
        final shuruqTime = parseTime(data['shuruq']?.toString(), date);
        final dhuhrTime = parseTime(data['dhuhr']?.toString(), date);
        final asrTime = parseTime(data['asr']?.toString(), date);
        final maghribTime = parseTime(data['maghrib']?.toString(), date);
        final ishaTime = parseTime(data['isha']?.toString(), date);
        //print(fajrTime);
        // ✅ DEBUG OUTPUT
        debugPrint('Fajr => ${formatPrayerTime(fajrTime)}');

        result.add(
          PrayerTimeStruct(
            fajr: fajrTime,
            shuruq: shuruqTime,
            dhuhr: dhuhrTime,
            asr: asrTime,
            maghrib: maghribTime,
            isha: ishaTime,
            hijriYear: data['hijri_year'] is int
                ? data['hijri_year']
                : int.tryParse(data['hijri_year']?.toString() ?? '0') ?? 0,
            hijriMonthNo: data['hijri_month_no'] is int
                ? data['hijri_month_no']
                : int.tryParse(data['hijri_month_no']?.toString() ?? '0') ?? 0,
            hijriMonthName: data['hijri_month_name']?.toString() ?? '',
            hijriDay: data['hijri_day'] is int
                ? data['hijri_day']
                : int.tryParse(data['hijri_day']?.toString() ?? '0') ?? 0,
            weekday: data['weekday']?.toString() ?? '',
          ),
        );
      } catch (e) {
        debugPrint('❌ Error parsing prayer entry: $e');
      }
    });
    print(result);
    return result;
  } catch (e) {
    debugPrint('❌ Error loading prayer times: $e');
    return [];
  }
}
