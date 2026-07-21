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

Future<List<MosqueStruct>?> searchCityByName(
  String searchValue,
  List<MosqueStruct> searchList,
) async {
  if (searchValue.trim().isEmpty) {
    return searchList;
  }

  final query = searchValue.trim().toLowerCase();

  return searchList.where((mosque) {
    return (mosque.name).toLowerCase().contains(query);
  }).toList();
}
