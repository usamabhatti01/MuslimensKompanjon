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

/// Set your widget name, define your parameter, and then add the boilerplate
/// code using the `</>` button on the right!
import 'package:google_fonts/google_fonts.dart';
import '/custom_code/actions/habit_tracker_service.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import '/custom_code/actions/habit_tracker_service.dart';

class HabitChecklistBottomSheet extends StatefulWidget {
  const HabitChecklistBottomSheet({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  static Future<void> show(
    BuildContext context, {
    required DateTime selectedDate,
    required int hijriDay,
    required int hijriMonth,
    required String hijriMonthName,
    required int hijriYear,
    String? dateTitle,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _HabitChecklistSheetContent(
        selectedDate: selectedDate,
        hijriDay: hijriDay,
        hijriMonth: hijriMonth,
        hijriMonthName: hijriMonthName,
        hijriYear: hijriYear,
        dateTitle: dateTitle,
      ),
    );
  }

  @override
  State<HabitChecklistBottomSheet> createState() =>
      _HabitChecklistBottomSheetState();
}

class _HabitChecklistBottomSheetState extends State<HabitChecklistBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hDate = HijriCalendar.fromDate(now);
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _HabitChecklistSheetContent(
        selectedDate: now,
        hijriDay: hDate.hDay,
        hijriMonth: hDate.hMonth,
        hijriMonthName: hDate.longMonthName,
        hijriYear: hDate.hYear,
      ),
    );
  }
}

class _HabitChecklistSheetContent extends StatefulWidget {
  final DateTime selectedDate;
  final int hijriDay;
  final int hijriMonth;
  final String hijriMonthName;
  final int hijriYear;
  final String? dateTitle;

  const _HabitChecklistSheetContent({
    required this.selectedDate,
    required this.hijriDay,
    required this.hijriMonth,
    required this.hijriMonthName,
    required this.hijriYear,
    this.dateTitle,
  });

  @override
  State<_HabitChecklistSheetContent> createState() =>
      _HabitChecklistSheetContentState();
}

class _HabitChecklistSheetContentState
    extends State<_HabitChecklistSheetContent> {
  final HabitTrackerService _habitService = HabitTrackerService();
  Set<String> _completedHabits = {};
  List<HabitItem> _scheduledHabits = [];
  bool _isLoading = true;

  DateTime get _selectedDate => widget.selectedDate ?? DateTime.now();
  int get _hijriDay => widget.hijriDay ?? 1;
  int get _hijriMonth => widget.hijriMonth ?? 1;
  String get _hijriMonthName => widget.hijriMonthName ?? '';
  int get _hijriYear => widget.hijriYear ?? 1446;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _habitService.init();
    final completed =
        await _habitService.getCompletedHabitsForDate(_selectedDate);
    final scheduled = _habitService.getScheduledHabitsForDate(
      gregorianDate: _selectedDate,
      hijriDay: _hijriDay,
      hijriMonth: _hijriMonth,
    );

    if (mounted) {
      setState(() {
        _completedHabits = completed;
        _scheduledHabits = scheduled;
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleHabit(String habitId) async {
    final isDone =
        await _habitService.toggleHabitCompletion(_selectedDate, habitId);
    if (mounted) {
      setState(() {
        if (isDone) {
          _completedHabits.add(habitId);
        } else {
          _completedHabits.remove(habitId);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark
        ? (theme.secondaryBackground ?? const Color(0xFF1E293B))
        : Colors.white;

    final primaryTextColor = isDark ? Colors.white : const Color(0xFF0F172A);
    final secondaryTextColor =
        isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);

    // Find the first relevant Hadith to showcase
    final HabitItem? highlightedHabit = _scheduledHabits.isNotEmpty
        ? _scheduledHabits.firstWhere(
            (h) => h.categoryKey == 'fasting' || h.categoryKey == 'quran',
            orElse: () => _scheduledHabits.first,
          )
        : null;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20.0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Drag Handle
            Container(
              margin: const EdgeInsets.only(top: 12.0, bottom: 8.0),
              width: 44.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),

            // Header Row (Title & Close Button)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Att göra idag',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        '$_hijriDay $_hijriMonthName $_hijriYear AH',
                        style: GoogleFonts.manrope(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: secondaryTextColor,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1.0, thickness: 1.0),

            // Scrollable Content
            Flexible(
              child: _isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFF10B981),
                        ),
                      ),
                    )
                  : ListView(
                      shrinkWrap: true,
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 24.0),
                      children: [
                        // Completion Progress Bar
                        if (_scheduledHabits.isNotEmpty) ...[
                          _buildProgressBar(
                            completed: _completedHabits
                                .intersection(
                                    _scheduledHabits.map((e) => e.id).toSet())
                                .length,
                            total: _scheduledHabits.length,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16.0),
                        ],

                        // Checklist Items
                        if (_scheduledHabits.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32.0),
                            child: Center(
                              child: Text(
                                'Inga specifika Sunnah-mål schemalagda för denna dag.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.manrope(
                                  color: secondaryTextColor,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          )
                        else
                          ..._scheduledHabits.map((habit) {
                            final isCompleted =
                                _completedHabits.contains(habit.id);
                            return _buildChecklistItem(
                              habit: habit,
                              isCompleted: isCompleted,
                              isDark: isDark,
                              onToggle: () => _toggleHabit(habit.id),
                            );
                          }),

                        const SizedBox(height: 16.0),

                        // Sunnah Bevis Card (Hadith evidence)
                        if (highlightedHabit != null)
                          _buildHadithEvidenceCard(
                            habit: highlightedHabit,
                            isDark: isDark,
                          ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar({
    required int completed,
    required int total,
    required bool isDark,
  }) {
    final double percent =
        total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Framsteg',
                style: GoogleFonts.manrope(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              Text(
                '$completed av $total avklarade',
                style: GoogleFonts.manrope(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 6.0,
              backgroundColor:
                  isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem({
    required HabitItem habit,
    required bool isCompleted,
    required bool isDark,
    required VoidCallback onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: isCompleted
              ? const Color(0xFF10B981).withOpacity(0.5)
              : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
          width: 1.2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14.0),
          onTap: onToggle,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            child: Row(
              children: [
                // Custom Checkbox
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: isCompleted
                          ? const Color(0xFF10B981)
                          : (isDark
                              ? const Color(0xFF64748B)
                              : const Color(0xFF94A3B8)),
                      width: 2.0,
                    ),
                  ),
                  child: isCompleted
                      ? const Icon(
                          Icons.check_rounded,
                          color: Colors.white,
                          size: 18.0,
                        )
                      : null,
                ),
                const SizedBox(width: 12.0),

                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: isCompleted
                              ? (isDark
                                  ? const Color(0xFF64748B)
                                  : const Color(0xFF94A3B8))
                              : (isDark
                                  ? Colors.white
                                  : const Color(0xFF0F172A)),
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        habit.subtitle,
                        style: GoogleFonts.manrope(
                          fontSize: 12.0,
                          color: isDark
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),

                // Category Dot
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: habit.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHadithEvidenceCard({
    required HabitItem habit,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF064E3B).withOpacity(0.3)
            : const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFF10B981).withOpacity(0.35),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFF10B981),
                  size: 18.0,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                'Sunnah Bevis',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            habit.hadithQuote,
            style: GoogleFonts.manrope(
              fontSize: 13.0,
              fontStyle: FontStyle.italic,
              height: 1.45,
              color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '— ${habit.hadithSource}',
              style: GoogleFonts.manrope(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF059669),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
