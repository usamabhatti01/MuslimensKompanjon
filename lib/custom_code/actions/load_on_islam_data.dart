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

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '/custom_code/actions/constants.dart';

Future<void> loadOnIslamData() async {
  // Check if data is already loaded to prevent redundant loading
  if (FFAppState().aboutIslam.isNotEmpty) {
    print("AboutIslam data already loaded in App State. Skipping JSON load.");
    return;
  }
  try {
    print("Loading OnIslam data from ${FileConstants.omIslamJsonPath}...");
    final String jsonString =
        await rootBundle.loadString(FileConstants.omIslamJsonPath);
    final List<dynamic> decodedList = json.decode(jsonString);

    final List<OnIslamStruct> parsedOnIslam = decodedList.map((item) {
      final Map<String, dynamic> itemMap = Map<String, dynamic>.from(item);
      if (itemMap['sections'] != null) {
        final List<dynamic> sections = List<dynamic>.from(itemMap['sections']);
        final List<Map<String, dynamic>> updatedSections =
            sections.map((section) {
          final Map<String, dynamic> sectionMap =
              Map<String, dynamic>.from(section);
          final paragraphs = sectionMap['paragraphs'];
          if (paragraphs is List) {
            sectionMap['paragraphs'] =
                paragraphs.map((p) => p.toString()).join('\n\n');
          } else if (paragraphs != null) {
            sectionMap['paragraphs'] = paragraphs.toString();
          }
          return sectionMap;
        }).toList();
        itemMap['sections'] = updatedSections;
      }
      return OnIslamStruct.fromMap(itemMap);
    }).toList();

    FFAppState().update(() {
      FFAppState().aboutIslam = parsedOnIslam;
    });
    print(
        "Successfully loaded ${parsedOnIslam.length} parts of OnIslam into App State.");
  } catch (e) {
    print("Error loading OnIslam JSON: $e");
  }
}
