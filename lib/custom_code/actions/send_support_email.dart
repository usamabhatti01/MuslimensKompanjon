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

// Custom imports
// Custom imports (Add at top of Custom Action file)
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

Future sendSupportEmail(
  String name,
  String subject,
  String message,
) async {
  // Use a different variable name or use the passed 'subject' directly
  final String emailSubject = subject.isNotEmpty ? subject : 'Subject';
  final String body = '$message\n\n---\nNamn: $name';

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'support@muslimenskompanjon.se',
    query: encodeQueryParameters({
      'subject': emailSubject,
      'body': body,
    }),
  );

  try {
    final bool launched = await launchUrl(emailUri);
    if (!launched) {
      await Clipboard.setData(
        const ClipboardData(text: 'support@muslimenskompanjon.se'),
      );
    }
  } catch (e) {
    await Clipboard.setData(
      const ClipboardData(text: 'support@muslimenskompanjon.se'),
    );
  }
}
