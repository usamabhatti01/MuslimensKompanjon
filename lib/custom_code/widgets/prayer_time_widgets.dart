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

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:timezone/data/latest.dart' as tz;

import 'package:timezone/timezone.dart' as tz;

// DO NOT REMOVE OR MODIFY THE CODE ABOVE

class PrayerWidgetStrings {
  static const Map<String, Map<String, String>> values = {
    'en': {
      'Fajr': 'Fajr',
      'Shuruq': 'Shuruq',
      'Dhuhr': 'Dhuhr',
      'Asr': 'Asr',
      'Maghrib': 'Maghrib',
      'Isha': 'Isha',
      'timeLeft': 'Time left until {nextPrayer}: {time}',
    },
    'sv': {
      'Fajr': 'Fajr',
      'Shuruq': 'Shuruq',
      'Dhuhr': 'Dhuhr',
      'Asr': 'Asr',
      'Maghrib': 'Maghrib',
      'Isha': 'Isha',
      'timeLeft': 'Tid kvar till {nextPrayer}: {time}',
    },
  };
}

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

  String timezone = '';

  String currentPrayer = '';

  String nextPrayer = '';

  tz.TZDateTime? nextPrayerTime;

  Timer? ticker;

  ValueNotifier<Duration> remaining = ValueNotifier(Duration.zero);

  final List<String> prayerOrder = const [
    'Fajr',
    'Shuruq',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];

  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();

    loadPrayerData();
  }

  @override
  void didUpdateWidget(covariant PrayerTimeWidgets oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.cityName != widget.cityName) {
      if (mounted) {
        setState(() {
          prayerTimes.clear();
        });
      }

      loadPrayerData();
    }
  }

  @override
  void dispose() {
    ticker?.cancel();

    remaining.dispose();

    super.dispose();
  }

  // =========================

  // LOAD DATA

  // =========================

  Future<void> loadPrayerData() async {
    try {
      final now = DateTime.now();

      final todayKey = "${now.year.toString().padLeft(4, '0')}-"
          "${now.month.toString().padLeft(2, '0')}-"
          "${now.day.toString().padLeft(2, '0')}";

      final jsonString = await loadPrayerJson(
        widget.cityName,
        now.year,
      );

      final decoded = json.decode(jsonString);

      final prayerData = decoded['prayer_times']?[todayKey];

      if (prayerData == null) return;

      // ✅ TAKE TIMEZONE FROM JSON (FIXED)

      final newTimezone = decoded['city']['timezone'];

      final newPrayerTimes = {
        'Fajr': _fmt(prayerData['fajr']),
        'Shuruq': _fmt(prayerData['shuruq']),
        'Dhuhr': _fmt(prayerData['dhuhr']),
        'Asr': _fmt(prayerData['asr']),
        'Maghrib': _fmt(prayerData['maghrib']),
        'Isha': _fmt(prayerData['isha']),
      };

      if (mounted) {
        setState(() {
          timezone = newTimezone;
          prayerTimes = newPrayerTimes;
          updatePrayerState();
        });
      }
    } catch (e) {
      debugPrint("Prayer load error: $e");
    }
  }

  String _fmt(dynamic t) {
    final parts = t.toString().split(':');

    return "${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}";
  }

  // =========================

  // TIMEZONE HELPERS

  // =========================

  tz.TZDateTime nowInCity() {
    final loc = tz.getLocation(timezone);

    return tz.TZDateTime.now(loc);
  }

  tz.TZDateTime parseTime(
    String time,
    tz.Location loc,
    tz.TZDateTime base,
  ) {
    final parts = time.split(':');

    return tz.TZDateTime(
      loc,
      base.year,
      base.month,
      base.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  // =========================

  // CORE LOGIC

  // =========================

  void updatePrayerState() {
    if (prayerTimes.isEmpty || timezone.isEmpty) return;

    final loc = tz.getLocation(timezone);

    final now = tz.TZDateTime.now(loc);

    tz.TZDateTime? next;

    String? nextName;

    String current = prayerOrder.first;

    for (final name in prayerOrder) {
      final t = prayerTimes[name];

      if (t == null) continue;

      final prayerTime = parseTime(t, loc, now);

      if (now.isAfter(prayerTime)) {
        current = name;
      } else if (next == null) {
        next = prayerTime;

        nextName = name;
      }
    }

    // rollover

    if (next == null) {
      next = parseTime(
        prayerTimes['Fajr']!,
        loc,
        now.add(const Duration(days: 1)),
      );

      nextName = 'Fajr';
    }

    currentPrayer = current;

    nextPrayer = nextName!;

    nextPrayerTime = next;

    startTicker();
  }

  // =========================

  // OPTIMIZED TIMER (ONLY COUNTDOWN)

  // =========================

  void startTicker() {
    ticker?.cancel();

    ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (nextPrayerTime == null || timezone.isEmpty) return;

      final loc = tz.getLocation(timezone);

      final now = tz.TZDateTime.now(loc);

      final diff = nextPrayerTime!.difference(now);

      remaining.value = diff.isNegative ? Duration.zero : diff;
    });
  }

  // =========================

  // UI HELPERS

  // =========================

  String formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');

    return "${two(d.inHours)}:"
        "${two(d.inMinutes.remainder(60))}:"
        "${two(d.inSeconds.remainder(60))}";
  }

  String _t(String key, {Map<String, String>? args}) {
    String lang = 'en';

    try {
      lang = FFLocalizations.of(context).languageCode;

      if (lang.startsWith('sv')) lang = 'sv';
    } catch (_) {}

    final map =
        PrayerWidgetStrings.values[lang] ?? PrayerWidgetStrings.values['en']!;

    String text = map[key] ?? key;

    args?.forEach((k, v) {
      text = text.replaceAll('{$k}', v);
    });

    return text;
  }

  Widget item(String title, String time) {
    final active = currentPrayer == title;

    return Expanded(
      child: Column(
        children: [
          Text(
            _t(title),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: active ? Colors.green : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: TextStyle(
              color: active ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // =========================

  // BUILD

  // =========================

  @override
  Widget build(BuildContext context) {
    if (prayerTimes.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              item('Fajr', prayerTimes['Fajr']!),
              item('Shuruq', prayerTimes['Shuruq']!),
              item('Dhuhr', prayerTimes['Dhuhr']!),
              item('Asr', prayerTimes['Asr']!),
              item('Maghrib', prayerTimes['Maghrib']!),
              item('Isha', prayerTimes['Isha']!),
            ],
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder<Duration>(
            valueListenable: remaining,
            builder: (context, value, _) {
              return Text(
                _t('timeLeft', args: {
                  'nextPrayer': _t(nextPrayer),
                  'time': formatDuration(value),
                }),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
