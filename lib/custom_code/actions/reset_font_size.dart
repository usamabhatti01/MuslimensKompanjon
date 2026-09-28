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

Future resetFontSize(
  String updatedValue,
  String value,
  double fontSize,
) async {
  FFAppState().update(() {
    switch (updatedValue) {
      case 'quran':
        FFAppState().updateQurantSettingStruct((s) {
          switch (value) {
            case 'arFont':
              s.arFont = fontSize;
              break;
            case 'swFont':
              s.swFont = fontSize;
              break;
            case 'enFont':
              s.enFont = fontSize;
              break;
          }
        });
        break;

      case 'adhkar':
        FFAppState().updateAdhkarSettingStruct((s) {
          switch (value) {
            case 'arFont':
              s.arFont = fontSize;
              break;
            case 'swFont':
              s.swFont = fontSize;
              break;
            case 'enFont':
              s.enFont = fontSize;
              break;
          }
        });
        break;

      case 'tasbih':
        FFAppState().updateTasbihSettingStruct((s) {
          switch (value) {
            case 'arFont':
              s.arFont = fontSize;
              break;
            case 'swFont':
              s.swFont = fontSize;
              break;
            case 'enFont':
              s.enFont = fontSize;
              break;
          }
        });
        break;

      case 'duas':
        FFAppState().updateDuasSettingStruct((s) {
          switch (value) {
            case 'arFont':
              s.arFont = fontSize;
              break;
            case 'swFont':
              s.swFont = fontSize;
              break;
            case 'enFont':
              s.enFont = fontSize;
              break;
          }
        });
        break;
    }
  });
}
