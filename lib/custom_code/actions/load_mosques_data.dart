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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '/custom_code/actions/constants.dart';

Future<void> loadMosquesData() async {
  try {
    String? jsonString;

    // 1. Fetch from live URL
    try {
      print(
          "Fetching mosques from live URL: ${FileConstants.mosquesJsonUrl}...");
      final response = await http.get(
        Uri.parse(FileConstants.mosquesJsonUrl),
        headers: const {
          'Accept': 'application/json, text/plain, */*',
          'User-Agent':
              'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        jsonString = utf8.decode(response.bodyBytes);

        // Cache to local storage for offline use
        try {
          final directory = await getApplicationDocumentsDirectory();
          final localFile = File('${directory.path}/map_mosques.json');
          await localFile.writeAsString(jsonString);
        } catch (e) {
          print("Error caching live mosques to disk: $e");
        }
      } else {
        print("Live mosque API returned status ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching live mosques: $e");
    }

    // 2. Read from disk cache if network failed
    if (jsonString == null || jsonString.isEmpty) {
      try {
        final directory = await getApplicationDocumentsDirectory();
        final localFile = File('${directory.path}/map_mosques.json');
        if (await localFile.exists()) {
          print("Loading mosques from disk cache...");
          jsonString = await localFile.readAsString();
        }
      } catch (e) {
        print("Error reading cached mosques file: $e");
      }
    }

    // 3. Fallback to bundled asset if both network and cache fail
    if (jsonString == null || jsonString.isEmpty) {
      try {
        print(
            "Falling back to bundled asset: ${FileConstants.mosquesJsonPath}...");
        jsonString = await rootBundle.loadString(FileConstants.mosquesJsonPath);
      } catch (e) {
        print("Error loading bundled mosques asset: $e");
      }
    }

    if (jsonString == null || jsonString.isEmpty) {
      print("No mosque data available.");
      return;
    }

    final decoded = json.decode(jsonString);
    List<dynamic> rawItems = [];

    if (decoded is List) {
      rawItems = decoded;
    } else if (decoded is Map) {
      final dynamic mosquesField = decoded['mosques'];
      if (mosquesField is Map) {
        rawItems = mosquesField.values.toList();
      } else if (mosquesField is List) {
        rawItems = mosquesField;
      } else {
        rawItems = decoded.values.toList();
      }
    }

    final List<MosqueStruct> parsedMosques = [];
    for (final item in rawItems) {
      if (item is! Map) continue;
      final city = item['city'] as String?;
      final rawName = item['name'] as String?;
      final address = item['address'] as String?;

      final lat = (item['lat'] as num?)?.toDouble() ??
          (item['latitude'] as num?)?.toDouble();
      final lng = (item['lng'] as num?)?.toDouble() ??
          (item['longitude'] as num?)?.toDouble();

      LatLng? latLng;
      if (lat != null && lng != null) {
        latLng = LatLng(lat, lng);
      }

      String formattedName;
      if (city != null && city.trim().isNotEmpty) {
        final cleanCity = city.trim();
        final cleanName = rawName?.trim() ?? '';
        if (cleanName.contains(',')) {
          formattedName = cleanName;
        } else {
          formattedName = '$cleanCity, $cleanName';
        }
      } else {
        formattedName = rawName?.trim() ?? '';
      }

      parsedMosques.add(
        MosqueStruct(
          name: formattedName,
          latitude: latLng,
          address: address,
        ),
      );
    }

    FFAppState().update(() {
      FFAppState().mosque = parsedMosques;
    });

    print("Successfully loaded ${parsedMosques.length} mosques.");
  } catch (e) {
    print("Error loading mosques: $e");
  }
}
