import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'english_value_model.dart';
export 'english_value_model.dart';

class EnglishValueWidget extends StatefulWidget {
  const EnglishValueWidget({
    super.key,
    required this.englishValue,
    this.width,
    this.height,
    required this.fontSize,
    required this.id,
    required this.swValue,
  });

  final String? englishValue;
  final double? width;
  final double? height;
  final int? fontSize;
  final int? id;
  final String? swValue;

  @override
  State<EnglishValueWidget> createState() => _EnglishValueWidgetState();
}

class _EnglishValueWidgetState extends State<EnglishValueWidget> {
  late EnglishValueModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EnglishValueModel());

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
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: AlignmentDirectional(0.0, 0.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/textframe_1_(2).png',
              width: widget.width,
              height: widget.height,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(-0.6, 0.0),
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).quranBg,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Text(
                  valueOrDefault<String>(
                    widget.id?.toString(),
                    '1',
                  ),
                  textAlign: TextAlign.center,
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
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                valueOrDefault<String>(
                  widget.englishValue,
                  'سُورَةُ الْعَنكَبُوتِ',
                ),
                textAlign: TextAlign.center,
                minFontSize: FFAppConstants.heading.toDouble(),
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.plusJakartaSans(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      fontSize: widget.fontSize?.toDouble(),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
              ),
              AutoSizeText(
                valueOrDefault<String>(
                  widget.swValue,
                  '(Öppningen)',
                ),
                textAlign: TextAlign.center,
                minFontSize: FFAppConstants.body.toDouble(),
                style: FlutterFlowTheme.of(context).labelSmall.override(
                      font: GoogleFonts.manrope(
                        fontWeight:
                            FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
                      ),
                      fontSize: widget.fontSize?.toDouble(),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).labelSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelSmall.fontStyle,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
