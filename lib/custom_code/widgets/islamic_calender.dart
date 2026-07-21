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

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:hijri/hijri_calendar.dart';
import '/custom_code/actions/constants.dart';

Future<String?> loadJsonFromUrlOrCache({
  required String fileName,
  required List<String> urls,
  required List<String> assetPaths,
}) async {
  // 1. Download from online URL first to get latest data
  for (final url in urls) {
    try {
      print("Attempting download from: $url");
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final downloadedContent = response.body;
        print("Successfully downloaded JSON from: $url");

        // Save to local device storage for future offline access
        try {
          final directory = await getApplicationDocumentsDirectory();
          final localFile = File('${directory.path}/$fileName');
          await localFile.writeAsString(downloadedContent);
          print("Cached JSON locally at: ${localFile.path}");
        } catch (e) {
          print("Failed to save $fileName to local cache: $e");
        }
        return downloadedContent;
      }
    } catch (e) {
      print("Failed to download from $url: $e");
    }
  }

  // 2. Read from local device cache if network failed/offline
  try {
    final directory = await getApplicationDocumentsDirectory();
    final localFile = File('${directory.path}/$fileName');
    if (await localFile.exists()) {
      final content = await localFile.readAsString();
      if (content.isNotEmpty) {
        print("Offline Cache Hit: Loaded local file $fileName");
        return content;
      }
    }
  } catch (e) {
    print("Error reading local cache ($fileName): $e");
  }

  // 3. Fallback to bundled asset
  for (final assetPath in assetPaths) {
    try {
      final content = await rootBundle.loadString(assetPath);
      if (content.isNotEmpty) {
        print("Loaded asset fallback: $assetPath");
        return content;
      }
    } catch (_) {}
  }

  return null;
}

Future<String> loadJsonFromAssetOrGit(String filePath) async {
  return await rootBundle.loadString(filePath);
}

class IslamicCalender extends StatefulWidget {
  const IslamicCalender({
    super.key,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;
  @override
  State<IslamicCalender> createState() => _IslamicCalenderState();
}

//// =========================================================================
// ISLAMIC EVENT MODEL & DATA DEFINITION
// =========================================================================
class IslamicEvent {
  final String title;
  final String subtitle;
  final int hijriMonth;
  final int hijriDay;
  final int hijriYear;
  final String description;
  final String iconType; // 'mosque', 'kaaba', 'moon'
  final bool isMajorHoliday;
  final String hijriDate;
  final String gregorianDate;

  IslamicEvent({
    required this.title,
    required this.subtitle,
    required this.hijriMonth,
    required this.hijriDay,
    required this.hijriYear,
    required this.description,
    required this.iconType,
    required this.hijriDate,
    required this.gregorianDate,
    this.isMajorHoliday = false,
  });

  factory IslamicEvent.fromJson(
      Map<String, dynamic> json, bool isSwedish, int fallbackHijriYear) {
    final String titleStr = (isSwedish
            ? (json['title_sv'] ?? json['Event'] ?? json['title'])
            : (json['title_en'] ?? json['Event'] ?? json['title'])) ??
        json['Event'] ??
        json['title'] ??
        '';

    final String subtitleStr = (isSwedish
            ? (json['subtitle_sv'] ?? json['subtitle'])
            : (json['subtitle_en'] ?? json['subtitle'])) ??
        json['subtitle'] ??
        '';

    final int month = castToType<int>(json['hijriMonth'] ??
            json['Hijri_Month_No'] ??
            json['HijriMonthNo']) ??
        1;

    final int day = castToType<int>(
            json['hijriDay'] ?? json['Hijri_Day'] ?? json['HijriDay']) ??
        1;

    final int year = castToType<int>(
            json['hijriYear'] ?? json['Hijri_Year'] ?? json['HijriYear']) ??
        fallbackHijriYear;

    final String monthName =
        json['Hijri_Month_Name'] ?? json['HijriMonthName'] ?? '';
    final String fallbackHijriDate =
        '$day ${monthName.isNotEmpty ? monthName : month} $year'.trim();
    final String rawHijriDate =
        (isSwedish ? json['hijriDate_sv'] : json['hijriDate_en']) ??
            json['hijriDate'] ??
            '';
    final String finalHijriDate =
        rawHijriDate.isNotEmpty ? rawHijriDate : fallbackHijriDate;

    return IslamicEvent(
      title: titleStr,
      subtitle: subtitleStr,
      hijriMonth: month,
      hijriDay: day,
      hijriYear: year,
      description:
          (isSwedish ? json['description_sv'] : json['description_en']) ??
              json['description'] ??
              '',
      iconType: json['iconType'] ?? 'moon',
      hijriDate: finalHijriDate,
      gregorianDate:
          (isSwedish ? json['gregorianDate_sv'] : json['gregorianDate_en']) ??
              json['gregorianDate'] ??
              json['Gregorian_Date'] ??
              '',
      isMajorHoliday: json['isMajorHoliday'] as bool? ?? false,
    );
  }
}

class EventOccurrence {
  final IslamicEvent event;
  final DateTime gregorianDate;
  final Map<String, dynamic> hijriDate;
  EventOccurrence({
    required this.event,
    required this.gregorianDate,
    required this.hijriDate,
  });
}

class _IslamicCalenderState extends State<IslamicCalender> {
  // Calendar State Variables
  int selectedTab = 0; // 0 = Månadsvy, 1 = Kommande händelser
  DateTime currentDate =
      DateTime(2026, 5, 1); // Default to May 2026 as per mockup
  DateTime? selectedDate;
  EventOccurrence? selectedEvent;
  // Flat cache: Gregorian date string ("yyyy-MM-dd") → Hijri data row
  Map<String, Map<String, dynamic>> hijriDateCache = {};
  bool isLoading = true;
  // Notification states: keys are event titles
  Map<String, bool> activeNotifications = {};
  List<Map<String, dynamic>> _rawIslamicEvents = [];
  bool get _isSwedish => Localizations.localeOf(context).languageCode == 'sv';

  List<IslamicEvent> get islamicEvents {
    final sv = _isSwedish;
    return _rawIslamicEvents
        .map((json) => IslamicEvent.fromJson(json, sv,
            castToType<int>(json['hijriYear'] ?? json['Hijri_Year']) ?? 1448))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    // Initialize to today's date if it is in 2026/2027
    //final hijri = HijriCalendar.now();
    //final int year = hijri.hYear;
    final now = DateTime.now();
    if (now.year == 2026 || now.year == 2027) {
      currentDate = DateTime(now.year, now.month, 1);
      selectedDate = now;
    } else {
      selectedDate = DateTime(2026, 5, 14); // Matches 14 Maj highlighted cell
    }
    loadAllCalendarData();
  }

  // =========================================================================
  // JSON LOADING LOGIC
  // =========================================================================

  /// Loads BOTH Hijri JSON files (1447 and 1448) into a flat cache keyed by
  /// Gregorian date string ("yyyy-MM-dd"). This ensures dates that cross the
  /// Hijri new year boundary (e.g. 30 Dhu al-Hijjah → 1 Muharram) are always
  /// found correctly regardless of which Gregorian year we are viewing.
  Future<void> loadAllCalendarData() async {
    if (hijriDateCache.isNotEmpty) {
      setState(() => isLoading = false);
      return;
    }
    setState(() => isLoading = true);
    try {
      HijriCalendar.setLocal("en");
      final int currentHijriYear = HijriCalendar.now().hYear;

      // Define candidate years dynamically centered around current Hijri year (e.g. 1447, 1448)
      final List<int> candidateYears = [
        currentHijriYear - 1,
        currentHijriYear,
        currentHijriYear + 1,
        1447,
        1448,
      ].toSet().toList();

      // Local helper to load and parse a specific calendar dates year
      Future<int?> loadYear(int y) async {
        final String fileName = 'Islamic_dates_$y.json';
        final List<String> urls = [
          '${FileConstants.islamicDatesUrlPrefix}$y.json',
        ];
        final List<String> assetPaths = [
          'assets/jsons/Islamic_dates_$y.json',
        ];
        try {
          final String? jsonString = await loadJsonFromUrlOrCache(
            fileName: fileName,
            urls: urls,
            assetPaths: assetPaths,
          );
          if (jsonString == null) return null;

          final List<dynamic> jsonData = json.decode(jsonString);
          for (final dynamic row in jsonData) {
            final Map<String, dynamic> entry =
                Map<String, dynamic>.from(row as Map);
            final String? dateKey = entry['Gregorian_Date'] as String?;
            if (dateKey != null) {
              hijriDateCache[dateKey] = entry;
            }
          }
          return y;
        } catch (e) {
          return null;
        }
      }

      // Load all candidate calendar years in parallel
      final List<int?> loadedYears = await Future.wait(
        candidateYears.map((y) => loadYear(y)),
      );
      final List<int> yearsToLoad = loadedYears.whereType<int>().toList()
        ..sort();

      // If nothing was loaded (fallback failsafe)
      if (yearsToLoad.isEmpty) {
        await loadYear(1447);
        await loadYear(1448);
        yearsToLoad.addAll([1447, 1448]);
      }

      // Load all available holiday files in parallel for the loaded years
      final List<Future<List<dynamic>>> holidayTasks =
          yearsToLoad.map((y) async {
        final String fileName = 'Islamic-holiday_$y.json';
        final List<String> urls = [
          '${FileConstants.islamicHolidaysUrlPrefix}$y.json',
          'https://ifis.se/mkprod/data/Islamic_holidays_$y.json',
        ];
        final List<String> assetPaths = [
          'assets/jsons/Islamic-holiday_$y.json',
        ];
        try {
          final String? holidaysJsonString = await loadJsonFromUrlOrCache(
            fileName: fileName,
            urls: urls,
            assetPaths: assetPaths,
          );
          if (holidaysJsonString == null) return [];

          final List<dynamic> holidaysData = json.decode(holidaysJsonString);
          for (var item in holidaysData) {
            if (item is Map) {
              item['hijriYear'] = y; // Inject the Hijri year dynamically
            }
          }
          return holidaysData;
        } catch (e) {
          return [];
        }
      }).toList();

      final List<List<dynamic>> holidaysResults =
          await Future.wait(holidayTasks);
      final List<dynamic> allHolidays =
          holidaysResults.expand((x) => x).toList();

      _rawIslamicEvents =
          allHolidays.map((e) => Map<String, dynamic>.from(e as Map)).toList();
    } catch (e) {
      print("Error loading Hijri calendar or holidays data: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  /// Legacy shim – called when navigating to a new year so the UI refreshes.
  Future<void> loadCalendarDataForYear(int year) async {
    // All data is already loaded in loadAllCalendarData(); just trigger a
    // rebuild so the new month is rendered.
    if (hijriDateCache.isNotEmpty) {
      if (mounted) setState(() => isLoading = false);
      return;
    }
    await loadAllCalendarData();
  }

  Map<String, dynamic> getHijriDate(DateTime date) {
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    // Look up directly in the flat date-keyed cache (covers both 1447 & 1448)
    if (hijriDateCache.containsKey(dateKey)) {
      return hijriDateCache[dateKey]!;
    }
    // Fallback: compute via the hijri package if not found in cache
    HijriCalendar.setLocal("en");
    final hijri = HijriCalendar.fromDate(date);
    return {
      'Hijri_Year': hijri.hYear,
      'Hijri_Month_No': hijri.hMonth,
      'Hijri_Month_Name': _getHijriMonthNameStandard(hijri.hMonth),
      'Hijri_Day': hijri.hDay,
      'Gregorian_Date': dateKey,
      'Weekday': DateFormat('EEEE').format(date),
    };
  }

  String _getHijriMonthNameStandard(int monthNo) {
    const months = [
      'Muharram',
      'Safar',
      'Rabi al-Awwal',
      'Rabi al-Thani',
      'Jumada al-Awwal',
      'Jumada al-Thani',
      'Rajab',
      'Shaban',
      'Ramadan',
      'Shawwal',
      'Dhu al-Qidah',
      'Dhu al-Hijjah'
    ];
    if (monthNo >= 1 && monthNo <= 12) {
      return months[monthNo - 1];
    }
    return '';
  }

  String _mapHijriMonthToSwedish(String name) {
    final lower = name.toLowerCase().replaceAll("'", "").replaceAll(" ", "");
    if (lower.contains("muharram")) return "Muharram";
    if (lower.contains("safar")) return "Safar";
    if (lower.contains("rabialawwal")) return "Rabi' al-awwal";
    if (lower.contains("rabialthani") || lower.contains("rabialsani"))
      return "Rabi' al-thani";
    if (lower.contains("jumadaalawwal") || lower.contains("jumadaalula"))
      return "Jumada al-awwal";
    if (lower.contains("jumadaalthani") || lower.contains("jumadaalakhira"))
      return "Jumada al-thani";
    if (lower.contains("rajab")) return "Rajab";
    if (lower.contains("shaban")) return "Sha'ban";
    if (lower.contains("ramadan")) return "Ramadan";
    if (lower.contains("shawwal")) return "Shawwal";
    if (lower.contains("dhualqidah") || lower.contains("dhulqidah"))
      return "Dhu al-Qi'dah";
    if (lower.contains("dhualhijjah") || lower.contains("dhulhijjah"))
      return "Dhu al-Hijjah";
    return name;
  }

  String _getGregorianMonthNameSwedish(int month) {
    const months = [
      "Januari",
      "Februari",
      "Mars",
      "April",
      "Maj",
      "Juni",
      "Juli",
      "Augusti",
      "September",
      "Oktober",
      "November",
      "December"
    ];
    if (month >= 1 && month <= 12) {
      return months[month - 1];
    }
    return '';
  }

  String _getWeekdayAbbrSwedish(int weekday) {
    const days = ["mån", "tis", "ons", "tors", "fre", "lör", "sön"];
    if (weekday >= 1 && weekday <= 7) {
      return days[weekday - 1];
    }
    return '';
  }

  String getMonthHeaderSubtitle() {
    if (isLoading) return '...';
    final middleDay = DateTime(currentDate.year, currentDate.month, 15);
    final hj = getHijriDate(middleDay);
    final year = hj['Hijri_Year'];
    final name = hj['Hijri_Month_Name'];
    return '${_mapHijriMonthToSwedish(name.toString())} $year';
  }

  // Resolves the Gregorian date for a specific IslamicEvent in the viewed year
  DateTime? getGregorianDateOfEvent(IslamicEvent event, int year) {
    // Search the flat cache for the event's Hijri year+month+day within the
    // given Gregorian year so results stay scoped to the visible year and the
    // correct Hijri year (avoids duplicates when two Hijri years overlap the
    // same Gregorian year, e.g. 1447 Muharram and 1448 Muharram both in 2026).
    for (final entry in hijriDateCache.values) {
      final gregDate = entry['Gregorian_Date'] as String?;
      if (gregDate == null) continue;
      if (!gregDate.startsWith(year.toString())) continue;
      if (entry['Hijri_Year'] == event.hijriYear &&
          entry['Hijri_Month_No'] == event.hijriMonth &&
          entry['Hijri_Day'] == event.hijriDay) {
        return DateTime.parse(gregDate);
      }
    }
    return null;
  }

  // Get occurrences in the current month (for Månadsvy list)
  List<EventOccurrence> getEventsForCurrentMonth() {
    if (isLoading) return [];
    List<EventOccurrence> list = [];
    final daysInMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    for (int d = 1; d <= daysInMonth; d++) {
      final dayDate = DateTime(currentDate.year, currentDate.month, d);
      final hj = getHijriDate(dayDate);
      final int? hjYear = castToType<int>(hj['Hijri_Year'] ?? hj['HijriYear']);
      final int? hjMonth =
          castToType<int>(hj['Hijri_Month_No'] ?? hj['HijriMonthNo']);
      final int? hjDay = castToType<int>(hj['Hijri_Day'] ?? hj['HijriDay']);
      final matches = islamicEvents.where((e) =>
          (hjYear == null || e.hijriYear == hjYear) &&
          (hjMonth == null || e.hijriMonth == hjMonth) &&
          (hjDay == null || e.hijriDay == hjDay));
      for (var ev in matches) {
        list.add(EventOccurrence(
          event: ev,
          gregorianDate: dayDate,
          hijriDate: hj,
        ));
      }
    }
    list.sort((a, b) => a.gregorianDate.compareTo(b.gregorianDate));
    return list;
  }

  // Compile all occurrences for a specific year (for Kommande händelser list)
  List<EventOccurrence> getEventsForYear(int year) {
    if (isLoading) return [];
    List<EventOccurrence> list = [];
    for (var ev in islamicEvents) {
      final gregDate = getGregorianDateOfEvent(ev, year);
      if (gregDate != null) {
        list.add(EventOccurrence(
          event: ev,
          gregorianDate: gregDate,
          hijriDate: getHijriDate(gregDate),
        ));
      }
    }
    list.sort((a, b) => a.gregorianDate.compareTo(b.gregorianDate));
    return list;
  }

  void nextMonth() {
    int m = currentDate.month + 1;
    int y = currentDate.year;
    if (m > 12) {
      m = 1;
      y += 1;
    }
    if (y <= 2027) {
      setState(() {
        currentDate = DateTime(y, m, 1);
      });
      loadCalendarDataForYear(y);
    }
  }

  void prevMonth() {
    int m = currentDate.month - 1;
    int y = currentDate.year;
    if (m < 1) {
      m = 12;
      y -= 1;
    }
    if (y >= 2026) {
      setState(() {
        currentDate = DateTime(y, m, 1);
      });
      loadCalendarDataForYear(y);
    }
  }

  // =========================================================================
  // CUSTOM VECTOR ICONS (Kaaba, Mosque, Moon)
  // =========================================================================
  Widget _buildKaabaIcon({double size = 22.0}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Stack(
        children: [
          Positioned(
            top: size * 0.25,
            left: 0,
            right: 0,
            child: Container(
              height: size * 0.08,
              color: const Color(0xFFFFD700), // Gold belt
            ),
          ),
          Positioned(
            bottom: size * 0.1,
            right: size * 0.25,
            child: Container(
              width: size * 0.15,
              height: size * 0.35,
              color: const Color(0xFFFFD700), // Gold door
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventIcon(String type,
      {Color color = Colors.black, double size = 22.0}) {
    if (type == 'kaaba') {
      return _buildKaabaIcon(size: size);
    } else if (type == 'mosque') {
      return Icon(Icons.mosque, color: color, size: size);
    } else {
      return Icon(Icons.nights_stay, color: color, size: size);
    }
  }

  // =========================================================================
  // VIEW BUILDERS: Tabs, Calendar Grid, Grouped Events, and Detail View
  // =========================================================================
  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      color: theme.primaryBackground,
      child: Column(
        children: [
          // 1. Custom Tab Bar (placed at the top of the widget, no nav header!)
          _buildTabBar(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : (selectedTab == 0)
                    ? _buildCalendarMainView()
                    : _buildUpcomingEventsView(),
          ),
        ],
      ),
    );
  }

  // TAB BAR WIDGET
  Widget _buildTabBar() {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          // Tab 1: Månadsvy
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = 0;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: selectedTab == 0
                      ? const Color(0xFF0B7A12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    'Månadsvy',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color:
                          selectedTab == 0 ? Colors.white : theme.secondaryText,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Tab 2: Kommande händelser
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: selectedTab == 1
                      ? const Color(0xFF0B7A12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    'Kommande händelser',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color:
                          selectedTab == 1 ? Colors.white : theme.secondaryText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 1. MÅNADSVY SCREEN
  Widget _buildCalendarMainView() {
    final theme = FlutterFlowTheme.of(context);
    final firstDay = DateTime(currentDate.year, currentDate.month, 1);
    final emptyCells = firstDay.weekday - 1; // Mon=1, ..., Sun=7
    final totalDays = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    List<Widget> cellWidgets = [];
    // Empty cells for grid alignment
    for (int i = 0; i < emptyCells; i++) {
      cellWidgets.add(Container(color: theme.secondaryBackground));
    }
    // Days of month
    for (int d = 1; d <= totalDays; d++) {
      final cellDate = DateTime(currentDate.year, currentDate.month, d);
      cellWidgets.add(_buildCalendarCell(cellDate));
    }
    // Align grid
    while (cellWidgets.length % 7 != 0) {
      cellWidgets.add(Container(color: theme.secondaryBackground));
    }
    List<TableRow> tableRows = [];
    for (int i = 0; i < cellWidgets.length; i += 7) {
      tableRows.add(TableRow(
        children: cellWidgets.sublist(i, i + 7),
      ));
    }
    final currentMonthEvents = getEventsForCurrentMonth();
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nav row for month change
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left,
                      size: 36, color: theme.primaryText),
                  onPressed: prevMonth,
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      '${_getGregorianMonthNameSwedish(currentDate.month)} ${currentDate.year}',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      getMonthHeaderSubtitle(),
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: theme.secondaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.arrow_right,
                      size: 36, color: theme.primaryText),
                  onPressed: nextMonth,
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Weekday Headers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                return Expanded(
                  child: Center(
                    child: Text(
                      _getWeekdayAbbrSwedish(index + 1),
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.primaryText,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            // Visual Grid Calendar
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: theme.alternate, width: 1.0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Table(
                  border: TableBorder.symmetric(
                    inside: BorderSide(color: theme.alternate, width: 1.0),
                  ),
                  children: tableRows,
                ),
              ),
            ),
            const SizedBox(height: 25),
            // Title
            Text(
              'Viktigt kommande datum',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.primaryText,
              ),
            ),
            const SizedBox(height: 12),
            // Events in month
            if (currentMonthEvents.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text(
                    'Inga viktiga datum denna månad',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      color: theme.secondaryText,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentMonthEvents.length,
                separatorBuilder: (context, idx) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final occurrence = currentMonthEvents[index];
                  final isMajorFestival =
                      occurrence.event.title.contains("(festival)");
                  return Container(
                    decoration: BoxDecoration(
                      color: isMajorFestival
                          ? (Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF0F3A15)
                              : const Color(0xFFEAF5EA))
                          : theme.secondaryBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: isMajorFestival
                          ? Border.all(
                              color: const Color(0xFF0B7A12), width: 1.0)
                          : Border.all(color: theme.alternate, width: 1.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _showEventDetailBottomSheet(occurrence);
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: theme.secondaryBackground,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: _buildEventIcon(
                                    occurrence.event.iconType,
                                    color: const Color(0xFF0B7A12),
                                    size: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      occurrence.event.title,
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: theme.primaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${occurrence.event.hijriDate} • ${occurrence.event.gregorianDate}',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: theme.secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right,
                                  color: Colors.grey, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // CALENDAR CELL
  Widget _buildCalendarCell(DateTime date) {
    final theme = FlutterFlowTheme.of(context);
    final hj = getHijriDate(date);
    final int hijriDay = hj['Hijri_Day'];
    final int hjMonth = hj['Hijri_Month_No'];
    final matchingEvents = islamicEvents.where((e) {
      final eventDate = getGregorianDateOfEvent(e, date.year);
      return eventDate != null &&
          eventDate.year == date.year &&
          eventDate.month == date.month &&
          eventDate.day == date.day;
    });
    final hasEvent = matchingEvents.isNotEmpty;
    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final isSelected = selectedDate != null &&
        date.year == selectedDate!.year &&
        date.month == selectedDate!.month &&
        date.day == selectedDate!.day;
    final hasFestival =
        matchingEvents.any((e) => e.title.contains("(festival)"));
    BoxDecoration cellDecoration;
    EdgeInsets cellMargin;
    if (isToday) {
      cellMargin = const EdgeInsets.all(3.0);
      cellDecoration = BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF0F3A15)
            : const Color(0xFFEAF5EA),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFF0B7A12), width: 1.5),
      );
    } else if (isSelected) {
      cellMargin = const EdgeInsets.all(3.0);
      cellDecoration = BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF0F3A15)
            : const Color(0xFFEAF5EA),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: const Color(0xFF0B7A12).withOpacity(0.5), width: 1.0),
      );
    } else if (hasEvent) {
      cellMargin = EdgeInsets.zero;
      cellDecoration = BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF0D2F12)
            : const Color(0xFFEAF5EA),
      );
    } else {
      cellMargin = EdgeInsets.zero;
      cellDecoration = BoxDecoration(
        color: theme.primaryBackground,
      );
    }
    return AspectRatio(
      aspectRatio: 0.90,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDate = date;
          });
          if (hasEvent) {
            final occ = EventOccurrence(
              event: matchingEvents.first,
              gregorianDate: date,
              hijriDate: hj,
            );
            _showEventDetailBottomSheet(occ);
          }
        },
        child: Container(
          margin: cellMargin,
          decoration: cellDecoration,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      date.day.toString(),
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15.0,
                        fontWeight: isToday || isSelected
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color: isToday
                            ? const Color(0xFF0B7A12)
                            : theme.primaryText,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      hijriDay.toString(),
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 10.5,
                        color: isToday
                            ? const Color(0xFF0B7A12).withOpacity(0.7)
                            : theme.secondaryText,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasEvent)
                const Positioned(
                  top: 4,
                  right: 4,
                  child: Icon(
                    Icons.mosque,
                    color: Color(0xFF0B7A12),
                    size: 12.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 2. KOMMANDE HÄNDELSER SCREEN (Middle screen layout!)
  Widget _buildUpcomingEventsView() {
    final theme = FlutterFlowTheme.of(context);
    final yearEvents = getEventsForYear(currentDate.year);
    // Grouping events
    // Section 1: Major Holidays
    final majorHolidays =
        yearEvents.where((oe) => oe.event.isMajorHoliday).toList();
    // Section 2: Grouped by Hijri Month (excluding major holidays to avoid duplicates)
    Map<int, List<EventOccurrence>> groupedByMonth = {};
    for (var oe in yearEvents) {
      if (oe.event.isMajorHoliday) continue;
      final int monthNo = castToType<int>(
              oe.hijriDate['Hijri_Month_No'] ?? oe.hijriDate['HijriMonthNo']) ??
          oe.event.hijriMonth;
      if (!groupedByMonth.containsKey(monthNo)) {
        groupedByMonth[monthNo] = [];
      }
      groupedByMonth[monthNo]!.add(oe);
    }
    // Sort month sections
    final sortedMonthsKeys = groupedByMonth.keys.toList()..sort();
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Year Selector Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ALLA ISLAMISKA HELGDAGAR',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryText,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                // 2026 / 2027 toggle pills
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildYearChip(2026),
                    const SizedBox(width: 8),
                    _buildYearChip(2027),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Major holidays list
            if (majorHolidays.isNotEmpty)
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: majorHolidays.length,
                separatorBuilder: (context, idx) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return _buildUpcomingEventCard(majorHolidays[index]);
                },
              ),
            const SizedBox(height: 20),
            // Other events grouped by Hijri Month
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortedMonthsKeys.length,
              itemBuilder: (context, index) {
                final monthNo = sortedMonthsKeys[index];
                final monthEvents = groupedByMonth[monthNo]!;
                final monthName =
                    _mapHijriMonthToSwedish(_getHijriMonthNameStandard(monthNo))
                        .toUpperCase();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                      child: Text(
                        'MÅNADEN $monthName',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryText,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: monthEvents.length,
                      separatorBuilder: (context, idx) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, idx) {
                        return _buildUpcomingEventCard(monthEvents[idx]);
                      },
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // BUILD YEAR TOGGLE CHIP
  Widget _buildYearChip(int year) {
    final theme = FlutterFlowTheme.of(context);
    final isSelected = currentDate.year == year;
    return GestureDetector(
      onTap: () {
        if (currentDate.year != year) {
          setState(() {
            currentDate = DateTime(year, currentDate.month, 1);
          });
          loadCalendarDataForYear(year);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color(0xFF0B7A12) : theme.secondaryBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          year.toString(),
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : theme.secondaryText,
          ),
        ),
      ),
    );
  }

  // DATE BADGE WIDGET FOR EVENT CARD
  Widget _buildDateBadge(EventOccurrence occ) {
    final theme = FlutterFlowTheme.of(context);
    final hjMonthName =
        _mapHijriMonthToSwedish(occ.hijriDate['Hijri_Month_Name'])
            .toUpperCase();
    final hijriDay = occ.hijriDate['Hijri_Day'].toString();
    final gregDay = occ.gregorianDate.day.toString();
    final gregMonth = _getGregorianMonthNameSwedish(occ.gregorianDate.month)
        .substring(0, 3)
        .toUpperCase();
    final weekday =
        _getWeekdayAbbrSwedish(occ.gregorianDate.weekday).toUpperCase();
    return Container(
      width: 65,
      height: 75,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF0F3A15)
            : const Color(0xFFEFF7EF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF0B7A12), width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Green top header bar in badge
          Container(
            width: double.infinity,
            height: 18,
            color: const Color(0xFF0B7A12),
            alignment: Alignment.center,
            child: Text(
              hjMonthName,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Day number & Date details
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  hijriDay,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryText,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$gregDay $gregMonth',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryText,
                    height: 1.1,
                  ),
                ),
                Text(
                  weekday,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 9.0,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryText,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEventCard(EventOccurrence occurrence) {
    final theme = FlutterFlowTheme.of(context);
    final isNotifActive = activeNotifications[occurrence.event.title] ?? false;
    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.alternate,
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showEventDetailBottomSheet(occurrence);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Left Date Badge
                _buildDateBadge(occurrence),
                const SizedBox(width: 14),
                // Middle Event details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        occurrence.event.title,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryText,
                        ),
                      ),
                      Text(
                        '${occurrence.event.hijriDate} • ${occurrence.event.gregorianDate}',
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B7A12),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        occurrence.event.description,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: theme.secondaryText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Right Chevron & Notification Bell
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.chevron_right,
                        color: Colors.grey, size: 20),
                    const SizedBox(height: 14),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          activeNotifications[occurrence.event.title] =
                              !isNotifActive;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              !isNotifActive
                                  ? 'Aviseringar aktiverade för ${occurrence.event.title}'
                                  : 'Aviseringar avaktiverade för ${occurrence.event.title}',
                              style: const TextStyle(fontFamily: 'Manrope'),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Icon(
                        isNotifActive
                            ? Icons.notifications_active
                            : Icons.notifications_none,
                        color: isNotifActive
                            ? const Color(0xFF0B7A12)
                            : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 3. EVENT DETAIL VIEW
  // 3. EVENT DETAIL BOTTOM SHEET
  void _showEventDetailBottomSheet(EventOccurrence occ) {
    final theme = FlutterFlowTheme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: theme.alternate,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Event Title
                Center(
                  child: Text(
                    occ.event.title
                        .replaceAll(" (festival)", "")
                        .replaceAll(" (Fasta)", ""),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Two-column Detail Card
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF0F3A15)
                        : const Color(0xFFEAF5EA),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: const Color(0xFF0B7A12), width: 1.0),
                  ),
                  child: Row(
                    children: [
                      // Hijri Column
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'HIJRI',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B7A12),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              occ.event.hijriDate.isNotEmpty
                                  ? occ.event.hijriDate
                                  : '${occ.hijriDate['Hijri_Day'] ?? ''} ${occ.hijriDate['Hijri_Month_Name'] ?? ''} ${occ.hijriDate['Hijri_Year'] ?? ''}'
                                      .trim(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                          height: 40,
                          width: 1,
                          color: const Color(0xFF0B7A12).withOpacity(0.2)),
                      // Gregorian Column
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'GREGORIANSK',
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B7A12),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              occ.event.gregorianDate,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // About Section
                Text(
                  'OM DENNA DAG',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: theme.primaryText,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  occ.event.description,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    height: 1.5,
                    color: theme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
