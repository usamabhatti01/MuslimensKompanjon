// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/ff_builtin_enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:hijri/hijri_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import '/custom_code/actions/habit_tracker_service.dart';
import '/custom_code/actions/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/pages/setting_page/bottom_sheet_icon/bottom_sheet_icon_widget.dart';

String sanitizeJsonString(String raw) {
  var text = raw.trim();
  if (text.startsWith('```json')) {
    text = text.substring(7);
  } else if (text.startsWith('```')) {
    text = text.substring(3);
  }
  text = text.replaceAll(RegExp(r'```[\s\S]*$'), '');
  text = text.replaceAll(RegExp(r'\[cite:[\s\S]*?\]'), '');
  return text.trim();
}

Future<String?> fetchLiveJsonFromUrl(List<String> urls) async {
  for (final url in urls) {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148',
          'Accept': 'application/json; charset=utf-8',
        },
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        // Explicitly decode as UTF-8 so characters like emojis (🌙, 🤲, etc.) and Swedish letters (å, ä, ö)
        // are never corrupted into Latin-1 mojibake (like ðŸ™)
        final rawDecoded =
            utf8.decode(response.bodyBytes, allowMalformed: true);
        final downloadedContent = sanitizeJsonString(rawDecoded);
        if (downloadedContent.startsWith('[') ||
            downloadedContent.startsWith('{')) {
          return downloadedContent;
        }
      }
    } catch (_) {}
  }
  return null;
}

Future<String?> loadJsonFromUrlOrCache({
  required String fileName,
  required List<String> urls,
  required List<String> assetPaths,
}) async {
  // 1. Download from online URL first to get latest data
  for (final url in urls) {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
              'Mozilla/5.0 (iPhone; CPU iPhone OS 16_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148',
          'Accept': 'application/json; charset=utf-8',
        },
      ).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        final rawDecoded =
            utf8.decode(response.bodyBytes, allowMalformed: true);
        final downloadedContent = sanitizeJsonString(rawDecoded);
        // Ensure downloaded content is valid JSON (not an HTML error/404 page)
        if (downloadedContent.startsWith('[') ||
            downloadedContent.startsWith('{')) {
          // Save to local device storage for future offline access
          try {
            final directory = await getApplicationDocumentsDirectory();
            final localFile = File('${directory.path}/$fileName');
            await localFile.writeAsString(downloadedContent);
          } catch (_) {}
          return downloadedContent;
        }
      }
    } catch (_) {}
  }

  // 2. Read from local device cache if network failed/offline
  try {
    final directory = await getApplicationDocumentsDirectory();
    final localFile = File('${directory.path}/$fileName');
    if (await localFile.exists()) {
      final content = sanitizeJsonString(await localFile.readAsString());
      if (content.startsWith('[') || content.startsWith('{')) {
        return content;
      }
    }
  } catch (_) {}

  // 3. Fallback to bundled asset
  for (final assetPath in assetPaths) {
    try {
      final content = (await rootBundle.loadString(assetPath)).trim();
      if (content.startsWith('[') || content.startsWith('{')) {
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

    String rawSubtitle = (isSwedish
            ? (json['subtitle_sv'] ?? json['subtitle'])
            : (json['subtitle_en'] ?? json['subtitle'])) ??
        json['subtitle'] ??
        '';
    if (rawSubtitle.isEmpty) {
      final t = titleStr.toLowerCase();
      if (t.contains('nyår') || t.contains('hijra')) {
        rawSubtitle = isSwedish
            ? 'Starten på det nya islamiska året'
            : 'Start of the Islamic New Year';
      } else if (t.contains('ashura')) {
        rawSubtitle = isSwedish
            ? 'Rekommenderad fasta. Historisk räddningsdag'
            : 'Recommended fasting day';
      } else if (t.contains('miraj') || t.contains('nattresa')) {
        rawSubtitle = isSwedish
            ? 'Profetens nattliga resa och himmelsfärd'
            : 'The Night Journey and Ascension';
      } else if (t.contains('ramadan') &&
          (t.contains('första') || t.contains('fastan'))) {
        rawSubtitle = isSwedish
            ? 'Den heliga fastemånaden inleds'
            : 'First day of fasting month';
      } else if (t.contains('eid al-fitr') || t.contains('ramadanfest')) {
        rawSubtitle = isSwedish
            ? 'Fastebrytelsens fest'
            : 'Celebration marking the end of Ramadan';
      } else if ((t.contains('dhu al-hijjah') || t.contains('dhul-hijjah')) &&
          t.contains('första')) {
        rawSubtitle = isSwedish
            ? 'De tio välsignade dagarna inleds'
            : 'First of the ten blessed days';
      } else if (t.contains('arafa')) {
        rawSubtitle = isSwedish
            ? 'Hajjens höjdpunkt. Rekommenderad fasta'
            : 'Peak of Hajj. Recommended fast';
      } else if (t.contains('eid al-adha') || t.contains('offerfest')) {
        rawSubtitle = isSwedish
            ? 'Offerhögtiden till minne av profeten Ibrahim'
            : 'Feast of Sacrifice';
      }
    }
    final String subtitleStr = rawSubtitle;

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
    final String rawDesc =
        (isSwedish ? json['description_sv'] : json['description_en']) ??
            json['Description'] ??
            json['description'] ??
            '';
    final String finalDesc = rawDesc;

    // Use actual Icon directly from live JSON link (e.g. 🌙, 🤲, ✨, 🎉, 🕋, ⛰️, 🐑)
    final String icon = (json['Icon'] ?? json['iconType'] ?? json['icon'] ?? '')
        .toString()
        .trim();

    final bool isMajor = (json['isMajorHoliday'] as bool?) ?? true;

    return IslamicEvent(
      title: titleStr,
      subtitle: subtitleStr,
      hijriMonth: month,
      hijriDay: day,
      hijriYear: year,
      description: finalDesc,
      iconType: icon,
      hijriDate: finalHijriDate,
      gregorianDate:
          (isSwedish ? json['gregorianDate_sv'] : json['gregorianDate_en']) ??
              json['gregorianDate'] ??
              json['Gregorian_Date'] ??
              '',
      isMajorHoliday: isMajor,
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

Widget _buildEventIconWidget(
  String iconType, {
  String title = '',
  double size = 20.0,
  Color? color,
}) {
  final clean = iconType.trim();
  if (clean.isNotEmpty) {
    return Text(
      clean,
      style: TextStyle(
        fontSize: size,
        height: 1.1,
      ),
      textAlign: TextAlign.center,
    );
  }
  return Icon(
    Icons.nightlight_round,
    color: color,
    size: size,
  );
}

IconData _getEventIconData(String iconType) {
  switch (iconType) {
    case '🤲':
      return Icons.front_hand_rounded;
    case '✨':
      return Icons.auto_awesome_rounded;
    case '🐑':
      return Icons.pets_rounded;
    case '⛰️':
    case '⛰':
      return Icons.landscape_rounded;
    case '🕋':
      return Icons.square_rounded;
    case '🎉':
      return Icons.celebration_rounded;
    case '📖':
      return Icons.menu_book_rounded;
    case '🌙':
    default:
      return Icons.nightlight_round;
  }
}

class _IslamicCalenderState extends State<IslamicCalender> {
  // Calendar State Variables
  int selectedTab = 0; // 0 = Månadsvy, 1 = Kommande händelser
  String selectedCategory =
      'Alla'; // 'Alla', 'Fasta', 'Koran', 'Bön', 'Dhikr', 'Välgörenhet', 'Eget'
  final HabitTrackerService _habitService = HabitTrackerService();
  DateTime currentDate =
      DateTime(2026, 9, 1); // Defaults to September 2026 as per v1.25 specs
  DateTime? selectedDate;
  EventOccurrence? selectedEvent;
  // Flat cache: Gregorian date string ("yyyy-MM-dd") → Hijri data row
  Map<String, Map<String, dynamic>> hijriDateCache = {};
  bool isLoading = true;
  // Notification states: keys are event titles
  Map<String, bool> activeNotifications = {};
  List<Map<String, dynamic>> _rawIslamicEvents = [];
  bool get _isSwedish => Localizations.localeOf(context).languageCode == 'sv';

  int? _cachedPrayerYear;
  int? _selectedUpcomingYear;

  Future<void> _loadYearFromExistingPrayerData() async {
    try {
      final String city = FFAppState().user.city.isNotEmpty
          ? FFAppState().user.city
          : 'Alingsås';
      final jsonString = await loadPrayerJson(city, DateTime.now().year);
      final decoded = json.decode(jsonString);
      if (decoded is Map && decoded.containsKey('year')) {
        final y = castToType<int>(decoded['year']);
        if (y != null && mounted) {
          setState(() {
            _cachedPrayerYear = y;
          });
        }
      }
    } catch (_) {}
  }

  List<int> get availableYears {
    final Set<int> years = {};

    // 1. From existing prayer data ('year': 2026 property directly)
    if (_cachedPrayerYear != null) {
      years.add(_cachedPrayerYear!);
    }

    // 2. From raw Islamic events / holidays JSON (only years that actually have events)
    for (var ev in _rawIslamicEvents) {
      final g = (ev['Gregorian_Date'] ?? ev['gregorianDate']) as String?;
      if (g != null && g.length >= 4) {
        final y = int.tryParse(g.substring(0, 4));
        if (y != null) years.add(y);
      }
    }

    // Fallback if still loading cache
    if (years.isEmpty) {
      years.add(currentDate.year);
    }

    final list = years.toList()..sort();
    return list;
  }

  Future<void> _loadHolidayNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((k) => k.startsWith('holiday_notif_'));
      final Map<String, bool> notifs = {};
      for (var k in keys) {
        final title = k.replaceFirst('holiday_notif_', '');
        notifs[title] = prefs.getBool(k) ?? false;
      }
      if (mounted) {
        setState(() {
          activeNotifications = notifs;
        });
      }
    } catch (_) {}
  }

  Future<void> _toggleEventNotification(IslamicEvent event,
      [DateTime? date]) async {
    try {
      final current = activeNotifications[event.title] ?? false;
      final newVal = !current;
      setState(() {
        activeNotifications[event.title] = newVal;
      });

      await scheduleEventNotifications(
        event.title,
        date,
        newVal,
        event.hijriDate,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              newVal
                  ? 'Påminnelse aktiverad för ${event.title}'
                  : 'Påminnelse inaktiverad för ${event.title}',
              style: GoogleFonts.manrope(),
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: newVal
                ? FlutterFlowTheme.of(context).primary
                : Colors.grey.shade700,
          ),
        );
      }
    } catch (_) {}
  }

  List<IslamicEvent> get islamicEvents {
    final sv = _isSwedish;
    if (_rawIslamicEvents.isNotEmpty) {
      return _rawIslamicEvents
          .map((json) => IslamicEvent.fromJson(
              json,
              sv,
              castToType<int>(json['hijriYear'] ?? json['Hijri_Year']) ??
                  HijriCalendar.now().hYear))
          .toList();
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    _habitService.init().then((_) {
      if (mounted) setState(() {});
    });
    _loadHolidayNotifications();
    _loadYearFromExistingPrayerData();
    final now = DateTime.now();
    if (now.year == 2026 || now.year == 2027) {
      currentDate = DateTime(now.year, now.month, 1);
      selectedDate = now;
    } else {
      currentDate = DateTime(2026, 9, 1);
      selectedDate = DateTime(2026, 9, 24);
    }
    loadAllCalendarData();
  }

  // =========================================================================
  // JSON LOADING LOGIC
  // =========================================================================

  Future<void> loadAllCalendarData() async {
    if (hijriDateCache.isNotEmpty && _rawIslamicEvents.isNotEmpty) {
      setState(() => isLoading = false);
      return;
    }
    setState(() => isLoading = true);
    try {
      HijriCalendar.setLocal("en");
      final int prayerYear = _cachedPrayerYear ?? currentDate.year;
      final int startH =
          HijriCalendar.fromDate(DateTime(prayerYear, 1, 1)).hYear;
      final int endH =
          HijriCalendar.fromDate(DateTime(prayerYear + 2, 12, 31)).hYear;
      final List<int> candidateYears = [
        for (int y = startH; y <= endH; y++) y,
      ];

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
        } catch (_) {
          return null;
        }
      }

      print(
          "📅 [Kalender] Loading calendar & holiday data for candidate years: $candidateYears");

      final List<Future<dynamic>> parallelTasks = [
        Future.wait(candidateYears.map((y) => loadYear(y))),
        Future.wait(candidateYears.map((y) async {
          final List<String> urls = [
            '${FileConstants.islamicHolidaysUrlPrefix}$y.json',
            'https://ifis.se/mkprod/data/Islamic_holidays_$y.json',
          ];
          try {
            // Delete any existing local device cache file so we always get fresh live data
            try {
              final directory = await getApplicationDocumentsDirectory();
              final localFile =
                  File('${directory.path}/Islamic-holiday_$y.json');
              if (await localFile.exists()) {
                await localFile.delete();
              }
            } catch (_) {}

            final String? holidaysJsonString = await fetchLiveJsonFromUrl(urls);
            if (holidaysJsonString == null) {
              print(
                  "📅 [Kalender] No holiday data returned from live link for year $y");
              return [];
            }

            final List<dynamic> holidaysData =
                json.decode(sanitizeJsonString(holidaysJsonString));
            print(
                "📅 [Kalender] Successfully fetched ${holidaysData.length} holidays for year $y from live link");
            for (var item in holidaysData) {
              if (item is Map) {
                item['hijriYear'] = y;
              }
            }
            return holidaysData;
          } catch (e) {
            print("📅 [Kalender] Error loading holidays for year $y: $e");
            return [];
          }
        })),
      ];

      final results = await Future.wait(parallelTasks);
      final List<List<dynamic>> holidaysResults =
          (results[1] as List).cast<List<dynamic>>();
      final List<dynamic> allHolidays =
          holidaysResults.expand((x) => x).toList();

      _rawIslamicEvents =
          allHolidays.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      print(
          "📅 [Kalender] Total raw Islamic events loaded: ${_rawIslamicEvents.length}");
    } catch (e) {
      print("Error loading Hijri calendar or holidays data: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> loadCalendarDataForYear(int year) async {
    if (hijriDateCache.isNotEmpty && _rawIslamicEvents.isNotEmpty) {
      if (mounted) setState(() => isLoading = false);
      return;
    }
    await loadAllCalendarData();
  }

  Map<String, dynamic> getHijriDate(DateTime date) {
    final dateKey = DateFormat('yyyy-MM-dd').format(date);
    if (hijriDateCache.containsKey(dateKey)) {
      return hijriDateCache[dateKey]!;
    }
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

  String _getWeekdayNameSwedish(int weekday) {
    const days = [
      "Måndag",
      "Tisdag",
      "Onsdag",
      "Torsdag",
      "Fredag",
      "Lördag",
      "Söndag"
    ];
    if (weekday >= 1 && weekday <= 7) {
      return days[weekday - 1];
    }
    return '';
  }

  String _getWeekdayAbbrSwedish(int weekday) {
    const days = ["Mån", "Tis", "Ons", "Tor", "Fre", "Lör", "Sön"];
    if (weekday >= 1 && weekday <= 7) {
      return days[weekday - 1];
    }
    return '';
  }

  String getMonthHeaderSubtitle() {
    if (isLoading) return '...';
    final middleDay = DateTime(currentDate.year, currentDate.month, 15);
    final hj = getHijriDate(middleDay);
    final year = hj['Hijri_Year'] ??
        hj['HijriYear'] ??
        HijriCalendar.fromDate(middleDay).hYear;
    final name =
        hj['Hijri_Month_Name'] ?? hj['HijriMonthName'] ?? 'Rabi al-Awwal';
    return '${_mapHijriMonthToSwedish(name.toString())} $year';
  }

  DateTime? getGregorianDateOfEvent(IslamicEvent event, int year) {
    for (final entry in hijriDateCache.values) {
      final gregDate = entry['Gregorian_Date'] as String?;
      if (gregDate == null) continue;
      if (!gregDate.startsWith(year.toString())) continue;
      final eYear = castToType<int>(entry['Hijri_Year'] ?? entry['HijriYear']);
      final eMonth =
          castToType<int>(entry['Hijri_Month_No'] ?? entry['HijriMonthNo']);
      final eDay = castToType<int>(entry['Hijri_Day'] ?? entry['HijriDay']);
      if ((event.hijriYear == 0 || eYear == null || eYear == event.hijriYear) &&
          eMonth == event.hijriMonth &&
          eDay == event.hijriDay) {
        return DateTime.tryParse(gregDate);
      }
    }

    try {
      final int hStart = HijriCalendar.fromDate(DateTime(year, 1, 1)).hYear;
      final int hEnd = HijriCalendar.fromDate(DateTime(year, 12, 31)).hYear;
      for (int hy = hStart - 1; hy <= hEnd + 1; hy++) {
        if (event.hijriYear != 0 && event.hijriYear != hy) continue;
        try {
          final DateTime dt = HijriCalendar()
              .hijriToGregorian(hy, event.hijriMonth, event.hijriDay);
          if (dt.year == year) {
            return dt;
          }
        } catch (_) {}
      }
    } catch (_) {}

    return null;
  }

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
          (e.hijriYear == 0 || hjYear == null || e.hijriYear == hjYear) &&
          (hjMonth == null || e.hijriMonth == hjMonth) &&
          (hjDay == null || e.hijriDay == hjDay));
      for (var ev in matches) {
        final resolvedEvent = IslamicEvent(
          title: ev.title,
          subtitle: ev.subtitle,
          hijriMonth: ev.hijriMonth,
          hijriDay: ev.hijriDay,
          hijriYear: hjYear ?? ev.hijriYear,
          description: ev.description,
          iconType: ev.iconType,
          hijriDate:
              '${ev.hijriDay} ${_mapHijriMonthToSwedish(_getHijriMonthNameStandard(ev.hijriMonth))} ${hjYear ?? ""}'
                  .trim(),
          gregorianDate:
              '${_getWeekdayAbbrSwedish(dayDate.weekday)}, ${dayDate.day} ${_getGregorianMonthNameSwedish(dayDate.month)}',
          isMajorHoliday: ev.isMajorHoliday,
        );
        list.add(EventOccurrence(
          event: resolvedEvent,
          gregorianDate: dayDate,
          hijriDate: hj,
        ));
      }
    }
    list.sort((a, b) => a.gregorianDate.compareTo(b.gregorianDate));
    return list;
  }

  IslamicEvent? _getEventForDate(DateTime date) {
    if (isLoading) return null;
    final hj = getHijriDate(date);
    final int? hjYear = castToType<int>(hj['Hijri_Year'] ?? hj['HijriYear']);
    final int? hjMonth =
        castToType<int>(hj['Hijri_Month_No'] ?? hj['HijriMonthNo']);
    final int? hjDay = castToType<int>(hj['Hijri_Day'] ?? hj['HijriDay']);
    if (hjMonth == null || hjDay == null) return null;
    final dateStr = DateFormat('yyyy-MM-dd').format(date);
    for (var e in islamicEvents) {
      if (e.gregorianDate.isNotEmpty && e.gregorianDate.startsWith(dateStr)) {
        return e;
      }
      if ((e.hijriYear == 0 || hjYear == null || e.hijriYear == hjYear) &&
          e.hijriMonth == hjMonth &&
          e.hijriDay == hjDay) {
        return e;
      }
    }
    return null;
  }

  bool _hasMajorHoliday(DateTime date) {
    final ev = _getEventForDate(date);
    return ev != null && ev.isMajorHoliday;
  }

  List<EventOccurrence> getEventsForYear(int year) {
    if (isLoading) return [];
    List<EventOccurrence> list = [];
    final Set<String> seen = {};

    for (var ev in islamicEvents) {
      DateTime? gregDate;
      // 1. Direct Gregorian date from file/network event
      if (ev.gregorianDate.isNotEmpty) {
        final parsed = DateTime.tryParse(ev.gregorianDate);
        if (parsed != null && parsed.year == year) {
          gregDate = parsed;
        }
      }

      // 2. Lookup in hijriDateCache
      if (gregDate == null) {
        for (final entry in hijriDateCache.values) {
          final g = entry['Gregorian_Date'] as String?;
          if (g == null || !g.startsWith(year.toString())) continue;
          final eYear =
              castToType<int>(entry['Hijri_Year'] ?? entry['HijriYear']);
          final eMonth =
              castToType<int>(entry['Hijri_Month_No'] ?? entry['HijriMonthNo']);
          final eDay = castToType<int>(entry['Hijri_Day'] ?? entry['HijriDay']);
          if ((ev.hijriYear == 0 || eYear == null || eYear == ev.hijriYear) &&
              eMonth == ev.hijriMonth &&
              eDay == ev.hijriDay) {
            gregDate = DateTime.tryParse(g);
            break;
          }
        }
      }

      // 3. Fallback to HijriCalendar conversion
      if (gregDate == null) {
        final int hStart = HijriCalendar.fromDate(DateTime(year, 1, 1)).hYear;
        final int hEnd = HijriCalendar.fromDate(DateTime(year, 12, 31)).hYear;
        for (int hy = hStart - 1; hy <= hEnd + 1; hy++) {
          if (ev.hijriYear != 0 && ev.hijriYear != hy) continue;
          try {
            final dt = HijriCalendar()
                .hijriToGregorian(hy, ev.hijriMonth, ev.hijriDay);
            if (dt.year == year) {
              gregDate = dt;
              break;
            }
          } catch (_) {}
        }
      }

      if (gregDate != null && gregDate.year == year) {
        final key =
            '${ev.title}_${gregDate.year}_${gregDate.month}_${gregDate.day}';
        if (seen.contains(key)) continue;
        seen.add(key);

        final hj = getHijriDate(gregDate);
        final int hy = castToType<int>(hj['Hijri_Year'] ?? hj['HijriYear']) ??
            (ev.hijriYear != 0
                ? ev.hijriYear
                : HijriCalendar.fromDate(gregDate).hYear);
        final resolvedEvent = IslamicEvent(
          title: ev.title,
          subtitle: ev.subtitle,
          hijriMonth: ev.hijriMonth,
          hijriDay: ev.hijriDay,
          hijriYear: hy,
          description: ev.description,
          iconType: ev.iconType,
          hijriDate:
              '${ev.hijriDay} ${_mapHijriMonthToSwedish(_getHijriMonthNameStandard(ev.hijriMonth))} $hy',
          gregorianDate:
              '${_getWeekdayAbbrSwedish(gregDate.weekday)}, ${gregDate.day} ${_getGregorianMonthNameSwedish(gregDate.month)}',
          isMajorHoliday: ev.isMajorHoliday,
        );
        list.add(EventOccurrence(
          event: resolvedEvent,
          gregorianDate: gregDate,
          hijriDate: hj,
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
    if (y <= 2028) {
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
    if (y >= 2025) {
      setState(() {
        currentDate = DateTime(y, m, 1);
      });
      loadCalendarDataForYear(y);
    }
  }

  // =========================================================================
  // VIEW BUILDERS
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
          // 1. Custom Tab Bar (Månadsvy & Kommande händelser)
          _buildTabBar(),

          // 2. Main content
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF154432)))
                : (selectedTab == 0)
                    ? _buildCalendarMainView()
                    : _buildUpcomingEventsView(),
          ),
        ],
      ),
    );
  }

  // TAB BAR WIDGET – TWO SEPARATED PILLS
  Widget _buildTabBar() {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget buildPillTab({
      required int tabIndex,
      required IconData icon,
      required String label,
    }) {
      final isSelected = selectedTab == tabIndex;
      return Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedTab = tabIndex;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? theme.primary : theme.secondaryBackground,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(
                color: isSelected
                    ? theme.primary
                    : (isDark ? theme.alternate : const Color(0xFFE2E8F0)),
                width: 1.0,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: theme.primary.withValues(alpha: 0.3),
                        blurRadius: 6.0,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 16.0,
                  color: isSelected ? Colors.white : theme.secondaryText,
                ),
                const SizedBox(width: 6.0),
                Text(
                  label,
                  maxLines: 1,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.0,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? Colors.white : theme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 6.0),
      child: Row(
        children: [
          // Distinct Pill 1: Månadsvy
          buildPillTab(
            tabIndex: 0,
            icon: Icons.calendar_month_rounded,
            label: 'Månadsvy',
          ),
          // Distinct visible spacing/gap between the two buttons
          const SizedBox(width: 10.0),
          // Distinct Pill 2: Kommande
          buildPillTab(
            tabIndex: 1,
            icon: Icons.access_time_rounded,
            label: 'Kommande',
          ),
        ],
      ),
    );
  }

  // 1. CATEGORY FILTER (TOP BAR) – COMPACT HEIGHT
  Widget _buildCategoryFilterPills() {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> categories = [
      {
        'label': 'Alla',
        'icon': Icons.grid_view_rounded,
        'color': theme.primary,
      },
      {
        'label': 'Fasta',
        'icon': Icons.nightlight_round,
        'color': HabitTrackerService.colorFasting,
      },
      {
        'label': 'Koran',
        'icon': Icons.menu_book_rounded,
        'color': HabitTrackerService.colorQuran,
      },
      {
        'label': 'Bön',
        'icon': Icons.mosque_rounded,
        'color': HabitTrackerService.colorPrayer,
      },
      {
        'label': 'Dhikr',
        'icon': Icons.lightbulb_outline_rounded,
        'color': HabitTrackerService.colorDhikr,
      },
      {
        'label': 'Välgörenhet',
        'icon': Icons.favorite_rounded,
        'color': HabitTrackerService.colorCharity,
      },
      {
        'label': 'Eget',
        'icon': Icons.person_outline_rounded,
        'color': HabitTrackerService.colorCustom,
      },
    ];

    return Container(
      margin: const EdgeInsets.only(top: 1.0, bottom: 6.0),
      height: 42.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8.0),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final String label = cat['label'] as String;
          final IconData icon = cat['icon'] as IconData;
          final Color catColor = cat['color'] as Color;
          final bool isSelected = selectedCategory == label;

          // Keep all category chips in their default pastel colors at all times:
          final Color cardBg = catColor.withValues(alpha: isDark ? 0.25 : 0.16);
          final Color textColor =
              isDark ? catColor.withValues(alpha: 0.95) : catColor;
          final Color iconColor = catColor;

          // Selected State: Indicate that a category filter is active ONLY by
          // applying a green outer border/outline around the chip.
          final Border border = isSelected
              ? Border.all(
                  color: theme.primary,
                  width: 2.0,
                )
              : Border.all(
                  color: catColor.withValues(alpha: isDark ? 0.40 : 0.28),
                  width: 1.0,
                );

          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedCategory == label && label != 'Alla') {
                  selectedCategory = 'Alla';
                } else {
                  selectedCategory = label;
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 9.0, vertical: 2.0),
              constraints: const BoxConstraints(minWidth: 46.0),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(10.0),
                border: border,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 14.5, color: iconColor),
                  const SizedBox(height: 1.0),
                  Text(
                    label,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10.0,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 1. MÅNADSVY SCREEN (CALENDAR VIEW)
  Widget _buildCalendarMainView() {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final firstDay = DateTime(currentDate.year, currentDate.month, 1);
    final emptyCells = firstDay.weekday - 1; // Mon=1, ..., Sun=7
    final totalDaysInCurrentMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;

    List<Widget> cellWidgets = [];

    // Empty blank cells before first day of current month (framed/clean grid per Screenshot_10-27_1.png)
    for (int i = 0; i < emptyCells; i++) {
      cellWidgets.add(const SizedBox(height: 42.0));
    }

    // Days of current month
    for (int d = 1; d <= totalDaysInCurrentMonth; d++) {
      final cellDate = DateTime(currentDate.year, currentDate.month, d);
      cellWidgets.add(_buildCalendarCell(cellDate));
    }

    // Empty blank cells to complete the 7-column grid
    while (cellWidgets.length % 7 != 0) {
      cellWidgets.add(const SizedBox(height: 42.0));
    }

    List<TableRow> tableRows = [];
    for (int i = 0; i < cellWidgets.length; i += 7) {
      tableRows.add(TableRow(
        children: cellWidgets.sublist(i, i + 7),
      ));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Category Filter Pills (Alla, Fasta, Koran, Bön, Dhikr, Välgörenhet, Eget)
                  _buildCategoryFilterPills(),

                  // Daily Progress Counter (re-activated from v1.25)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: _buildDailyProgressCounter(theme, isDark),
                  ),

                  // Calendar Card Container with Swipe gesture support
                  GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity != null) {
                        if (details.primaryVelocity! < -200) {
                          nextMonth(); // Swiped left -> next month
                        } else if (details.primaryVelocity! > 200) {
                          prevMonth(); // Swiped right -> prev month
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: isDark
                              ? theme.alternate
                              : const Color(0xFFE2E8F0),
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withValues(alpha: isDark ? 0.25 : 0.05),
                            blurRadius: 10.0,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Column(
                        children: [
                          // Month Header (< September 2026 > and Rabi' al-awwal 1448)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                    minWidth: 36, minHeight: 36),
                                icon: const Icon(Icons.chevron_left_rounded,
                                    size: 24),
                                color: theme.primary,
                                onPressed: prevMonth,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${_getGregorianMonthNameSwedish(currentDate.month)} ${currentDate.year}',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w700,
                                      color: theme.primaryText,
                                    ),
                                  ),
                                  const SizedBox(height: 1.5),
                                  Text(
                                    getMonthHeaderSubtitle(),
                                    style: GoogleFonts.manrope(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: theme.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(
                                    minWidth: 36, minHeight: 36),
                                icon: const Icon(Icons.chevron_right_rounded,
                                    size: 24),
                                color: theme.primary,
                                onPressed: nextMonth,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),

                          // Weekday Headers (Mån, Tis, Ons, Tor, Fre, Lör, Sön)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(7, (index) {
                              return Expanded(
                                child: Center(
                                  child: Text(
                                    _getWeekdayAbbrSwedish(index + 1),
                                    style: GoogleFonts.manrope(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600,
                                      color: theme.secondaryText,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 8.0),

                          // Month Grid with Continuous Framed Borders around all four rounded corners
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: isDark
                                    ? const Color(0xFF334155)
                                    : const Color(0xFFE2E8F0),
                                width: 0.8,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.2),
                              child: Table(
                                border: TableBorder(
                                  horizontalInside: BorderSide(
                                    color: isDark
                                        ? const Color(0xFF334155)
                                        : const Color(0xFFE2E8F0),
                                    width: 0.8,
                                  ),
                                  verticalInside: BorderSide(
                                    color: isDark
                                        ? const Color(0xFF334155)
                                        : const Color(0xFFE2E8F0),
                                    width: 0.8,
                                  ),
                                ),
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: tableRows,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Spacer pushes bottom buttons to bottom of screen if space permits,
                  // ensuring they NEVER overlap the calendar dates!
                  const Spacer(),
                  const SizedBox(height: 10.0),

                  // Dual Floating / Bottom Action Buttons (FAB) aligned on exact same baseline
                  _buildBottomActionButtons(theme, isDark),

                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // BOTTOM ACTION BUTTONS: [ 📅 Idag ] and [ ➕ ]
  // [ 📅 Idag ] is HIDDEN when on current month, and ONLY rendered when navigated to a different month
  Widget _buildBottomActionButtons(FlutterFlowTheme theme, bool isDark) {
    const double actionHeight = 46.0;
    final now = DateTime.now();
    final bool isViewingCurrentMonth =
        currentDate.year == now.year && currentDate.month == now.month;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: isViewingCurrentMonth
            ? MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bottom-Left: [ 📅 Idag ] - ONLY rendered when swiped/navigated away to a different month
          if (!isViewingCurrentMonth)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  final n = DateTime.now();
                  setState(() {
                    currentDate = DateTime(n.year, n.month, 1);
                    selectedDate = n;
                  });
                  loadCalendarDataForYear(n.year);
                },
                borderRadius: BorderRadius.circular(actionHeight / 2),
                child: Container(
                  height: actionHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(actionHeight / 2),
                    border: Border.all(
                      color: theme.primary.withValues(alpha: 0.35),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                        blurRadius: 8.0,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 15.0,
                        color: theme.primary,
                      ),
                      const SizedBox(width: 7.0),
                      Text(
                        'Idag',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: theme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Bottom-Right: [ ➕ ] – EXACT SAME HEIGHT & ALIGNMENT
          SizedBox(
            width: actionHeight,
            height: actionHeight,
            child: FloatingActionButton(
              heroTag: 'calendar_add_fab',
              backgroundColor: theme.primary,
              elevation: 4.0,
              shape: const CircleBorder(),
              onPressed: () =>
                  _showQuickMenuModal(selectedDate ?? DateTime.now()),
              child: const Icon(Icons.add, color: Colors.white, size: 24.0),
            ),
          ),
        ],
      ),
    );
  }

  // 3. DATE CELL LAYOUT: INLINE GREGORIAN + HIJRI e.g. "21 (10)" + ENLARGED ACTIVITY DOTS & FRAMED SELECTION
  Widget _buildCalendarCell(DateTime date) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hj = getHijriDate(date);
    final int hijriDay =
        castToType<int>(hj['Hijri_Day'] ?? hj['HijriDay']) ?? 1;
    final int hjMonth =
        castToType<int>(hj['Hijri_Month_No'] ?? hj['HijriMonthNo']) ?? 1;

    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final isSelected = selectedDate != null &&
        date.year == selectedDate!.year &&
        date.month == selectedDate!.month &&
        date.day == selectedDate!.day;

    final specialEvent = _getEventForDate(date);
    final bool isMajorHoliday = specialEvent?.isMajorHoliday ?? false;
    List<Color> indicatorDots = _habitService.getIndicatorDotsForDate(
      gregorianDate: date,
      hijriDay: hijriDay,
      hijriMonth: hjMonth,
      categoryFilter: selectedCategory,
    );
    if (isMajorHoliday) {
      const holidayColor = Color(0xFF10B981);
      if (!indicatorDots.contains(holidayColor)) {
        indicatorDots = [holidayColor, ...indicatorDots].take(4).toList();
      }
    }

    BoxDecoration? cellDecoration;
    Color gregorianColor;
    Color hijriColor;

    if (isToday) {
      // Today's Date: Highlight with our standard green background
      cellDecoration = BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(8.0),
      );
      gregorianColor = Colors.white;
      hijriColor = Colors.white.withValues(alpha: 0.85);
    } else if (isSelected) {
      // Selected Date: Highlight with a subtle/light green background & green border to distinguish from today
      cellDecoration = BoxDecoration(
        color: theme.primary.withValues(alpha: isDark ? 0.25 : 0.12),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: theme.primary,
          width: 1.5,
        ),
      );
      gregorianColor = theme.primaryText;
      hijriColor = theme.secondaryText;
    } else {
      cellDecoration = null;
      gregorianColor = theme.primaryText;
      hijriColor = theme.secondaryText;
    }

    return SizedBox(
      height: 42.0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            selectedDate = date;
          });
          _showDayModalBottomSheet(date);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
          decoration: cellDecoration,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Dedicated Special Islamic Event Icon (e.g. celebration, mosque, star, kaaba, moon)
              if (specialEvent != null)
                Positioned(
                  top: 2.0,
                  right: 2.5,
                  child: Icon(
                    _getEventIconData(specialEvent.iconType),
                    size: 9.5,
                    color: isToday
                        ? Colors.white
                        : (isDark
                            ? const Color(0xFF34D399)
                            : const Color(0xFF047857)),
                  ),
                ),

              // Gregorian + Hijri on the same horizontal line, perfectly centered
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${date.day} ',
                            style: GoogleFonts.manrope(
                              fontSize: 14.5,
                              fontWeight:
                                  isToday ? FontWeight.w800 : FontWeight.w700,
                              color: gregorianColor,
                            ),
                          ),
                          TextSpan(
                            text: '($hijriDay)',
                            style: GoogleFonts.manrope(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: hijriColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Activity Indicator Dots: positioned at the bottom so date text remains perfectly centered
              if (indicatorDots.isNotEmpty)
                Positioned(
                  bottom: 2.5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: indicatorDots.take(4).map((c) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0.8),
                            width: 5.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                              color: c,
                              shape: BoxShape.circle,
                              border: isToday
                                  ? Border.all(color: Colors.white, width: 1.0)
                                  : null,
                              boxShadow: isToday
                                  ? [
                                      BoxShadow(
                                        color: Colors.black
                                            .withValues(alpha: 0.35),
                                        blurRadius: 1.0,
                                        offset: const Offset(0, 0.5),
                                      ),
                                    ]
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // 2. DAY MODAL (BOTTOM SHEET) – ON DATE CLICK
  // =========================================================================
  void _showDayModalBottomSheet(DateTime date) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _DayModalContent(
          date: date,
          dayEvent: _getEventForDate(date),
          habitService: _habitService,
          getHijriDate: getHijriDate,
          mapHijriMonthToSwedish: _mapHijriMonthToSwedish,
          getWeekdayNameSwedish: _getWeekdayNameSwedish,
          getGregorianMonthNameSwedish: _getGregorianMonthNameSwedish,
          onAddActivity: (selectedDate) {
            Navigator.of(ctx).pop();
            _showQuickMenuModal(selectedDate);
          },
          onEditActivity: (activity) {
            _showActivityCreationModal(
              date: activity.date,
              initialCategoryKey: activity.categoryKey,
              initialActivity: activity,
            );
          },
          onChanged: () {
            setState(() {});
          },
        );
      },
    );
  }

  // =========================================================================
  // 3. QUICK MENU ON ( ➕ ) TAP
  // =========================================================================
  void _showQuickMenuModal(DateTime date) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final categories = [
      {
        'key': 'custom',
        'title': 'Egen aktivitet',
        'color': HabitTrackerService.colorCustom,
        'icon': Icons.person_rounded,
      },
      {
        'key': 'fasting',
        'title': 'Fasta',
        'color': HabitTrackerService.colorFasting,
        'icon': Icons.nightlight_round,
      },
      {
        'key': 'quran',
        'title': 'Koran',
        'color': HabitTrackerService.colorQuran,
        'icon': Icons.menu_book_rounded,
      },
      {
        'key': 'prayers',
        'title': 'Bön',
        'color': HabitTrackerService.colorPrayer,
        'icon': Icons.mosque_rounded,
      },
      {
        'key': 'dhikr',
        'title': 'Dhikr',
        'color': HabitTrackerService.colorDhikr,
        'icon': Icons.fingerprint_rounded,
      },
      {
        'key': 'charity',
        'title': 'Välgörenhet',
        'color': HabitTrackerService.colorCharity,
        'icon': Icons.volunteer_activism_rounded,
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.88,
          ),
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24.0)),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    theme.designToken.spacing.md,
                    theme.designToken.spacing.md,
                    theme.designToken.spacing.md,
                    0.0,
                  ),
                  child: const BottomSheetIconWidget(),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      theme.designToken.spacing.md,
                      0.0,
                      theme.designToken.spacing.md,
                      theme.designToken.spacing.md +
                          MediaQuery.of(ctx).padding.bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Välj kategori',
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.plusJakartaSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14.0),
                        Column(
                          children: categories.map((cat) {
                            final Color c = cat['color'] as Color;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              decoration: BoxDecoration(
                                color: theme.primaryBackground,
                                borderRadius: BorderRadius.circular(14.0),
                                border: Border.all(
                                  color: theme.alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(14.0),
                                  onTap: () {
                                    Navigator.of(ctx).pop();
                                    _showActivityCreationModal(
                                      date: date,
                                      initialCategoryKey: cat['key'] as String,
                                      initialColor: c,
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 36.0,
                                          height: 36.0,
                                          decoration: BoxDecoration(
                                            color: c.withValues(alpha: 0.15),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            cat['icon'] as IconData,
                                            color: c,
                                            size: 18.0,
                                          ),
                                        ),
                                        const SizedBox(width: 14.0),
                                        Expanded(
                                          child: Text(
                                            cat['title'] as String,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: theme.primaryText,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.chevron_right,
                                            color: theme.secondaryText,
                                            size: 20.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================================
  // 4. ACTIVITY CREATION MODAL (FORM)
  // =========================================================================
  void _showActivityCreationModal({
    required DateTime date,
    String initialCategoryKey = 'custom',
    Color initialColor = const Color(0xFF8E44AD),
    CustomCalendarActivity? initialActivity,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _ActivityCreationFormModal(
          initialDate: date,
          initialCategoryKey: initialCategoryKey,
          initialActivity: initialActivity,
          habitService: _habitService,
          getGregorianMonthNameSwedish: _getGregorianMonthNameSwedish,
          onSaved: () {
            setState(() {});
          },
        );
      },
    );
  }

  // DAILY PROGRESS COUNTER COMPONENT (Re-activated from v1.25)
  Widget _buildDailyProgressCounter(FlutterFlowTheme theme, bool isDark) {
    final now = DateTime.now();
    return FutureBuilder<Map<String, dynamic>>(
      future: _habitService.getProgressStatistics(
        now,
        getHijriDate: getHijriDate,
      ),
      builder: (context, snapshot) {
        final stats = snapshot.data;
        final dayStats = stats?['day'] as Map<String, dynamic>?;
        final int completed = dayStats?['completed'] ?? 0;
        final int total = dayStats?['total'] ?? 0;
        final double rate = (dayStats?['rate'] as num?)?.toDouble() ?? 0.0;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (_) => CalendarProgressPage(
                        habitService: _habitService,
                        getHijriDate: getHijriDate,
                      ),
                    ),
                  )
                  .then((_) => setState(() {}));
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: isDark ? theme.alternate : const Color(0xFFE2E8F0),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                    blurRadius: 6.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: theme.primary.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.trending_up_rounded,
                              color: theme.primary,
                              size: 16.0,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Dagens framsteg',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: theme.primaryText,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            total > 0
                                ? '$completed av $total (${(rate * 100).round()}%)'
                                : 'Inga aktiva vanor',
                            style: GoogleFonts.manrope(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: theme.primary,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 18.0,
                            color: theme.secondaryText,
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (total > 0) ...[
                    const SizedBox(height: 8.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: LinearProgressIndicator(
                        value: rate,
                        minHeight: 6.0,
                        backgroundColor: isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(theme.primary),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 2. KOMMANDE HÄNDELSER SCREEN
  Widget _buildUpcomingEventsView() {
    final theme = FlutterFlowTheme.of(context);
    final int displayYear = _selectedUpcomingYear ?? currentDate.year;
    final int activeYear = availableYears.contains(displayYear)
        ? displayYear
        : (availableYears.isNotEmpty ? availableYears.first : 2026);
    final yearEvents = getEventsForYear(activeYear);
    final majorHolidays =
        yearEvents.where((oe) => oe.event.isMajorHoliday).toList();

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
    final sortedMonthsKeys = groupedByMonth.keys.toList()..sort();

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'VIKTIGA ISLAMISKA DAGAR',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryText,
                    letterSpacing: 0.5,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.secondaryBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: theme.alternate, width: 1.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<int>(
                      value: activeYear,
                      icon: Icon(Icons.keyboard_arrow_down_rounded,
                          color: theme.primary, size: 20),
                      isDense: true,
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryText,
                      ),
                      dropdownColor: theme.secondaryBackground,
                      items: availableYears.map((y) {
                        return DropdownMenuItem<int>(
                          value: y,
                          child: Text(y.toString()),
                        );
                      }).toList(),
                      onChanged: (newYear) {
                        if (newYear != null) {
                          setState(() {
                            _selectedUpcomingYear = newYear;
                          });
                          loadCalendarDataForYear(newYear);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (isLoading)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: theme.primary,
                  ),
                ),
              )
            else if (yearEvents.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Text(
                    'Inga händelser hittades för $activeYear',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: theme.secondaryText,
                    ),
                  ),
                ),
              )
            else ...[
              if (majorHolidays.isNotEmpty)
                ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: majorHolidays.length,
                  separatorBuilder: (context, idx) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return _buildUpcomingEventCard(majorHolidays[index]);
                  },
                ),
              if (sortedMonthsKeys.isNotEmpty) const SizedBox(height: 20),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sortedMonthsKeys.length,
                itemBuilder: (context, index) {
                  final monthNo = sortedMonthsKeys[index];
                  final monthEvents = groupedByMonth[monthNo]!;
                  final monthName = _mapHijriMonthToSwedish(
                          _getHijriMonthNameStandard(monthNo))
                      .toUpperCase();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 8.0),
                        child: Text(
                          'MÅNADEN $monthName',
                          style: GoogleFonts.manrope(
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
            ],
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingEventCard(EventOccurrence occurrence) {
    final theme = FlutterFlowTheme.of(context);
    final isNotified = activeNotifications[occurrence.event.title] ?? false;

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
          onTap: () => _showEventDetailModal(occurrence),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: Row(
              children: [
                // Category / Event Icon
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: theme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: _buildEventIconWidget(
                      occurrence.event.iconType,
                      title: occurrence.event.title,
                      size: 20.0,
                      color: theme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),

                // Event Title & Dates
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        occurrence.event.title,
                        style: GoogleFonts.manrope(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryText,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      Text(
                        '${occurrence.event.hijriDate} • ${occurrence.event.gregorianDate}',
                        style: GoogleFonts.manrope(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: theme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),

                // Calendar Icon — jump to this date in calendar view
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = 0;
                      selectedEvent = occurrence;
                      selectedDate = occurrence.gregorianDate;
                      currentDate = DateTime(
                        occurrence.gregorianDate.year,
                        occurrence.gregorianDate.month,
                        1,
                      );
                    });
                    loadCalendarDataForYear(occurrence.gregorianDate.year);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 8.0),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: theme.secondaryText,
                      size: 22.0,
                    ),
                  ),
                ),

                // Bell Icon (🔔) toggle for holiday notifications
                GestureDetector(
                  onTap: () => _toggleEventNotification(
                      occurrence.event, occurrence.gregorianDate),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 8.0),
                    child: Icon(
                      isNotified
                          ? Icons.notifications_active_rounded
                          : Icons.notifications_none_rounded,
                      color: isNotified ? theme.primary : theme.secondaryText,
                      size: 22.0,
                    ),
                  ),
                ),
                const SizedBox(width: 4.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEventDetailModal(EventOccurrence occurrence) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final String description = occurrence.event.description;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final isNotified =
                activeNotifications[occurrence.event.title] ?? false;
            return Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.88,
              ),
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              child: SafeArea(
                top: false,
                bottom: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        theme.designToken.spacing.md,
                        theme.designToken.spacing.md,
                        theme.designToken.spacing.md,
                        0.0,
                      ),
                      child: const BottomSheetIconWidget(),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          theme.designToken.spacing.md,
                          0.0,
                          theme.designToken.spacing.md,
                          theme.designToken.spacing.md +
                              MediaQuery.of(ctx).padding.bottom,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header row with Icon, Title, and Bell Toggle
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 44.0,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    color:
                                        theme.primary.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Center(
                                    child: _buildEventIconWidget(
                                      occurrence.event.iconType,
                                      title: occurrence.event.title,
                                      size: 24.0,
                                      color: theme.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        occurrence.event.title,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700,
                                          color: theme.primaryText,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        '${occurrence.event.hijriDate} • ${occurrence.event.gregorianDate}',
                                        style: GoogleFonts.manrope(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          color: theme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    isNotified
                                        ? Icons.notifications_active_rounded
                                        : Icons.notifications_none_rounded,
                                    color: isNotified
                                        ? theme.primary
                                        : theme.secondaryText,
                                    size: 24.0,
                                  ),
                                  onPressed: () async {
                                    await _toggleEventNotification(
                                        occurrence.event,
                                        occurrence.gregorianDate);
                                    setModalState(() {});
                                  },
                                ),
                              ],
                            ),

                            if (description.isNotEmpty) ...[
                              const SizedBox(height: 16.0),
                              const Divider(height: 1.0, thickness: 1.0),
                              const SizedBox(height: 16.0),
                              Text(
                                'Om denna dag',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: theme.primaryText,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                description,
                                style: GoogleFonts.manrope(
                                  fontSize: 14.0,
                                  height: 1.6,
                                  color: theme.primaryText,
                                ),
                              ),
                            ],

                            const SizedBox(height: 24.0),

                            // "Visa i kalendern" (View in calendar) button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0),
                                ),
                                icon: const Icon(Icons.calendar_month_rounded,
                                    color: Colors.white, size: 20.0),
                                label: Text(
                                  'Visa i kalendern',
                                  style: GoogleFonts.manrope(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  setState(() {
                                    selectedTab = 0;
                                    selectedEvent = occurrence;
                                    selectedDate = occurrence.gregorianDate;
                                    currentDate = DateTime(
                                      occurrence.gregorianDate.year,
                                      occurrence.gregorianDate.month,
                                      1,
                                    );
                                  });
                                  loadCalendarDataForYear(
                                      occurrence.gregorianDate.year);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// =========================================================================
// SUB-WIDGET: DAY MODAL CONTENT
// =========================================================================
class _DayModalContent extends StatefulWidget {
  final DateTime date;
  final IslamicEvent? dayEvent;
  final HabitTrackerService habitService;
  final Map<String, dynamic> Function(DateTime) getHijriDate;
  final String Function(String) mapHijriMonthToSwedish;
  final String Function(int) getWeekdayNameSwedish;
  final String Function(int) getGregorianMonthNameSwedish;
  final Function(DateTime) onAddActivity;
  final Function(CustomCalendarActivity)? onEditActivity;
  final VoidCallback onChanged;

  const _DayModalContent({
    required this.date,
    this.dayEvent,
    required this.habitService,
    required this.getHijriDate,
    required this.mapHijriMonthToSwedish,
    required this.getWeekdayNameSwedish,
    required this.getGregorianMonthNameSwedish,
    required this.onAddActivity,
    this.onEditActivity,
    required this.onChanged,
  });

  @override
  State<_DayModalContent> createState() => _DayModalContentState();
}

class _DayModalContentState extends State<_DayModalContent> {
  Set<String> _completedHabits = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCompletion();
  }

  Future<void> _loadCompletion() async {
    final completed =
        await widget.habitService.getCompletedHabitsForDate(widget.date);
    if (mounted) {
      setState(() {
        _completedHabits = completed;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hj = widget.getHijriDate(widget.date);
    final int hijriDay =
        castToType<int>(hj['Hijri_Day'] ?? hj['HijriDay']) ?? 1;
    final int hjMonth =
        castToType<int>(hj['Hijri_Month_No'] ?? hj['HijriMonthNo']) ?? 1;
    final int hjYear = castToType<int>(hj['Hijri_Year'] ?? hj['HijriYear']) ??
        HijriCalendar.fromDate(widget.date).hYear;
    final String rawHjName = hj['Hijri_Month_Name']?.toString() ??
        hj['HijriMonthName']?.toString() ??
        'Rabi al-Awwal';
    final String hjMonthName = widget.mapHijriMonthToSwedish(rawHjName);

    final String weekday = widget.getWeekdayNameSwedish(widget.date.weekday);
    final String monthName =
        widget.getGregorianMonthNameSwedish(widget.date.month);

    final habits = widget.habitService.getScheduledHabitsForDate(
      gregorianDate: widget.date,
      hijriDay: hijriDay,
      hijriMonth: hjMonth,
      categoryFilter: 'Alla',
    );
    final customActivities = widget.habitService
        .getCustomActivitiesForDate(widget.date, categoryFilter: 'Alla');

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                theme.designToken.spacing.md,
                theme.designToken.spacing.md,
                theme.designToken.spacing.md,
                0.0,
              ),
              child: const BottomSheetIconWidget(),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  theme.designToken.spacing.md,
                  0.0,
                  theme.designToken.spacing.md,
                  theme.designToken.spacing.md +
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Torsdag 24 September 2026 & (12 Rabi' al-Awwal 1448)
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$weekday ${widget.date.day} $monthName ${widget.date.year}',
                            style: FlutterFlowTheme.of(context)
                                .titleLarge
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '$hijriDay $hjMonthName $hjYear AH',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.manrope(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: theme.primary,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Divider(height: 1.0, thickness: 1.0),
                    const SizedBox(height: 16.0),

                    // Special Islamic Event Banner (if any)
                    if (widget.dayEvent != null) ...[
                      Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: theme.primary
                              .withValues(alpha: isDark ? 0.22 : 0.08),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: theme.primary
                                .withValues(alpha: isDark ? 0.4 : 0.25),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 36.0,
                              height: 36.0,
                              decoration: BoxDecoration(
                                color: theme.primary
                                    .withValues(alpha: isDark ? 0.35 : 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: _buildEventIconWidget(
                                  widget.dayEvent!.iconType,
                                  title: widget.dayEvent!.title,
                                  size: 18.0,
                                  color: theme.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.dayEvent!.title,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: theme.primaryText,
                                    ),
                                  ),
                                  if (widget.dayEvent!.subtitle.isNotEmpty) ...[
                                    const SizedBox(height: 2.0),
                                    Text(
                                      widget.dayEvent!.subtitle,
                                      style: GoogleFonts.manrope(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                        color: theme.primary,
                                      ),
                                    ),
                                  ],
                                  if (widget
                                      .dayEvent!.description.isNotEmpty) ...[
                                    const SizedBox(height: 5.0),
                                    Text(
                                      widget.dayEvent!.description,
                                      style: GoogleFonts.manrope(
                                        fontSize: 11.5,
                                        color: theme.secondaryText,
                                        height: 1.35,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Section Title: Dagens schemalagda aktiviteter:
                    Text(
                      'Dagens schemalagda aktiviteter:',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                        color: theme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // List of activities
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : (habits.isEmpty && customActivities.isEmpty)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24.0),
                                child: Center(
                                  child: Text(
                                    'Inga schemalagda aktiviteter för denna dag.',
                                    style: GoogleFonts.manrope(
                                      fontSize: 13.5,
                                      color: theme.secondaryText,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  // Master habits (full card clickable)
                                  ...habits.map((habit) {
                                    final isDone =
                                        _completedHabits.contains(habit.id);
                                    final String categoryLabel =
                                        _getCategoryLabel(habit.categoryKey);
                                    final String timeStr =
                                        habit.defaultTime.isNotEmpty
                                            ? ' (${habit.defaultTime})'
                                            : '';

                                    return Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      decoration: BoxDecoration(
                                        color: theme.primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: theme.alternate,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          onTap: () async {
                                            final toggled = await widget
                                                .habitService
                                                .toggleHabitCompletion(
                                                    widget.date, habit.id);
                                            setState(() {
                                              if (toggled) {
                                                _completedHabits.add(habit.id);
                                              } else {
                                                _completedHabits
                                                    .remove(habit.id);
                                              }
                                            });
                                            widget.onChanged();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 22.0,
                                                  height: 22.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: isDone
                                                        ? habit.color
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                      color: isDone
                                                          ? habit.color
                                                          : theme.secondaryText,
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: isDone
                                                      ? const Icon(Icons.check,
                                                          size: 14.0,
                                                          color: Colors.white)
                                                      : null,
                                                ),
                                                const SizedBox(width: 10.0),
                                                // Category tag: [🟢 Fasta]
                                                _buildCategoryTag(
                                                    categoryLabel, habit.color),
                                                const SizedBox(width: 8.0),
                                                Expanded(
                                                  child: Text(
                                                    '${habit.title}$timeStr',
                                                    style: GoogleFonts.manrope(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: isDone
                                                          ? theme.secondaryText
                                                          : theme.primaryText,
                                                      decoration: isDone
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),

                                  // Custom user activities (full card clickable)
                                  ...customActivities.map((act) {
                                    final String categoryLabel =
                                        _getCategoryLabel(act.categoryKey);
                                    final String timeStr = act.time.isNotEmpty
                                        ? ' (${act.time})'
                                        : '';

                                    return Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 8.0),
                                      decoration: BoxDecoration(
                                        color: theme.primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: theme.alternate,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          onTap: () async {
                                            await widget.habitService
                                                .toggleCustomActivityCompletion(
                                                    act.id);
                                            setState(() {});
                                            widget.onChanged();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 22.0,
                                                  height: 22.0,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: act.isCompleted
                                                        ? act.categoryColor
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                      color: act.isCompleted
                                                          ? act.categoryColor
                                                          : theme.secondaryText,
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: act.isCompleted
                                                      ? const Icon(Icons.check,
                                                          size: 14.0,
                                                          color: Colors.white)
                                                      : null,
                                                ),
                                                const SizedBox(width: 10.0),
                                                _buildCategoryTag(categoryLabel,
                                                    act.categoryColor),
                                                const SizedBox(width: 8.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${act.title}$timeStr',
                                                        style:
                                                            GoogleFonts.manrope(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: act.isCompleted
                                                              ? theme
                                                                  .secondaryText
                                                              : theme
                                                                  .primaryText,
                                                          decoration: act
                                                                  .isCompleted
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : null,
                                                        ),
                                                      ),
                                                      if (act.notes.isNotEmpty)
                                                        Text(
                                                          act.notes,
                                                          style: GoogleFonts
                                                              .manrope(
                                                            fontSize: 11.5,
                                                            color: theme
                                                                .secondaryText,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.edit_outlined,
                                                      size: 18.0,
                                                      color:
                                                          theme.secondaryText),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    widget.onEditActivity
                                                        ?.call(act);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                      Icons.delete_outline,
                                                      size: 18.0,
                                                      color: Colors.redAccent),
                                                  onPressed: () async {
                                                    await widget.habitService
                                                        .deleteCustomActivity(
                                                            act.id);
                                                    setState(() {});
                                                    widget.onChanged();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                    const SizedBox(height: 16.0),

                    // Button: ➕ Lägg till ny aktivitet
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton.icon(
                        onPressed: () => widget.onAddActivity(widget.date),
                        icon:
                            const Icon(Icons.add_rounded, color: Colors.white),
                        label: Text(
                          'Lägg till ny aktivitet',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7.0,
            height: 7.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5.0),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryLabel(String key) {
    switch (key) {
      case 'fasting':
        return 'Fasta';
      case 'quran':
        return 'Koran';
      case 'prayers':
        return 'Bön';
      case 'dhikr':
        return 'Dhikr';
      case 'charity':
        return 'Välgörenhet';
      case 'custom':
      default:
        return 'Eget';
    }
  }
}

// =========================================================================
// SUB-WIDGET: ACTIVITY CREATION FORM MODAL
// =========================================================================
class _ActivityCreationFormModal extends StatefulWidget {
  final DateTime initialDate;
  final String initialCategoryKey;
  final CustomCalendarActivity? initialActivity;
  final HabitTrackerService habitService;
  final String Function(int) getGregorianMonthNameSwedish;
  final VoidCallback onSaved;

  const _ActivityCreationFormModal({
    required this.initialDate,
    required this.initialCategoryKey,
    this.initialActivity,
    required this.habitService,
    required this.getGregorianMonthNameSwedish,
    required this.onSaved,
  });

  @override
  State<_ActivityCreationFormModal> createState() =>
      _ActivityCreationFormModalState();
}

class _ActivityCreationFormModalState
    extends State<_ActivityCreationFormModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  late DateTime _selectedDate;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 17, minute: 30);
  String _selectedReminderDay = 'Samma dag';
  TimeOfDay _selectedReminderTime = const TimeOfDay(hour: 17, minute: 0);
  late String _selectedCategoryKey;
  String _selectedSound = 'Standard (Systemljud)';
  bool _titleHasError = false;

  final List<Map<String, dynamic>> _categories = [
    {
      'key': 'custom',
      'label': 'Personligt',
      'color': HabitTrackerService.colorCustom,
    },
    {
      'key': 'fasting',
      'label': 'Fasta',
      'color': HabitTrackerService.colorFasting,
    },
    {
      'key': 'quran',
      'label': 'Koran',
      'color': HabitTrackerService.colorQuran,
    },
    {
      'key': 'prayers',
      'label': 'Bön',
      'color': HabitTrackerService.colorPrayer,
    },
    {
      'key': 'dhikr',
      'label': 'Dhikr',
      'color': HabitTrackerService.colorDhikr,
    },
    {
      'key': 'charity',
      'label': 'Välgörenhet',
      'color': HabitTrackerService.colorCharity,
    },
  ];

  static final List<Map<String, dynamic>> _soundList = [
    {
      'name': 'Endast vibration',
      'azanName': FFAppConstants.NullValue,
      'iconType': 'vibration',
    },
    {
      'name': 'Standard (Systemljud)',
      'azanName': SoundName.Standard.name,
      'iconType': 'volume',
    },
    {
      'name': 'Kort Adhan 1',
      'azanName': SoundName.Adhan_1.name,
      'iconType': 'mosque',
    },
    {
      'name': 'Kort Adhan 2',
      'azanName': SoundName.Adhan_2.name,
      'iconType': 'mosque',
    },
    {
      'name': 'Kort Adhan 3',
      'azanName': SoundName.Adhan_3.name,
      'iconType': 'mosque',
    },
    {
      'name': 'Kort Adhan 4',
      'azanName': SoundName.Adhan_4.name,
      'iconType': 'mosque',
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialActivity != null) {
      final act = widget.initialActivity!;
      _titleController.text = act.title;
      _notesController.text = act.notes;
      _selectedDate = act.date;
      _selectedCategoryKey = act.categoryKey;
      _selectedReminderDay = act.reminderDay;
      if (act.sound.toLowerCase().contains('vibration')) {
        _selectedSound = 'Endast vibration';
      } else if (act.sound.contains('1')) {
        _selectedSound = 'Kort Adhan 1';
      } else if (act.sound.contains('2')) {
        _selectedSound = 'Kort Adhan 2';
      } else if (act.sound.contains('3')) {
        _selectedSound = 'Kort Adhan 3';
      } else if (act.sound.contains('4')) {
        _selectedSound = 'Kort Adhan 4';
      } else {
        _selectedSound = 'Standard (Systemljud)';
      }
      if (act.time.contains(':')) {
        final parts = act.time.split(':');
        _selectedTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 17,
          minute: int.tryParse(parts[1]) ?? 30,
        );
      }
    } else {
      _selectedDate = widget.initialDate;
      _selectedCategoryKey = widget.initialCategoryKey;
    }

    _titleController.addListener(() {
      if (_titleHasError && _titleController.text.trim().isNotEmpty) {
        setState(() {
          _titleHasError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Color _getCategoryColor(String key) {
    final found = _categories.firstWhere((c) => c['key'] == key,
        orElse: () => _categories.first);
    return found['color'] as Color;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2028),
      helpText: 'Välj datum',
      cancelText: 'Avbryt',
      confirmText: 'Välj',
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      helpText: 'Välj tid',
      cancelText: 'Avbryt',
      confirmText: 'Välj',
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _pickReminderTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedReminderTime,
      helpText: 'Välj påminnelsetid',
      cancelText: 'Avbryt',
      confirmText: 'Välj',
    );
    if (picked != null) {
      setState(() {
        _selectedReminderTime = picked;
      });
    }
  }

  Widget _buildSoundIcon(String iconType, bool isDark) {
    if (iconType == 'vibration') {
      return Icon(
        Icons.vibration_outlined,
        size: 22.0,
        color: FlutterFlowTheme.of(context).primaryText,
      );
    } else if (iconType == 'volume') {
      return Icon(
        Icons.volume_up_rounded,
        size: 22.0,
        color: FlutterFlowTheme.of(context).primaryText,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Image.asset(
          isDark
              ? 'assets/images/Screenshot_2026-08-01_at_6.26.29_PM.png'
              : 'assets/images/iconMosque.png',
          width: 24.0,
          height: 24.0,
          fit: BoxFit.contain,
        ),
      );
    }
  }

  void _showSoundSelectionBottomSheet() {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (modalCtx, setModalState) {
            return Container(
              padding: EdgeInsets.fromLTRB(
                16.0,
                12.0,
                16.0,
                16.0 + MediaQuery.of(ctx).padding.bottom,
              ),
              decoration: BoxDecoration(
                color: theme.primaryBackground,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: BottomSheetIconWidget()),
                  const SizedBox(height: 12.0),
                  Text(
                    'Påminnelseljud',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryText,
                    ),
                  ),
                  const SizedBox(height: 14.0),
                  ..._soundList.map((opt) {
                    final isSelected = _selectedSound == opt['name'];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12.0),
                          onTap: () async {
                            setState(() {
                              _selectedSound = opt['name'] as String;
                            });
                            setModalState(() {});
                            final azanName = opt['azanName'] as String?;
                            if (azanName != null &&
                                azanName != FFAppConstants.NullValue) {
                              try {
                                await audioPlay(azanName);
                              } catch (_) {}
                            }
                            if (mounted) {
                              Navigator.of(ctx).pop();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 46.0,
                                  height: 46.0,
                                  decoration: BoxDecoration(
                                    color: theme.primaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: _buildSoundIcon(
                                        opt['iconType'] as String, isDark),
                                  ),
                                ),
                                const SizedBox(width: 14.0),
                                Expanded(
                                  child: Text(
                                    opt['name'] as String,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w600,
                                      color: theme.primaryText,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 22.0,
                                  height: 22.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF10B981)
                                          : theme.secondaryText,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Center(
                                          child: Container(
                                            width: 10.0,
                                            height: 10.0,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF10B981),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      setState(() {
        _titleHasError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vänligen ange en titel för aktiviteten',
            style: GoogleFonts.manrope(),
          ),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    final formattedTime =
        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
    final formattedReminderTime =
        'kl. ${_selectedReminderTime.hour.toString().padLeft(2, '0')}:${_selectedReminderTime.minute.toString().padLeft(2, '0')}';

    if (widget.initialActivity != null) {
      final updated = CustomCalendarActivity(
        id: widget.initialActivity!.id,
        title: title,
        categoryKey: _selectedCategoryKey,
        categoryColor: _getCategoryColor(_selectedCategoryKey),
        date: _selectedDate,
        time: formattedTime,
        reminderDay: _selectedReminderDay,
        reminderTime: formattedReminderTime,
        sound: _selectedSound,
        notes: _notesController.text.trim(),
        isCompleted: widget.initialActivity!.isCompleted,
      );
      await widget.habitService.updateCustomActivity(updated);
    } else {
      final newActivity = CustomCalendarActivity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        categoryKey: _selectedCategoryKey,
        categoryColor: _getCategoryColor(_selectedCategoryKey),
        date: _selectedDate,
        time: formattedTime,
        reminderDay: _selectedReminderDay,
        reminderTime: formattedReminderTime,
        sound: _selectedSound,
        notes: _notesController.text.trim(),
      );
      await widget.habitService.addCustomActivity(newActivity);
    }
    widget.onSaved();

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.initialActivity != null
                ? 'Aktiviteten har uppdaterats!'
                : 'Aktiviteten har sparats!',
            style: GoogleFonts.manrope(),
          ),
          backgroundColor: FlutterFlowTheme.of(context).primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final formattedDate =
        '${_selectedDate.day} ${widget.getGregorianMonthNameSwedish(_selectedDate.month)} ${_selectedDate.year}';
    final formattedTime =
        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
    final formattedReminderTime =
        '${_selectedReminderTime.hour.toString().padLeft(2, '0')}:${_selectedReminderTime.minute.toString().padLeft(2, '0')}';

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            theme.designToken.spacing.md,
            theme.designToken.spacing.md,
            theme.designToken.spacing.md,
            theme.designToken.spacing.md +
                MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BottomSheetIconWidget(),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header: Ny aktivitet / Redigera aktivitet
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.initialActivity != null
                                  ? 'Redigera aktivitet'
                                  : 'Ny aktivitet',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Divider(height: 1.0, thickness: 1.0),
                      const SizedBox(height: 16.0),

                      // Titel: [ Skriv titel här... ]
                      Text(
                        'Titel:',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Skriv titel här...',
                          hintStyle: GoogleFonts.manrope(
                            fontSize: 13.5,
                            color: theme.secondaryText,
                          ),
                          filled: true,
                          fillColor: theme.primaryBackground,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: _titleHasError
                                  ? Colors.redAccent
                                  : theme.alternate,
                              width: _titleHasError ? 1.6 : 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: _titleHasError
                                  ? Colors.redAccent
                                  : theme.alternate,
                              width: _titleHasError ? 1.6 : 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: _titleHasError
                                  ? Colors.redAccent
                                  : theme.primary,
                              width: 1.8,
                            ),
                          ),
                        ),
                      ),
                      if (_titleHasError)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                          child: Text(
                            'Titel är obligatorisk',
                            style: GoogleFonts.manrope(
                              fontSize: 12.0,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16.0),

                      // Kategori / Färg:
                      Text(
                        'Kategori / Färg:',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: _categories.map((cat) {
                            final String key = cat['key'] as String;
                            final String label = cat['label'] as String;
                            final Color col = cat['color'] as Color;
                            final bool isSelected = _selectedCategoryKey == key;

                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCategoryKey = key;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? col.withValues(alpha: 0.18)
                                        : theme.primaryBackground,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: isSelected ? col : theme.alternate,
                                      width: isSelected ? 1.8 : 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8.0,
                                        height: 8.0,
                                        decoration: BoxDecoration(
                                          color: col,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        label,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12.5,
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          color: isSelected
                                              ? col
                                              : theme.primaryText,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Datum & Tid:
                      Text(
                        'Datum & Tid:',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          // Date picker button
                          Expanded(
                            child: InkWell(
                              onTap: _pickDate,
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12.0),
                                decoration: BoxDecoration(
                                  color: theme.primaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(color: theme.alternate),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today_rounded,
                                        size: 16.0, color: Color(0xFF154432)),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        formattedDate,
                                        style: GoogleFonts.manrope(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          color: theme.primaryText,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),

                          // Time picker button
                          Expanded(
                            child: InkWell(
                              onTap: _pickTime,
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12.0),
                                decoration: BoxDecoration(
                                  color: theme.primaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(color: theme.alternate),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.access_time_rounded,
                                        size: 16.0, color: Color(0xFF154432)),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        formattedTime,
                                        style: GoogleFonts.manrope(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600,
                                          color: theme.primaryText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // Påminnelse: [ Samma dag ∨ ]   kl. [ 17:00 ∨ ]
                      Text(
                        'Påminnelse:',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48.0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: theme.primaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(color: theme.alternate),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedReminderDay,
                                  isExpanded: true,
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: theme.secondaryText),
                                  style: GoogleFonts.manrope(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: theme.primaryText,
                                  ),
                                  dropdownColor: theme.secondaryBackground,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Samma dag',
                                      child: Text('Samma dag'),
                                    ),
                                    DropdownMenuItem(
                                      value: '1 dag innan',
                                      child: Text('1 dag innan'),
                                    ),
                                    DropdownMenuItem(
                                      value: '2 dagar innan',
                                      child: Text('2 dagar innan'),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() {
                                        _selectedReminderDay = val;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: InkWell(
                              onTap: _pickReminderTime,
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                height: 48.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                decoration: BoxDecoration(
                                  color: theme.primaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(color: theme.alternate),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'kl. $formattedReminderTime',
                                      style: GoogleFonts.manrope(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500,
                                        color: theme.primaryText,
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                        color: theme.secondaryText),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // Påminnelseljud (Notification sound selector)
                      Text(
                        'Påminnelseljud:',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                        ),
                      ),
                      InkWell(
                        onTap: _showSoundSelectionBottomSheet,
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          height: 52.0,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: theme.primaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: theme.alternate),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34.0,
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: theme.secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: _buildSoundIcon(
                                    _soundList.firstWhere(
                                      (s) => s['name'] == _selectedSound,
                                      orElse: () => _soundList[1],
                                    )['iconType'] as String,
                                    isDark,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: Text(
                                  _selectedSound,
                                  style: GoogleFonts.manrope(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: theme.primaryText,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded,
                                  color: theme.secondaryText, size: 22.0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Anteckningar (Valfritt):
                      Text(
                        'Anteckningar (Valfritt):',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: theme.primaryText,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      TextField(
                        controller: _notesController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Skriv ytterligare information här...',
                          hintStyle: GoogleFonts.manrope(
                            fontSize: 13.5,
                            color: theme.secondaryText,
                          ),
                          filled: true,
                          fillColor: theme.primaryBackground,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 12.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: theme.alternate),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: theme.alternate),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Button: Spara
                      SizedBox(
                        width: double.infinity,
                        height: 44.0,
                        child: ElevatedButton(
                          onPressed: _save,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Spara',
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// SUB-PAGE: CALENDAR PROGRESS & SELF-REFLECTION (Framsteg / Självrannsakan)
// =========================================================================
class CalendarProgressPage extends StatefulWidget {
  final HabitTrackerService habitService;
  final Map<String, dynamic> Function(DateTime) getHijriDate;

  const CalendarProgressPage({
    super.key,
    required this.habitService,
    required this.getHijriDate,
  });

  @override
  State<CalendarProgressPage> createState() => _CalendarProgressPageState();
}

class _CalendarProgressPageState extends State<CalendarProgressPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? _stats;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadStats();
  }

  Future<void> _loadStats() async {
    if (_stats == null) {
      setState(() => _isLoading = true);
    }
    final s = await widget.habitService.getProgressStatistics(
      DateTime.now(),
      getHijriDate: widget.getHijriDate,
    );
    if (mounted) {
      setState(() {
        _stats = s;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                theme.designToken.spacing.md,
                theme.designToken.spacing.sm,
                theme.designToken.spacing.md,
                0.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.chevron_left,
                      color: theme.primaryText,
                      size: FFAppConstants.iconSize.toDouble(),
                    ),
                  ),
                  SizedBox(width: theme.designToken.spacing.sm),
                  Text(
                    'Framsteg & Självrannsakan',
                    style: theme.titleMedium.override(
                      font: GoogleFonts.plusJakartaSans(
                        fontWeight: theme.titleMedium.fontWeight,
                        fontStyle: theme.titleMedium.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight: theme.titleMedium.fontWeight,
                      fontStyle: theme.titleMedium.fontStyle,
                      color: theme.primaryText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? theme.alternate : const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: theme.primary,
                unselectedLabelColor: theme.secondaryText,
                indicatorColor: theme.primary,
                indicatorWeight: 3.0,
                labelStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
                unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: 'Idag'),
                  Tab(text: 'Vecka'),
                  Tab(text: 'Månad'),
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: theme.primary))
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDayTab(theme, isDark),
                        _buildWeekTab(theme, isDark),
                        _buildMonthTab(theme, isDark),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayTab(FlutterFlowTheme theme, bool isDark) {
    final now = DateTime.now();
    final dayStats = _stats?['day'] as Map<String, dynamic>?;
    final int completed = dayStats?['completed'] ?? 0;
    final int total = dayStats?['total'] ?? 0;
    final double rate = (dayStats?['rate'] as num?)?.toDouble() ?? 0.0;

    final hj = widget.getHijriDate(now);
    final int hjDay = castToType<int>(hj['Hijri_Day'] ?? hj['HijriDay']) ?? 1;
    final int hjMonth =
        castToType<int>(hj['Hijri_Month_No'] ?? hj['HijriMonthNo']) ?? 1;
    final habits = widget.habitService.getScheduledHabitsForDate(
      gregorianDate: now,
      hijriDay: hjDay,
      hijriMonth: hjMonth,
      categoryFilter: 'Alla',
    );
    final customActs = widget.habitService
        .getCustomActivitiesForDate(now, categoryFilter: 'Alla');

    final completedHabitIds = (_stats?['completedHabitIds'] as Set<String>?) ??
        ((_stats?['completedHabitIds'] as Iterable?)
                ?.map((e) => e.toString())
                .toSet() ??
            <String>{});

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        16.0,
        16.0,
        16.0,
        16.0 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's summary card
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: isDark ? theme.alternate : const Color(0xFFE2E8F0),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: 10.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dagens översikt',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: theme.primaryText,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: theme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        '${(rate * 100).round()}% fullföljt',
                        style: GoogleFonts.manrope(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: theme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: LinearProgressIndicator(
                    value: total > 0 ? rate : 0.0,
                    minHeight: 10.0,
                    backgroundColor: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFE2E8F0),
                    valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  '$completed av $total aktiviteter slutförda idag',
                  style: GoogleFonts.manrope(
                    fontSize: 13.0,
                    color: theme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          Text(
            'Aktiviteter idag',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: theme.primaryText,
            ),
          ),
          const SizedBox(height: 10.0),

          if (habits.isEmpty && customActs.isEmpty)
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Center(
                child: Text(
                  'Inga schemalagda aktiviteter eller aktiva vanor för idag.\nAktivera vanor i kalenderinställningar!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontSize: 13.5,
                    color: theme.secondaryText,
                  ),
                ),
              ),
            )
          else ...[
            ...habits.map((h) {
              final isDone = completedHabitIds.contains(h.id);
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: theme.alternate, width: 0.8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () async {
                      await widget.habitService
                          .toggleHabitCompletion(now, h.id);
                      await _loadStats();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDone ? h.color : Colors.transparent,
                              border: Border.all(
                                color: isDone ? h.color : theme.secondaryText,
                                width: 1.6,
                              ),
                            ),
                            child: isDone
                                ? const Icon(Icons.check,
                                    size: 15.0, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              h.title,
                              style: GoogleFonts.manrope(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: isDone
                                    ? theme.secondaryText
                                    : theme.primaryText,
                                decoration:
                                    isDone ? TextDecoration.lineThrough : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            ...customActs.map((ca) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  color: theme.secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: theme.alternate, width: 0.8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () async {
                      await widget.habitService
                          .toggleCustomActivityCompletion(ca.id);
                      _loadStats();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ca.isCompleted
                                  ? ca.categoryColor
                                  : Colors.transparent,
                              border: Border.all(
                                color: ca.isCompleted
                                    ? ca.categoryColor
                                    : theme.secondaryText,
                                width: 1.6,
                              ),
                            ),
                            child: ca.isCompleted
                                ? const Icon(Icons.check,
                                    size: 15.0, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              ca.title,
                              style: GoogleFonts.manrope(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: ca.isCompleted
                                    ? theme.secondaryText
                                    : theme.primaryText,
                                decoration: ca.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildWeekTab(FlutterFlowTheme theme, bool isDark) {
    final weekStats = _stats?['week'] as Map<String, dynamic>?;
    final int completed = weekStats?['completed'] ?? 0;
    final int total = weekStats?['total'] ?? 0;
    final double rate = (weekStats?['rate'] as num?)?.toDouble() ?? 0.0;
    final List<dynamic> days = weekStats?['days'] as List<dynamic>? ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weekly summary card
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: isDark ? theme.alternate : const Color(0xFFE2E8F0),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: 10.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Denna veckas framsteg',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: theme.primaryText,
                      ),
                    ),
                    Text(
                      '${(rate * 100).round()}%',
                      style: GoogleFonts.manrope(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        color: theme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: LinearProgressIndicator(
                    value: total > 0 ? rate : 0.0,
                    minHeight: 10.0,
                    backgroundColor: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFE2E8F0),
                    valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  '$completed av $total aktiviteter slutförda denna vecka',
                  style: GoogleFonts.manrope(
                    fontSize: 13.0,
                    color: theme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          Text(
            'Dag för dag (Måndag – Söndag)',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: theme.primaryText,
            ),
          ),
          const SizedBox(height: 10.0),

          ...days.map((item) {
            final dayMap = item as Map<String, dynamic>;
            final String weekdayName = dayMap['weekday'] ?? '';
            final String dateStr = dayMap['date'] ?? '';
            final int dayComp = dayMap['completed'] ?? 0;
            final int dayTot = dayMap['total'] ?? 0;
            final double dayRate = dayTot > 0 ? dayComp / dayTot : 0.0;

            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: theme.secondaryBackground,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: theme.alternate, width: 0.8),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 76.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weekdayName,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: theme.primaryText,
                          ),
                        ),
                        Text(
                          dateStr,
                          style: GoogleFonts.manrope(
                            fontSize: 11.5,
                            color: theme.secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: LinearProgressIndicator(
                        value: dayRate,
                        minHeight: 8.0,
                        backgroundColor: isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            dayComp == dayTot && dayTot > 0
                                ? const Color(0xFF10B981)
                                : theme.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Text(
                    dayTot > 0 ? '$dayComp / $dayTot' : '–',
                    style: GoogleFonts.manrope(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color:
                          dayTot > 0 ? theme.primaryText : theme.secondaryText,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildMonthTab(FlutterFlowTheme theme, bool isDark) {
    final monthStats = _stats?['month'] as Map<String, dynamic>?;
    final int completed = monthStats?['completed'] ?? 0;
    final int activeDays = monthStats?['daysWithCompletion'] ?? 0;
    final double rate = (monthStats?['rate'] as num?)?.toDouble() ?? 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Monthly overview card
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(
                color: isDark ? theme.alternate : const Color(0xFFE2E8F0),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: 10.0,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Månadsöversikt',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: theme.primaryText,
                  ),
                ),
                const SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatPill(
                      theme,
                      isDark,
                      title: 'Slutförda',
                      value: completed.toString(),
                      icon: Icons.check_circle_rounded,
                      iconColor: theme.primary,
                    ),
                    _buildStatPill(
                      theme,
                      isDark,
                      title: 'Aktiva dagar',
                      value: activeDays.toString(),
                      icon: Icons.calendar_month_rounded,
                      iconColor: const Color(0xFFF59E0B),
                    ),
                    _buildStatPill(
                      theme,
                      isDark,
                      title: 'Genomsnitt',
                      value: '${(rate * 100).round()}%',
                      icon: Icons.auto_graph_rounded,
                      iconColor: const Color(0xFF8B5CF6),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // Hadith reflection card
          Container(
            padding: const EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: theme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: theme.primary.withValues(alpha: 0.25),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline_rounded,
                        color: theme.primary, size: 20.0),
                    const SizedBox(width: 8.0),
                    Text(
                      'Visdom om regelbundenhet',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: theme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  '”De handlingar som är mest älskade inför Allah är de som utförs regelbundet, även om de är få.”',
                  style: GoogleFonts.manrope(
                    fontSize: 13.5,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                    color: theme.primaryText,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  '– Sahih al-Bukhari & Sahih Muslim',
                  style: GoogleFonts.manrope(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: theme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(
    FlutterFlowTheme theme,
    bool isDark, {
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22.0),
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            color: theme.primaryText,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 12.0,
            color: theme.secondaryText,
          ),
        ),
      ],
    );
  }
}
