import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'supplications_dua_box_model.dart';
export 'supplications_dua_box_model.dart';

class SupplicationsDuaBoxWidget extends StatefulWidget {
  const SupplicationsDuaBoxWidget({
    super.key,
    required this.tasbihName,
    required this.tasbih,
  });

  final String? tasbihName;
  final String? tasbih;

  @override
  State<SupplicationsDuaBoxWidget> createState() =>
      _SupplicationsDuaBoxWidgetState();
}

class _SupplicationsDuaBoxWidgetState extends State<SupplicationsDuaBoxWidget> {
  late SupplicationsDuaBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupplicationsDuaBoxModel());
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
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w800,
                    fontStyle:
                        FlutterFlowTheme.of(context).pxBoldGreen.fontStyle,
                  ),
            ),
            Text(
              widget.tasbih!,
              textAlign: TextAlign.end,
              style: FlutterFlowTheme.of(context).arabicBalckBold.override(
                    font: GoogleFonts.cairo(
                      fontWeight: FontWeight.w800,
                      fontStyle: FlutterFlowTheme.of(context)
                          .arabicBalckBold
                          .fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).black,
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w800,
                    fontStyle:
                        FlutterFlowTheme.of(context).arabicBalckBold.fontStyle,
                  ),
            ),
          ].divide(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
