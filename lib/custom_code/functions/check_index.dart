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

int checkIndex(
  int var1,
  String math,
  int length,
) {
  print(var1);

  if (math == "sub") {
    print("sub");
    return var1 > 0 ? var1 - 1 : 0;
  } else {
    print("add");
    return var1 < length - 1 ? var1 + 1 : length - 1;
  }
}
