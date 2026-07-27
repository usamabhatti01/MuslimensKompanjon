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

import 'package:http/http.dart' as http;

Future<bool> isImageValid(String? url) async {
  if (url == null || url.trim().isEmpty) {
    print('URL is null or empty');

    return false;
  }

  try {
    final uri = Uri.parse(url);

    print('Checking URL: $url');

    // First try HEAD request

    var response = await http.head(uri);

    print('HEAD Status Code: ${response.statusCode}');

    // Some servers don't support HEAD

    if (response.statusCode == 405) {
      print('HEAD not supported, trying GET request...');

      response = await http.get(uri);

      print('GET Status Code: ${response.statusCode}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final contentType = response.headers['content-type'];

      print('Content-Type: $contentType');

      final isImage =
          contentType != null && contentType.toLowerCase().startsWith('image/');

      print('Is Image: $isImage');

      return isImage;
    }

    print('Request failed with status: ${response.statusCode}');

    return false;
  } catch (e, stackTrace) {
    print('Error checking image: $e');

    print(stackTrace);

    return false;
  }
}
