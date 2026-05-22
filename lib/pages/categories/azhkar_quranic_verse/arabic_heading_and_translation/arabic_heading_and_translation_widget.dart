import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'arabic_heading_and_translation_model.dart';
export 'arabic_heading_and_translation_model.dart';

class ArabicHeadingAndTranslationWidget extends StatefulWidget {
  const ArabicHeadingAndTranslationWidget({
    super.key,
    required this.heading,
    this.translation,
  });

  final String? heading;
  final String? translation;

  @override
  State<ArabicHeadingAndTranslationWidget> createState() =>
      _ArabicHeadingAndTranslationWidgetState();
}

class _ArabicHeadingAndTranslationWidgetState
    extends State<ArabicHeadingAndTranslationWidget> {
  late ArabicHeadingAndTranslationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArabicHeadingAndTranslationModel());

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
          Text(
            widget.heading!,
            style: FlutterFlowTheme.of(context).arabiFont.override(
                  font: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    fontStyle: FlutterFlowTheme.of(context).arabiFont.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).arabiFont.fontStyle,
                ),
          ),
          RichText(
            textScaler: MediaQuery.of(context).textScaler,
            text: TextSpan(
              children: [
                TextSpan(
                  text: FFLocalizations.of(context).getText(
                    'v45ugzwi' /* Translation:  */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
                TextSpan(
                  text: widget.translation!,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                )
              ],
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
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            textAlign: TextAlign.center,
          ),
        ].divide(SizedBox(height: 5.0)),
      ),
    );
  }
}
