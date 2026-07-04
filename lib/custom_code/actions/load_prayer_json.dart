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

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '/custom_code/actions/constants.dart';

Future<String> loadPrayerJson(
  String cityName,
  int year,
) async {
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

  final slug = cityName.trim().toLowerCase();
  final fileName = '${slug}_$year.json';
  final fileNameNfd = toNfd(fileName);

  // 1. Try to read from local device cache first
  try {
    final directory = await getApplicationDocumentsDirectory();
    final localFilePath = '${directory.path}/$fileName';
    final localFile = File(localFilePath);

    if (await localFile.exists()) {
      print("Offline Cache Hit: Loaded local file for $cityName ($year).");
      return await localFile.readAsString();
    }
  } catch (e) {
    print("Error reading from local device cache: $e");
  }

  // 2. Local cache missed. Try to download from GitHub repository
  // Change these two values if you ever change your GitHub username or repository:
  final gitHubOwner = GitConstants.gitHubOwner;
  final gitHubRepo = GitConstants.gitHubRepo;
  final branches = GitConstants.branches;
  final possibleUrls = <String>[];
  for (final b in branches) {
    possibleUrls.addAll([
      'https://raw.githubusercontent.com/$gitHubOwner/$gitHubRepo/$b/assets/jsons/$fileName',
      'https://raw.githubusercontent.com/$gitHubOwner/$gitHubRepo/$b/assets/jsons/$fileNameNfd',
      'https://raw.githubusercontent.com/$gitHubOwner/$gitHubRepo/$b/assets/jsons/$year/$fileName',
      'https://raw.githubusercontent.com/$gitHubOwner/$gitHubRepo/$b/assets/jsons/$year/$fileNameNfd',
    ]);
  }

  String? downloadedContent;
  for (final url in possibleUrls) {
    try {
      print("Attempting download from: $url");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        downloadedContent = response.body;
        print("Successfully downloaded JSON from: $url");
        break;
      }
    } catch (e) {
      print("Failed to download from $url: $e");
    }
  }

  // 3. Save successfully downloaded file to local cache
  if (downloadedContent != null) {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final localFilePath = '${directory.path}/$fileName';
      final localFile = File(localFilePath);
      await localFile.writeAsString(downloadedContent);
      print("Cached JSON locally at: $localFilePath");
    } catch (e) {
      print("Failed to write JSON to local cache: $e");
    }
    return downloadedContent;
  }

  // 4. Download failed / offline & not in cache: fallback to local bundled assets (if any)
  print(
      "Cache missed and download failed/offline. Falling back to local bundle assets.");

  List<String>? _cachedAssets;

  Future<List<String>> allAssets() async {
    if (_cachedAssets != null) return _cachedAssets!;
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    _cachedAssets = manifest.listAssets();
    return _cachedAssets!;
  }

  Future<String?> resolvePath() async {
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
    print("Asset path not resolved. Trying default_year fallback.");
    try {
      return await rootBundle.loadString(
        'assets/jsons/$year/default_$year.json',
      );
    } catch (e) {
      print("Fallback failed. Trying default.json.");
      return await rootBundle.loadString('assets/jsons/alingsås_2026.json');
    }
  }

  return rootBundle.loadString(path);
} ////
