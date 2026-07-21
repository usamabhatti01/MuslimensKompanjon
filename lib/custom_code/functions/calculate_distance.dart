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

String calculateDistance(
  LatLng currentLocation,
  LatLng mapLocation,
) {
  const double p = 0.017453292519943295; // math.pi / 180
  final double lat1 = currentLocation.latitude;
  final double lon1 = currentLocation.longitude;
  final double lat2 = mapLocation.latitude;
  final double lon2 = mapLocation.longitude;

  final double a = 0.5 -
      math.cos((lat2 - lat1) * p) / 2 +
      math.cos(lat1 * p) *
          math.cos(lat2 * p) *
          (1 - math.cos((lon2 - lon1) * p)) /
          2;

  final double distanceInMeters = 12742000 * math.asin(math.sqrt(a));

  return distanceInMeters < 1000
      ? '${distanceInMeters.toStringAsFixed(0)} m'
      : '${(distanceInMeters / 1000).toStringAsFixed(2)} km';
}
