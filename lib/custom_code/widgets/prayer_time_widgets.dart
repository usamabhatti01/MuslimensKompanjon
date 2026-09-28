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
      'today': 'Today',
    },
    'sv': {
      'Fajr': 'Fajr',
      'Shuruq': 'Shuruq',
      'Dhuhr': 'Dhuhr',
      'Asr': 'Asr',
      'Maghrib': 'Maghrib',
      'Isha': 'Isha',
      'timeLeft': 'Tid kvar till {nextPrayer}: {time}',
      'today': 'Idag',
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

class _PrayerTimeWidgetsState extends State<PrayerTimeWidgets>
    with WidgetsBindingObserver {
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

  DateTime selectedDate = DateTime.now();
  late ScrollController _scrollController;
  late List<DateTime> days;
  final double itemWidth = 90.0;
  bool _scrolledToSelected = false;
  bool _isScrolledFar = false;
  bool _isProgrammaticScroll = false;
  double _viewportWidth = 0.0;
  dynamic decodedJson;
  int? loadedYear;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _generateMonthDays();

    tz.initializeTimeZones();

    loadPrayerData();
  }

  void _onScroll() {
    if (_isProgrammaticScroll ||
        !_scrollController.hasClients ||
        _viewportWidth <= 0 ||
        days.isEmpty) return;
    const double totalItemWidth = 90.0;
    final now = timezone.isNotEmpty ? nowInCity() : DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final todayIndex = days.indexWhere((d) =>
        d.year == todayDate.year &&
        d.month == todayDate.month &&
        d.day == todayDate.day);
    if (todayIndex == -1) return;

    final double todayOffset = (todayIndex * totalItemWidth) +
        (totalItemWidth / 2) -
        (_viewportWidth / 2);
    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double clampedTodayOffset =
        todayOffset.clamp(0.0, maxScroll > 0 ? maxScroll : 0.0);
    final double scrollDiff =
        (_scrollController.offset - clampedTodayOffset).abs();
    final bool far = (scrollDiff / totalItemWidth) >= 2.2;

    if (far != _isScrolledFar) {
      setState(() {
        _isScrolledFar = far;
      });
    }
  }

  void _setDateAndRefresh(DateTime newDate) {
    selectedDate = newDate;
    _isScrolledFar = false;

    if (decodedJson != null && loadedYear == selectedDate.year) {
      final key = "${selectedDate.year.toString().padLeft(4, '0')}-"
          "${selectedDate.month.toString().padLeft(2, '0')}-"
          "${selectedDate.day.toString().padLeft(2, '0')}";
      final prayerData = decodedJson['prayer_times']?[key];
      if (prayerData != null) {
        prayerTimes = {
          'Fajr': _fmt(prayerData['fajr']),
          'Shuruq': _fmt(prayerData['shuruq']),
          'Dhuhr': _fmt(prayerData['dhuhr']),
          'Asr': _fmt(prayerData['asr']),
          'Maghrib': _fmt(prayerData['maghrib']),
          'Isha': _fmt(prayerData['isha']),
        };
        updatePrayerState();
      }
    }
  }

  void _recenterToToday() {
    final now = timezone.isNotEmpty ? nowInCity() : DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    setState(() {
      _setDateAndRefresh(today);
    });
    if (_viewportWidth > 0) {
      _scrollToSelected(_viewportWidth);
    }
    loadPrayerData();
  }

  @override
  void didUpdateWidget(covariant PrayerTimeWidgets oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.cityName != widget.cityName) {
      if (mounted) {
        setState(() {
          prayerTimes.clear();
          decodedJson = null;
          _scrolledToSelected = false;
        });
      }

      loadPrayerData();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    ticker?.cancel();

    remaining.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      loadTodayHijriData();
      setState(() {
        final now = timezone.isNotEmpty ? nowInCity() : DateTime.now();
        selectedDate = DateTime(now.year, now.month, now.day);
        decodedJson = null;
        _generateMonthDays();
        _scrolledToSelected = false;
      });
      loadPrayerData();
    }
  }

  // =========================

  // LOAD DATA

  // =========================

  Future<void> loadPrayerData() async {
    try {
      if (decodedJson == null || loadedYear != selectedDate.year) {
        final jsonString = await loadPrayerJson(
          widget.cityName,
          selectedDate.year,
        );
        decodedJson = json.decode(jsonString);
        loadedYear = selectedDate.year;
      }

      final key = "${selectedDate.year.toString().padLeft(4, '0')}-"
          "${selectedDate.month.toString().padLeft(2, '0')}-"
          "${selectedDate.day.toString().padLeft(2, '0')}";

      final prayerData = decodedJson['prayer_times']?[key];

      if (prayerData == null) return;

      // ✅ TAKE TIMEZONE FROM JSON (FIXED)

      final newTimezone = decodedJson['city']['timezone'];

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
          _generateMonthDays();
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

    if (!isToday(selectedDate)) {
      ticker?.cancel();
      currentPrayer = '';
      nextPrayer = '';
      nextPrayerTime = null;
      remaining.value = Duration.zero;
      return;
    }

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
      final fajr = prayerTimes['Fajr'];
      if (fajr != null) {
        next = parseTime(
          fajr,
          loc,
          now.add(const Duration(days: 1)),
        );
        nextName = 'Fajr';
      }
    }

    currentPrayer = current;
    nextPrayer = nextName ?? 'Fajr';
    nextPrayerTime = next;

    if (next != null) {
      final diff = next.difference(now);
      remaining.value = diff.isNegative ? Duration.zero : diff;
    }

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

      // Check if the calendar day has changed in the city's timezone
      if (now.day != selectedDate.day) {
        loadTodayHijriData();
        if (mounted) {
          setState(() {
            selectedDate = DateTime(now.year, now.month, now.day);
            _generateMonthDays();
            _scrolledToSelected = false;
          });
          loadPrayerData();
        }
        return;
      }

      final diff = nextPrayerTime!.difference(now);

      if (diff.isNegative) {
        remaining.value = Duration.zero;
        loadPrayerData();
      } else {
        remaining.value = diff;
      }
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
    } catch (_) {}
    try {
      final appStateLang = FFAppState().user.languageCode;
      if (appStateLang.isNotEmpty) {
        lang = appStateLang;
      }
    } catch (_) {}

    if (lang.startsWith('sv')) lang = 'sv';

    final map =
        PrayerWidgetStrings.values[lang] ?? PrayerWidgetStrings.values['en']!;

    String text = map[key] ?? key;

    args?.forEach((k, v) {
      text = text.replaceAll('{$k}', v);
    });

    return text;
  }

  Widget item(String title, String time) {
    final theme = FlutterFlowTheme.of(context);
    final active = isToday(selectedDate) && (currentPrayer == title);

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _t(title),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                color: active ? theme.primary : theme.primaryText,
              ),
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active ? theme.primary : theme.primaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _generateMonthDays() {
    final now = timezone.isNotEmpty ? nowInCity() : DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final List<DateTime> list = [];

    // Generate dates from today - 15 days to today + 15 days
    for (int i = -15; i <= 15; i++) {
      list.add(today.add(Duration(days: i)));
    }

    days = list;
  }

  void _scrollToSelected(double viewportWidth) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;

      final int selectedIndex = days.indexWhere((d) =>
          d.day == selectedDate.day &&
          d.month == selectedDate.month &&
          d.year == selectedDate.year);

      if (selectedIndex == -1) return;

      final double totalItemWidth =
          80.0 + 10.0; // width (80) + horizontal margins (5 * 2)
      final double itemCenter =
          (selectedIndex * totalItemWidth) + (totalItemWidth / 2);
      final double targetOffset = itemCenter - (viewportWidth / 2);
      final double maxScroll = (days.length * totalItemWidth) - viewportWidth;

      _isProgrammaticScroll = true;
      _scrollController
          .animateTo(
        targetOffset.clamp(0.0, maxScroll > 0 ? maxScroll : 0.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      )
          .then((_) {
        if (mounted) {
          _isProgrammaticScroll = false;
        }
      });
    });
  }

  bool isToday(DateTime date) {
    if (timezone.isEmpty) {
      final now = DateTime.now();
      return date.day == now.day &&
          date.month == now.month &&
          date.year == now.year;
    }
    final now = nowInCity();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  String formatDate(BuildContext context, DateTime date) {
    String lang = 'en';
    try {
      lang = FFLocalizations.of(context).languageCode;
    } catch (_) {}
    try {
      final appStateLang = FFAppState().user.languageCode;
      if (appStateLang.isNotEmpty) {
        lang = appStateLang;
      }
    } catch (_) {}

    if (isToday(date)) {
      if (lang.startsWith('sv')) {
        return 'Idag';
      } else {
        return 'Today';
      }
    }

    if (lang.startsWith('sv')) {
      lang = 'sv';
    } else {
      lang = 'en';
    }
    // Remove dots and convert to lowercase to match "ons 15 juli" and "mon 15 jul" formats
    return DateFormat('EEE d MMM', lang)
        .format(date)
        .replaceAll('.', '')
        .toLowerCase();
  }

  Widget buildDatePicker(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final primary = theme.primary;
    return SizedBox(
      height: 36,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double viewportWidth = constraints.maxWidth;
          _viewportWidth = viewportWidth;
          if (viewportWidth > 0 && !_scrolledToSelected) {
            _scrolledToSelected = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToSelected(viewportWidth);
            });
          }

          return ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            itemBuilder: (context, index) {
              final date = days[index];
              final isSelected = selectedDate.day == date.day &&
                  selectedDate.month == date.month &&
                  selectedDate.year == date.year;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _setDateAndRefresh(date);
                  });
                  _scrollToSelected(viewportWidth);
                  loadPrayerData();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 80.0,
                  height: 28.0,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? primary : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          formatDate(context, date),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade600,
                          ),
                        ),
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

  // =========================

  // BUILD

  // =========================

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    if (prayerTimes.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final isCurrentDay = isToday(selectedDate);
    final now = timezone.isNotEmpty ? nowInCity() : DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final selDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    final int dayDiff = (selDate.difference(todayDate).inDays).abs();

    final bool showTodayButton =
        _isScrolledFar || (!isCurrentDay && dayDiff >= 3);

    Widget bottomBarContent;
    if (showTodayButton) {
      bottomBarContent = GestureDetector(
        key: const ValueKey('today_capsule_btn'),
        onTap: _recenterToToday,
        child: Container(
          width: 76.0,
          height: 26.0,
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            _t('today'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else if (isCurrentDay) {
      bottomBarContent = ValueListenableBuilder<Duration>(
        key: const ValueKey('countdown_timer_view'),
        valueListenable: remaining,
        builder: (context, value, _) {
          final displayPrayer =
              nextPrayer.isNotEmpty ? nextPrayer : prayerOrder.first;
          return FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _t('timeLeft', args: {
                'nextPrayer': _t(displayPrayer),
                'time': formatDuration(value),
              }),
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: theme.primary,
              ),
            ),
          );
        },
      );
    } else {
      bottomBarContent = const SizedBox.shrink(key: ValueKey('empty_spacer'));
    }

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildDatePicker(context),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                item('Fajr', prayerTimes['Fajr'] ?? '--:--'),
                item('Shuruq', prayerTimes['Shuruq'] ?? '--:--'),
                item('Dhuhr', prayerTimes['Dhuhr'] ?? '--:--'),
                item('Asr', prayerTimes['Asr'] ?? '--:--'),
                item('Maghrib', prayerTimes['Maghrib'] ?? '--:--'),
                item('Isha', prayerTimes['Isha'] ?? '--:--'),
              ],
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 26,
            child: Center(
              child: bottomBarContent,
            ),
          ),
        ],
      ),
    );
  }
}
