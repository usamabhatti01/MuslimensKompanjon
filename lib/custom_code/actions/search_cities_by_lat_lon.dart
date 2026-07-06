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
    final List<CityRecordStruct> cities = FFAppState().cityList;

    if (cities.isNotEmpty) {
      CityRecordStruct? closestCity;
      double minDistance = double.maxFinite;
      const double threshold = 0.5;

      for (final city in cities) {
        final lat = city.lat;
        final lng = city.lng;

        final latDiff = (lat - latLog.latitude).abs();
        final lngDiff = (lng - latLog.longitude).abs();

        if (latDiff <= threshold && lngDiff <= threshold) {
          // Compute squared Euclidean distance
          final distance = latDiff * latDiff + lngDiff * lngDiff;

          if (distance < minDistance) {
            minDistance = distance;
            closestCity = city;
          }
        }
      }

      if (closestCity != null) {
        return closestCity;
      }
    }
  } catch (e) {
    print("Error in searchCitiesByLatLon: $e");
  }

  return null;
}
