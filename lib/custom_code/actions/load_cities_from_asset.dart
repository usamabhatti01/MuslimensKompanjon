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

import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '/custom_code/actions/constants.dart';

Future<String> loadJsonFromAssetOrGit(String filePath) async {
  return await rootBundle.loadString(filePath);
}

Future<List<CityRecordStruct>> loadCitiesFromAsset(
  LatLng? value,
) async {
  print("🚀 FUNCTION STARTED");
  if (FFAppState().cityList.isNotEmpty) {
    print("📋 Cities already loaded in App State. Skipping asset load.");
    return FFAppState().cityList;
  }

  try {
    print("📦 Loading JSON from assets...");

    final jsonString = await loadJsonFromAssetOrGit(
      FileConstants.citiesJsonPath,
    );

    print("✅ JSON loaded successfully");

    final decoded = json.decode(jsonString);

    if (decoded is! List) {
      print("❌ Decoded JSON is NOT a List");

      return [];
    }

    print("📋 JSON is a List with ${decoded.length} items");

    final List<CityRecordStruct> cities = [];

    for (int i = 0; i < decoded.length; i++) {
      final item = decoded[i];

      if (item is! Map) {
        continue;
      }

      final name = item['name']?.toString() ?? '';

      final latStr = item['lat']?.toString() ?? '';

      final lngStr = item['lng']?.toString() ?? '';

      final lat = double.tryParse(latStr) ?? 0.0;

      final lng = double.tryParse(lngStr) ?? 0.0;

      cities.add(
        CityRecordStruct(
          name: name,
          lat: lat,
          lng: lng,
        ),
      );
    }

    print("✅ Total cities parsed: ${cities.length}");

    List<CityRecordStruct> result = cities;

    if (value != null) {
      print("📍 User location: ${value.latitude}, ${value.longitude}");

      final double userLat = value.latitude;

      final double userLng = value.longitude;

      const double threshold = 0.5;

      final filtered = cities.where((city) {
        final lat = city.lat ?? 0.0;

        final lng = city.lng ?? 0.0;

        return (lat - userLat).abs() <= threshold &&
            (lng - userLng).abs() <= threshold;
      }).toList();

      print("🎯 Filtered cities count: ${filtered.length}");

      if (filtered.isNotEmpty) {
        result = filtered;
      }
    } else {
      print("⚠️ Location is NULL → using all cities");
    }

    // STORE IN APP STATE

    FFAppState().cityList = result;

    print("✅ App State Updated");

    print("📊 cityList count: ${FFAppState().cityList.length}");

    if (FFAppState().cityList.isNotEmpty) {
      print(
        "🏙️ First city: ${FFAppState().cityList.first.name}",
      );
    }

    return result;
  } catch (e, stack) {
    print("❌ ERROR OCCURRED:");

    print(e);

    print(stack);

    return [];
  }
}
