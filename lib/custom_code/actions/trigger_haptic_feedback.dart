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
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

Future triggerHapticFeedback() async {
  if (FFAppState().haptic) {
    try {
      HapticFeedback.lightImpact();
    } catch (_) {}
    try {
      final hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator == true) {
        Vibration.vibrate(duration: 40);
      }
    } catch (_) {}
  }
}

Future tasbihHapticFeedback() async {
  await triggerHapticFeedback();
}
