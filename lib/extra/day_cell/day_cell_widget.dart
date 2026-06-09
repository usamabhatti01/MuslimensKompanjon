import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'day_cell_model.dart';
export 'day_cell_model.dart';

class DayCellWidget extends StatefulWidget {
  const DayCellWidget({
    super.key,
    bool? isToday,
    String? dayNum,
    String? fajr,
    String? maghrib,
  })  : this.isToday = isToday ?? false,
        this.dayNum = dayNum ?? '1',
        this.fajr = fajr ?? '05:12',
        this.maghrib = maghrib ?? '18:02';

  final bool isToday;
  final String dayNum;
  final String fajr;
  final String maghrib;

  @override
  State<DayCellWidget> createState() => _DayCellWidgetState();
}

class _DayCellWidgetState extends State<DayCellWidget> {
  late DayCellModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DayCellModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        color: widget.isToday
            ? FlutterFlowTheme.of(context).warning
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
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Container(
            height: 64.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget.dayNum,
                    '1',
                  ),
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        color: widget.isToday
                            ? Color(0x00000000)
                            : FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                        lineHeight: 1.4,
                      ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          color: widget.isToday
                              ? Color(0x00000000)
                              : FlutterFlowTheme.of(context).primary,
                          size: 10.0,
                        ),
                        Text(
                          valueOrDefault<String>(
                            widget.fajr,
                            '05:12',
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
                                color: widget.isToday
                                    ? Color(0x00000000)
                                    : FlutterFlowTheme.of(context).primaryText,
                                fontSize: 10.0,
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
                      ].divide(SizedBox(width: 4.0)),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.light_mode_rounded,
                          color: widget.isToday
                              ? Color(0x00000000)
                              : FlutterFlowTheme.of(context).primary,
                          size: 10.0,
                        ),
                        Text(
                          valueOrDefault<String>(
                            widget.maghrib,
                            '18:02',
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
                                color: widget.isToday
                                    ? Color(0x00000000)
                                    : FlutterFlowTheme.of(context).primaryText,
                                fontSize: 10.0,
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
                      ].divide(SizedBox(width: 4.0)),
                    ),
                  ].divide(SizedBox(height: 2.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
