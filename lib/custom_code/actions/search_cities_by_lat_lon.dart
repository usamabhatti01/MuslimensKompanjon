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

import '/app_state.dart';

Future<CityRecordStruct?> searchCitiesByLatLon(LatLng latLog) async {
  try {
    final double userLat = latLog.latitude;
    final double userLng = latLog.longitude;

    // Return null if location is default (0.0, 0.0) or invalid
    if (userLat == 0.0 && userLng == 0.0) {
      print("⚠️ GPS location is default (0.0, 0.0). Returning null (empty).");
      return null;
    }

    List<CityRecordStruct> cities = FFAppState().cityList;

    if (cities.isEmpty) {
      print("📋 cityList is empty, loading cities from asset...");
      cities = await loadCities(null);
    }

    if (cities.isNotEmpty) {
      CityRecordStruct? closestCity;
      double minDistance = double.maxFinite;

      for (final city in cities) {
        final lat = city.lat;
        final lng = city.lng;

        final latDiff = (lat - userLat).abs();
        final lngDiff = (lng - userLng).abs();

        final distance = latDiff * latDiff + lngDiff * lngDiff;

        if (distance < minDistance) {
          minDistance = distance;
          closestCity = city;
        }
      }

      // Maximum allowable distance threshold for GPS matching.
      // Threshold of 0.5 degrees ≈ ~50-55 km (0.5^2 = 0.25 squared distance).
      const double maxThresholdSquared = 0.25;

      if (closestCity != null && minDistance <= maxThresholdSquared) {
        print(
            "🎯 Found matching city: ${closestCity.name} for location ($userLat, $userLng) (dist^2: ${minDistance.toStringAsFixed(4)})");
        return closestCity;
      } else {
        print(
            "⚠️ GPS location ($userLat, $userLng) does not match any city within valid threshold (~50km). Returning null (empty).");
        return null;
      }
    }
  } catch (e) {
    print("Error in searchCitiesByLatLon: $e");
  }

  return null;
}
