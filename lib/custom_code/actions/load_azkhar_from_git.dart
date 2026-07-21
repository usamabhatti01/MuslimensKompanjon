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
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '/custom_code/actions/constants.dart';

Future<void> loadAzkharFromGit() async {
  print("🚀 loadAzkharFromGit started");

  // Helper to load file from Asset
  Future<String> loadJsonFromAssetOrGitLocal(String filePath) async {
    return await rootBundle.loadString(filePath);
  }

  // Load AllahNames from json path assets/jsons/AllahNames.json
  try {
    print("Loading AllahNames from assets/jsons/AllahNames.json...");
    final namesJsonString =
        await loadJsonFromAssetOrGitLocal('assets/jsons/AllahNames.json');
    final decodedNames = json.decode(namesJsonString);

    if (decodedNames is List) {
      final List<AllahNameStruct> parsedNames = decodedNames.map((item) {
        final map = Map<String, dynamic>.from(item);
        return AllahNameStruct(
          number: castToType<int>(map['Number']),
          arabic: map['Arabic'] as String?,
          transliteration: map['Transliteration'] as String?,
          swedishTranslation: map['Swedish Translation'] as String? ??
              map['SwedishTranslation'] as String?,
          swedishExplanation: map['Swedish Explanation'] as String? ??
              map['SwedishExplanation'] as String?,
          arabicExplanation: map['Arabic Explanation'] as String? ??
              map['ArabicExplanation'] as String?,
          arabicAudioUrl: map['ArabicAudioUrl'] as String?,
          swedishAudioUrl: map['SwedishAudioUrl'] as String?,
        );
      }).toList();
      FFAppState().update(() {
        FFAppState().AllahNames = parsedNames;
      });
      print(
          "Successfully loaded ${parsedNames.length} names into App State AllahNames.");
    } else {
      print(
          "Warning: AllahNames JSON is not a List. Decoded type: ${decodedNames.runtimeType}");
    }
  } catch (e) {
    print("Error loading AllahNames: $e");
  }

  // Load Duas from json path assets/jsons/Dua_all.json
  try {
    print("Loading Duas from assets/jsons/Dua_all.json...");
    final duasJsonString =
        await loadJsonFromAssetOrGitLocal('assets/jsons/Dua_all.json');
    final decodedDuas = json.decode(duasJsonString);

    if (decodedDuas is List) {
      final List<DuaStruct> parsedDuas = decodedDuas.map((item) {
        return DuaStruct.fromMap(Map<String, dynamic>.from(item));
      }).toList();
      FFAppState().update(() {
        FFAppState().duaList = parsedDuas;
      });
      print(
          "Successfully loaded ${parsedDuas.length} categories into App State duaList.");
    } else {
      print(
          "Warning: Duas JSON is not a List. Decoded type: ${decodedDuas.runtimeType}");
    }
  } catch (e) {
    print("Error loading Duas: $e");
  }

  // Load Morning Adhkar from json path assets/jsons/Morning_Adhkar.json
  try {
    print("Loading Morning Adhkar from assets/jsons/Morning_Adhkar.json...");
    final morningJsonString =
        await loadJsonFromAssetOrGitLocal('assets/jsons/Morning_Adhkar.json');
    final decodedMorning = json.decode(morningJsonString);

    if (decodedMorning is List) {
      final List<AdhkarStruct> parsedMorning = decodedMorning.map((item) {
        return AdhkarStruct.fromMap(Map<String, dynamic>.from(item));
      }).toList();
      FFAppState().update(() {
        FFAppState().morningAdhkar = parsedMorning;
      });
      print(
          "Successfully loaded ${parsedMorning.length} items into App State morningAdhkar.");
    } else {
      print(
          "Warning: Morning Adhkar JSON is not a List. Decoded type: ${decodedMorning.runtimeType}");
    }
  } catch (e) {
    print("Error loading Morning Adhkar: $e");
  }

  // Load Evening Adhkar from json path assets/jsons/Evening_Adhkar.json
  try {
    print("Loading Evening Adhkar from assets/jsons/Evening_Adhkar.json...");
    final eveningJsonString =
        await loadJsonFromAssetOrGitLocal('assets/jsons/Evening_Adhkar.json');
    final decodedEvening = json.decode(eveningJsonString);

    if (decodedEvening is List) {
      final List<AdhkarStruct> parsedEvening = decodedEvening.map((item) {
        return AdhkarStruct.fromMap(Map<String, dynamic>.from(item));
      }).toList();
      FFAppState().update(() {
        FFAppState().eveningAdhkar = parsedEvening;
      });
      print(
          "Successfully loaded ${parsedEvening.length} items into App State eveningAdhkar.");
    } else {
      print(
          "Warning: Evening Adhkar JSON is not a List. Decoded type: ${decodedEvening.runtimeType}");
    }
  } catch (e) {
    print("Error loading Evening Adhkar: $e");
  }

  // Load Tasbih from json path assets/jsons/Tasbih.json
  try {
    print("Loading Tasbih from assets/jsons/Tasbih.json...");
    final tasbihJsonString =
        await loadJsonFromAssetOrGitLocal('assets/jsons/Tasbih.json');
    final decodedTasbih = json.decode(tasbihJsonString);

    if (decodedTasbih is List) {
      final List<TasbihStruct> parsedTasbih = decodedTasbih.map((item) {
        return TasbihStruct.fromMap(Map<String, dynamic>.from(item));
      }).toList();
      FFAppState().update(() {
        FFAppState().tasbihList = parsedTasbih;
      });
      print(
          "Successfully loaded ${parsedTasbih.length} items into App State tasbihList.");
    } else {
      print(
          "Warning: Tasbih JSON is not a List. Decoded type: ${decodedTasbih.runtimeType}");
    }
  } catch (e) {
    print("Error loading Tasbih: $e");
  }

  // Load Adhkar from json path assets/jsons/adhkar.json
  try {
    print("Loading Adhkar from assets/jsons/adhkar.json...");
    final adhkarJsonString =
        await loadJsonFromAssetOrGitLocal('assets/jsons/adhkar.json');
    final decodedAdhkar = json.decode(adhkarJsonString);

    if (decodedAdhkar is List) {
      final List<AdhkarStruct> parsedAdhkar = decodedAdhkar.map((item) {
        final map = Map<String, dynamic>.from(item);
        if (map.containsKey('count') && !map.containsKey('counter')) {
          map['counter'] = map['count'];
        }
        return AdhkarStruct.fromMap(map);
      }).toList();
      FFAppState().update(() {
        FFAppState().azkhar = parsedAdhkar;
      });
      print(
          "Successfully loaded ${parsedAdhkar.length} items into App State azkhar.");
    } else {
      print(
          "Warning: Adhkar JSON is not a List. Decoded type: ${decodedAdhkar.runtimeType}");
    }
  } catch (e) {
    print("Error loading Adhkar: $e");
  }
}
