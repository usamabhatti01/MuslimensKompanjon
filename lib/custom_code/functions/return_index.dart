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

int returnIndex(
  int number,
  List<SurahsStruct> numberList,
) {
  // compare number with list of numberlist and return index
  for (int i = 0; i < numberList.length; i++) {
    if (numberList[i].number == number) {
      return i; // Return the index if the number matches
    }
  }
  return -1; // Return -1 if the number is not found
}
