import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prayer_time_model.dart';
export 'prayer_time_model.dart';

class PrayerTimeWidget extends StatefulWidget {
  const PrayerTimeWidget({
    super.key,
    required this.namazName,
    required this.namazTime,
    this.activeTab,
  });

  final String? namazName;
  final DateTime? namazTime;
  final bool? activeTab;

  @override
  State<PrayerTimeWidget> createState() => _PrayerTimeWidgetState();
}

class _PrayerTimeWidgetState extends State<PrayerTimeWidget> {
  late PrayerTimeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrayerTimeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          valueOrDefault<String>(
            widget.namazName,
            'fajr',
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              ),
        ),
        Text(
          widget.namazTime!.toString(),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              ),
        ),
      ].divide(SizedBox(height: 5.0)),
    );
  }
}
