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

String combineTextFormat(
  String arabic,
  String eng,
  String sw,
) {
  final combinedText = '''

العربية

${arabic.trim()}

English

${eng.trim()}

Svenska

${sw.trim()}

''';

  print(combinedText);

  return combinedText;
}
