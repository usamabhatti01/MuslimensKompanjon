import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prayer_time_item_model.dart';
export 'prayer_time_item_model.dart';

class PrayerTimeItemWidget extends StatefulWidget {
  const PrayerTimeItemWidget({
    super.key,
    String? label,
    String? time,
  })  : this.label = label ?? 'Fajr',
        this.time = time ?? '';

  final String label;
  final String time;

  @override
  State<PrayerTimeItemWidget> createState() => _PrayerTimeItemWidgetState();
}

class _PrayerTimeItemWidgetState extends State<PrayerTimeItemWidget> {
  late PrayerTimeItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrayerTimeItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          valueOrDefault<String>(
            widget.label,
            'Fajr',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
        Text(
          widget.time,
          style: FlutterFlowTheme.of(context).labelMedium.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                lineHeight: 1.4,
              ),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
