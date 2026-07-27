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

/// i want to make search engine in which user send list of all data and
/// search value this action check the value match and return if not match
/// reurn alll videos else only matched adn return
Future<List<YoutubeStruct>?> searchReels(
  List<YoutubeStruct> searchList,
  String searchValue,
  String? order,
) async {
  List<YoutubeStruct> results = [];

  if (searchValue.isEmpty || searchValue.trim().isEmpty) {
    results = List<YoutubeStruct>.from(searchList);
  } else {
    final String lowerCaseSearchValue = searchValue.toLowerCase().trim();
    results = searchList.where((YoutubeStruct reel) {
      final String title = (reel.title ?? '').toLowerCase();
      final String topic = (reel.topic ?? '').toLowerCase();
      final String video = (reel.video ?? '').toLowerCase();

      return title.contains(lowerCaseSearchValue) ||
          topic.contains(lowerCaseSearchValue) ||
          video.contains(lowerCaseSearchValue);
    }).toList();
  }

  if (order != null && order.isNotEmpty) {
    if (order == 'Latest') {
      results.sort((a, b) {
        final DateTime? dateA = a.postDate;
        final DateTime? dateB = b.postDate;
        if (dateA == null && dateB == null) return 0;
        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateB.compareTo(dateA);
      });
    } else if (order == 'Old') {
      results.sort((a, b) {
        final DateTime? dateA = a.postDate;
        final DateTime? dateB = b.postDate;
        if (dateA == null && dateB == null) return 0;
        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateA.compareTo(dateB);
      });
    } else if (order == 'Popular') {
      double parseViews(String viewsStr) {
        final clean = viewsStr
            .toLowerCase()
            .replaceAll('visningar', '')
            .replaceAll(' ', '')
            .replaceAll(',', '.')
            .trim();
        if (clean.isEmpty) return 0.0;
        if (clean.endsWith('m')) {
          final numStr = clean.substring(0, clean.length - 1);
          final val = double.tryParse(numStr) ?? 0.0;
          return val * 1000000;
        } else if (clean.endsWith('k')) {
          final numStr = clean.substring(0, clean.length - 1);
          final val = double.tryParse(numStr) ?? 0.0;
          return val * 1000;
        } else {
          return double.tryParse(clean) ?? 0.0;
        }
      }

      results.sort((a, b) {
        final double viewsA = parseViews(a.views);
        final double viewsB = parseViews(b.views);
        return viewsB.compareTo(viewsA);
      });
    }
  }

  return results;
}
