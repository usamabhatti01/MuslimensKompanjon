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

// Begin custom widget coded

import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PrayerMonthTable extends StatefulWidget {
  const PrayerMonthTable({
    super.key,
    this.width,
    this.height,
    required this.cityName,
    this.month,
    this.year,
  });

  final double? width;
  final double? height;
  final String cityName;
  final String? month;
  final int? year;

  @override
  State<PrayerMonthTable> createState() => _PrayerMonthTableState();
}

class _PrayerMonthTableState extends State<PrayerMonthTable> {
  @override
  List<Map<String, dynamic>> prayerTimes = [];

  bool isLoading = true;

  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    // ✅ current month fallback

    selectedMonth = parseMonthName(
          widget.month,
        ) ??
        now.month;
    print(widget.month);
    // ✅ current year fallback

    selectedYear = widget.year ?? now.year;

    loadPrayerTimes();
  }

  @override
  void didUpdateWidget(
    covariant PrayerMonthTable oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    final now = DateTime.now();

    selectedMonth = parseMonthName(
          widget.month,
        ) ??
        now.month;
    print(widget.month);

    selectedYear = widget.year ?? now.year;

    setState(() {
      isLoading = true;
      prayerTimes = [];
    });

    loadPrayerTimes();
  }
  // ✅ Convert month name → number

  int? parseMonthName(String? month) {
    if (month == null || month.trim().isEmpty) {
      return null;
    }

    final lower = month.trim().toLowerCase();

    const months = {
      'january': 1,
      'february': 2,
      'march': 3,
      'april': 4,
      'may': 5,
      'june': 6,
      'july': 7,
      'august': 8,
      'september': 9,
      'october': 10,
      'november': 11,
      'december': 12,
    };

    return months[lower];
  }

  static List<String>? _cachedAssets;

  // =====================================================
  // LOAD PRAYER DATA
  // =====================================================

  Future<void> loadPrayerTimes() async {
    try {
      final jsonString = await loadPrayerJson(
        widget.cityName,
        selectedYear,
      );

      final decoded = json.decode(jsonString);

      final prayerData = decoded['prayer_times'] as Map<String, dynamic>;

      final List<Map<String, dynamic>> loaded = [];

      prayerData.forEach((dateStr, data) {
        try {
          final date = DateTime.parse(dateStr);

          // ✅ filter selected month/year

          if (date.month != selectedMonth || date.year != selectedYear) {
            return;
          }

          loaded.add({
            'date': date,
            'fajr': data['fajr']?.toString() ?? '--:--',
            'shuruq': data['shuruq']?.toString() ?? '--:--',
            'dhuhr': data['dhuhr']?.toString() ?? '--:--',
            'asr': data['asr']?.toString() ?? '--:--',
            'maghrib': data['maghrib']?.toString() ?? '--:--',
            'isha': data['isha']?.toString() ?? '--:--',
          });
        } catch (e) {
          debugPrint(
            '❌ Parse item error: $e',
          );
        }
      });

      loaded.sort(
        (a, b) => (a['date'] as DateTime).compareTo(
          b['date'] as DateTime,
        ),
      );

      setState(() {
        prayerTimes = loaded;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(
        '❌ Error loading prayer times: $e',
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  // ✅ ACTIVE DAY HIGHLIGHT
  // only compares system day

  bool isToday(DateTime date) {
    final now = DateTime.now();

    return date.day == now.day;
  }

  Widget buildCell(
    String text, {
    bool highlighted = false,
    bool isHeader = false,
    double width = 55,
  }) {
    return Container(
      alignment: Alignment.center,
      width: width,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 14 : 12,
          fontWeight: isHeader
              ? FontWeight.w600
              : highlighted
                  ? FontWeight.w600
                  : FontWeight.w400,
          color: highlighted ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.white,
      child: Column(
        children: [
          // ✅ HEADER

          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              children: [
                buildCell(
                  'Day',
                  width: 30,
                  isHeader: true,
                ),
                buildCell(
                  'Fajr',
                  isHeader: true,
                ),
                buildCell(
                  'Shuroq',
                  isHeader: true,
                ),
                buildCell(
                  'Dhohr',
                  isHeader: true,
                ),
                buildCell(
                  'Asr',
                  isHeader: true,
                ),
                buildCell(
                  'Magrib',
                  isHeader: true,
                ),
                buildCell(
                  'Isha',
                  isHeader: true,
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: prayerTimes.length,
              itemBuilder: (context, index) {
                final item = prayerTimes[index];

                final date = item['date'] as DateTime;

                final highlighted = isToday(date);

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 10,
                    left: 0,
                    right: 0,
                  ),
                  decoration: BoxDecoration(
                    color: highlighted
                        ? const Color(
                            0xFFC9A227,
                          )
                        : const Color(
                            0xFFF2F2F2,
                          ),
                    borderRadius: BorderRadius.circular(
                      2,
                    ),
                  ),
                  child: Row(
                    children: [
                      buildCell(
                        date.day.toString(),
                        width: 30,
                        highlighted: highlighted,
                      ),
                      buildCell(
                        item['fajr'],
                        highlighted: highlighted,
                      ),
                      buildCell(
                        item['shuruq'],
                        highlighted: highlighted,
                      ),
                      buildCell(
                        item['dhuhr'],
                        highlighted: highlighted,
                      ),
                      buildCell(
                        item['asr'],
                        highlighted: highlighted,
                      ),
                      buildCell(
                        item['maghrib'],
                        highlighted: highlighted,
                      ),
                      buildCell(
                        item['isha'],
                        highlighted: highlighted,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
