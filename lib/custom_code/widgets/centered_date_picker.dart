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

class CenteredDatePicker extends StatefulWidget {
  const CenteredDatePicker({
    super.key,
    this.width,
    this.height,
    required this.primaryColor,
  });
  final double? width;
  final double? height;
  final Color primaryColor;
  @override
  State<CenteredDatePicker> createState() => _CenteredDatePickerState();
}

class _CenteredDatePickerState extends State<CenteredDatePicker>
    with WidgetsBindingObserver {
  late ScrollController _controller;
  late List<DateTime> days;
  late int todayIndex;
  final double itemWidth = 90.0;
  bool _scrolledToToday = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = ScrollController();
    _generateMonthDays();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Reload Hijri calendar data for today
      loadTodayHijriData();

      setState(() {
        _generateMonthDays();
        _scrolledToToday = false; // Trigger re-scrolling to today
      });
    }
  }

  void _generateMonthDays() {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, now.month, 1);
    final nextMonth = DateTime(now.year, now.month + 1, 1);
    final totalDays = nextMonth.difference(firstDay).inDays;
    days = List.generate(
      totalDays,
      (index) => DateTime(now.year, now.month, index + 1),
    );
    todayIndex = now.day - 1;
  }

  void _scrollToToday(double viewportWidth) {
    if (!_controller.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToToday(viewportWidth);
      });
      return;
    }

    final double totalItemWidth =
        itemWidth + 12.0; // itemWidth (90) + horizontal margins (6 * 2)
    final double itemCenter =
        (todayIndex * totalItemWidth) + (totalItemWidth / 2);
    final double targetOffset = itemCenter - (viewportWidth / 2);
    final double maxScroll = (days.length * totalItemWidth) - viewportWidth;

    _controller.animateTo(
      targetOffset.clamp(0.0, maxScroll > 0 ? maxScroll : 0.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  String formatDate(BuildContext context, DateTime date) {
    if (isToday(date)) {
      String lang = 'en';
      try {
        lang = FFLocalizations.of(context).languageCode;
      } catch (_) {}
      if (lang.startsWith('sv')) {
        return 'Idag';
      } else {
        return 'Today';
      }
    }
    String lang = 'en';
    try {
      lang = FFLocalizations.of(context).languageCode;
    } catch (_) {}
    if (lang.startsWith('sv')) {
      lang = 'sv';
    } else {
      lang = 'en';
    }
    return DateFormat('EEE d MMM', lang).format(date);
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    final primary = widget.primaryColor ?? Colors.blue;
    return SizedBox(
      height: 70,
      width: widget.width,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double viewportWidth = constraints.maxWidth;
          if (viewportWidth > 0 && !_scrolledToToday) {
            _scrolledToToday = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToToday(viewportWidth);
            });
          }

          return ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            itemBuilder: (context, index) {
              final date = days[index];
              final selected = isToday(date);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: itemWidth,
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                decoration: BoxDecoration(
                  color: selected ? primary : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    formatDate(context, date),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.black87,
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
}
