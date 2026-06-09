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

import 'package:flutter/services.dart';

Future<String> loadPrayerJson(
  String cityName,
  int year,
) async {
  List<String>? _cachedAssets;

  String toNfd(String input) {
    const decomposed = <String, String>{
      'å': 'a\u030A',
      'ä': 'a\u0308',
      'ö': 'o\u0308',
      'é': 'e\u0301',
      'è': 'e\u0300',
      'ü': 'u\u0308',
      'Å': 'A\u030A',
      'Ä': 'A\u0308',
      'Ö': 'O\u0308',
      'É': 'E\u0301',
    };

    var result = input;

    decomposed.forEach((composed, decomposedValue) {
      result = result.replaceAll(composed, decomposedValue);
    });

    return result;
  }

  bool fileNamesMatch(String a, String b) {
    final left = a.toLowerCase();
    final right = b.toLowerCase();

    if (left == right) return true;
    if (toNfd(left) == right) return true;
    if (left == toNfd(right)) return true;
    if (toNfd(left) == toNfd(right)) return true;

    return false;
  }

  Future<List<String>> allAssets() async {
    if (_cachedAssets != null) return _cachedAssets!;

    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);

    _cachedAssets = manifest.listAssets();

    return _cachedAssets!;
  }

  Future<String?> resolvePath() async {
    final slug = cityName.trim().toLowerCase();
    final fileName = '${slug}_$year.json';
    final fileNameNfd = toNfd(fileName);

    final assets = await allAssets();

    final directPaths = <String>[
      'assets/jsons/$year/$fileName',
      'assets/jsons/$year/$fileNameNfd',
      'assets/jsons/$fileName',
      'assets/jsons/$fileNameNfd',
    ];

    for (final path in directPaths) {
      if (assets.contains(path)) return path;
    }

    String? rootFallback;

    for (final asset in assets) {
      if (!asset.startsWith('assets/jsons/')) continue;
      if (!asset.endsWith('_$year.json')) continue;

      final base = asset.split('/').last;

      if (!fileNamesMatch(base, fileName)) continue;

      if (asset.contains('/$year/')) return asset;

      rootFallback ??= asset;
    }

    return rootFallback;
  }

  final path = await resolvePath();

  if (path == null) {
    return await rootBundle.loadString(
      'assets/jsons/$year/default_$year.json',
    );
  }

  return rootBundle.loadString(path);
}
