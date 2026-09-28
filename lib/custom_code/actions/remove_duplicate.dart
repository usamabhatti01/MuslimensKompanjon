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

Future removeDuplicate(
  List<HistoryStruct> history,
  String checkValue,
) async {
  if (checkValue.trim().isEmpty) {
    return;
  }

  final cityToAdd = checkValue.trim();

  // 1. Remove any existing entry matching checkValue (case-insensitive)
  final currentList = FFAppState().userFvtCities.toList();
  for (int i = currentList.length - 1; i >= 0; i--) {
    if (currentList[i].cityName.trim().toLowerCase() ==
        cityToAdd.toLowerCase()) {
      FFAppState().removeAtIndexFromUserFvtCities(i);
    }
  }

  // 2. Deduplicate any other existing duplicates in userFvtCities
  final seen = <String>{};
  final cleanedList = FFAppState().userFvtCities.toList();
  for (int i = cleanedList.length - 1; i >= 0; i--) {
    final name = cleanedList[i].cityName.trim().toLowerCase();
    if (seen.contains(name)) {
      FFAppState().removeAtIndexFromUserFvtCities(i);
    } else {
      seen.add(name);
    }
  }

  // 3. Add new entry at top with latest timestamp ID
  final nextId = DateTime.now().millisecondsSinceEpoch;
  FFAppState().addToUserFvtCities(HistoryStruct(
    cityName: cityToAdd,
    id: nextId,
  ));

  // 4. If length > 5, remove the oldest entries
  while (FFAppState().userFvtCities.length > 6) {
    final oldest = FFAppState()
        .userFvtCities
        .reduce((curr, next) => curr.id < next.id ? curr : next);
    FFAppState().removeFromUserFvtCities(oldest);
  }
}
