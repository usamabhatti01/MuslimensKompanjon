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

// i want to make search engine in which user send list of all data and search value this action check the value match and return if not match reurn alll videos else only matched adn return
Future<List<YoutubeStruct>?> searchReels(
  List<YoutubeStruct> searchList,
  String searchValue,
) async {
  if (searchValue.isEmpty || searchValue.trim().isEmpty) {
    return searchList;
  }

  final String lowerCaseSearchValue = searchValue.toLowerCase().trim();

  final List<YoutubeStruct> matchedResults =
      searchList.where((YoutubeStruct reel) {
    final String title = (reel.title ?? '').toLowerCase();
    final String topic = (reel.topic ?? '').toLowerCase();
    final String video = (reel.video ?? '').toLowerCase();

    return title.contains(lowerCaseSearchValue) ||
        topic.contains(lowerCaseSearchValue) ||
        video.contains(lowerCaseSearchValue);
  }).toList();

  if (matchedResults.isEmpty) {
    return [];
  }

  return matchedResults;
}
