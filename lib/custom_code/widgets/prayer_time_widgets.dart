// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
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
import 'package:flutter/services.dart';

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
  void didUpdateWidget(
    covariant PrayerTimeWidgets oldWidget,
  ) {
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

  // =====================================================
  // PRAYER ASSET RESOLVER
  // =====================================================

  // static List<String>? _cachedAssets;

  // static String toNfd(String input) {
  //   const decomposed = <String, String>{
  //     'å': 'a\u030A',
  //     'ä': 'a\u0308',
  //     'ö': 'o\u0308',
  //     'é': 'e\u0301',
  //     'è': 'e\u0300',
  //     'ü': 'u\u0308',
  //     'Å': 'A\u030A',
  //     'Ä': 'A\u0308',
  //     'Ö': 'O\u0308',
  //     'É': 'E\u0301',
  //   };

  //   var result = input;

  //   decomposed.forEach((composed, decomposed) {
  //     result = result.replaceAll(
  //       composed,
  //       decomposed,
  //     );
  //   });

  //   return result;
  // }

  // static bool _fileNamesMatch(
  //   String a,
  //   String b,
  // ) {
  //   final left = a.toLowerCase();
  //   final right = b.toLowerCase();

  //   if (left == right) return true;

  //   if (toNfd(left) == right) return true;

  //   if (left == toNfd(right)) return true;

  //   if (toNfd(left) == toNfd(right)) return true;

  //   return false;
  // }

  // static Future<List<String>> _allAssets() async {
  //   if (_cachedAssets != null) {
  //     return _cachedAssets!;
  //   }

  //   final manifest = await AssetManifest.loadFromAssetBundle(
  //     rootBundle,
  //   );

  //   _cachedAssets = manifest.listAssets();

  //   return _cachedAssets!;
  // }

  // static Future<String?> resolvePath(
  //   String cityName,
  //   int year,
  // ) async {
  //   final slug = cityName.trim().toLowerCase();

  //   final fileName = '${slug}_$year.json';

  //   final fileNameNfd = toNfd(fileName);

  //   final assets = await _allAssets();

  //   final directPaths = <String>[
  //     'assets/jsons/$year/$fileName',
  //     'assets/jsons/$year/$fileNameNfd',
  //     'assets/jsons/$fileName',
  //     'assets/jsons/$fileNameNfd',
  //   ];

  //   for (final path in directPaths) {
  //     if (assets.contains(path)) {
  //       return path;
  //     }
  //   }

  //   String? rootFallback;

  //   for (final asset in assets) {
  //     if (!asset.startsWith(
  //       'assets/jsons/',
  //     )) {
  //       continue;
  //     }

  //     if (!asset.endsWith(
  //       '_$year.json',
  //     )) {
  //       continue;
  //     }

  //     final base = asset.split('/').last;

  //     if (!_fileNamesMatch(
  //       base,
  //       fileName,
  //     )) {
  //       continue;
  //     }

  //     if (asset.contains('/$year/')) {
  //       return asset;
  //     }

  //     rootFallback ??= asset;
  //   }

  //   return rootFallback;
  // }

  // static Future<String> loadJsonString(
  //   String cityName,
  //   int year,
  // ) async {
  //   final path = await resolvePath(
  //     cityName,
  //     year,
  //   );

  //   if (path == null) {
  //     throw FlutterError(
  //       'No prayer JSON asset for '
  //       '"$cityName" ($year).',
  //     );
  //   }

  //   return rootBundle.loadString(path);
  // }
  // =====================================================
  // LOAD PRAYER DATA
  // =====================================================

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

      if (prayerData == null) {
        debugPrint(
          "No prayer data found",
        );
        return;
      }

      prayerTimes = {
        'Fajr': formatTime(
          prayerData['fajr'],
        ),
        'Shuruq': formatTime(
          prayerData['shuruq'],
        ),
        'Dhohr': formatTime(
          prayerData['dhuhr'],
        ),
        'Asr': formatTime(
          prayerData['asr'],
        ),
        'Maghrib': formatTime(
          prayerData['maghrib'],
        ),
        'Isha': formatTime(
          prayerData['isha'],
        ),
      };

      updatePrayerState();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint(
        "Error loading prayer data: $e",
      );
    }
  }

  String formatTime(dynamic time) {
    if (time == null) {
      return '--:--';
    }

    final parts = time.toString().split(':');

    return "${parts[0].padLeft(2, '0')}:"
        "${parts[1].padLeft(2, '0')}";
  }

  DateTime parsePrayerTime(
    String time,
  ) {
    final now = DateTime.now();

    final parts = time.split(':');

    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  void updatePrayerState() {
    if (prayerTimes.isEmpty) return;

    final now = DateTime.now();

    final entries = prayerTimes.entries.toList();

    DateTime? nextTime;

    String? nextName;

    String activePrayer = entries.first.key;

    for (final entry in entries) {
      final prayerTime = parsePrayerTime(
        entry.value,
      );

      if (now.isAfter(prayerTime)) {
        activePrayer = entry.key;
      }

      if (now.isBefore(prayerTime) && nextTime == null) {
        nextTime = prayerTime;
        nextName = entry.key;
      }
    }

    if (nextTime == null) {
      final fajr = parsePrayerTime(
        prayerTimes['Fajr']!,
      );

      nextTime = fajr.add(
        const Duration(days: 1),
      );

      nextName = 'Fajr';
    }

    if (!mounted) return;

    setState(() {
      currentPrayer = activePrayer;
      nextPrayer = nextName!;
      remaining = nextTime!.difference(now);
    });
  }

  String formatDuration(
    Duration duration,
  ) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);

    final minutes = twoDigits(
      duration.inMinutes.remainder(60),
    );

    final seconds = twoDigits(
      duration.inSeconds.remainder(60),
    );

    return "$hours:$minutes:$seconds";
  }

  Widget prayerItem(
    String title,
    String time,
  ) {
    final isActive = currentPrayer == title;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.green : Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
            children: [
              prayerItem(
                'Fajr',
                prayerTimes['Fajr']!,
              ),
              prayerItem(
                'Shuruq',
                prayerTimes['Shuruq']!,
              ),
              prayerItem(
                'Dhohr',
                prayerTimes['Dhohr']!,
              ),
              prayerItem(
                'Asr',
                prayerTimes['Asr']!,
              ),
              prayerItem(
                'Maghrib',
                prayerTimes['Maghrib']!,
              ),
              prayerItem(
                'Isha',
                prayerTimes['Isha']!,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            "Time left until "
            "$nextPrayer: "
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
