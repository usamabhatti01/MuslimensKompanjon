import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'name_svenska_box_model.dart';
export 'name_svenska_box_model.dart';

class NameSvenskaBoxWidget extends StatefulWidget {
  const NameSvenskaBoxWidget({
    super.key,
    required this.allahName,
  });

  final String? allahName;

  @override
  State<NameSvenskaBoxWidget> createState() => _NameSvenskaBoxWidgetState();
}

class _NameSvenskaBoxWidgetState extends State<NameSvenskaBoxWidget> {
  late NameSvenskaBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NameSvenskaBoxModel());

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
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.sm),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).allahNameBg,
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.all(
                        FlutterFlowTheme.of(context).designToken.spacing.xs),
                    child: AutoSizeText(
                      valueOrDefault<String>(
                        widget.allahName,
                        'Allah',
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      minFontSize: FFAppConstants.heading.toDouble(),
                      style: FlutterFlowTheme.of(context).svenskaTitle.override(
                            font: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .svenskaTitle
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).allahNameFont,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .svenskaTitle
                                .fontStyle,
                          ),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 2.0)),
          ),
        ),
      ),
    );
  }
}
