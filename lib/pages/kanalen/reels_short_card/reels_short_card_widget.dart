import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reels_short_card_model.dart';
export 'reels_short_card_model.dart';

class ReelsShortCardWidget extends StatefulWidget {
  const ReelsShortCardWidget({
    super.key,
    this.imageDesc,
    String? title,
    required this.des,
  }) : this.title = title ?? 'Påminnelse om sabr och tawakkul';

  final String? imageDesc;
  final String title;
  final String? des;

  @override
  State<ReelsShortCardWidget> createState() => _ReelsShortCardWidgetState();
}

class _ReelsShortCardWidgetState extends State<ReelsShortCardWidget> {
  late ReelsShortCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReelsShortCardModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: AspectRatio(
            aspectRatio: 0.56,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                valueOrDefault<String>(
                  widget.imageDesc,
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/muslimens-kompanjon-ewv0n1/assets/hr631zfw06jv/play_store_512.png',
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 0.0, 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                widget.title,
                maxLines: 1,
                minFontSize: FFAppConstants.heading.toDouble(),
                style: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.plusJakartaSans(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).titleSmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleSmall.fontStyle,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.des != null && widget.des != '')
                AutoSizeText(
                  valueOrDefault<String>(
                    widget.des,
                    '.',
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  minFontSize: FFAppConstants.body.toDouble(),
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                        font: GoogleFonts.manrope(
                          fontWeight:
                              FlutterFlowTheme.of(context).bodySmall.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodySmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodySmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodySmall.fontStyle,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
            ].divide(SizedBox(height: 3.0)),
          ),
        ),
      ].divide(SizedBox(height: 5.0)),
    );
  }
}
