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
import 'package:google_fonts/google_fonts.dart';
import '/custom_code/actions/habit_tracker_service.dart';
import '/custom_code/actions/constants.dart';

Future<String?> loadJsonFromUrlOrCache({
  required String fileName,
  required List<String> urls,
  required List<String> assetPaths,
}) async {
  // 1. Download from online URL first to get latest data
  for (final url in urls) {
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final downloadedContent = response.body;

        // Save to local device storage for future offline access
        try {
          final directory = await getApplicationDocumentsDirectory();
          final localFile = File('${directory.path}/$fileName');
          await localFile.writeAsString(downloadedContent);
        } catch (_) {}
        return downloadedContent;
      }
    } catch (_) {}
  }

  // 2. Read from local device cache if network failed/offline
  try {
    final directory = await getApplicationDocumentsDirectory();
    final localFile = File('${directory.path}/$fileName');
    if (await localFile.exists()) {
      final content = await localFile.readAsString();
      if (content.isNotEmpty) {
        return content;
      }
    }
  } catch (_) {}

  // 3. Fallback to bundled asset
  for (final assetPath in assetPaths) {
    try {
      final content = await rootBundle.loadString(assetPath);
      if (content.isNotEmpty) {
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

  List<IslamicEvent> get islamicEvents {
    final sv = _isSwedish;
    if (_rawIslamicEvents.isNotEmpty) {
      return _rawIslamicEvents
          .map((json) => IslamicEvent.fromJson(json, sv,
              castToType<int>(json['hijriYear'] ?? json['Hijri_Year']) ?? 1448))
          .toList();
    }
    return _getDefaultIslamicEvents(sv);
  }

  List<IslamicEvent> _getDefaultIslamicEvents(bool sv) {
    return [
      IslamicEvent(
        title: sv ? "Islamiskt nyår (Al-Hijra)" : "Islamic New Year",
        subtitle: sv
            ? "Början på det nya islamiska året"
            : "Start of the Islamic New Year",
        hijriMonth: 1,
        hijriDay: 1,
        hijriYear: 0,
        description: sv
            ? "Början på det nya islamiska året. Muslimer reflekterar över tidens gång och emigrationen (Hijrah) som profeten Muhammed (saw) gjorde från Mecka till Medina."
            : "Beginning of the new Islamic year. Muslims reflect on the passage of time and the emigration (Hijrah) of Prophet Muhammad (pbuh) from Mecca to Medina.",
        iconType: "moon",
        isMajorHoliday: false,
        hijriDate: "1 Muharram",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv ? "Ashura-dagen" : "Day of Ashura",
        subtitle: sv
            ? "Rekommenderad fasta. Historisk räddningsdag"
            : "Recommended fasting day",
        hijriMonth: 1,
        hijriDay: 10,
        hijriYear: 0,
        description: sv
            ? "Ashura-dagen firas till minne av att Allah räddade profeten Musa (Moses) och Israels barn från Farao genom att klyva havet. Det rekommenderas starkt att fasta denna dag."
            : "Day of Ashura marks the day Allah saved Prophet Musa (Moses) and the Israelites from Pharaoh. Fasting on this day is strongly recommended.",
        iconType: "moon",
        isMajorHoliday: true,
        hijriDate: "10 Muharram",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv
            ? "Profetens födelsedag (Mawlid)"
            : "Prophet's Birthday (Mawlid)",
        subtitle: sv
            ? "Födelsen av profeten Muhammed (saw)"
            : "Birth of Prophet Muhammad (pbuh)",
        hijriMonth: 3,
        hijriDay: 12,
        hijriYear: 0,
        description: sv
            ? "Mawlid an-Nabi markerar födelsen av profeten Muhammed (saw), Allahs sista sändebud. En tid för reflektion över hans liv och läror."
            : "Mawlid an-Nabi marks the birth of Prophet Muhammad (pbuh), the final messenger of Allah.",
        iconType: "mosque",
        isMajorHoliday: false,
        hijriDate: "12 Rabi' al-Awwal",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv ? "Isra' och Mi'raj" : "Isra and Mi'raj",
        subtitle: sv
            ? "Profetens nattliga resa och himmelsfärd"
            : "The Night Journey and Ascension",
        hijriMonth: 7,
        hijriDay: 27,
        hijriYear: 0,
        description: sv
            ? "Den mirakulösa nattliga resan från Mecka till Jerusalem och uppstigningen till himlarna, där de fem dagliga bönerna instiftades."
            : "The miraculous night journey from Mecca to Jerusalem and ascension to the heavens, where the five daily prayers were ordained.",
        iconType: "moon",
        isMajorHoliday: false,
        hijriDate: "27 Rajab",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv
            ? "Laylat al-Bara'at (Nisf Sha'ban)"
            : "Mid-Sha'ban (Laylat al-Bara'at)",
        subtitle: sv
            ? "Förlåtelsens och barmhärtighetens natt"
            : "Night of Forgiveness",
        hijriMonth: 8,
        hijriDay: 15,
        hijriYear: 0,
        description: sv
            ? "Förlåtelsens natt mitt i Sha'ban då muslimer ber om förlåtelse för synder och förbereder sig inför Ramadan."
            : "The Night of Forgiveness in the middle of Sha'ban where Muslims seek forgiveness and prepare for Ramadan.",
        iconType: "moon",
        isMajorHoliday: false,
        hijriDate: "15 Sha'ban",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv ? "Första dagen i Ramadan (Fasta)" : "First Day of Ramadan",
        subtitle: sv
            ? "Den heliga fastemånaden inleds"
            : "First day of fasting month",
        hijriMonth: 9,
        hijriDay: 1,
        hijriYear: 0,
        description: sv
            ? "Den heliga månaden Ramadan inleds då muslimer världen över fastar från gryning till solnedgång under en månad av bön och andlighet."
            : "The holy month of Ramadan begins. Muslims worldwide observe daily fasting from dawn to sunset.",
        iconType: "moon",
        isMajorHoliday: true,
        hijriDate: "1 Ramadan",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv
            ? "Laylat al-Qadr (Allmaktens natt)"
            : "Laylat al-Qadr (Night of Power)",
        subtitle: sv
            ? "Koranens uppenbarelse. Bättre än tusen månader"
            : "Better than a thousand months",
        hijriMonth: 9,
        hijriDay: 27,
        hijriYear: 0,
        description: sv
            ? "Allmaktens natt då Koranen först uppenbarades. Denna natt är bättre än tusen månader i andlig belöning och välsignelse."
            : "The Night of Power when the first verses of the Quran were revealed to Prophet Muhammad (pbuh). Better than a thousand months.",
        iconType: "moon",
        isMajorHoliday: true,
        hijriDate: "27 Ramadan",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv ? "Eid al-Fitr (festival)" : "Eid al-Fitr (festival)",
        subtitle: sv
            ? "Firandet av fastemånadens slut"
            : "Celebration marking the end of Ramadan",
        hijriMonth: 10,
        hijriDay: 1,
        hijriYear: 0,
        description: sv
            ? "Eid al-Fitr markerar slutet på Ramadan. En glädjefylld högtid som firas med gemensam Eid-bön, välgörenhet (Zakat al-Fitr) och festmåltider med nära och kära."
            : "Eid al-Fitr marks the joyous completion of Ramadan, celebrated with morning prayers, charity, family gatherings, and feasts.",
        iconType: "mosque",
        isMajorHoliday: true,
        hijriDate: "1 Shawwal",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv ? "Början av Dhu al-Hijjah" : "Start of Dhu al-Hijjah",
        subtitle: sv
            ? "De tio välsignade dagarna inleds"
            : "First of the ten blessed days",
        hijriMonth: 12,
        hijriDay: 1,
        hijriYear: 0,
        description: sv
            ? "Början på pilgrimsfärdsmånaden Dhu al-Hijjah. De första tio dagarna är de mest älskade dagarna hos Allah för goda gärningar."
            : "The first ten days of Dhu al-Hijjah are considered the best and most beloved days of the year for righteous deeds.",
        iconType: "kaaba",
        isMajorHoliday: false,
        hijriDate: "1 Dhu al-Hijjah",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv ? "Hajj-pilgrimsfärd börjar" : "Hajj Pilgrimage Begins",
        subtitle: sv
            ? "Pilgrimerna reser till Mina"
            : "Pilgrims travel to Mina (Yawm at-Tarwiyah)",
        hijriMonth: 12,
        hijriDay: 8,
        hijriYear: 0,
        description: sv
            ? "Den årliga pilgrimsfärden Hajj börjar i Mecka. Pilgrimerna beger sig till Mina för att förbereda sig inför Arafat."
            : "The annual Hajj pilgrimage begins in Mecca as pilgrims gather in Mina.",
        iconType: "kaaba",
        isMajorHoliday: false,
        hijriDate: "8 Dhu al-Hijjah",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv ? "Arafah-dagen (Fasta)" : "Day of Arafah (Fasting)",
        subtitle: sv
            ? "Hajjens höjdpunkt. Rekommenderad fasta"
            : "Peak of Hajj. Recommended fast",
        hijriMonth: 12,
        hijriDay: 9,
        hijriYear: 0,
        description: sv
            ? "Arafah-dagen är den viktigaste dagen under Hajj. För de som inte är på Hajj är fasta denna dag starkt rekommenderad och utplånar två års synder."
            : "The Day of Arafah is the pinnacle of Hajj. Fasting this day is highly virtuous and expiates sins of previous and upcoming year.",
        iconType: "moon",
        isMajorHoliday: true,
        hijriDate: "9 Dhu al-Hijjah",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv ? "Eid al-Adha (festival)" : "Eid al-Adha (festival)",
        subtitle: sv
            ? "Offerhögtiden till minne av profeten Ibrahim"
            : "Feast of Sacrifice",
        hijriMonth: 12,
        hijriDay: 10,
        hijriYear: 0,
        description: sv
            ? "Offerhögtiden Eid al-Adha firas till minne av profeten Ibrahims hängivenhet till Allah. Muslimer samlas för Eid-bön, offrar ett djur och delar köttet med behövande."
            : "Eid al-Adha honors the willingness of Prophet Ibrahim to sacrifice his son in obedience to God. Celebrated with Eid prayer and sharing food with family and needy.",
        iconType: "mosque",
        isMajorHoliday: true,
        hijriDate: "10 Dhu al-Hijjah",
        gregorianDate: "",
      ),
      IslamicEvent(
        title: sv
            ? "Tashreeq-dagarna (Eid al-Adha)"
            : "Days of Tashreeq (Eid al-Adha)",
        subtitle: sv
            ? "Dagar av tacksägelse, takbeer och gemenskap"
            : "Days of takbeer and celebration",
        hijriMonth: 12,
        hijriDay: 11,
        hijriYear: 0,
        description: sv
            ? "Dagarna 11, 12 och 13 i Dhu al-Hijjah fortsätter firandet av Eid al-Adha med takbeerat, måltider och tacksamhet till Allah."
            : "Days 11, 12, and 13 of Dhu al-Hijjah continue the celebrations of Eid al-Adha with takbeer and remembrance of Allah.",
        iconType: "mosque",
        isMajorHoliday: false,
        hijriDate: "11 Dhu al-Hijjah",
        gregorianDate: "",
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _habitService.init().then((_) {
      if (mounted) setState(() {});
    });
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
    if (hijriDateCache.isNotEmpty) {
      setState(() => isLoading = false);
      return;
    }
    setState(() => isLoading = true);
    try {
      HijriCalendar.setLocal("en");
      final int currentHijriYear = HijriCalendar.now().hYear;

      final List<int> candidateYears = [
        currentHijriYear - 1,
        currentHijriYear,
        currentHijriYear + 1,
        1447,
        1448,
      ].toSet().toList();

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

      final List<int?> loadedYears = await Future.wait(
        candidateYears.map((y) => loadYear(y)),
      );
      final List<int> yearsToLoad = loadedYears.whereType<int>().toList()
        ..sort();

      if (yearsToLoad.isEmpty) {
        await loadYear(1447);
        await loadYear(1448);
        yearsToLoad.addAll([1447, 1448]);
      }

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
              item['hijriYear'] = y;
            }
          }
          return holidaysData;
        } catch (_) {
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

  Future<void> loadCalendarDataForYear(int year) async {
    if (hijriDateCache.isNotEmpty) {
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
    final year = hj['Hijri_Year'] ?? hj['HijriYear'] ?? 1448;
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

  List<EventOccurrence> getEventsForYear(int year) {
    if (isLoading) return [];
    List<EventOccurrence> list = [];
    final int hStart = HijriCalendar.fromDate(DateTime(year, 1, 1)).hYear;
    final int hEnd = HijriCalendar.fromDate(DateTime(year, 12, 31)).hYear;

    for (var ev in islamicEvents) {
      for (int hy = hStart - 1; hy <= hEnd + 1; hy++) {
        if (ev.hijriYear != 0 && ev.hijriYear != hy) continue;
        try {
          DateTime? gregDate;
          for (final entry in hijriDateCache.values) {
            final g = entry['Gregorian_Date'] as String?;
            if (g == null || !g.startsWith(year.toString())) continue;
            final eYear =
                castToType<int>(entry['Hijri_Year'] ?? entry['HijriYear']);
            final eMonth = castToType<int>(
                entry['Hijri_Month_No'] ?? entry['HijriMonthNo']);
            final eDay =
                castToType<int>(entry['Hijri_Day'] ?? entry['HijriDay']);
            if (eYear == hy && eMonth == ev.hijriMonth && eDay == ev.hijriDay) {
              gregDate = DateTime.tryParse(g);
              break;
            }
          }
          gregDate ??=
              HijriCalendar().hijriToGregorian(hy, ev.hijriMonth, ev.hijriDay);
          if (gregDate.year == year) {
            final hj = getHijriDate(gregDate);
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
        } catch (_) {}
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
              color: isSelected
                  ? theme.primary
                  : (isDark
                      ? const Color(0xFF1E293B)
                      : theme.secondaryBackground),
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

          Color cardBg;
          Color textColor;
          Color iconColor;
          Border? border;

          if (label == 'Alla') {
            if (isSelected) {
              cardBg = theme.primary;
              textColor = Colors.white;
              iconColor = Colors.white;
            } else {
              cardBg = isDark
                  ? const Color(0xFF1E293B)
                  : theme.primary.withValues(alpha: 0.12);
              textColor = theme.primary;
              iconColor = theme.primary;
            }
          } else {
            if (isSelected) {
              cardBg = catColor;
              textColor = Colors.white;
              iconColor = Colors.white;
            } else {
              cardBg = catColor.withValues(alpha: isDark ? 0.22 : 0.14);
              textColor = isDark ? Colors.white : catColor;
              iconColor = catColor;
              border = Border.all(
                  color: catColor.withValues(alpha: 0.3), width: 1.0);
            }
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = label;
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
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: (label == 'Alla' ? theme.primary : catColor)
                              .withValues(alpha: 0.25),
                          blurRadius: 4.0,
                          offset: const Offset(0, 1.5),
                        )
                      ]
                    : null,
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
    final prevMonthTotalDays =
        DateTime(currentDate.year, currentDate.month, 0).day;

    List<Widget> cellWidgets = [];

    // Overflow days from previous month (dimmed inline style)
    for (int i = emptyCells - 1; i >= 0; i--) {
      final prevDate = DateTime(
          currentDate.year, currentDate.month - 1, prevMonthTotalDays - i);
      cellWidgets.add(_buildCalendarCell(prevDate, isCurrentMonth: false));
    }

    // Days of current month
    for (int d = 1; d <= totalDaysInCurrentMonth; d++) {
      final cellDate = DateTime(currentDate.year, currentDate.month, d);
      cellWidgets.add(_buildCalendarCell(cellDate, isCurrentMonth: true));
    }

    // Overflow days into next month to complete the 7-column rows
    int nextMonthDay = 1;
    while (cellWidgets.length % 7 != 0) {
      final nextDate =
          DateTime(currentDate.year, currentDate.month + 1, nextMonthDay++);
      cellWidgets.add(_buildCalendarCell(nextDate, isCurrentMonth: false));
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
                          const SizedBox(height: 6.0),

                          // Month Grid
                          Table(
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: tableRows,
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

  // BOTTOM ACTION BUTTONS: [ 📅 Idag ] and [ ➕ ] ALIGNED ON EXACT SAME HORIZONTAL BASELINE
  Widget _buildBottomActionButtons(FlutterFlowTheme theme, bool isDark) {
    const double actionHeight = 46.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bottom-Left: [ 📅 Idag ]
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                final now = DateTime.now();
                setState(() {
                  currentDate = DateTime(now.year, now.month, 1);
                  selectedDate = now;
                });
                loadCalendarDataForYear(now.year);
              },
              borderRadius: BorderRadius.circular(actionHeight / 2),
              child: Container(
                height: actionHeight,
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
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

  // 3. DATE CELL LAYOUT: INLINE GREGORIAN + HIJRI e.g. "21 (10)" + ENLARGED ACTIVITY DOTS
  Widget _buildCalendarCell(DateTime date, {required bool isCurrentMonth}) {
    final theme = FlutterFlowTheme.of(context);
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

    final indicatorDots = _habitService.getIndicatorDotsForDate(
      gregorianDate: date,
      hijriDay: hijriDay,
      hijriMonth: hjMonth,
      categoryFilter: selectedCategory,
    );

    BoxDecoration? cellDecoration;
    if (isToday) {
      cellDecoration = BoxDecoration(
        color: theme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: theme.primary, width: 1.5),
      );
    } else if (isSelected) {
      cellDecoration = BoxDecoration(
        color: theme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: theme.primary.withValues(alpha: 0.45),
          width: 1.0,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            selectedDate = date;
          });
          _showDayModalBottomSheet(date);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 2.0),
          decoration: cellDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gregorian + Hijri on the same horizontal line: e.g. 21 (10)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${date.day} ',
                          style: GoogleFonts.manrope(
                            fontSize: 13.0,
                            fontWeight:
                                isToday ? FontWeight.w800 : FontWeight.w700,
                            color: !isCurrentMonth
                                ? theme.secondaryText.withValues(alpha: 0.35)
                                : (isToday ? theme.primary : theme.primaryText),
                          ),
                        ),
                        TextSpan(
                          text: '($hijriDay)',
                          style: GoogleFonts.manrope(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: !isCurrentMonth
                                ? theme.secondaryText.withValues(alpha: 0.35)
                                : (isToday
                                    ? theme.primary.withValues(alpha: 0.85)
                                    : theme.secondaryText),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 3.0),

              // Activity Indicator Dots: nicely aligned directly under inline text with slightly increased size
              if (indicatorDots.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: indicatorDots.take(4).map((c) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1.2),
                      width: 5.5,
                      height: 5.5,
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                      ),
                    );
                  }).toList(),
                )
              else
                const SizedBox(height: 5.5),
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
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _DayModalContent(
          date: date,
          habitService: _habitService,
          getHijriDate: getHijriDate,
          mapHijriMonthToSwedish: _mapHijriMonthToSwedish,
          getWeekdayNameSwedish: _getWeekdayNameSwedish,
          getGregorianMonthNameSwedish: _getGregorianMonthNameSwedish,
          onAddActivity: (selectedDate) {
            Navigator.of(ctx).pop();
            _showQuickMenuModal(selectedDate);
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
        'title': 'Egen aktivitet / Personligt',
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
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(24.0)),
          ),
          padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle with tap to close
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(ctx).pop(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                  child: Center(
                    child: Container(
                      width: 44.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF555555)
                            : const Color(0xFFD1D5DB),
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),

              Text(
                'Välj kategori',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: theme.primaryText,
                ),
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
                                  color: theme.secondaryText, size: 20.0),
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
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return _ActivityCreationFormModal(
          initialDate: date,
          initialCategoryKey: initialCategoryKey,
          habitService: _habitService,
          getGregorianMonthNameSwedish: _getGregorianMonthNameSwedish,
          onSaved: () {
            setState(() {});
          },
        );
      },
    );
  }

  // 2. KOMMANDE HÄNDELSER SCREEN
  Widget _buildUpcomingEventsView() {
    final theme = FlutterFlowTheme.of(context);
    final yearEvents = getEventsForYear(currentDate.year);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 12),
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

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
          color: isSelected ? theme.primary : theme.secondaryBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          year.toString(),
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : theme.secondaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingEventCard(EventOccurrence occurrence) {
    final theme = FlutterFlowTheme.of(context);
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
            setState(() {
              selectedDate = occurrence.gregorianDate;
              currentDate = DateTime(occurrence.gregorianDate.year,
                  occurrence.gregorianDate.month, 1);
            });
            _showDayModalBottomSheet(occurrence.gregorianDate);
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        occurrence.event.title,
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryText,
                        ),
                      ),
                      Text(
                        '${occurrence.event.hijriDate} • ${occurrence.event.gregorianDate}',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: theme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// SUB-WIDGET: DAY MODAL CONTENT
// =========================================================================
class _DayModalContent extends StatefulWidget {
  final DateTime date;
  final HabitTrackerService habitService;
  final Map<String, dynamic> Function(DateTime) getHijriDate;
  final String Function(String) mapHijriMonthToSwedish;
  final String Function(int) getWeekdayNameSwedish;
  final String Function(int) getGregorianMonthNameSwedish;
  final Function(DateTime) onAddActivity;
  final VoidCallback onChanged;

  const _DayModalContent({
    required this.date,
    required this.habitService,
    required this.getHijriDate,
    required this.mapHijriMonthToSwedish,
    required this.getWeekdayNameSwedish,
    required this.getGregorianMonthNameSwedish,
    required this.onAddActivity,
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
    final int hjYear =
        castToType<int>(hj['Hijri_Year'] ?? hj['HijriYear']) ?? 1448;
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
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle with tap to close
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
              child: Center(
                child: Container(
                  width: 44.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF555555)
                        : const Color(0xFFD1D5DB),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),

          // Header: Torsdag 24 September 2026 & (12 Rabi' al-Awwal 1448)
          Center(
            child: Column(
              children: [
                Text(
                  '$weekday ${widget.date.day} $monthName ${widget.date.year}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w700,
                    color: theme.primaryText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '($hijriDay $hjMonthName $hjYear)',
                  style: GoogleFonts.manrope(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: theme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          const Divider(height: 1.0, thickness: 1.0),
          const SizedBox(height: 16.0),

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
          Flexible(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : (habits.isEmpty && customActivities.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
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
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          // Master habits
                          ...habits.map((habit) {
                            final isDone = _completedHabits.contains(habit.id);
                            final String categoryLabel =
                                _getCategoryLabel(habit.categoryKey);
                            final String timeStr = habit.defaultTime.isNotEmpty
                                ? ' (${habit.defaultTime})'
                                : '';

                            return Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: theme.primaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: theme.alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final toggled = await widget.habitService
                                          .toggleHabitCompletion(
                                              widget.date, habit.id);
                                      setState(() {
                                        if (toggled) {
                                          _completedHabits.add(habit.id);
                                        } else {
                                          _completedHabits.remove(habit.id);
                                        }
                                      });
                                      widget.onChanged();
                                    },
                                    child: Container(
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
                                              size: 14.0, color: Colors.white)
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  // Category tag: [🟢 Fasta]
                                  _buildCategoryTag(categoryLabel, habit.color),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      '${habit.title}$timeStr',
                                      style: GoogleFonts.manrope(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: isDone
                                            ? theme.secondaryText
                                            : theme.primaryText,
                                        decoration: isDone
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),

                          // Custom user activities
                          ...customActivities.map((act) {
                            final String categoryLabel =
                                _getCategoryLabel(act.categoryKey);
                            final String timeStr =
                                act.time.isNotEmpty ? ' (${act.time})' : '';

                            return Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: theme.primaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: theme.alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await widget.habitService
                                          .toggleCustomActivityCompletion(
                                              act.id);
                                      setState(() {});
                                      widget.onChanged();
                                    },
                                    child: Container(
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
                                              size: 14.0, color: Colors.white)
                                          : null,
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  _buildCategoryTag(
                                      categoryLabel, act.categoryColor),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${act.title}$timeStr',
                                          style: GoogleFonts.manrope(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: act.isCompleted
                                                ? theme.secondaryText
                                                : theme.primaryText,
                                            decoration: act.isCompleted
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                        ),
                                        if (act.notes.isNotEmpty)
                                          Text(
                                            act.notes,
                                            style: GoogleFonts.manrope(
                                              fontSize: 11.5,
                                              color: theme.secondaryText,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        size: 18.0, color: Colors.redAccent),
                                    onPressed: () async {
                                      await widget.habitService
                                          .deleteCustomActivity(act.id);
                                      setState(() {});
                                      widget.onChanged();
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
          ),
          const SizedBox(height: 16.0),

          // Button: ➕ Lägg till ny aktivitet på denna dag
          SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton.icon(
              onPressed: () => widget.onAddActivity(widget.date),
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: Text(
                'Lägg till ny aktivitet på denna dag',
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
  final HabitTrackerService habitService;
  final String Function(int) getGregorianMonthNameSwedish;
  final VoidCallback onSaved;

  const _ActivityCreationFormModal({
    required this.initialDate,
    required this.initialCategoryKey,
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

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _selectedCategoryKey = widget.initialCategoryKey;
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

  Future<void> _save() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vänligen ange en titel', style: GoogleFonts.manrope()),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final formattedTime =
        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
    final formattedReminderTime =
        'kl. ${_selectedReminderTime.hour.toString().padLeft(2, '0')}:${_selectedReminderTime.minute.toString().padLeft(2, '0')}';

    final newActivity = CustomCalendarActivity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      categoryKey: _selectedCategoryKey,
      categoryColor: _getCategoryColor(_selectedCategoryKey),
      date: _selectedDate,
      time: formattedTime,
      reminderDay: _selectedReminderDay,
      reminderTime: formattedReminderTime,
      notes: _notesController.text.trim(),
    );

    await widget.habitService.addCustomActivity(newActivity);
    widget.onSaved();

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Aktiviteten har sparats!', style: GoogleFonts.manrope()),
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
      padding: EdgeInsets.fromLTRB(
          20.0, 12.0, 20.0, MediaQuery.of(context).viewInsets.bottom + 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Drag Handle with tap to close
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
                child: Center(
                  child: Container(
                    width: 44.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF555555)
                          : const Color(0xFFD1D5DB),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),

            // Header: Ny aktivitet
            Center(
              child: Text(
                'Ny aktivitet',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: theme.primaryText,
                ),
              ),
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
                  borderSide: BorderSide(color: theme.alternate),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: theme.alternate),
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
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _categories.map((cat) {
                final String key = cat['key'] as String;
                final String label = cat['label'] as String;
                final Color col = cat['color'] as Color;
                final bool isSelected = _selectedCategoryKey == key;

                return GestureDetector(
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
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? col : theme.primaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        color: theme.primaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: theme.alternate),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              height: 50.0,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Spara',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
