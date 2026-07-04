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
import 'package:hijri/hijri_calendar.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '/custom_code/actions/constants.dart';

Future<String> loadJsonFromAssetOrGit(String filePath) async {
  try {
    return await rootBundle.loadString(filePath);
  } catch (e) {
    print("Asset not found ($filePath): $e. Trying cache/network.");
  }

  final fileName = filePath.split('/').last;

  try {
    final directory = await getApplicationDocumentsDirectory();
    final localFile = File('${directory.path}/$fileName');
    if (await localFile.exists()) {
      print("Cache hit: Loaded $fileName from documents cache.");
      return await localFile.readAsString();
    }
  } catch (e) {
    print("Error reading from local documents cache: $e");
  }

  final gitHubOwner = GitConstants.gitHubOwner;
  final gitHubRepo = GitConstants.gitHubRepo;
  final branches = GitConstants.branches;

  for (final branch in branches) {
    final url =
        'https://raw.githubusercontent.com/$gitHubOwner/$gitHubRepo/$branch/$filePath';
    try {
      print("Attempting to download from $url");
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final content = response.body;
        try {
          final directory = await getApplicationDocumentsDirectory();
          final localFile = File('${directory.path}/$fileName');
          await localFile.writeAsString(content);
          print("Cached $fileName locally.");
        } catch (cacheError) {
          print("Error caching $fileName: $cacheError");
        }
        return content;
      }
    } catch (netError) {
      print("Error downloading from $url: $netError");
    }
  }

  throw Exception(
      "Failed to load JSON file $filePath from assets, cache, or GitHub.");
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
  final String description;
  final String iconType; // 'mosque', 'kaaba', 'moon'
  final bool isMajorHoliday;
  IslamicEvent({
    required this.title,
    required this.subtitle,
    required this.hijriMonth,
    required this.hijriDay,
    required this.description,
    required this.iconType,
    this.isMajorHoliday = false,
  });
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
  // Static list of Islamic Events
  bool get _isSwedish => Localizations.localeOf(context).languageCode == 'sv';

  List<IslamicEvent> get islamicEvents {
    final sv = _isSwedish;
    return [
      IslamicEvent(
        title: sv ? "Islamiskt nyår" : "Islamic New Year",
        subtitle: sv
            ? "Början på det nya islamiska året"
            : "Beginning of the new Islamic year",
        hijriMonth: 1,
        hijriDay: 1,
        description: sv
            ? "Början på det nya islamiska året (1448 / 1449 AH). Muslimer reflekterar över tidens gång och emigrationen (Hijrah) som profeten Muhammed gjorde från Mecka till Medina."
            : "The start of the new Islamic year (1448 / 1449 AH). Muslims reflect on the passage of time and the migration (Hijrah) of the Prophet Muhammad from Mecca to Medina.",
        iconType: "moon",
        isMajorHoliday: false,
      ),
      IslamicEvent(
        title: sv ? "Ashura-dagen" : "Day of Ashura",
        subtitle: sv
            ? "Rekommenderad fasta. Speciella böner vid berget Muharram"
            : "Recommended fasting. Special prayers on the day of Muharram",
        hijriMonth: 1,
        hijriDay: 10,
        description: sv
            ? "Ashura-dagen firas till minne av att Gud räddade profeten Musa (Moses) och Israels barn från Farao genom att dela Röda havet. Det rekommenderas att fasta denna dag."
            : "The Day of Ashura commemorates the day God saved Prophet Musa (Moses) and the Children of Israel from Pharaoh by parting the Red Sea. Fasting on this day is highly recommended.",
        iconType: "moon",
        isMajorHoliday: true,
      ),
      IslamicEvent(
        title: sv
            ? "Profetens födelsedag (Mawlid)"
            : "Prophet's Birthday (Mawlid)",
        subtitle: sv
            ? "Födelsen av profeten Muhammed"
            : "The birth of Prophet Muhammad",
        hijriMonth: 3,
        hijriDay: 12,
        description: sv
            ? "Mawlid an-Nabi markerar födelsen av profeten Muhammed, Guds sista sändebud. Denna dag används ofta för att lära sig mer om hans liv och läror."
            : "Mawlid an-Nabi marks the birth of the Prophet Muhammad, God's final messenger. This day is often spent learning more about his life and teachings.",
        iconType: "mosque",
        isMajorHoliday: false,
      ),
      IslamicEvent(
        title: sv ? "Isra' och Mi'raj" : "Isra' and Mi'raj",
        subtitle: sv
            ? "Det sändebudets himmelsfärd"
            : "The Prophet's night journey and ascension",
        hijriMonth: 7,
        hijriDay: 27,
        description: sv
            ? "Den nattliga resan och himmelsfärden. Profeten Muhammed reste mirakulöst från Mecka till Jerusalem och steg sedan upp till himlen."
            : "The Night Journey and Ascension. The Prophet Muhammad miraculously traveled from Mecca to Jerusalem and then ascended to the heavens.",
        iconType: "moon",
        isMajorHoliday: false,
      ),
      IslamicEvent(
        title: sv ? "Laylat al-Bara'at" : "Laylat al-Bara'at",
        subtitle: sv
            ? "Förlåtelsens och ödets natt"
            : "Night of forgiveness and salvation",
        hijriMonth: 8,
        hijriDay: 15,
        description: sv
            ? "Förlåtelsens natt, där muslimer ber om förlåtelse för sina synder och andas hopp inför det kommande året."
            : "The Night of Forgiveness, on which Muslims pray for forgiveness for their sins and look forward to the coming year with hope.",
        iconType: "moon",
        isMajorHoliday: false,
      ),
      IslamicEvent(
        title: sv ? "Ramadan börjar" : "Ramadan Begins",
        subtitle: sv ? "Muslimernas faste-månad" : "The holy month of fasting",
        hijriMonth: 9,
        hijriDay: 1,
        description: sv
            ? "Faste-månaden Ramadan börjar. Muslimer världen över fastar från gryning till solnedgång. Det är en månad av bön och andlig reflektion."
            : "The holy month of Ramadan begins. Muslims worldwide fast from dawn to sunset. It is a month of prayer, charity, and spiritual reflection.",
        iconType: "moon",
        isMajorHoliday: false,
      ),
      IslamicEvent(
        title: sv ? "Laylat al-Qadr" : "Laylat al-Qadr",
        subtitle: sv
            ? "Allmaktens natt. Bättre än tusen månader"
            : "The Night of Decree. Better than a thousand months",
        hijriMonth: 9,
        hijriDay: 27,
        description: sv
            ? "Allmaktens natt, då Koranen först uppenbarades för profeten Muhammed. Den anses vara bättre än tusen månader."
            : "The Night of Power, when the Quran was first revealed to the Prophet Muhammad. It is considered better than a thousand months.",
        iconType: "moon",
        isMajorHoliday: false,
      ),
      IslamicEvent(
        title: sv ? "Eid al-Fitr (festival)" : "Eid al-Fitr (festival)",
        subtitle: sv
            ? "Firandet av fastemånadens slut"
            : "Celebration marking the end of Ramadan",
        hijriMonth: 10,
        hijriDay: 1,
        description: sv
            ? "Eid al-Fitr markerar slutet på fastemånaden Ramadan. Det är en glädjefylld högtid som firas med gemensam bön, familjebesök och festmåltider."
            : "Eid al-Fitr marks the end of the fasting month of Ramadan. It is a joyful celebration marked by congregational prayers, family visits, and festive meals.",
        iconType: "mosque",
        isMajorHoliday: true,
      ),
      IslamicEvent(
        title: sv ? "Början av Dhu al-Hijjah" : "Start of Dhu al-Hijjah",
        subtitle:
            sv ? "Hajj-pilgrimsfärd börjar" : "Sacred month of Hajj begins",
        hijriMonth: 12,
        hijriDay: 1,
        description: sv
            ? "Början på den heliga månaden Dhu al-Hijjah. De första tio dagarna av denna månad anses vara de bästa dagarna på året för goda gärningar."
            : "The start of the holy month of Dhu al-Hijjah. The first ten days of this month are considered the best days of the year for performing good deeds.",
        iconType: "kaaba",
        isMajorHoliday: false,
      ),
      IslamicEvent(
        title: sv ? "Hajj-pilgrimsfärd börjar" : "Hajj Pilgrimage Begins",
        subtitle:
            sv ? "Pilgrimerna reser till Mina" : "Pilgrims travel to Mina",
        hijriMonth: 12,
        hijriDay: 8,
        description: sv
            ? "Hajj-pilgrimsfärden börjar i Mecka. Pilgrimer beger sig till Mina för att påbörja riterna för Hajj, en av islams fem pelare."
            : "The Hajj pilgrimage begins in Mecca. Pilgrims head to Mina to start the Hajj rites, one of the five pillars of Islam.",
        iconType: "kaaba",
        isMajorHoliday: false,
      ),
      IslamicEvent(
        title: sv ? "Arafah-dagen (Fasta)" : "Day of Arafah (Fasting)",
        subtitle: sv
            ? "Rekommenderad fasta. Speciella böner vid berget Arafah"
            : "Recommended fasting. Special prayers at Mount Arafah",
        hijriMonth: 12,
        hijriDay: 9,
        description: sv
            ? "Profeten Muhammed frid vare med honom, lärde dem som inte gör Hajj att fasta på Arafah-dagen med löftet att detta utplånar hela det föregående årets synder och de synder som begås under det kommande året."
            : "Prophet Muhammad, peace be upon him, taught those not performing Hajj to fast on the Day of Arafah with the promise that it expiates the sins of the past year and the coming year.",
        iconType: "moon",
        isMajorHoliday: true,
      ),
      IslamicEvent(
        title: sv ? "Eid al-Adha (festival)" : "Eid al-Adha (festival)",
        subtitle: sv
            ? "Offerhögtiden till minne av profeten Ibrahim"
            : "Festival of Sacrifice honoring Prophet Ibrahim",
        hijriMonth: 12,
        hijriDay: 10,
        description: sv
            ? "Offerhögtiden Eid al-Adha firas till minne av profeten Ibrahims villighet och trofasthet. Muslimer delar köttet med familj, vänner och behövande."
            : "The Festival of Sacrifice, Eid al-Adha, honors the willingness of Prophet Ibrahim (Abraham) to sacrifice his son in obedience to God's command. Muslims share meat with family, friends, and the needy.",
        iconType: "mosque",
        isMajorHoliday: true,
      ),
      IslamicEvent(
        title:
            sv ? "Sista dagen av Dhu al-Hijjah" : "Last Day of Dhu al-Hijjah",
        subtitle: sv
            ? "Rekommenderad fasta. Speciella böner vid slutet av året"
            : "Recommended fasting. Special prayers at the end of the year",
        hijriMonth: 12,
        hijriDay: 29,
        description: sv
            ? "Den sista dagen på det islamiska kalenderåret. Muslimer reflekterar över det gångna året och förbereder sig andligen inför det nya året."
            : "The final day of the Islamic calendar year. Muslims reflect on the past year and prepare spiritually for the coming new year.",
        iconType: "moon",
        isMajorHoliday: false,
      ),
    ];
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
      for (final hijriYear in [1447, 1448]) {
        final String filePath =
            '${FileConstants.hijriCalendarPathPrefix}$hijriYear.json';
        final String jsonString = await loadJsonFromAssetOrGit(filePath);
        final List<dynamic> jsonData = json.decode(jsonString);
        for (final dynamic row in jsonData) {
          final Map<String, dynamic> entry =
              Map<String, dynamic>.from(row as Map);
          final String? dateKey = entry['Gregorian_Date'] as String?;
          if (dateKey != null) {
            hijriDateCache[dateKey] = entry;
          }
        }
      }
    } catch (e) {
      print("Error loading Hijri calendar data: $e");
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
    // Search the flat cache for the event's Hijri month+day within the given
    // Gregorian year so results stay scoped to the visible year.
    for (final entry in hijriDateCache.values) {
      final gregDate = entry['Gregorian_Date'] as String?;
      if (gregDate == null) continue;
      if (!gregDate.startsWith(year.toString())) continue;
      if (entry['Hijri_Month_No'] == event.hijriMonth &&
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
      final hjMonth = hj['Hijri_Month_No'] as int;
      final hjDay = hj['Hijri_Day'] as int;
      final matches = islamicEvents
          .where((e) => e.hijriMonth == hjMonth && e.hijriDay == hjDay);
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
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      color: Colors.white,
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
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
                      color: selectedTab == 0 ? Colors.white : Colors.black54,
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
                      color: selectedTab == 1 ? Colors.white : Colors.black54,
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
    final firstDay = DateTime(currentDate.year, currentDate.month, 1);
    final emptyCells = firstDay.weekday - 1; // Mon=1, ..., Sun=7
    final totalDays = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    List<Widget> cellWidgets = [];
    // Empty cells for grid alignment
    for (int i = 0; i < emptyCells; i++) {
      cellWidgets.add(Container(color: Colors.white));
    }
    // Days of month
    for (int d = 1; d <= totalDays; d++) {
      final cellDate = DateTime(currentDate.year, currentDate.month, d);
      cellWidgets.add(_buildCalendarCell(cellDate));
    }
    // Align grid
    while (cellWidgets.length % 7 != 0) {
      cellWidgets.add(Container(color: Colors.white));
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
                  icon: const Icon(Icons.arrow_left,
                      size: 36, color: Colors.black),
                  onPressed: prevMonth,
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      '${_getGregorianMonthNameSwedish(currentDate.month)} ${currentDate.year}',
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      getMonthHeaderSubtitle(),
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.54),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.arrow_right,
                      size: 36, color: Colors.black),
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
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
                border: Border.all(color: const Color(0xFFE2E2E2), width: 1.0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Table(
                  border: const TableBorder.symmetric(
                    inside: BorderSide(color: Color(0xFFE2E2E2), width: 1.0),
                  ),
                  children: tableRows,
                ),
              ),
            ),
            const SizedBox(height: 25),
            // Title
            const Text(
              'Viktigt kommande datum',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
                      color: Colors.grey[500],
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
                          ? const Color(0xFFEAF5EA)
                          : const Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(16),
                      border: isMajorFestival
                          ? Border.all(
                              color: const Color(0xFF0B7A12), width: 1.0)
                          : null,
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
                                  color: Colors.white,
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
                                      style: const TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${occurrence.event.subtitle} / ${_getWeekdayAbbrSwedish(occurrence.gregorianDate.weekday)}, ${occurrence.gregorianDate.day} ${_getGregorianMonthNameSwedish(occurrence.gregorianDate.month).toLowerCase()} ${occurrence.gregorianDate.year}',
                                      style: const TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xFF737373),
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
    final hj = getHijriDate(date);
    final int hijriDay = hj['Hijri_Day'];
    final int hjMonth = hj['Hijri_Month_No'];
    final matchingEvents = islamicEvents
        .where((e) => e.hijriMonth == hjMonth && e.hijriDay == hijriDay);
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
        color: const Color(0xFFEAF5EA),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFF0B7A12), width: 1.5),
      );
    } else if (isSelected) {
      cellMargin = const EdgeInsets.all(3.0);
      cellDecoration = BoxDecoration(
        color: const Color(0xFFEAF5EA),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: const Color(0xFF0B7A12).withOpacity(0.5), width: 1.0),
      );
    } else if (hasEvent) {
      cellMargin = EdgeInsets.zero;
      cellDecoration = const BoxDecoration(
        color: Color(0xFFEAF5EA),
      );
    } else {
      cellMargin = EdgeInsets.zero;
      cellDecoration = const BoxDecoration(
        color: Colors.white,
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
                        color: isToday ? const Color(0xFF0B7A12) : Colors.black,
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
                            : Colors.grey[500],
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
    final yearEvents = getEventsForYear(currentDate.year);
    // Grouping events
    // Section 1: Major Holidays
    final majorHolidays =
        yearEvents.where((oe) => oe.event.isMajorHoliday).toList();
    // Section 2: Grouped by Hijri Month
    Map<int, List<EventOccurrence>> groupedByMonth = {};
    for (var oe in yearEvents) {
      final monthNo = oe.hijriDate['Hijri_Month_No'] as int;
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
                const Text(
                  'ALLA ISLAMISKA HELGDAGAR',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
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
          color: isSelected ? const Color(0xFF0B7A12) : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          year.toString(),
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }

  // DATE BADGE WIDGET FOR EVENT CARD
  Widget _buildDateBadge(EventOccurrence occ) {
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
        color: const Color(0xFFEFF7EF),
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
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$gregDay $gregMonth',
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.1,
                  ),
                ),
                Text(
                  weekday,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 9.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
    final isNotifActive = activeNotifications[occurrence.event.title] ?? false;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
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
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        occurrence.event.subtitle,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF737373),
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
    final weekdayStr = _getWeekdayAbbrSwedish(occ.gregorianDate.weekday);
    final hijriMonthName =
        _mapHijriMonthToSwedish(occ.hijriDate['Hijri_Month_Name']);
    final gregMonthName =
        _getGregorianMonthNameSwedish(occ.gregorianDate.month);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
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
                      color: Colors.grey[300],
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
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Three-column Detail Card
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF5EA),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: const Color(0xFF0B7A12), width: 1.0),
                  ),
                  child: Row(
                    children: [
                      // Weekday Column
                      Expanded(
                        child: Center(
                          child: Text(
                            weekdayStr,
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // Divider
                      Container(
                          height: 40,
                          width: 1,
                          color: const Color(0xFF0B7A12).withOpacity(0.2)),
                      // Hijri Day/Month Column
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              occ.hijriDate['Hijri_Day'].toString(),
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              hijriMonthName,
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                          height: 40,
                          width: 1,
                          color: const Color(0xFF0B7A12).withOpacity(0.2)),
                      // Gregorian Day/Month Column
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Text(
                              occ.gregorianDate.day.toString(),
                              style: const TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              gregMonthName,
                              style: TextStyle(
                                fontFamily: 'Manrope',
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // About Section
                const Text(
                  'OM DENNA DAG',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  occ.event.description,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
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
