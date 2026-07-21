import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'juz_heading_model.dart';
export 'juz_heading_model.dart';

class JuzHeadingWidget extends StatefulWidget {
  const JuzHeadingWidget({
    super.key,
    required this.heading,
    required this.subHeading,
    required this.totalVerses,
    required this.suratNumber,
    required this.suratName,
    required this.fav,
  });

  final String? heading;
  final String? subHeading;
  final int? totalVerses;
  final int? suratNumber;
  final String? suratName;
  final bool? fav;

  @override
  State<JuzHeadingWidget> createState() => _JuzHeadingWidgetState();
}

class _JuzHeadingWidgetState extends State<JuzHeadingWidget> {
  late JuzHeadingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JuzHeadingModel());

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
      width: 300.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).quranBg,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Text(
                  valueOrDefault<String>(
                    widget.suratNumber?.toString(),
                    '1',
                  ),
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        font: GoogleFonts.plusJakartaSans(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleLarge.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleLarge.fontStyle,
                      ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  valueOrDefault<String>(
                    widget.heading,
                    'Al-Fatiha',
                  ),
                  textAlign: TextAlign.end,
                  minFontSize: FFAppConstants.heading.toDouble(),
                  style: FlutterFlowTheme.of(context).arabicBody.override(
                        fontFamily: 'arabic',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                AutoSizeText(
                  valueOrDefault<String>(
                    widget.subHeading,
                    'Öppningen',
                  ),
                  minFontSize: FFAppConstants.body.toDouble(),
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FontWeight.normal,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AutoSizeText(
                      'verser ${widget.totalVerses?.toString()}',
                      minFontSize: FFAppConstants.body.toDouble(),
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            font: GoogleFonts.manrope(
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                    ),
                  ].divide(SizedBox(width: 5.0)),
                ),
              ].divide(SizedBox(height: 5.0)),
            ),
            AutoSizeText(
              valueOrDefault<String>(
                widget.suratName,
                'الرَّحِيْم',
              ),
              minFontSize: FFAppConstants.heading.toDouble(),
              style: FlutterFlowTheme.of(context).arabiTitle.override(
                    fontFamily: 'arabic',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
