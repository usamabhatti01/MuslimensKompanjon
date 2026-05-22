import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adkhar_box_model.dart';
export 'adkhar_box_model.dart';

class AdkharBoxWidget extends StatefulWidget {
  const AdkharBoxWidget({
    super.key,
    required this.azkarNumber,
    required this.azkarNmae,
    required this.azkar,
    required this.azkarTranslation,
  });

  final int? azkarNumber;
  final String? azkarNmae;
  final String? azkar;
  final String? azkarTranslation;

  @override
  State<AdkharBoxWidget> createState() => _AdkharBoxWidgetState();
}

class _AdkharBoxWidgetState extends State<AdkharBoxWidget> {
  late AdkharBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdkharBoxModel());

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
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 38.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(
                  FlutterFlowTheme.of(context).designToken.radius.md),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  FlutterFlowTheme.of(context).designToken.spacing.md,
                  FlutterFlowTheme.of(context).designToken.spacing.xs,
                  FlutterFlowTheme.of(context).designToken.spacing.md,
                  FlutterFlowTheme.of(context).designToken.spacing.xs),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Adkhar ${widget.azkarNumber?.toString()}',
                    style: FlutterFlowTheme.of(context).blackBold.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .blackBold
                                .fontStyle,
                          ),
                          color: Colors.black,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).blackBold.fontStyle,
                        ),
                  ),
                  Text(
                    widget.azkarNmae!,
                    style: FlutterFlowTheme.of(context).pxBoldGreen.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.w800,
                            fontStyle: FlutterFlowTheme.of(context)
                                .pxBoldGreen
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w800,
                          fontStyle: FlutterFlowTheme.of(context)
                              .pxBoldGreen
                              .fontStyle,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            widget.azkar!,
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
                  fontStyle: FlutterFlowTheme.of(context).pxBoldGreen.fontStyle,
                ),
          ),
          Text(
            widget.azkarTranslation!,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.manrope(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
        ].divide(SizedBox(height: 15.0)).addToEnd(SizedBox(height: 15.0)),
      ),
    );
  }
}
