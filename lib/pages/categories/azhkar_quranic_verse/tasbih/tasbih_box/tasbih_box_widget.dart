import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tasbih_box_model.dart';
export 'tasbih_box_model.dart';

class TasbihBoxWidget extends StatefulWidget {
  const TasbihBoxWidget({
    super.key,
    required this.tasbihName,
    required this.tasbih,
  });

  final String? tasbihName;
  final String? tasbih;

  @override
  State<TasbihBoxWidget> createState() => _TasbihBoxWidgetState();
}

class _TasbihBoxWidgetState extends State<TasbihBoxWidget> {
  late TasbihBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TasbihBoxModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.md),
        border: Border.all(
          color: FlutterFlowTheme.of(context).containerBg,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            FlutterFlowTheme.of(context).designToken.spacing.md,
            FlutterFlowTheme.of(context).designToken.spacing.sm,
            FlutterFlowTheme.of(context).designToken.spacing.md,
            FlutterFlowTheme.of(context).designToken.spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.tasbihName!,
              textAlign: TextAlign.end,
              style: FlutterFlowTheme.of(context).pxBoldGreen.override(
                    font: GoogleFonts.manrope(
                      fontWeight: FontWeight.w800,
                      fontStyle:
                          FlutterFlowTheme.of(context).pxBoldGreen.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w800,
                    fontStyle:
                        FlutterFlowTheme.of(context).pxBoldGreen.fontStyle,
                  ),
            ),
            Text(
              widget.tasbih!,
              textAlign: TextAlign.end,
              style: FlutterFlowTheme.of(context).arabicText.override(
                    font: GoogleFonts.cairo(
                      fontWeight:
                          FlutterFlowTheme.of(context).arabicText.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).arabicText.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).black,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).arabicText.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).arabicText.fontStyle,
                  ),
            ),
          ].divide(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
