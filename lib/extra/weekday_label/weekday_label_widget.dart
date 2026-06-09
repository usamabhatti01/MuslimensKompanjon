import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'weekday_label_model.dart';
export 'weekday_label_model.dart';

class WeekdayLabelWidget extends StatefulWidget {
  const WeekdayLabelWidget({
    super.key,
    String? label,
  }) : this.label = label ?? 'MON';

  final String label;

  @override
  State<WeekdayLabelWidget> createState() => _WeekdayLabelWidgetState();
}

class _WeekdayLabelWidgetState extends State<WeekdayLabelWidget> {
  late WeekdayLabelModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeekdayLabelModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Container(
          child: Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Text(
              valueOrDefault<String>(
                widget.label,
                'MON',
              ),
              style: FlutterFlowTheme.of(context).labelSmall.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelSmall.fontStyle,
                    lineHeight: 1.4,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
