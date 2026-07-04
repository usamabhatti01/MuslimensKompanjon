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

Future<CityRecordStruct> searchCitiesByLatLon(LatLng latLog) async {
  try {
    final List<CityRecordStruct> cities = FFAppState().cityList;

    if (cities.isNotEmpty) {
      CityRecordStruct? closestCity;
      double minDistance = double.maxFinite;

      for (final city in cities) {
        final lat = city.lat;
        final lng = city.lng;

        // Compute squared Euclidean distance
        final distance = (lat - latLog.latitude) * (lat - latLog.latitude) +
            (lng - latLog.longitude) * (lng - latLog.longitude);

        if (distance < minDistance) {
          minDistance = distance;
          closestCity = city;
        }
      }

      if (closestCity != null) {
        return closestCity;
      }
    }
  } catch (e) {
    print("Error in searchCitiesByLatLon: $e");
  }

  // Fallback to Stockholm if anything fails
  return CityRecordStruct(
    name: 'Stockholm',
    lat: 59.3293,
    lng: 18.0686,
  );
}
