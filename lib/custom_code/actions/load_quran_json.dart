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

String _normalizeArabic(String text) {
  return text
      .replaceAll('\u0627\u0653',
          '\u0622') // Replace Alef + Maddah with standard Alef with Madda (آ)
      .replaceAll('\u06e1',
          '\u0652'); // Replace Quranic sukun (small high dotless head of kha ۡ) with standard sukun (ْ)
}

Future<void> loadQuranJson() async {
  // Check if data is already loaded to prevent redundant loading
  if (FFAppState().surahsList.isNotEmpty &&
      FFAppState().ayahsList.isNotEmpty &&
      FFAppState().juzList.isNotEmpty) {
    print("Quran data already loaded in App State. Skipping JSON load.");
    return;
  }

  try {
    print("Loading Quran data from assets/jsons/quran.json...");
    final String jsonString =
        await rootBundle.loadString('assets/jsons/quran.json');
    final Map<String, dynamic> decoded = json.decode(jsonString);

    // 1. Parse and update Surahs
    if (decoded.containsKey('surahs') && decoded['surahs'] is List) {
      final List<SurahsStruct> parsedSurahs =
          (decoded['surahs'] as List).map((item) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(item);
        if (map['name'] != null && map['name'] is String) {
          map['name'] = _normalizeArabic(map['name'] as String);
        }
        return SurahsStruct.fromMap(map);
      }).toList();

      FFAppState().update(() {
        FFAppState().surahsList = parsedSurahs;
      });
      print(
          "Successfully loaded ${parsedSurahs.length} surahs into App State surahsList.");
    }

    // 2. Parse and update Ayahs
    if (decoded.containsKey('ayahs') && decoded['ayahs'] is List) {
      final List<AyahsStruct> parsedAyahs =
          (decoded['ayahs'] as List).map((item) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(item);
        if (map['arabic'] != null && map['arabic'] is String) {
          map['arabic'] = _normalizeArabic(map['arabic'] as String);
        }
        return AyahsStruct.fromMap(map);
      }).toList();

      FFAppState().update(() {
        FFAppState().ayahsList = parsedAyahs;
      });
      print(
          "Successfully loaded ${parsedAyahs.length} ayahs into App State ayahsList.");
    }

    // 3. Parse and update Juzs
    if (decoded.containsKey('juzs') && decoded['juzs'] is List) {
      final List<SurahsStruct> parsedJuzs =
          (decoded['juzs'] as List).map((item) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(item);
        if (map['name'] != null && map['name'] is String) {
          map['name'] = _normalizeArabic(map['name'] as String);
        }
        return SurahsStruct.fromMap(map);
      }).toList();

      FFAppState().update(() {
        FFAppState().juzList = parsedJuzs;
      });
      print(
          "Successfully loaded ${parsedJuzs.length} juzs into App State juzList.");
    }
  } catch (e) {
    print("Error loading Quran JSON: $e");
  }
}
