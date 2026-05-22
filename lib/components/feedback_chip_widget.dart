import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'feedback_chip_model.dart';
export 'feedback_chip_model.dart';

class FeedbackChipWidget extends StatefulWidget {
  const FeedbackChipWidget({
    super.key,
    bool? selected,
    String? label,
  })  : this.selected = selected ?? true,
        this.label = label ?? 'Prayer Times';

  final bool selected;
  final String label;

  @override
  State<FeedbackChipWidget> createState() => _FeedbackChipWidgetState();
}

class _FeedbackChipWidgetState extends State<FeedbackChipWidget> {
  late FeedbackChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeedbackChipModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.selected
            ? FlutterFlowTheme.of(context).secondary
            : FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(9999.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: widget.selected
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 16.0, 8.0, 16.0),
        child: Container(
          child: Text(
            valueOrDefault<String>(
              widget.label,
              'Prayer Times',
            ),
            style: FlutterFlowTheme.of(context).labelLarge.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).labelLarge.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelLarge.fontStyle,
                  ),
                  color: widget.selected
                      ? FlutterFlowTheme.of(context).primaryBackground
                      : FlutterFlowTheme.of(context).secondaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).labelLarge.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                  lineHeight: 1.4,
                ),
          ),
        ),
      ),
    );
  }
}
