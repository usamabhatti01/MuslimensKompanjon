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

Future<void> loadAzkhar() async {
  print("🚀 loadAzkharFromGit started");

  // Skip loading if data is already present in AppState
  // if (FFAppState().adhkar.isNotEmpty &&
  //     FFAppState().AllahNames.isNotEmpty &&
  //     FFAppState().duaList.isNotEmpty &&
  //     FFAppState().tasbihList.isNotEmpty) {
  //   print("⚡ Data already loaded in AppState. Skipping reload.");
  //   return;
  // }

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

  // Load Duas from json path assets/jsons/Dua.json
  try {
    print("Loading Duas from assets/jsons/Dua.json...");
    final duasJsonString =
        await loadJsonFromAssetOrGitLocal('assets/jsons/dua.json');
    final decodedDuas = json.decode(duasJsonString);

    if (decodedDuas is List) {
      final List<DuaStruct> parsedDuas = decodedDuas.map((item) {
        final map = Map<String, dynamic>.from(item);
        final rawDuas = map['duas'] ?? map['dua'];
        List<DuaChildStruct> childDuas = [];

        if (rawDuas is List) {
          childDuas = rawDuas.map((d) {
            final dMap = Map<String, dynamic>.from(d);
            int? parseChildId(dynamic val) {
              if (val is num) return val.toInt();
              if (val is String) return int.tryParse(val);
              return null;
            }

            return DuaChildStruct(
              id: parseChildId(dMap['id']),
              titleAr:
                  dMap['title_ar']?.toString() ?? dMap['titleAr']?.toString(),
              arabic: dMap['arabic']?.toString(),
              translitterering: dMap['translitterering']?.toString() ??
                  dMap['transliteration']?.toString(),
              titleSv:
                  dMap['title_sv']?.toString() ?? dMap['titleSv']?.toString(),
              swedish: dMap['swedish']?.toString(),
              source: dMap['source']?.toString(),
              status: dMap['status']?.toString(),
            );
          }).toList();
        }

        int? parseCategoryId(dynamic val) {
          if (val is num) return val.toInt();
          if (val is String) return int.tryParse(val);
          return null;
        }

        return DuaStruct(
          categoryId: parseCategoryId(map['category_id'] ?? map['categoryId']),
          categoryTitleAr: map['categoryTitleAr']?.toString() ??
              map['category_title_ar']?.toString() ??
              map['categoryTitleSv']?.toString() ??
              '',
          categoryTitleSv: map['categoryTitleSv']?.toString() ??
              map['category_title_sv']?.toString() ??
              '',
          duas: childDuas,
          icon: map['icon']?.toString() ?? '',
          subtitle: map['subtitle']?.toString() ?? map['sub']?.toString() ?? '',
        );
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

  // Load Adhkar from json path assets/jsons/adhkar.json
  try {
    print("Loading Adhkar from assets/jsons/adhkar.json...");
    final adhkarJsonString =
        await loadJsonFromAssetOrGitLocal('assets/jsons/adhkar.json');
    final decodedAdhkar = json.decode(adhkarJsonString);

    if (decodedAdhkar is List) {
      final List<AdhkarStruct> parsedAdhkar = decodedAdhkar.map((item) {
        final map = Map<String, dynamic>.from(item);

        int parseId(dynamic val) {
          if (val is num) return val.toInt();
          if (val is String) return int.tryParse(val) ?? 0;
          return 0;
        }

        int parseCount(dynamic val) {
          if (val is num) return val.toInt();
          if (val is String) return int.tryParse(val) ?? 1;
          return 1;
        }

        final rawId = map['id'];
        final rawCount = map['count'] ?? map['counter'];

        map['id'] = parseId(rawId);
        map['counter'] = parseCount(rawCount);
        map['morning'] = map['morning'] == true;
        map['evening'] = map['evening'] == true;
        map['arabic'] = map['arabic']?.toString() ?? '';
        map['swedish'] = map['swedish']?.toString() ?? '';
        map['translitterering'] = map['translitterering']?.toString() ?? '';
        map['audio'] = map['audio']?.toString() ?? '';

        return AdhkarStruct.fromMap(map);
      }).toList();

      final List<AdhkarStruct> parsedMorning =
          parsedAdhkar.where((item) => item.morning).toList();
      final List<AdhkarStruct> parsedEvening =
          parsedAdhkar.where((item) => item.evening).toList();

      FFAppState().update(() {
        FFAppState().adhkar = parsedAdhkar;
      });
      print(
          "Successfully loaded ${parsedAdhkar.length} items into App State azkhar (${parsedMorning.length} morning, ${parsedEvening.length} evening).");

      // Pre-download audio files in background for offline use
      downloadAllAdhkarAudio(parsedAdhkar);
    } else {
      print(
          "Warning: Adhkar JSON is not a List. Decoded type: ${decodedAdhkar.runtimeType}");
    }
  } catch (e) {
    print("Error loading Adhkar: $e");
  }

  // Load Tasbih from json path assets/jsons/Tasbih.json
  try {
    print("Loading Tasbih from assets/jsons/Tasbih.json...");
    final tasbihJsonString =
        await loadJsonFromAssetOrGitLocal('assets/jsons/tasbih.json');
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
}

Future<void> downloadAllAdhkarAudio(List<AdhkarStruct> adhkarList) async {
  try {
    final docsDir = await getApplicationDocumentsDirectory();
    final audioDir = Directory('${docsDir.path}/adhkar_audio');
    if (!await audioDir.exists()) {
      await audioDir.create(recursive: true);
    }

    for (final item in adhkarList) {
      final audioUrl = item.audio.trim();
      if (audioUrl.startsWith('http://') || audioUrl.startsWith('https://')) {
        final fileName = audioUrl.split('/').last;
        final localFile = File('${audioDir.path}/$fileName');

        if (!await localFile.exists() || (await localFile.length()) == 0) {
          try {
            print("Downloading Adhkar audio: $fileName...");
            final response = await http.get(Uri.parse(audioUrl));
            if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
              await localFile.writeAsBytes(response.bodyBytes);
              print("Saved audio file locally: $fileName");
            }
          } catch (e) {
            print("Error downloading $fileName: $e");
          }
        }
      }
    }
  } catch (e) {
    print("Error in downloadAllAdhkarAudio: $e");
  }
}
