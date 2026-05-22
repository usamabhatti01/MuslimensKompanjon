import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'name_box_model.dart';
export 'name_box_model.dart';

class NameBoxWidget extends StatefulWidget {
  const NameBoxWidget({
    super.key,
    required this.arabicName,
    required this.engishName,
    required this.nameId,
  });

  final String? arabicName;
  final String? engishName;
  final int? nameId;

  @override
  State<NameBoxWidget> createState() => _NameBoxWidgetState();
}

class _NameBoxWidgetState extends State<NameBoxWidget> {
  late NameBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NameBoxModel());

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
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.md),
        border: Border.all(
          color: FlutterFlowTheme.of(context).containerBg,
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.sm),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 64.0,
                height: 64.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tint,
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.all(
                        FlutterFlowTheme.of(context).designToken.spacing.sm),
                    child: AutoSizeText(
                      widget.arabicName!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      minFontSize: 12.0,
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w800,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                    ),
                  ),
                ),
              ),
              AutoSizeText(
                widget.engishName!,
                textAlign: TextAlign.center,
                maxLines: 1,
                minFontSize: 10.0,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodySmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodySmall.fontStyle,
                      ),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodySmall.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodySmall.fontStyle,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '#${widget.nameId?.toString()}',
                style: FlutterFlowTheme.of(context).yellowNumbering.override(
                      font: GoogleFonts.manrope(
                        fontWeight: FlutterFlowTheme.of(context)
                            .yellowNumbering
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .yellowNumbering
                            .fontStyle,
                      ),
                      color: Color(0xFFFFCE31),
                      fontSize: 9.0,
                      letterSpacing: 0.0,
                      fontWeight: FlutterFlowTheme.of(context)
                          .yellowNumbering
                          .fontWeight,
                      fontStyle: FlutterFlowTheme.of(context)
                          .yellowNumbering
                          .fontStyle,
                    ),
              ),
            ].divide(SizedBox(height: 2.0)),
          ),
        ),
      ),
    );
  }
}
