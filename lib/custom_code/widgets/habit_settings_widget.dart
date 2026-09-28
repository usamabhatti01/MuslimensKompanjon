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
/// Set your widget name, define your parameter, and then add the boilerplate
/// code using the `</>` button on the right!
import 'package:google_fonts/google_fonts.dart';
import '/custom_code/actions/habit_tracker_service.dart';

class HabitSettingsWidget extends StatefulWidget {
  const HabitSettingsWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const HabitSettingsWidget(),
    );
  }

  @override
  State<HabitSettingsWidget> createState() => _HabitSettingsWidgetState();
}

class _HabitSettingsWidgetState extends State<HabitSettingsWidget> {
  final HabitTrackerService _habitService = HabitTrackerService();
  late Map<String, bool> _localSettings;
  final Map<String, String> _localReminderDay = {};
  final Map<String, String> _localReminderTime = {};
  bool _isLoading = true;

  // Track expanded accordion sections
  final Map<String, bool> _expandedSections = {
    'fasting': true,
    'quran': true,
    'prayers': true,
    'dhikr': false,
    'charity': false,
    'custom': false,
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await _habitService.init();
    _localSettings = {
      for (var entry in HabitTrackerService.masterHabits.entries)
        entry.key: _habitService.isHabitEnabled(entry.key),
    };
    for (var entry in HabitTrackerService.masterHabits.entries) {
      _localReminderDay[entry.key] =
          _habitService.getHabitReminderDay(entry.key);
      _localReminderTime[entry.key] =
          _habitService.getHabitReminderTime(entry.key);
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveAndClose() async {
    await _habitService.saveSettings(_localSettings);
    for (var entry in _localReminderDay.entries) {
      await _habitService.setHabitReminder(
        habitId: entry.key,
        day: entry.value,
        time: _localReminderTime[entry.key] ?? 'Kl. 20:00',
      );
    }
    if (mounted) {
      final theme = FlutterFlowTheme.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Inställningarna har sparats!',
            style: GoogleFonts.manrope(color: Colors.white),
          ),
          backgroundColor: theme.primary,
          duration: const Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _pickTime(String habitKey) async {
    final currentStr = _localReminderTime[habitKey] ?? 'Kl. 20:00';
    int initialHour = 20;
    int initialMinute = 0;
    final regex = RegExp(r'(\d{1,2}):(\d{2})');
    final match = regex.firstMatch(currentStr);
    if (match != null) {
      initialHour = int.tryParse(match.group(1)!) ?? 20;
      initialMinute = int.tryParse(match.group(2)!) ?? 0;
    }

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: initialHour, minute: initialMinute),
      helpText: 'Välj påminnelsetid',
      cancelText: 'Avbryt',
      confirmText: 'Välj',
    );

    if (picked != null && mounted) {
      final formatted =
          'Kl. ${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      setState(() {
        _localReminderTime[habitKey] = formatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = theme.secondaryBackground;
    final primaryTextColor = theme.primaryText;
    final secondaryTextColor = theme.secondaryText;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.92,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Drag handle
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: Center(
                  child: Container(
                    width: 50.0,
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

            // Header Row
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 4.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: theme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.tune_rounded,
                      color: theme.primary,
                      size: 20.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    'Kalenderinställningar',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: primaryTextColor,
                    ),
                  ),
                ],
              ),
            ),

            // Subtitle description
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Välj vilka aktiviteter du vill få påminnelser om och ställ in när och hur du vill bli påmind.',
                  style: GoogleFonts.manrope(
                    fontSize: 13.0,
                    color: secondaryTextColor,
                    height: 1.4,
                  ),
                ),
              ),
            ),

            const Divider(height: 1.0, thickness: 1.0),

            // Accordion Sections
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: theme.primary,
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      children: [
                        // 1. Fasta
                        _buildAccordionCategory(
                          key: 'fasting',
                          title: 'Fasta',
                          icon: Icons.nightlight_round,
                          iconColor: HabitTrackerService.colorFasting,
                          habitKeys: [
                            'fasting_monday_thursday',
                            'fasting_ayyam_al_bid',
                            'fasting_arafah',
                            'fasting_ashura',
                            'fasting_shawwal',
                            'fasting_kada',
                          ],
                          subgroups: {
                            'fasting_monday_thursday': 'Veckovis / Månadsvis',
                            'fasting_arafah': 'Årlig fasta',
                            'fasting_kada': 'Egen fasta',
                          },
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12.0),

                        // 2. Koran
                        _buildAccordionCategory(
                          key: 'quran',
                          title: 'Koran',
                          icon: Icons.menu_book_rounded,
                          iconColor: HabitTrackerService.colorQuran,
                          habitKeys: [
                            'quran_kahf_friday',
                            'quran_daily',
                            'quran_khatm',
                          ],
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12.0),

                        // 3. Böner
                        _buildAccordionCategory(
                          key: 'prayers',
                          title: 'Böner',
                          icon: Icons.wb_sunny_rounded,
                          iconColor: HabitTrackerService.colorPrayer,
                          habitKeys: [
                            'prayer_duha',
                            'prayer_witr',
                            'prayer_tahajjud',
                            'prayer_rawatib',
                            'prayer_eclipse',
                          ],
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12.0),

                        // 4. Dhikr
                        _buildAccordionCategory(
                          key: 'dhikr',
                          title: 'Dhikr',
                          icon: Icons.fingerprint_rounded,
                          iconColor: HabitTrackerService.colorDhikr,
                          habitKeys: [
                            'dhikr_morning',
                            'dhikr_evening',
                            'dhikr_after_prayer',
                          ],
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12.0),

                        // 5. Välgörenhet
                        _buildAccordionCategory(
                          key: 'charity',
                          title: 'Välgörenhet',
                          icon: Icons.volunteer_activism_rounded,
                          iconColor: HabitTrackerService.colorCharity,
                          habitKeys: [
                            'charity_friday',
                            'charity_good_deeds',
                            'charity_zakat',
                          ],
                          isDark: isDark,
                        ),
                        const SizedBox(height: 12.0),

                        // 6. Personligt / Egna aktiviteter
                        _buildAccordionCategory(
                          key: 'custom',
                          title: 'Personligt / Egna aktiviteter',
                          icon: Icons.person_rounded,
                          iconColor: HabitTrackerService.colorCustom,
                          habitKeys: [
                            'custom_events_enabled',
                          ],
                          isDark: isDark,
                          isCustomSection: true,
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
            ),

            // Bottom Save Button
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 16.0),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border(
                  top: BorderSide(
                    color: theme.alternate,
                    width: 1.0,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton.icon(
                  onPressed: _saveAndClose,
                  icon: const Icon(Icons.check_rounded, color: Colors.white),
                  label: Text(
                    'Spara inställningar',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccordionCategory({
    required String key,
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<String> habitKeys,
    required bool isDark,
    Map<String, String>? subgroups,
    bool isCustomSection = false,
  }) {
    final theme = FlutterFlowTheme.of(context);
    final isExpanded = _expandedSections[key] ?? false;

    return Container(
      decoration: BoxDecoration(
        color: theme.primaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.alternate,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: () {
              setState(() {
                _expandedSections[key] = !isExpanded;
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(icon, color: iconColor, size: 18.0),
                  ),
                  const SizedBox(width: 12.0),
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: theme.primaryText,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: theme.secondaryText,
                  ),
                ],
              ),
            ),
          ),

          // Toggles
          if (isExpanded) ...[
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: theme.alternate,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: habitKeys.map((hKey) {
                  final habit = HabitTrackerService.masterHabits[hKey];
                  if (habit == null) return const SizedBox.shrink();
                  final bool isEnabled = _localSettings[hKey] ?? true;
                  final String reminderDay =
                      _localReminderDay[hKey] ?? 'Samma dag';
                  final String reminderTime =
                      _localReminderTime[hKey] ?? 'Kl. 20:00';
                  final String? subheader = subgroups?[hKey];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (subheader != null)
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 4.0),
                          child: Text(
                            subheader.toUpperCase(),
                            style: GoogleFonts.manrope(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: theme.secondaryText,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    habit.title,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: theme.primaryText,
                                    ),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    habit.subtitle,
                                    style: GoogleFonts.manrope(
                                      fontSize: 12.0,
                                      color: theme.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Transform.scale(
                              scaleX: 0.75,
                              scaleY: 0.75,
                              child: Switch.adaptive(
                                value: isEnabled,
                                activeTrackColor: theme.primary,
                                inactiveTrackColor: isDark
                                    ? const Color(0xFF334155)
                                    : const Color(0xFFE2E8F0),
                                onChanged: (val) {
                                  setState(() {
                                    _localSettings[hKey] = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // EXPANDABLE INLINE SETUP PANEL (When ON, except for custom section toggle)
                      if (isEnabled && !isCustomSection) ...[
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin:
                              const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 10.0),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF1E293B)
                                : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: theme.alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1. Reminder Day (När)
                              Row(
                                children: [
                                  Text(
                                    '📅 När:',
                                    style: GoogleFonts.manrope(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: theme.primaryText,
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Container(
                                      height: 36.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? const Color(0xFF0F172A)
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: theme.alternate,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: reminderDay,
                                          isDense: true,
                                          isExpanded: true,
                                          icon: Icon(Icons.arrow_drop_down,
                                              color: theme.secondaryText),
                                          style: GoogleFonts.manrope(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w500,
                                            color: theme.primaryText,
                                          ),
                                          dropdownColor: isDark
                                              ? const Color(0xFF1E293B)
                                              : Colors.white,
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
                                                _localReminderDay[hKey] = val;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),

                              // 2. Notification Time (Tid)
                              Row(
                                children: [
                                  Text(
                                    '⏰ Tid:',
                                    style: GoogleFonts.manrope(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: theme.primaryText,
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => _pickTime(hKey),
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Container(
                                        height: 36.0,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? const Color(0xFF0F172A)
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: theme.alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              reminderTime,
                                              style: GoogleFonts.manrope(
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.w500,
                                                color: theme.primaryText,
                                              ),
                                            ),
                                            Icon(
                                              Icons.access_time_rounded,
                                              size: 16.0,
                                              color: theme.secondaryText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
