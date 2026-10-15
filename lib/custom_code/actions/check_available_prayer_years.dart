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

import 'dart:io';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future checkAvailablePrayerYears() async {
  final Set<int> confirmedYears = {};
  final int currentYear = DateTime.now().year;

  // Always include the current year as a baseline (never past years)
  confirmedYears.add(currentYear);

  // Pick 1 user city + 2 random cities
  final Set<String> testCities = {};
  final String userCity = FFAppState().user.city.trim();
  if (userCity.isNotEmpty) {
    testCities.add(userCity);
  } else {
    testCities.add('Stockholm');
  }

  // Load cities list to sample 2 random cities
  final List<String> fallbackCities = [
    'Stockholm',
    'Göteborg',
    'Malmö',
    'Uppsala',
    'Västerås',
    'Örebro',
    'Linköping',
    'Helsingborg',
    'Jönköping',
    'Norrköping',
    'Lund',
    'Umeå',
    'Gävle',
    'Borås',
    'Södertälje',
    'Eskilstuna',
    'Halmstad',
    'Växjö',
    'Karlstad',
    'Alingsås'
  ];

  List<String> allCityNames = [];
  try {
    final jsonStr = await rootBundle.loadString('assets/jsons/cities.json');
    final parsed = json.decode(jsonStr) as List;
    for (final item in parsed) {
      if (item is Map && item['name'] != null) {
        allCityNames.add(item['name'].toString().trim());
      }
    }
  } catch (_) {
    allCityNames = fallbackCities;
  }

  if (allCityNames.isEmpty) {
    allCityNames = fallbackCities;
  }

  final random = math.Random();
  final availableForRandom =
      allCityNames.where((c) => !testCities.contains(c)).toList();
  availableForRandom.shuffle(random);
  for (final city in availableForRandom) {
    if (testCities.length >= 3) break;
    testCities.add(city);
  }

  print('checkAvailablePrayerYears: Testing cities: $testCities');

  String toAscii(String input) {
    return input
        .replaceAll('å', 'a')
        .replaceAll('ä', 'a')
        .replaceAll('ö', 'o')
        .replaceAll('Å', 'A')
        .replaceAll('Ä', 'A')
        .replaceAll('Ö', 'O')
        .replaceAll('é', 'e')
        .replaceAll('è', 'e')
        .replaceAll('ü', 'u');
  }

  Directory? documentsDir;
  try {
    documentsDir = await getApplicationDocumentsDirectory();
  } catch (_) {}

  // Headers to bypass Simply.com / server WAF
  final headers = {
    'User-Agent':
        'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148',
    'Accept': 'application/json, text/plain, */*',
    'Range': 'bytes=0-300',
  };

  Future<bool> checkYear(int year) async {
    // 1. Check local device cache
    if (documentsDir != null) {
      for (final cityName in testCities) {
        final slug = cityName.trim().toLowerCase();
        final slugAscii = toAscii(slug);
        final candidateLocalNames = [
          '${slug}_$year.json',
          '${slugAscii}_$year.json',
          '${slug}_combined_$year.json',
          '${slugAscii}_combined_$year.json',
        ];
        for (final fname in candidateLocalNames) {
          final file = File('${documentsDir.path}/$fname');
          if (file.existsSync() && file.lengthSync() > 500) {
            try {
              final snippet =
                  await file.openRead(0, 200).transform(utf8.decoder).join();
              final trimmed = snippet.trimLeft();
              if (trimmed.startsWith('{') &&
                  (trimmed.contains('prayer_times') ||
                      trimmed.contains('city'))) {
                return true;
              } else if (trimmed.startsWith('<')) {
                // Delete invalid cached file (e.g. HTML 404 page)
                try {
                  file.deleteSync();
                } catch (_) {}
              }
            } catch (_) {}
          }
        }
      }
    }

    // 2. Check bundled local assets
    for (final cityName in testCities) {
      final slug = cityName.trim().toLowerCase();
      final slugAscii = toAscii(slug);
      final assetPaths = [
        'assets/jsons/${slug}_$year.json',
        'assets/jsons/${slugAscii}_$year.json',
      ];
      for (final aPath in assetPaths) {
        try {
          final content = await rootBundle.loadString(aPath);
          final trimmed = content.trimLeft();
          if (trimmed.startsWith('{') &&
              (trimmed.contains('prayer_times') || trimmed.contains('city'))) {
            return true;
          }
        } catch (_) {}
      }
    }

    // 3. Check remote server in parallel across test cities
    final checkFutures = testCities.map((cityName) async {
      final slug = cityName.trim().toLowerCase();
      final slugAscii = toAscii(slug);
      final candidateUrls = [
        'https://ifis.se/mkprod/data/prayer_times/$year/${slug}_combined_$year.json',
        if (slug != slugAscii)
          'https://ifis.se/mkprod/data/prayer_times/$year/${slugAscii}_combined_$year.json',
      ];

      for (final rawUrl in candidateUrls) {
        try {
          final encodedUrl = Uri.encodeFull(rawUrl);
          final response = await http
              .get(Uri.parse(encodedUrl), headers: headers)
              .timeout(const Duration(seconds: 2));

          final contentType =
              (response.headers['content-type'] ?? '').toLowerCase();
          final bodyText =
              utf8.decode(response.bodyBytes, allowMalformed: true).trimLeft();

          if ((response.statusCode == 200 || response.statusCode == 206) &&
              contentType.contains('json') &&
              !bodyText.startsWith('<') &&
              bodyText.startsWith('{') &&
              (bodyText.contains('prayer_times') ||
                  bodyText.contains('city'))) {
            print(
                'checkAvailablePrayerYears: Confirmed year $year from $rawUrl ($cityName)');
            return true;
          }
        } catch (_) {}
      }
      return false;
    });

    final results = await Future.wait(checkFutures);
    return results.contains(true);
  }

  // Check upcoming candidate years with early-exit:
  // If year N is not present, STOP immediately and do not check subsequent years
  final upcomingCandidateYears = [
    currentYear + 1,
    currentYear + 2,
    currentYear + 3,
  ];

  for (final year in upcomingCandidateYears) {
    if (confirmedYears.contains(year)) continue;
    final found = await checkYear(year);
    if (found) {
      confirmedYears.add(year);
    } else {
      // If this year is not present, don't check subsequent years
      break;
    }
  }

  final sortedList = confirmedYears.toList()..sort();
  print('checkAvailablePrayerYears: Available prayer years = $sortedList');

  // Update App State
  FFAppState().availablePrayerYears = sortedList;
}
