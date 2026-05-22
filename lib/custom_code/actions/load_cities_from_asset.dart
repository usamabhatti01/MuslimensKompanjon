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

import 'package:flutter/services.dart';
import 'dart:convert';

Future<List<CityRecordStruct>> loadCitiesFromAsset(
  LatLng? value,
) async {
  print("🚀 FUNCTION STARTED");

  try {
    print("📦 Loading JSON from assets...");

    final jsonString = await rootBundle.loadString(
      'assets/jsons/cities.json',
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

    // LOCATION CHECK
    print("📍 Checking user location... value = $value");

    if (value == null) {
      print("⚠️ value is NULL → returning all cities");
      return cities;
    }

    print("📍 Extracting latitude/longitude...");

    final double userLat = value.latitude;
    final double userLng = value.longitude;

    print("👤 userLat=$userLat userLng=$userLng");

    const double threshold = 0.5;

    print("🔍 Filtering cities...");

    final filtered = cities.where((city) {
      final lat = city.lat ?? 0.0;
      final lng = city.lng ?? 0.0;

      final latDiff = (lat - userLat).abs();
      final lngDiff = (lng - userLng).abs();

      print("➡️ city=${city.name} latDiff=$latDiff lngDiff=$lngDiff");

      return latDiff <= threshold && lngDiff <= threshold;
    }).toList();

    print("🎯 Filtered result: ${filtered.length} cities");

    return filtered.isEmpty ? cities : filtered;
  } catch (e, stack) {
    print("❌ ERROR OCCURRED:");
    print(e);
    print("📛 STACK TRACE:");
    print(stack);
    return [];
  }
}
