// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Action to initialize habit tracker settings
Future<void> habitTrackerService() async {
  await HabitTrackerService().init();
}

/// Represents a user-created custom activity
class CustomCalendarActivity {
  final String id;
  final String title;
  final String
      categoryKey; // 'custom', 'fasting', 'quran', 'prayers', 'dhikr', 'charity'
  final Color categoryColor;
  final DateTime date; // Normalized to YYYY-MM-DD
  final String time; // e.g. "17:30"
  final String reminderDay; // "Samma dag", "1 dag innan", "2 dagar innan"
  final String reminderTime; // e.g. "kl. 17:00"
  final String notes;
  bool isCompleted;

  CustomCalendarActivity({
    required this.id,
    required this.title,
    required this.categoryKey,
    required this.categoryColor,
    required this.date,
    required this.time,
    required this.reminderDay,
    required this.reminderTime,
    this.notes = '',
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'categoryKey': categoryKey,
        'categoryColor': categoryColor.value,
        'date':
            '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        'time': time,
        'reminderDay': reminderDay,
        'reminderTime': reminderTime,
        'notes': notes,
        'isCompleted': isCompleted,
      };

  factory CustomCalendarActivity.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(json['date'] as String);
    } catch (_) {
      parsedDate = DateTime.now();
    }
    return CustomCalendarActivity(
      id: json['id'] as String? ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['title'] as String? ?? '',
      categoryKey: json['categoryKey'] as String? ?? 'custom',
      categoryColor: Color(json['categoryColor'] as int? ?? 0xFF8E44AD),
      date: DateTime(parsedDate.year, parsedDate.month, parsedDate.day),
      time: json['time'] as String? ?? '12:00',
      reminderDay: json['reminderDay'] as String? ?? 'Samma dag',
      reminderTime: json['reminderTime'] as String? ?? 'kl. 12:00',
      notes: json['notes'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}

/// Represents a single Islamic Habit / Sunnah item
class HabitItem {
  final String id;
  final String title;
  final String subtitle;
  final String
      categoryKey; // 'fasting', 'quran', 'prayers', 'dhikr', 'charity', 'custom'
  final Color color;
  final String iconName;
  final String hadithQuote;
  final String hadithSource;
  final String defaultTime;

  const HabitItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.categoryKey,
    required this.color,
    required this.iconName,
    required this.hadithQuote,
    required this.hadithSource,
    this.defaultTime = '',
  });
}

class HabitTrackerService {
  static final HabitTrackerService _instance = HabitTrackerService._internal();
  factory HabitTrackerService() => _instance;
  HabitTrackerService._internal();

  static const String _settingsKey = 'habit_tracker_settings_v1';
  static const String _remindersKey = 'habit_reminder_settings_v1';
  static const String _customActivitiesKey = 'custom_calendar_activities_v1';

  // Category Color Codes (exact from specifications)
  static const Color colorCustom = Color(0xFF8E44AD); // Purple
  static const Color colorFasting = Color(0xFF2ECC71); // Green
  static const Color colorQuran = Color(0xFF3498DB); // Blue
  static const Color colorPrayer = Color(0xFFF1C40F); // Gold/Yellow
  static const Color colorDhikr = Color(0xFFE67E22); // Orange/Red
  static const Color colorCharity = Color(0xFFE91E63); // Pink

  // Default enabled state for all habits
  final Map<String, bool> _defaultSettings = {
    'fasting_monday_thursday': true,
    'fasting_monday': true,
    'fasting_thursday': true,
    'fasting_ayyam_al_bid': true,
    'fasting_arafah': true,
    'fasting_ashura': true,
    'fasting_shawwal': true,
    'fasting_kada': false,
    'quran_kahf_friday': true,
    'quran_daily': true,
    'quran_khatm': false,
    'prayer_duha': true,
    'prayer_witr': true,
    'prayer_tahajjud': true,
    'prayer_rawatib': true,
    'prayer_eclipse': false,
    'dhikr_morning': true,
    'dhikr_evening': true,
    'dhikr_after_prayer': true,
    'charity_friday': true,
    'charity_good_deeds': true,
    'charity_zakat': true,
    'charity_dhul_hijjah': true,
    'custom_events_enabled': true,
  };

  Map<String, bool> _currentSettings = {};
  Map<String, Map<String, String>> _reminderSettings = {};
  List<CustomCalendarActivity> _customActivities = [];
  bool _isInitialized = false;

  // Master definition of all habits structured per Swedish specifications
  static final Map<String, HabitItem> masterHabits = {
    // 1. Fasta
    'fasting_monday_thursday': const HabitItem(
      id: 'fasting_monday_thursday',
      title: 'Måndags- & Torsdagsfasta',
      subtitle: 'Sunnah fasta två dagar i veckan',
      categoryKey: 'fasting',
      color: colorFasting,
      iconName: 'fasting',
      hadithQuote:
          'Profeten ﷺ sade: "Handlingarna presenteras inför Allah på måndagar och torsdagar, och jag vill att mina handlingar ska presenteras medan jag fastar."',
      hadithSource: 'Jami` at-Tirmidhi 747',
      defaultTime: '04:30',
    ),
    'fasting_monday': const HabitItem(
      id: 'fasting_monday',
      title: 'Fasta måndag',
      subtitle: 'Sunnah fasta',
      categoryKey: 'fasting',
      color: colorFasting,
      iconName: 'fasting',
      hadithQuote:
          'Profeten ﷺ tillfrågades om fasta på måndagar och sade: "Det är dagen då jag föddes och dagen då uppenbarelsen sändes till mig."',
      hadithSource: 'Sahih Muslim 1162',
      defaultTime: '04:30',
    ),
    'fasting_thursday': const HabitItem(
      id: 'fasting_thursday',
      title: 'Fasta torsdag',
      subtitle: 'Sunnah fasta',
      categoryKey: 'fasting',
      color: colorFasting,
      iconName: 'fasting',
      hadithQuote:
          'Profeten ﷺ sade: "Handlingarna presenteras inför Allah på måndagar och torsdagar, och jag vill att mina handlingar ska presenteras medan jag fastar."',
      hadithSource: 'Jami` at-Tirmidhi 747',
      defaultTime: '04:30',
    ),
    'fasting_ayyam_al_bid': const HabitItem(
      id: 'fasting_ayyam_al_bid',
      title: 'Ayyam al-Bid (Vita dagarna)',
      subtitle: '13:e, 14:e och 15:e i Hijri-månaden',
      categoryKey: 'fasting',
      color: colorFasting,
      iconName: 'moon',
      hadithQuote:
          'Profeten ﷺ sade till Abu Dharr: "Om du fastar tre dagar i månaden, fasta då den 13:e, 14:e och 15:e."',
      hadithSource: 'Sunan an-Nasa\'i 2424',
      defaultTime: '04:30',
    ),
    'fasting_arafah': const HabitItem(
      id: 'fasting_arafah',
      title: 'Fasta Arafah',
      subtitle: '9:e Dhu al-Hijjah',
      categoryKey: 'fasting',
      color: colorFasting,
      iconName: 'kaaba',
      hadithQuote:
          'Fasta på Arafah-dagen soner för synderna från det gångna året och det kommande året.',
      hadithSource: 'Sahih Muslim 1162',
      defaultTime: '04:30',
    ),
    'fasting_ashura': const HabitItem(
      id: 'fasting_ashura',
      title: 'Fasta Ashura',
      subtitle: '10:e Muharram',
      categoryKey: 'fasting',
      color: colorFasting,
      iconName: 'fasting',
      hadithQuote:
          'Fasta på Ashura-dagen soner för synderna under det föregående året.',
      hadithSource: 'Sahih Muslim 1162',
      defaultTime: '04:30',
    ),
    'fasting_shawwal': const HabitItem(
      id: 'fasting_shawwal',
      title: '6 dagar i Shawwal',
      subtitle: 'Sunnah efter Ramadan',
      categoryKey: 'fasting',
      color: colorFasting,
      iconName: 'fasting',
      hadithQuote:
          'Den som fastar Ramadan och sedan följer upp det med sex dagar i Shawwal, det är som att ha fastat hela året.',
      hadithSource: 'Sahih Muslim 1164',
      defaultTime: '04:30',
    ),
    'fasting_kada': const HabitItem(
      id: 'fasting_kada',
      title: 'Egen fasta / Skuld-fasta (Kada)',
      subtitle: 'Markera valt datum du fastar ikapp',
      categoryKey: 'fasting',
      color: colorFasting,
      iconName: 'fasting',
      hadithQuote:
          'Den som har missat fastedagar från Ramadan ska fasta ikapp dem.',
      hadithSource: 'Koranen 2:185',
      defaultTime: '04:30',
    ),

    // 2. Koran
    'quran_kahf_friday': const HabitItem(
      id: 'quran_kahf_friday',
      title: 'Läs Surah Al-Kahf',
      subtitle: 'Fredags-Sunnah',
      categoryKey: 'quran',
      color: colorQuran,
      iconName: 'quran',
      hadithQuote:
          'Den som läser Surah Al-Kahf på fredagen kommer att ha ett ljus som skiner för honom från en fredag till nästa.',
      hadithSource: 'Al-Mustadrak \'ala al-Sahihayn 3392',
      defaultTime: '10:00',
    ),
    'quran_daily': const HabitItem(
      id: 'quran_daily',
      title: 'Daglig Koranläsning',
      subtitle: 'Mål: 1 Sida, 1 Hizb, 1 Juz',
      categoryKey: 'quran',
      color: colorQuran,
      iconName: 'quran',
      hadithQuote:
          'Läs Koranen, för på Uppståndelsens dag kommer den att komma som en förebedjare för dess följeslagare.',
      hadithSource: 'Sahih Muslim 804',
      defaultTime: '06:00',
    ),
    'quran_khatm': const HabitItem(
      id: 'quran_khatm',
      title: 'Koran-avslut (Khatm-planering)',
      subtitle: 'Dagliga lässekvenser för slutförande',
      categoryKey: 'quran',
      color: colorQuran,
      iconName: 'quran',
      hadithQuote:
          'Den bästa handlingen är när den troende påbörjar Koranen från början så fort han avslutat den.',
      hadithSource: 'Sunan at-Tirmidhi 2948',
      defaultTime: '19:00',
    ),

    // 3. Böner
    'prayer_duha': const HabitItem(
      id: 'prayer_duha',
      title: 'Duha-bönen',
      subtitle: 'Förmiddagsbön (2-8 rak\'ah)',
      categoryKey: 'prayers',
      color: colorPrayer,
      iconName: 'sun',
      hadithQuote:
          'Varje morgon krävs en allmosa för varje led i din kropp... och två rak\'ah av Duha-bönen räcker för allt detta.',
      hadithSource: 'Sahih Muslim 720',
      defaultTime: '10:00',
    ),
    'prayer_witr': const HabitItem(
      id: 'prayer_witr',
      title: 'Witr-bönen',
      subtitle: 'Avslutande nattbön',
      categoryKey: 'prayers',
      color: colorPrayer,
      iconName: 'prayer',
      hadithQuote: 'Gör din sista bön på natten till en udda bön (Witr).',
      hadithSource: 'Sahih al-Bukhari 998',
      defaultTime: '22:30',
    ),
    'prayer_tahajjud': const HabitItem(
      id: 'prayer_tahajjud',
      title: 'Tahajjud / Qiyam Al-layl',
      subtitle: 'Nattbön',
      categoryKey: 'prayers',
      color: colorPrayer,
      iconName: 'night',
      hadithQuote:
          'Den bästa bönen efter de obligatoriska bönerna är nattbönen (Qiyam Al-layl).',
      hadithSource: 'Sahih Muslim 1163',
      defaultTime: '04:00',
    ),
    'prayer_rawatib': const HabitItem(
      id: 'prayer_rawatib',
      title: 'Sunnah Rawatib',
      subtitle: 'Frivilliga böner kopplade till de obligatoriska',
      categoryKey: 'prayers',
      color: colorPrayer,
      iconName: 'prayer',
      hadithQuote:
          'Vem som ber tolv frivilliga rak\'ah varje dag kommer Allah att bygga ett hus för i Paradiset.',
      hadithSource: 'Sahih Muslim 728',
      defaultTime: '12:00',
    ),
    'prayer_eclipse': const HabitItem(
      id: 'prayer_eclipse',
      title: 'Förmörkelseböner',
      subtitle: 'Al-Kusuf ☀️ & Al-Khusuf 🌕',
      categoryKey: 'prayers',
      color: colorPrayer,
      iconName: 'moon',
      hadithQuote:
          'Solen och månen är två av Allahs tecken... när ni ser en förmörkelse, be då och åkalla Allah.',
      hadithSource: 'Sahih al-Bukhari 1044',
      defaultTime: '14:00',
    ),

    // 4. Dhikr
    'dhikr_morning': const HabitItem(
      id: 'dhikr_morning',
      title: 'Morgon-Adhkar',
      subtitle: 'Åminnelser efter Fajr',
      categoryKey: 'dhikr',
      color: colorDhikr,
      iconName: 'dhikr',
      hadithQuote:
          'O ni som tror! Minns Allah med mycket åkallan och prisa Honom morgon och afton.',
      hadithSource: 'Koranen 33:41-42',
      defaultTime: '06:30',
    ),
    'dhikr_evening': const HabitItem(
      id: 'dhikr_evening',
      title: 'Kvälls-Adhkar',
      subtitle: 'Åminnelser efter Asr/Maghrib',
      categoryKey: 'dhikr',
      color: colorDhikr,
      iconName: 'dhikr',
      hadithQuote:
          'Att sitta med folk som minns Allah efter Asr fram till solnedgången är mer älskat av mig än att frige fyra slavar.',
      hadithSource: 'Sunan Abi Dawud 3667',
      defaultTime: '17:30',
    ),
    'dhikr_after_prayer': const HabitItem(
      id: 'dhikr_after_prayer',
      title: 'Tasbih efter bön',
      subtitle: 'Tasbih, Tahmid, Takbir 33x',
      categoryKey: 'dhikr',
      color: colorDhikr,
      iconName: 'tasbih',
      hadithQuote:
          'Den som säger SubhanAllah 33 ggr, Alhamdulillah 33 ggr, Allahu Akbar 33 ggr och avslutar med La ilaha illallah... får sina synder förlåtna.',
      hadithSource: 'Sahih Muslim 597',
      defaultTime: '13:00',
    ),

    // 5. Välgörenhet
    'charity_friday': const HabitItem(
      id: 'charity_friday',
      title: 'Ge Sadaqah',
      subtitle: 'Frivillig givmildhet / t.ex. på fredagar',
      categoryKey: 'charity',
      color: colorCharity,
      iconName: 'heart',
      hadithQuote:
          'Sadaqah som ges på fredagen har större förtjänst än någon annan dag.',
      hadithSource: 'Ibn al-Qayyim, Zad al-Ma\'ad',
      defaultTime: '11:00',
    ),
    'charity_good_deeds': const HabitItem(
      id: 'charity_good_deeds',
      title: 'Goda gärningar',
      subtitle: 'Allmänna handlingar och initiativ',
      categoryKey: 'charity',
      color: colorCharity,
      iconName: 'star',
      hadithQuote: 'Varje god handling är en välgörenhet (Sadaqah).',
      hadithSource: 'Sahih al-Bukhari 6021',
      defaultTime: '14:00',
    ),
    'charity_zakat': const HabitItem(
      id: 'charity_zakat',
      title: 'Zakat al-Fitr & al-Mal',
      subtitle: 'Obligatoriska zakat-påminnelser',
      categoryKey: 'charity',
      color: colorCharity,
      iconName: 'heart',
      hadithQuote: 'Upprätta bönen och ge Zakat.',
      hadithSource: 'Koranen 2:43',
      defaultTime: '10:00',
    ),
    'charity_dhul_hijjah': const HabitItem(
      id: 'charity_dhul_hijjah',
      title: 'Goda gärningar i Dhul Hijjah',
      subtitle: 'Första 10 dagarna',
      categoryKey: 'charity',
      color: colorCharity,
      iconName: 'star',
      hadithQuote:
          'Det finns inga dagar då goda handlingar är mer älskade av Allah än dessa tio dagar.',
      hadithSource: 'Sahih al-Bukhari 969',
      defaultTime: '10:00',
    ),

    // 6. Personligt / Eget
    'custom_events_enabled': const HabitItem(
      id: 'custom_events_enabled',
      title: 'Visa egna aktiviteter',
      subtitle: 'Visa användarskapade händelser i kalendern',
      categoryKey: 'custom',
      color: colorCustom,
      iconName: 'person',
      hadithQuote:
          'Den mest älskade handlingen inför Allah är den mest regelbundna, även om den är liten.',
      hadithSource: 'Sahih al-Bukhari 6464',
      defaultTime: '12:00',
    ),
  };

  /// Initialize and load settings from SharedPreferences
  Future<void> init() async {
    if (_isInitialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();

      // 1. Habit toggles
      final String? raw = prefs.getString(_settingsKey);
      if (raw != null && raw.isNotEmpty) {
        final Map<String, dynamic> decoded = json.decode(raw);
        _currentSettings = decoded.map((k, v) => MapEntry(k, v as bool));
      } else {
        _currentSettings = Map.from(_defaultSettings);
      }

      // 2. Reminder settings
      final String? rawReminders = prefs.getString(_remindersKey);
      if (rawReminders != null && rawReminders.isNotEmpty) {
        final Map<String, dynamic> decoded = json.decode(rawReminders);
        _reminderSettings = decoded.map((k, v) => MapEntry(
            k,
            Map<String, String>.from((v as Map)
                .map((rk, rv) => MapEntry(rk.toString(), rv.toString())))));
      }

      // 3. Custom activities
      final String? rawCustom = prefs.getString(_customActivitiesKey);
      if (rawCustom != null && rawCustom.isNotEmpty) {
        final List<dynamic> decodedList = json.decode(rawCustom);
        _customActivities = decodedList
            .map((item) => CustomCalendarActivity.fromJson(
                Map<String, dynamic>.from(item as Map)))
            .toList();
      }
    } catch (e) {
      print('HabitTrackerService init error: $e');
      _currentSettings = Map.from(_defaultSettings);
    }
    _isInitialized = true;
  }

  /// Get current enabled status of a habit
  bool isHabitEnabled(String habitId) {
    if (!_isInitialized || !_currentSettings.containsKey(habitId)) {
      return _defaultSettings[habitId] ?? true;
    }
    return _currentSettings[habitId] ?? true;
  }

  /// Save all habit settings
  Future<void> saveSettings(Map<String, bool> newSettings) async {
    _currentSettings = Map.from(newSettings);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_settingsKey, json.encode(_currentSettings));
    } catch (e) {
      print('Failed to save habit settings: $e');
    }
  }

  // =========================================================================
  // REMINDER SETTINGS
  // =========================================================================

  String getHabitReminderDay(String habitId) {
    return _reminderSettings[habitId]?['day'] ?? 'Samma dag';
  }

  String getHabitReminderTime(String habitId) {
    return _reminderSettings[habitId]?['time'] ?? 'Kl. 20:00';
  }

  Future<void> setHabitReminder({
    required String habitId,
    required String day,
    required String time,
  }) async {
    _reminderSettings[habitId] = {
      'day': day,
      'time': time,
    };
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_remindersKey, json.encode(_reminderSettings));
    } catch (e) {
      print('Failed to save habit reminder: $e');
    }
  }

  // =========================================================================
  // CUSTOM USER ACTIVITIES
  // =========================================================================

  List<CustomCalendarActivity> get customActivities =>
      List.unmodifiable(_customActivities);

  List<CustomCalendarActivity> getCustomActivitiesForDate(DateTime date,
      {String categoryFilter = 'Alla'}) {
    if (!isHabitEnabled('custom_events_enabled')) return [];
    final target = DateTime(date.year, date.month, date.day);
    return _customActivities.where((act) {
      final sameDay = act.date.year == target.year &&
          act.date.month == target.month &&
          act.date.day == target.day;
      if (!sameDay) return false;
      if (categoryFilter == 'Alla' || categoryFilter == 'all') return true;
      if (categoryFilter == 'Eget' || categoryFilter == 'custom')
        return act.categoryKey == 'custom';
      if (categoryFilter == 'Fasta') return act.categoryKey == 'fasting';
      if (categoryFilter == 'Koran') return act.categoryKey == 'quran';
      if (categoryFilter == 'Bön') return act.categoryKey == 'prayers';
      if (categoryFilter == 'Dhikr') return act.categoryKey == 'dhikr';
      if (categoryFilter == 'Välgörenhet') return act.categoryKey == 'charity';
      return true;
    }).toList();
  }

  Future<void> addCustomActivity(CustomCalendarActivity activity) async {
    _customActivities.add(activity);
    await _saveCustomActivities();
  }

  Future<void> deleteCustomActivity(String id) async {
    _customActivities.removeWhere((a) => a.id == id);
    await _saveCustomActivities();
  }

  Future<void> toggleCustomActivityCompletion(String id) async {
    final idx = _customActivities.indexWhere((a) => a.id == id);
    if (idx != -1) {
      _customActivities[idx].isCompleted = !_customActivities[idx].isCompleted;
      await _saveCustomActivities();
    }
  }

  Future<void> _saveCustomActivities() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = _customActivities.map((a) => a.toJson()).toList();
      await prefs.setString(_customActivitiesKey, json.encode(list));
    } catch (e) {
      print('Failed to save custom activities: $e');
    }
  }

  // =========================================================================
  // SCHEDULED HABITS FOR DATE
  // =========================================================================

  /// Get list of scheduled habits for a specific Gregorian date + Hijri date
  List<HabitItem> getScheduledHabitsForDate({
    required DateTime gregorianDate,
    required int hijriDay,
    required int hijriMonth,
    dynamic categoryFilter = 'Alla',
  }) {
    final List<HabitItem> scheduled = [];

    final bool mondayThursdayEnabled =
        isHabitEnabled('fasting_monday_thursday') ||
            isHabitEnabled('fasting_monday') ||
            isHabitEnabled('fasting_thursday');

    // 1. Check Monday & Thursday Fasting
    if (gregorianDate.weekday == DateTime.monday && mondayThursdayEnabled) {
      scheduled.add(masterHabits['fasting_monday_thursday'] ??
          masterHabits['fasting_monday']!);
    } else if (gregorianDate.weekday == DateTime.thursday &&
        mondayThursdayEnabled) {
      scheduled.add(masterHabits['fasting_monday_thursday'] ??
          masterHabits['fasting_thursday']!);
    }

    // 2. Check Ayyam al-Bid (13, 14, 15 of Hijri Month, except Ramadan)
    if (hijriMonth != 9 &&
        (hijriDay == 13 || hijriDay == 14 || hijriDay == 15) &&
        isHabitEnabled('fasting_ayyam_al_bid')) {
      scheduled.add(masterHabits['fasting_ayyam_al_bid']!);
    }

    // 3. Check Arafah (9 Dhu al-Hijjah = Month 12, Day 9)
    if (hijriMonth == 12 && hijriDay == 9 && isHabitEnabled('fasting_arafah')) {
      scheduled.add(masterHabits['fasting_arafah']!);
    }

    // 4. Check Ashura (10 Muharram = Month 1, Day 10)
    if (hijriMonth == 1 &&
        (hijriDay == 9 || hijriDay == 10) &&
        isHabitEnabled('fasting_ashura')) {
      scheduled.add(masterHabits['fasting_ashura']!);
    }

    // 5. Check Shawwal Fasting (Month 10, days 2..30)
    if (hijriMonth == 10 && hijriDay > 1 && isHabitEnabled('fasting_shawwal')) {
      scheduled.add(masterHabits['fasting_shawwal']!);
    }

    // 6. Check Friday Surah Al-Kahf & Sadaqah
    if (gregorianDate.weekday == DateTime.friday) {
      if (isHabitEnabled('quran_kahf_friday')) {
        scheduled.add(masterHabits['quran_kahf_friday']!);
      }
      if (isHabitEnabled('charity_friday')) {
        scheduled.add(masterHabits['charity_friday']!);
      }
    }

    // 7. Check 10 days of Dhul Hijjah (Month 12, Days 1..10)
    if (hijriMonth == 12 &&
        hijriDay >= 1 &&
        hijriDay <= 10 &&
        isHabitEnabled('charity_dhul_hijjah')) {
      scheduled.add(masterHabits['charity_dhul_hijjah']!);
    }

    // 8. Daily Habits
    if (isHabitEnabled('quran_daily')) {
      scheduled.add(masterHabits['quran_daily']!);
    }
    if (isHabitEnabled('prayer_duha')) {
      scheduled.add(masterHabits['prayer_duha']!);
    }
    if (isHabitEnabled('prayer_witr')) {
      scheduled.add(masterHabits['prayer_witr']!);
    }
    if (isHabitEnabled('prayer_tahajjud')) {
      scheduled.add(masterHabits['prayer_tahajjud']!);
    }
    if (isHabitEnabled('prayer_rawatib')) {
      scheduled.add(masterHabits['prayer_rawatib']!);
    }
    if (isHabitEnabled('dhikr_morning')) {
      scheduled.add(masterHabits['dhikr_morning']!);
    }
    if (isHabitEnabled('dhikr_evening')) {
      scheduled.add(masterHabits['dhikr_evening']!);
    }
    if (isHabitEnabled('dhikr_after_prayer')) {
      scheduled.add(masterHabits['dhikr_after_prayer']!);
    }

    // Apply category filter (supports both String and HabitCategory enum)
    final String catStr = categoryFilter is String
        ? categoryFilter
        : (categoryFilter is HabitCategory
            ? (categoryFilter == HabitCategory.fasting
                ? 'Fasta'
                : (categoryFilter == HabitCategory.prayers ? 'Bön' : 'Alla'))
            : 'Alla');

    if (catStr == 'Alla' || catStr == 'all') {
      return scheduled;
    } else if (catStr == 'Fasta' || catStr == 'fasting') {
      return scheduled.where((h) => h.categoryKey == 'fasting').toList();
    } else if (catStr == 'Koran' || catStr == 'quran') {
      return scheduled.where((h) => h.categoryKey == 'quran').toList();
    } else if (catStr == 'Bön' || catStr == 'prayers') {
      return scheduled.where((h) => h.categoryKey == 'prayers').toList();
    } else if (catStr == 'Dhikr' || catStr == 'dhikr') {
      return scheduled.where((h) => h.categoryKey == 'dhikr').toList();
    } else if (catStr == 'Välgörenhet' || catStr == 'charity') {
      return scheduled.where((h) => h.categoryKey == 'charity').toList();
    } else if (catStr == 'Eget' || catStr == 'custom') {
      return []; // master habits are not custom events
    }

    return scheduled;
  }

  /// Get indicator dots colors for calendar cells
  List<Color> getIndicatorDotsForDate({
    required DateTime gregorianDate,
    required int hijriDay,
    required int hijriMonth,
    dynamic categoryFilter = 'Alla',
  }) {
    final habits = getScheduledHabitsForDate(
      gregorianDate: gregorianDate,
      hijriDay: hijriDay,
      hijriMonth: hijriMonth,
      categoryFilter: categoryFilter,
    );

    final Set<Color> uniqueColors = {};
    for (var h in habits) {
      uniqueColors.add(h.color);
    }

    // Also include custom activities colors if enabled
    final String catStr = categoryFilter is String ? categoryFilter : 'Alla';
    final customActs =
        getCustomActivitiesForDate(gregorianDate, categoryFilter: catStr);
    for (var ca in customActs) {
      uniqueColors.add(ca.categoryColor);
    }

    return uniqueColors.take(4).toList();
  }

  // =========================================================================
  // DAILY COMPLETION STORAGE
  // =========================================================================

  String _getCompletionDateKey(DateTime date) {
    return 'habit_completed_${date.year}_${date.month.toString().padLeft(2, '0')}_${date.day.toString().padLeft(2, '0')}';
  }

  /// Get completed habit IDs for a given date
  Future<Set<String>> getCompletedHabitsForDate(DateTime date) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _getCompletionDateKey(date);
      final List<String>? list = prefs.getStringList(key);
      return list != null ? list.toSet() : <String>{};
    } catch (_) {
      return <String>{};
    }
  }

  /// Toggle habit completion status for a date
  Future<bool> toggleHabitCompletion(DateTime date, String habitId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _getCompletionDateKey(date);
      final List<String> current = prefs.getStringList(key) ?? [];
      final Set<String> set = current.toSet();

      final bool isCompletedNow;
      if (set.contains(habitId)) {
        set.remove(habitId);
        isCompletedNow = false;
      } else {
        set.add(habitId);
        isCompletedNow = true;
      }

      await prefs.setStringList(key, set.toList());
      return isCompletedNow;
    } catch (e) {
      print('Failed to toggle habit completion: $e');
      return false;
    }
  }
}
