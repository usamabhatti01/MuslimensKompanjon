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
import 'dart:convert';
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

  String toAscii(String input) {
    return input
        .replaceAll('å', 'a')
        .replaceAll('ä', 'a')
        .replaceAll('ö', 'o')
        .replaceAll('Å', 'A')
        .replaceAll('Ä', 'A')
        .replaceAll('Ö', 'O')
        .replaceAll('é', 'e')
        .replaceAll('è', 'e')
        .replaceAll('ü', 'u');
  }

  bool fileNamesMatch(String a, String b) {
    final left = a.toLowerCase();
    final right = b.toLowerCase();

    if (left == right) return true;
    if (toNfd(left) == right) return true;
    if (left == toNfd(right)) return true;
    if (toNfd(left) == toNfd(right)) return true;
    if (toAscii(left) == toAscii(right)) return true;

    return false;
  }

  final slug = cityName.trim().toLowerCase();
  final slugAscii = toAscii(slug);
  final slugNfd = toNfd(slug);
  final originalName = cityName.trim();
  final originalNameNfd = toNfd(originalName);
  final originalNameAscii = toAscii(originalName);

  final fileName = '${slug}_$year.json';
  final fileNameNfd = toNfd(fileName);
  final fileNameAscii = '${slugAscii}_$year.json';

  // 1. Try to read from local device cache first
  try {
    final directory = await getApplicationDocumentsDirectory();
    final candidateLocalFiles = [
      File('${directory.path}/$fileName'),
      File('${directory.path}/$fileNameNfd'),
      File('${directory.path}/$fileNameAscii'),
    ];

    for (final localFile in candidateLocalFiles) {
      if (await localFile.exists()) {
        final content = await localFile.readAsString();
        if (content.isNotEmpty) {
          print("Offline Cache Hit: Loaded local file for $cityName ($year).");
          return content;
        }
      }
    }
  } catch (e) {
    print("Error reading from local device cache: $e");
  }

  // 2. Local cache missed. Try to download from possible online URLs
  final possibleUrls = <String>[
    'https://ifis.se/mkprod/data/prayer_times/$year/${slug}_combined_$year.json',
    'https://ifis.se/mkprod/data/prayer_times/$year/${slugAscii}_combined_$year.json',
    'https://ifis.se/mkprod/data/prayer_times/$year/${slugNfd}_combined_$year.json',
    'https://ifis.se/mkprod/data/prayer_times/$year/${slug}_$year.json',
    'https://ifis.se/mkprod/data/prayer_times/$year/${slugAscii}_$year.json',
    'https://ifis.se/mkprod/data/prayer_times/$year/${originalName}_combined_$year.json',
    'https://ifis.se/mkprod/data/prayer_times/$year/${originalNameAscii}_combined_$year.json',
    'https://ifis.se/mkprod/data/prayer_times/$year/${originalNameNfd}_combined_$year.json',
    'https://ifis.se/mkprod/data/prayer_times/$year/${originalName}_$year.json',
  ].toSet().toList();

  String? downloadedContent;
  for (final rawUrl in possibleUrls) {
    try {
      final encodedUrl = Uri.encodeFull(rawUrl);
      print("Attempting download from: $encodedUrl");
      final response = await http.get(
        Uri.parse(encodedUrl),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148',
          'Accept': 'application/json, text/plain, */*',
        },
      ).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        downloadedContent = utf8.decode(response.bodyBytes);
        print("Successfully downloaded JSON from: $rawUrl");
        break;
      }
    } catch (e) {
      print("Failed to download from $rawUrl: $e");
    }
  }

  // 3. Save successfully downloaded file to local cache
  if (downloadedContent != null && downloadedContent.isNotEmpty) {
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
      "Cache missed and download failed/offline for $cityName ($year). Falling back to local bundle assets.");

  List<String>? cachedAssets;

  Future<List<String>> allAssets() async {
    if (cachedAssets != null) return cachedAssets!;
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    cachedAssets = manifest.listAssets();
    return cachedAssets!;
  }

  Future<String?> resolvePath() async {
    final assets = await allAssets();

    final directPaths = <String>[
      'assets/jsons/$year/$fileName',
      'assets/jsons/$year/$fileNameNfd',
      'assets/jsons/$year/$fileNameAscii',
      'assets/jsons/$fileName',
      'assets/jsons/$fileNameNfd',
      'assets/jsons/$fileNameAscii',
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
    print("Asset path not resolved for $year. Trying default_$year fallback.");
    try {
      return await rootBundle.loadString(
        'assets/jsons/$year/default_$year.json',
      );
    } catch (e) {
      print(
          "Fallback failed for $year. Loading bundled 2026 asset as emergency fallback.");
      return await rootBundle.loadString('assets/jsons/alingsås_2026.json');
    }
  }

  return rootBundle.loadString(path);
} ////
