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
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// =========================================================================
// TRANSLATION STRINGS: Customize headers & month abbreviations here
// =========================================================================
class PrayerTableStrings {
  static const Map<String, Map<String, String>> values = {
    // English Translations
    'en': {
      'day':
          'Dag', // Header name for Day (Follow Swedish/Mockup standard as base)
      'fajr': 'Fajr',
      'shuroq': 'Shuroq',
      'dhohr': 'Dhohr',
      'asr': 'Asr',
      'magrib': 'Maghrib',
      'isha': 'Isha',
    },
    // Swedish Translations
    'sv': {
      'day': 'Dag',
      'fajr': 'Fajr',
      'shuroq': 'Shuroq',
      'dhohr': 'Dhohr',
      'asr': 'Asr',
      'magrib': 'Maghrib',
      'isha': 'Isha',
    },
  };
  // Month labels shown in the horizontal scroller
  static const Map<String, List<String>> monthLabels = {
    'en': [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ],
    'sv': [
      'Jan',
      'Feb',
      'Mars',
      'Apr',
      'Maj',
      'Jun',
      'Juli',
      'Aug',
      'Sep',
      'Okt',
      'Nov',
      'Dec'
    ],
  };
}

class PrayerMonthTable extends StatefulWidget {
  const PrayerMonthTable({
    super.key,
    this.width,
    this.height,
    required this.cityName,
    this.year,
  });
  final double? width;
  final double? height;
  final String cityName;
  final int? year;
  @override
  State<PrayerMonthTable> createState() => _PrayerMonthTableState();
}

class _PrayerMonthTableState extends State<PrayerMonthTable> {
  // =========================================================================
  // CUSTOMIZABLE DESIGN PARAMETERS: Change header/body cell sizes & padding here
  // =========================================================================
  final double headerFontSize = 12.0; // Font size of header cells
  final double headerVerticalPadding =
      6.0; //// Height/padding of the header row cells
  final double headerRowContainerPadding =
      2.0; // Extra container padding for header row
  final double bodyCellFontSize = 12.0; // Font size of regular body cells
  final double bodyRowVerticalPadding =
      8.0; // Height/padding of regular row cells
  List<Map<String, dynamic>> prayerTimes = [];
  bool isLoading = true;
  late int selectedMonth;
  late int selectedYear;
  late ScrollController _monthScrollController;
  @override
  void initState() {
    super.initState();
    _monthScrollController = ScrollController();
    final now = DateTime.now();
    // Start with the current calendar month
    selectedMonth = now.month;
    selectedYear = widget.year ?? now.year;
    loadPrayerTimes();
    // Scroll to center the active month in the horizontal selector on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActiveMonth();
    });
  }

  @override
  void didUpdateWidget(covariant PrayerMonthTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool needReload = false;
    // Reload if city changed
    if (oldWidget.cityName != widget.cityName) {
      needReload = true;
    }
    // Reload if year changed
    if (oldWidget.year != widget.year && widget.year != null) {
      selectedYear = widget.year!;
      needReload = true;
    }
    if (needReload) {
      setState(() {
        isLoading = true;
        prayerTimes = [];
      });
      loadPrayerTimes();
      _scrollToActiveMonth();
    }
  }

  @override
  void dispose() {
    _monthScrollController.dispose();
    super.dispose();
  }

  // =========================================================================
  // SCROLLER POSITIONING: Adjust scrolling math if month pill widths change
  // =========================================================================
  void _scrollToActiveMonth() {
    if (!_monthScrollController.hasClients) return;

    // Width of one month pill including margins (item width is ~75 + 10 margin = 85)
    final double itemWidth = 85.0;

    // Target offset calculation to align the active month in the center
    final double targetOffset = (selectedMonth - 1) * itemWidth - 100.0;

    _monthScrollController.animateTo(
      math.max(0.0, targetOffset),
      duration:
          const Duration(milliseconds: 300), // Change scroll duration here
      curve: Curves.easeOut, // Change scroll animation type here
    );
  }

  // Helper method to detect language code from FlutterFlow and return translations
  String _translate(String key) {
    String lang = 'en';
    try {
      if (mounted) {
        lang = FFLocalizations.of(context).languageCode;
      }
    } catch (_) {}
    if (lang.startsWith('sv')) {
      lang = 'sv';
    } else {
      lang = 'en';
    }
    final translationMap =
        PrayerTableStrings.values[lang] ?? PrayerTableStrings.values['en']!;
    return translationMap[key] ?? key;
  }

  // =========================================================================
  // PARSING JSON DATA: Loads local JSON file based on city & year
  // =========================================================================
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
          // Only show times matching selected month & selected year
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
          debugPrint('❌ Parse item error: $e');
        }
      });
      // Sort chronological by date
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
      debugPrint('❌ Error loading prayer times: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Check if dates match the device's system time (current date)
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  // =========================================================================
  // CELL STYLING: Modify fonts, weight, and color of cells inside columns
  // =========================================================================
  // Builds a flex-based cell that expands proportionally inside a Row.
  // [flex] controls the relative width (Day col uses 2, prayer cols use 3).
  Widget buildCell(
    String text, {
    bool highlighted = false,
    bool isHeader = false,
    int flex = 3, // Relative width weight (Day col = 2, prayer cols = 3)
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: isHeader ? headerVerticalPadding : bodyRowVerticalPadding,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isHeader ? headerFontSize : bodyCellFontSize,
            fontWeight: isHeader
                ? FontWeight.w600
                : highlighted
                    ? FontWeight.w600
                    : FontWeight.w400,
            color: isHeader
                ? const Color(0xFF0B7A12)
                : highlighted
                    ? Colors.black
                    : Colors.black87,
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // MONTH SCROLLER WIDGET: Edit the horizontal selector pills styling here
  // =========================================================================
  Widget _buildMonthScroller() {
    String lang = 'en';
    try {
      if (mounted) {
        lang = FFLocalizations.of(context).languageCode;
      }
    } catch (_) {}
    if (lang.startsWith('sv')) {
      lang = 'sv';
    } else {
      lang = 'en';
    }
    final labels = PrayerTableStrings.monthLabels[lang] ??
        PrayerTableStrings.monthLabels['en']!;
    return SizedBox(
      height: 48, // Month bar height
      child: ListView.builder(
        controller: _monthScrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final monthNum = index + 1;
          final isSelected = selectedMonth == monthNum;
          final label = labels[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedMonth = monthNum;
                isLoading = true; // Shows progress indicator while reloading
              });
              loadPrayerTimes();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 6), // spacing between month pills
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 6), // internal margins of pill
              decoration: BoxDecoration(
                // Color mapping: Active/Selected pill vs Inactive pill background
                color: isSelected
                    ? const Color(
                        0xFF0B7A12) // Selected Month Background (Green)
                    : const Color(
                        0xFFF2F2F2), // Inactive Month Background (Light Grey)
                borderRadius: BorderRadius.circular(
                    30), // Rounded corners (make it pill-shaped)
              ),
              child: Center(
                child: Text(
                  label.toLowerCase(), // Converts month labels to lowercase
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    // Color mapping: Active/Selected pill vs Inactive pill font color
                    color: isSelected
                        ? Colors.white // Active month text (White)
                        : Colors.black54, // Inactive month text (Grey)
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // =========================================================================
  // MAIN BUILDER: Modifies overall spacing, header, row styles, highlights
  // =========================================================================
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.white, // Table background color
      child: Column(
        children: [
          // 1. Month Selector scroller
          _buildMonthScroller(),
          const SizedBox(height: 10), // Spacing between month selector & header
          // 2. Table Header Container
          Container(
            padding: EdgeInsets.symmetric(
              vertical:
                  headerRowContainerPadding, // Customizable extra container padding
              horizontal: 8, // //
            ),
            decoration: BoxDecoration(
              color:
                  const Color(0xFFEAF5EA), // Header Row Background (Mint Green)
              borderRadius:
                  BorderRadius.circular(6), // Rounded corners of header row
            ),
            child: Row(
              children: [
                buildCell(
                  _translate('day'),
                  flex: 2, // Day column is narrower
                  isHeader: true,
                ),
                buildCell(
                  _translate('fajr'),
                  isHeader: true,
                ),
                buildCell(
                  _translate('shuroq'),
                  isHeader: true,
                ),
                buildCell(
                  _translate('dhohr'),
                  isHeader: true,
                ),
                buildCell(
                  _translate('asr'),
                  isHeader: true,
                ),
                buildCell(
                  _translate('magrib'),
                  isHeader: true,
                ),
                buildCell(
                  _translate('isha'),
                  isHeader: true,
                ),
              ],
            ),
          ),
          const SizedBox(
              height: 10), // Spacing between Header row & first data row
          // 3. Grid list showing monthly prayer times
          Expanded(
            child: isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(), // Loading spinner color/styles
                  )
                : ListView.builder(
                    itemCount: prayerTimes.length,
                    itemBuilder: (context, index) {
                      final item = prayerTimes[index];
                      final date = item['date'] as DateTime;
                      final highlighted = isToday(date);
                      final isEven = index % 2 == 0;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 1), // Spacing between table rows
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          // Row color logic: highlighted today vs alternating zebra stripes (even/odd)
                          color: highlighted
                              ? const Color(
                                  0xFFFFB547) // Background for today (Gold/Yellow)
                              : (isEven
                                  ? const Color(
                                      0xFFF9F9F9) // Even index row color (Very Light Grey)
                                  : Colors
                                      .white), // Odd index row color (White)
                          borderRadius: BorderRadius.circular(
                              4), // Subtle rounded corners on rows
                        ),
                        child: Row(
                          children: [
                            buildCell(
                              date.day.toString(),
                              flex: 2, // Day column is narrower
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
} // // //
