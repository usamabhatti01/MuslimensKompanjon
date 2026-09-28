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

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

Future<void> sendReviewEmail(
  String message,
  int rating,
) async {
  const String email = 'support@muslimenskompanjon.se';

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  final String stars = '★' * rating + '☆' * (5 - rating);

  final String body = '''
Ny recension

Betyg: $rating/5
$stars

Recension:
$message

-------------------------
Denna recension skickades från appen Muslimens Kompanjon.
''';

  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query: encodeQueryParameters({
      'subject': 'Ny recension – $rating/5',
      'body': body,
    }),
  );

  try {
    final bool launched = await launchUrl(emailUri);

    if (!launched) {
      await Clipboard.setData(
        const ClipboardData(text: email),
      );
    }
  } catch (e) {
    await Clipboard.setData(
      const ClipboardData(text: email),
    );
  }
}
