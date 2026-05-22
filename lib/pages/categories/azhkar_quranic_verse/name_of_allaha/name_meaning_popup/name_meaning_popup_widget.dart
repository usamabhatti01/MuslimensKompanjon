import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'name_meaning_popup_model.dart';
export 'name_meaning_popup_model.dart';

class NameMeaningPopupWidget extends StatefulWidget {
  const NameMeaningPopupWidget({
    super.key,
    required this.popupNameArabic,
    required this.popupNameEnglish,
    required this.popupMeaningEn,
    required this.popupMeaningAr,
  });

  final String? popupNameArabic;
  final String? popupNameEnglish;
  final String? popupMeaningEn;
  final String? popupMeaningAr;

  @override
  State<NameMeaningPopupWidget> createState() => _NameMeaningPopupWidgetState();
}

class _NameMeaningPopupWidgetState extends State<NameMeaningPopupWidget> {
  late NameMeaningPopupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NameMeaningPopupModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.94,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(
              FlutterFlowTheme.of(context).designToken.radius.lg),
        ),
        child: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.popupNameArabic!,
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).arabiFont.override(
                      font: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).arabiFont.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).primary,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).arabiFont.fontStyle,
                    ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.popupMeaningAr!,
                    textAlign: TextAlign.center,
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
                    widget.popupNameEnglish!,
                    textAlign: TextAlign.center,
                    style:
                        FlutterFlowTheme.of(context).youtubeVideoTitle.override(
                              font: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .youtubeVideoTitle
                                    .fontStyle,
                              ),
                              color: Colors.black,
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .youtubeVideoTitle
                                  .fontStyle,
                            ),
                  ),
                  Text(
                    widget.popupMeaningEn!,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                  ),
                ].divide(SizedBox(height: 12.0)),
              ),
              FFButtonWidget(
                onPressed: () async {
                  Navigator.pop(context);
                },
                text: FFLocalizations.of(context).getText(
                  'fo35xndn' /* Closed */,
                ),
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: Colors.white,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(
                      FlutterFlowTheme.of(context).designToken.radius.md),
                ),
              ),
            ].divide(SizedBox(height: 25.0)),
          ),
        ),
      ),
    );
  }
}
