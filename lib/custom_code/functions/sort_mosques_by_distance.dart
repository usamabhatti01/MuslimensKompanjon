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
import '/flutter_flow/ff_builtin_enums.dart';

List<MosqueStruct> sortMosquesByDistance(
  List<MosqueStruct>? mosques,
  LatLng? userLocation,
) {
  if (mosques == null || mosques.isEmpty) {
    return [];
  }
  final list = List<MosqueStruct>.from(mosques);
  if (userLocation == null ||
      (userLocation.latitude == 0 && userLocation.longitude == 0)) {
    return list;
  }

  const double p = 0.017453292519943295; // math.pi / 180
  final double uLat = userLocation.latitude;
  final double uLon = userLocation.longitude;

  list.sort((a, b) {
    if (a.latitude == null) return 1;
    if (b.latitude == null) return -1;

    final double lat1 = a.latitude!.latitude;
    final double lon1 = a.latitude!.longitude;
    final double distA = 0.5 -
        math.cos((lat1 - uLat) * p) / 2 +
        math.cos(uLat * p) *
            math.cos(lat1 * p) *
            (1 - math.cos((lon1 - uLon) * p)) /
            2;

    final double lat2 = b.latitude!.latitude;
    final double lon2 = b.latitude!.longitude;
    final double distB = 0.5 -
        math.cos((lat2 - uLat) * p) / 2 +
        math.cos(uLat * p) *
            math.cos(lat2 * p) *
            (1 - math.cos((lon2 - uLon) * p)) /
            2;

    return distA.compareTo(distB);
  });

  return list;
}
