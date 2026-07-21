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

class _PrayerMonthTableState extends State<PrayerMonthTable>
    with WidgetsBindingObserver {
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
  bool _scrolledToSelectedMonth = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _monthScrollController = ScrollController();
    final now = DateTime.now();
    // Start with the current calendar month
    selectedMonth = now.month;
    selectedYear = widget.year ?? now.year;
    loadPrayerTimes();
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
      _scrolledToSelectedMonth = false;
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
    WidgetsBinding.instance.removeObserver(this);
    _monthScrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(
          () {}); // Re-evaluates isToday(date) highlights for the current calendar day
    }
  }

  // =========================================================================
  // SCROLLER POSITIONING: Adjust scrolling math to center active month pill
  // =========================================================================
  void _scrollToActiveMonth([double? viewportWidth]) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_monthScrollController.hasClients) return;

      final double width = viewportWidth ??
          (_monthScrollController.position.viewportDimension > 0
              ? _monthScrollController.position.viewportDimension
              : (widget.width ?? MediaQuery.sizeOf(context).width));

      final double itemWidth = 78.0; // width (70) + horizontal margins (4 * 2)
      final double itemCenter =
          (selectedMonth - 1) * itemWidth + (itemWidth / 2);
      final double targetOffset = itemCenter - (width / 2);
      final double maxScroll = _monthScrollController.position.maxScrollExtent;

      _monthScrollController.animateTo(
        targetOffset.clamp(0.0, maxScroll > 0 ? maxScroll : 0.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
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
    int flex = 3,
  }) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color textColor;
    if (isHeader) {
      textColor = theme.primary;
    } else if (highlighted) {
      textColor = Colors.white;
    } else {
      textColor = isDark ? Colors.white : const Color(0xFF1D1D1F);
    }

    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: isHeader ? headerVerticalPadding : bodyRowVerticalPadding,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              fontSize: isHeader ? headerFontSize : bodyCellFontSize,
              fontWeight: isHeader
                  ? FontWeight.w600
                  : highlighted
                      ? FontWeight.w700
                      : FontWeight.w600,
              color: textColor,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // MONTH SCROLLER WIDGET: Horizontal month selector pills styling
  // =========================================================================
  Widget _buildMonthScroller() {
    final theme = FlutterFlowTheme.of(context);
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
      height: 36, // Compact month bar height
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double viewportWidth = constraints.maxWidth;
          if (viewportWidth > 0 && !_scrolledToSelectedMonth) {
            _scrolledToSelectedMonth = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToActiveMonth(viewportWidth);
            });
          }

          return ListView.builder(
            controller: _monthScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: 12,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, index) {
              final monthNum = index + 1;
              final isSelected = selectedMonth == monthNum;
              final label = labels[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMonth = monthNum;
                    isLoading = true;
                  });
                  _scrollToActiveMonth(viewportWidth);
                  loadPrayerTimes();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 70.0,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? theme.primary : theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      label.toLowerCase(),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : theme.secondaryText,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // =========================================================================
  // MAIN BUILDER: Compact single-screen width layout with zebra striping
  // =========================================================================
  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.transparent,
      child: Column(
        children: [
          // 1. Month Selector scroller
          _buildMonthScroller(),
          const SizedBox(height: 6),

          // 2. Table Header Container (Fits single screen width without horizontal scroll)
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 4.0,
            ),
            decoration: BoxDecoration(
              color: isDark ? const Color(0x292ECC71) : const Color(0xFFEAF5EA),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                buildCell(
                  _translate('day'),
                  flex: 2,
                  isHeader: true,
                ),
                buildCell(
                  _translate('fajr'),
                  flex: 3,
                  isHeader: true,
                ),
                buildCell(
                  _translate('shuroq'),
                  flex: 3,
                  isHeader: true,
                ),
                buildCell(
                  _translate('dhohr'),
                  flex: 3,
                  isHeader: true,
                ),
                buildCell(
                  _translate('asr'),
                  flex: 3,
                  isHeader: true,
                ),
                buildCell(
                  _translate('magrib'),
                  flex: 3,
                  isHeader: true,
                ),
                buildCell(
                  _translate('isha'),
                  flex: 3,
                  isHeader: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),

          // 3. Grid list showing monthly prayer times with zebra striping & orange today highlight
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: prayerTimes.length,
                    itemBuilder: (context, index) {
                      final item = prayerTimes[index];
                      final date = item['date'] as DateTime;
                      final highlighted = isToday(date);
                      final isEven = index % 2 == 0;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 1.0),
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          // Today highlighted in vibrant orange, compact alternating zebra striping
                          color: highlighted
                              ? const Color(0xFFFF9500)
                              : (isEven
                                  ? (isDark
                                      ? const Color(0xFF26262A)
                                      : const Color(0xFFF2F2F7))
                                  : (isDark
                                      ? const Color(0xFF1C1C1E)
                                      : Colors.white)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            buildCell(
                              date.day.toString(),
                              flex: 2,
                              highlighted: highlighted,
                            ),
                            buildCell(
                              item['fajr'],
                              flex: 3,
                              highlighted: highlighted,
                            ),
                            buildCell(
                              item['shuruq'],
                              flex: 3,
                              highlighted: highlighted,
                            ),
                            buildCell(
                              item['dhuhr'],
                              flex: 3,
                              highlighted: highlighted,
                            ),
                            buildCell(
                              item['asr'],
                              flex: 3,
                              highlighted: highlighted,
                            ),
                            buildCell(
                              item['maghrib'],
                              flex: 3,
                              highlighted: highlighted,
                            ),
                            buildCell(
                              item['isha'],
                              flex: 3,
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
