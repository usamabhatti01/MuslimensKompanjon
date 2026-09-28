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

import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

Future rateApp() async {
  Uri? storeUrl;

  if (Platform.isAndroid) {
    storeUrl = Uri.parse(
      'https://play.google.com/store/apps/details?id=se.muslimenskompanjon.app',
    );
  } else if (Platform.isIOS) {
    storeUrl = Uri.parse(
      'https://apps.apple.com/us/app/muslimens-kompanjon/id1614461250',
    );
  }

  if (storeUrl != null) {
    await launchUrl(
      storeUrl,
      mode: LaunchMode.externalApplication,
    );
  }
}
