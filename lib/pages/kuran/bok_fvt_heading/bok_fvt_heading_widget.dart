import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bok_fvt_heading_model.dart';
export 'bok_fvt_heading_model.dart';

class BokFvtHeadingWidget extends StatefulWidget {
  const BokFvtHeadingWidget({
    super.key,
    required this.heading,
    required this.subHeading,
    required this.totalVerses,
    required this.suratName,
  });

  final String? heading;
  final String? subHeading;
  final int? totalVerses;
  final String? suratName;

  @override
  State<BokFvtHeadingWidget> createState() => _BokFvtHeadingWidgetState();
}

class _BokFvtHeadingWidgetState extends State<BokFvtHeadingWidget> {
  late BokFvtHeadingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BokFvtHeadingModel());

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
      height: 100.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).tint,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    Icons.star_rate,
                    color: FlutterFlowTheme.of(context).warning,
                    size: 24.0,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault<String>(
                        widget.heading,
                        'Al-Fatiha',
                      ),
                      textAlign: TextAlign.end,
                      style: FlutterFlowTheme.of(context).arabicBody.override(
                            fontFamily: 'arabic',
                            color: FlutterFlowTheme.of(context).black,
                            fontSize: 14.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.subHeading,
                        'Öppningen',
                      ),
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            font: GoogleFonts.inter(
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'verser ${widget.totalVerses?.toString()}',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    font: GoogleFonts.inter(
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
                  ].divide(SizedBox(height: 3.0)),
                ),
              ].divide(SizedBox(width: 30.0)).addToStart(SizedBox(width: 10.0)),
            ),
            Text(
              valueOrDefault<String>(
                widget.suratName,
                'الرَّحِيْم',
              ),
              style: FlutterFlowTheme.of(context).arabiTitle.override(
                    fontFamily: 'arabic',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ].divide(SizedBox(width: 10.0)),
        ),
      ),
    );
  }
}
