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
    final String filePath =
        '${FileConstants.hijriCalendarPathPrefix}$year.json';
    final String fileName = '${FileConstants.hijriCalendarPrefix}$year.json';
    print(filePath);

    String jsonString;

    // 1. Try to load from assets first
    try {
      jsonString = await rootBundle.loadString(filePath);
    } catch (e) {
      print("Asset not found ($filePath): $e. Trying cache/network.");

      // 2. Try local documents cache
      try {
        final directory = await getApplicationDocumentsDirectory();
        final localFile = File('${directory.path}/$fileName');
        if (await localFile.exists()) {
          print("Cache hit: Loaded $fileName from documents cache.");
          jsonString = await localFile.readAsString();
        } else {
          // 3. Try to download from GitHub repository
          final gitHubOwner = GitConstants.gitHubOwner;
          final gitHubRepo = GitConstants.gitHubRepo;
          final branches = GitConstants.branches;
          String? downloadedContent;

          for (final branch in branches) {
            final url =
                'https://raw.githubusercontent.com/$gitHubOwner/$gitHubRepo/$branch/$filePath';
            try {
              print("Attempting to download from $url");
              final response = await http.get(Uri.parse(url));
              if (response.statusCode == 200) {
                downloadedContent = response.body;
                // Save successfully downloaded file to local cache
                try {
                  await localFile.writeAsString(downloadedContent);
                  print("Cached $fileName locally.");
                } catch (cacheError) {
                  print("Error caching $fileName: $cacheError");
                }
                break;
              }
            } catch (netError) {
              print("Error downloading from $url: $netError");
            }
          }
          if (downloadedContent != null) {
            jsonString = downloadedContent;
          } else {
            throw Exception("Failed to download from GitHub.");
          }
        }
      } catch (cacheOrNetError) {
        throw Exception(
            "Failed to load JSON file from cache or GitHub: $cacheOrNetError");
      }
    }

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
