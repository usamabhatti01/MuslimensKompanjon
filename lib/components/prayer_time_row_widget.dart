import '/components/prayer_time_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prayer_time_row_model.dart';
export 'prayer_time_row_model.dart';

class PrayerTimeRowWidget extends StatefulWidget {
  const PrayerTimeRowWidget({
    super.key,
    bool? isToday,
    String? dayNum,
    String? dayName,
    String? hijriDate,
    String? fajr,
    String? dhuhr,
    String? asr,
    String? maghrib,
    String? isha,
  })  : this.isToday = isToday ?? true,
        this.dayNum = dayNum ?? '24',
        this.dayName = dayName ?? 'Thursday',
        this.hijriDate = hijriDate ?? '11 Rabi\' al-Thani',
        this.fajr = fajr ?? '05:42',
        this.dhuhr = dhuhr ?? '12:48',
        this.asr = asr ?? '15:21',
        this.maghrib = maghrib ?? '17:52',
        this.isha = isha ?? '19:15';

  final bool isToday;
  final String dayNum;
  final String dayName;
  final String hijriDate;
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  @override
  State<PrayerTimeRowWidget> createState() => _PrayerTimeRowWidgetState();
}

class _PrayerTimeRowWidgetState extends State<PrayerTimeRowWidget> {
  late PrayerTimeRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrayerTimeRowModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: widget.isToday
                ? Color(0x00000000)
                : FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(12.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: widget.isToday
                  ? FlutterFlowTheme.of(context).warning
                  : FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 32.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                              color: widget.isToday
                                  ? FlutterFlowTheme.of(context).warning
                                  : Color(0x00000000),
                              borderRadius: BorderRadius.circular(9999.0),
                              shape: BoxShape.rectangle,
                            ),
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.dayNum,
                                '24',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                    ),
                                    color: widget.isToday
                                        ? Color(0x00000000)
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                valueOrDefault<String>(
                                  widget.dayName,
                                  'Thursday',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                              Text(
                                valueOrDefault<String>(
                                  widget.hijriDate,
                                  '11 Rabi\' al-Thani',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ],
                          ),
                        ].divide(SizedBox(width: 8.0)),
                      ),
                      if (valueOrDefault<bool>(
                        widget.isToday,
                        true,
                      ))
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).warning,
                            borderRadius: BorderRadius.circular(2.0),
                            shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 4.0, 8.0, 4.0),
                            child: Container(
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'lmx7qwl4' /* TODAY */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Divider(
                    height: 16.0,
                    thickness: 1.0,
                    indent: 0.0,
                    endIndent: 0.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      wrapWithModel(
                        model: _model.prayerTimeItemModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: PrayerTimeItemWidget(
                          label: 'Fajr',
                          time: valueOrDefault<String>(
                            widget.fajr,
                            '05:42',
                          ),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.prayerTimeItemModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: PrayerTimeItemWidget(
                          label: 'Dhuhr',
                          time: valueOrDefault<String>(
                            widget.dhuhr,
                            '12:48',
                          ),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.prayerTimeItemModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: PrayerTimeItemWidget(
                          label: 'Asr',
                          time: valueOrDefault<String>(
                            widget.asr,
                            '15:21',
                          ),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.prayerTimeItemModel4,
                        updateCallback: () => safeSetState(() {}),
                        child: PrayerTimeItemWidget(
                          label: 'Maghrib',
                          time: valueOrDefault<String>(
                            widget.maghrib,
                            '17:52',
                          ),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.prayerTimeItemModel5,
                        updateCallback: () => safeSetState(() {}),
                        child: PrayerTimeItemWidget(
                          label: 'Isha',
                          time: valueOrDefault<String>(
                            widget.isha,
                            '19:15',
                          ),
                        ),
                      ),
                    ],
                  ),
                ].divide(SizedBox(height: 8.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
