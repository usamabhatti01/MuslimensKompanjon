import '/extra/prayer_time_row/prayer_time_row_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'in_page2_model.dart';
export 'in_page2_model.dart';

/// i want a page in which there is dropdown  from which user select city name
/// after that select month name and yera on the basis of this full 30 days
/// with prayer name and time show and current day show in active like yellow
/// highlight
class InPage2Widget extends StatefulWidget {
  const InPage2Widget({super.key});

  static String routeName = 'InPage2';
  static String routePath = '/inPage2';

  @override
  State<InPage2Widget> createState() => _InPage2WidgetState();
}

class _InPage2WidgetState extends State<InPage2Widget> {
  late InPage2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InPage2Model());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Prayer Timetable',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                              Text(
                                'Monthly Schedule',
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
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.mosque_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 32.0,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: FlutterFlowDropDown<String>(
                                  controller:
                                      _model.dropdownValueController1 ??=
                                          FormFieldController<String>(
                                    _model.dropdownValue1 ??= 'London',
                                  ),
                                  options: [
                                    'London',
                                    'New York',
                                    'Dubai',
                                    'Riyadh',
                                    'Istanbul'
                                  ],
                                  onChanged: (val) => safeSetState(
                                      () => _model.dropdownValue1 = val),
                                  width: 200.0,
                                  height: 40.0,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                  hintText: 'London',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 1.0,
                                  borderRadius: 12.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                  labelText: 'City',
                                  labelTextStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: FlutterFlowDropDown<String>(
                                  controller:
                                      _model.dropdownValueController2 ??=
                                          FormFieldController<String>(
                                    _model.dropdownValue2 ??= 'October',
                                  ),
                                  options: [
                                    'January',
                                    'February',
                                    'March',
                                    'April',
                                    'May',
                                    'June',
                                    'July',
                                    'August',
                                    'September',
                                    'October',
                                    'November',
                                    'December'
                                  ],
                                  onChanged: (val) => safeSetState(
                                      () => _model.dropdownValue2 = val),
                                  width: 200.0,
                                  height: 40.0,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                  hintText: 'January',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 1.0,
                                  borderRadius: 12.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                  labelText: 'Month',
                                  labelTextStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: FlutterFlowDropDown<String>(
                                  controller:
                                      _model.dropdownValueController3 ??=
                                          FormFieldController<String>(
                                    _model.dropdownValue3 ??= '2024',
                                  ),
                                  options: ['2023', '2024', '2025'],
                                  onChanged: (val) => safeSetState(
                                      () => _model.dropdownValue3 = val),
                                  width: 200.0,
                                  height: 40.0,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.manrope(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                  hintText: '2023',
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 2.0,
                                  borderColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  borderWidth: 1.0,
                                  borderRadius: 12.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  hidesUnderline: true,
                                  isOverButton: false,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                  labelText: 'Year',
                                  labelTextStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                    ].divide(SizedBox(height: 16.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              wrapWithModel(
                                model: _model.prayerTimeRowModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: PrayerTimeRowWidget(
                                  isToday: true,
                                  dayNum: '24',
                                  dayName: 'Thursday',
                                  hijriDate: '11 Rabi\' al-Thani',
                                  fajr: '05:42',
                                  dhuhr: '12:48',
                                  asr: '15:21',
                                  maghrib: '17:52',
                                  isha: '19:15',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.prayerTimeRowModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: PrayerTimeRowWidget(
                                  isToday: false,
                                  dayNum: '25',
                                  dayName: 'Friday',
                                  hijriDate: '12 Rabi\' al-Thani',
                                  fajr: '05:44',
                                  dhuhr: '12:48',
                                  asr: '15:19',
                                  maghrib: '17:50',
                                  isha: '19:13',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.prayerTimeRowModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: PrayerTimeRowWidget(
                                  isToday: false,
                                  dayNum: '26',
                                  dayName: 'Saturday',
                                  hijriDate: '13 Rabi\' al-Thani',
                                  fajr: '05:45',
                                  dhuhr: '12:48',
                                  asr: '15:17',
                                  maghrib: '17:48',
                                  isha: '19:11',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.prayerTimeRowModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: PrayerTimeRowWidget(
                                  isToday: false,
                                  dayNum: '27',
                                  dayName: 'Sunday',
                                  hijriDate: '14 Rabi\' al-Thani',
                                  fajr: '05:47',
                                  dhuhr: '12:48',
                                  asr: '15:15',
                                  maghrib: '17:46',
                                  isha: '19:09',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.prayerTimeRowModel5,
                                updateCallback: () => safeSetState(() {}),
                                child: PrayerTimeRowWidget(
                                  isToday: false,
                                  dayNum: '28',
                                  dayName: 'Monday',
                                  hijriDate: '15 Rabi\' al-Thani',
                                  fajr: '05:49',
                                  dhuhr: '12:48',
                                  asr: '15:13',
                                  maghrib: '17:44',
                                  isha: '19:07',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.prayerTimeRowModel6,
                                updateCallback: () => safeSetState(() {}),
                                child: PrayerTimeRowWidget(
                                  isToday: false,
                                  dayNum: '29',
                                  dayName: 'Tuesday',
                                  hijriDate: '16 Rabi\' al-Thani',
                                  fajr: '05:51',
                                  dhuhr: '12:48',
                                  asr: '15:11',
                                  maghrib: '17:42',
                                  isha: '19:05',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.prayerTimeRowModel7,
                                updateCallback: () => safeSetState(() {}),
                                child: PrayerTimeRowWidget(
                                  isToday: false,
                                  dayNum: '30',
                                  dayName: 'Wednesday',
                                  hijriDate: '17 Rabi\' al-Thani',
                                  fajr: '05:53',
                                  dhuhr: '12:48',
                                  asr: '15:09',
                                  maghrib: '17:40',
                                  isha: '19:03',
                                ),
                              ),
                            ].divide(SizedBox(height: 8.0)),
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
      ),
    );
  }
}
