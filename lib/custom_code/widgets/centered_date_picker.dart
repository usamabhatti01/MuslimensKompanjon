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

class _CenteredDatePickerState extends State<CenteredDatePicker> {
  late ScrollController _controller;

  late List<DateTime> days;

  late int todayIndex;

  final double itemWidth = 90.0;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();

    _generateMonthDays();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
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

  void _scrollToToday() {
    if (!_controller.hasClients) return;

    _controller.animateTo(
      todayIndex * itemWidth,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('EEE d MMM').format(date); // Sun 6 Apr
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
      child: ListView.builder(
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
                formatDate(date),
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
      ),
    );
  }
}
