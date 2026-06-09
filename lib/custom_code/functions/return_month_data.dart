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

List<String> returnMonthData(DateTime currentMonth) {
  //   // i need a function that receive current month and return list of month date like this mon 7 apr
  print(currentMonth);
  List<String> monthData = [];
  int daysInMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;

  for (int day = 1; day <= daysInMonth; day++) {
    DateTime date = DateTime(currentMonth.year, currentMonth.month, day);
    String formattedDate = DateFormat('EEE d MMM').format(date);
    monthData.add(formattedDate);
  }
  return monthData;
}
