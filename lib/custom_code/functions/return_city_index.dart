import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';

int returnCityIndex(
  List<CityRecordStruct> cityList,
  String matchValue,
) {
  // compare match value with city in the list of city and return its index
  for (int i = 0; i < cityList.length; i++) {
    if (cityList[i].name == matchValue) {
      return i; // Return the index if a match is found
    }
  }
  return -1; // Return -1 if no match is found
}
