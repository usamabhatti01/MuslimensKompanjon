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

List<AllahNameStruct> reverseGridList(List<AllahNameStruct> list) {
  final result = <AllahNameStruct>[];
  const columns = 3;
  for (var i = 0; i < list.length; i += columns) {
    final end = (i + columns < list.length) ? i + columns : list.length;
    final chunk = list.sublist(i, end);
    result.addAll(chunk.reversed);
  }
  return result;
}
