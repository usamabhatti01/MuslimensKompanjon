import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
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

String datetimeToMonth(DateTime month) {
  // convert curnet time to month name
  return DateFormat('MMMM').format(month); // Returns the full month name
}

int datetimeToYear(DateTime year) {
  // convert datetime to year like 2025
  return year.year;
}

String formatTime(DateTime time) {
  if (time == null) return '--:--';
  return DateFormat('HH:mm').format(time);
}

List<String> returnMonthName() {
  // return Month full Name
  return [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}
