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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '/custom_code/actions/constants.dart';

Future<void> loadMosquesData() async {
  if (FFAppState().mosque.isNotEmpty) {
    print("Mosque data already loaded in App State. Skipping JSON load.");
    return;
  }
  try {
    print("Loading mosques from assets/jsons/mosques.json...");
    final String jsonString =
        await rootBundle.loadString(FileConstants.mosquesJsonPath);
    final List<dynamic> decodedList = json.decode(jsonString);

    final List<MosqueStruct> parsedMosques = decodedList.map((item) {
      final name = item['name'] as String?;
      final lat = (item['latitude'] as num?)?.toDouble();
      final lng = (item['longitude'] as num?)?.toDouble();

      LatLng? latLng;
      if (lat != null && lng != null) {
        latLng = LatLng(lat, lng);
      }

      return MosqueStruct(
        name: name,
        latitude: latLng,
      );
    }).toList();

    FFAppState().update(() {
      FFAppState().mosque = parsedMosques;
    });

    print("Successfully loaded ${parsedMosques.length} mosques.");
  } catch (e) {
    print("Error loading mosques JSON: $e");
  }
}
