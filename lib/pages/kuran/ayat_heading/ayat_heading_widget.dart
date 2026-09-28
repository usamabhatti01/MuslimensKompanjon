import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ayat_heading_model.dart';
export 'ayat_heading_model.dart';

class AyatHeadingWidget extends StatefulWidget {
  const AyatHeadingWidget({
    super.key,
    required this.arabic,
    required this.english,
    required this.sw,
    required this.suratNumber,
  });

  final String? arabic;
  final String? english;
  final String? sw;
  final int? suratNumber;

  @override
  State<AyatHeadingWidget> createState() => _AyatHeadingWidgetState();
}

class _AyatHeadingWidgetState extends State<AyatHeadingWidget> {
  late AyatHeadingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AyatHeadingModel());

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
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
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget.arabic,
                      'Al-Fatiha',
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).arabicBody.override(
                          fontFamily: 'arabic',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget.english,
                      'Öppningen',
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget.sw,
                      '0',
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FontWeight.normal,
                            fontStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .fontStyle,
                          ),
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ].divide(SizedBox(height: 5.0)),
              ),
            ),
          ].divide(SizedBox(width: 10.0)).around(SizedBox(width: 10.0)),
        ),
      ),
    );
  }
}
