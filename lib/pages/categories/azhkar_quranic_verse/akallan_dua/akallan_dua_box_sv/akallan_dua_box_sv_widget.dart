import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'akallan_dua_box_sv_model.dart';
export 'akallan_dua_box_sv_model.dart';

class AkallanDuaBoxSvWidget extends StatefulWidget {
  const AkallanDuaBoxSvWidget({
    super.key,
    required this.tasbihName,
    required this.tasbih,
  });

  final String? tasbihName;
  final String? tasbih;

  @override
  State<AkallanDuaBoxSvWidget> createState() => _AkallanDuaBoxSvWidgetState();
}

class _AkallanDuaBoxSvWidgetState extends State<AkallanDuaBoxSvWidget> {
  late AkallanDuaBoxSvModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AkallanDuaBoxSvModel());
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.tasbihName!,
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).svenskaTitle.override(
                    font: GoogleFonts.cairo(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).svenskaTitle.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primary,
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).svenskaTitle.fontStyle,
                  ),
            ),
            Text(
              widget.tasbih!,
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).svenskaBody.override(
                    font: GoogleFonts.manrope(
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).svenskaBody.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).black,
                    fontSize: 14.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).svenskaBody.fontStyle,
                  ),
            ),
          ].divide(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
