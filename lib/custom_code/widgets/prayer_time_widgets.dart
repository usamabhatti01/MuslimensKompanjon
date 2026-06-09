// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;

class PrayerTimeWidgets extends StatefulWidget {
  const PrayerTimeWidgets({
    super.key,
    this.width,
    this.height,
    required this.cityName,
  });

  final double? width;
  final double? height;
  final String cityName;

  @override
  State<PrayerTimeWidgets> createState() => _PrayerTimeWidgetsState();
}

class _PrayerTimeWidgetsState extends State<PrayerTimeWidgets> {
  Map<String, String> prayerTimes = {};

  String currentPrayer = '';
  String nextPrayer = '';
  Duration remaining = Duration.zero;

  Timer? timer;

  tz.Location? cityLocation;

  final List<String> prayerOrder = const [
    'Fajr',
    'Shuruq',
    'Dhohr',
    'Asr',
    'Maghrib',
    'Isha',
  ];

  @override
  void initState() {
    super.initState();
    loadPrayerData();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => updatePrayerState(),
    );
  }

  @override
  void didUpdateWidget(covariant PrayerTimeWidgets oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.cityName != widget.cityName) {
      prayerTimes.clear();
      currentPrayer = '';
      nextPrayer = '';
      remaining = Duration.zero;

      loadPrayerData();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // ================= ONLY CITY TIME =================

  tz.TZDateTime nowCity() {
    return tz.TZDateTime.now(cityLocation!);
  }

  // ================= LOAD DATA =================

  Future<void> loadPrayerData() async {
    try {
      final jsonString = await loadPrayerJson(
        widget.cityName,
        DateTime.now().year,
      );

      final decoded = json.decode(jsonString);

      final timeZoneName = decoded['city']?['timezone'] ?? 'UTC';

      cityLocation = tz.getLocation(timeZoneName);

      final now = nowCity();

      final todayKey = "${now.year.toString().padLeft(4, '0')}-"
          "${now.month.toString().padLeft(2, '0')}-"
          "${now.day.toString().padLeft(2, '0')}";

      final prayerData = decoded['prayer_times']?[todayKey];

      if (prayerData == null) {
        debugPrint("No prayer data for $todayKey");
        return;
      }

      prayerTimes = {
        'Fajr': _format(prayerData['fajr']),
        'Shuruq': _format(prayerData['shuruq']),
        'Dhohr': _format(prayerData['dhuhr']),
        'Asr': _format(prayerData['asr']),
        'Maghrib': _format(prayerData['maghrib']),
        'Isha': _format(prayerData['isha']),
      };

      updatePrayerState();

      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  String _format(dynamic t) {
    final parts = t.toString().split(':');
    return "${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}";
  }

  // ================= PRAYER TIME =================

  tz.TZDateTime _toTime(String time) {
    final now = nowCity();
    final parts = time.split(':');

    return tz.TZDateTime(
      cityLocation!,
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  // ================= CORE LOGIC =================

  void updatePrayerState() {
    if (prayerTimes.isEmpty || cityLocation == null) return;

    final now = nowCity();

    String active = prayerOrder.first;
    tz.TZDateTime? nextTime;
    String? nextName;

    for (final prayer in prayerOrder) {
      final time = _toTime(prayerTimes[prayer]!);

      if (now.isAfter(time)) {
        active = prayer;
      } else if (nextTime == null) {
        nextTime = time;
        nextName = prayer;
      }
    }

    // rollover to next day
    if (nextTime == null) {
      final fajr = _toTime(prayerTimes['Fajr']!);
      nextTime = fajr.add(const Duration(days: 1));
      nextName = 'Fajr';
    }

    if (!mounted) return;

    setState(() {
      currentPrayer = active;
      nextPrayer = nextName!;
      remaining = nextTime!.difference(now);
    });
  }

  // ================= UI =================

  String formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');

    return "${two(d.inHours)}:"
        "${two(d.inMinutes.remainder(60))}:"
        "${two(d.inSeconds.remainder(60))}";
  }

  Widget prayerItem(String title, String time) {
    final isActive = currentPrayer == title;

    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.green : Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            time,
            style: TextStyle(
              color: isActive ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (prayerTimes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children:
                prayerOrder.map((p) => prayerItem(p, prayerTimes[p]!)).toList(),
          ),
          const SizedBox(height: 18),
          Text(
            "Time left until $nextPrayer: "
            "${formatDuration(remaining)}",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
