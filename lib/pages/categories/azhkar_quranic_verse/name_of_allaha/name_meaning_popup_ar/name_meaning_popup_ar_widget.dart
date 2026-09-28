import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'name_meaning_popup_ar_model.dart';
export 'name_meaning_popup_ar_model.dart';

class NameMeaningPopupArWidget extends StatefulWidget {
  const NameMeaningPopupArWidget({
    super.key,
    required this.name,
    required this.explanation,
  });

  final String? name;
  final String? explanation;

  @override
  State<NameMeaningPopupArWidget> createState() =>
      _NameMeaningPopupArWidgetState();
}

class _NameMeaningPopupArWidgetState extends State<NameMeaningPopupArWidget> {
  late NameMeaningPopupArModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NameMeaningPopupArModel());

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
        width: MediaQuery.sizeOf(context).width * 0.95,
        height: 250.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(
              FlutterFlowTheme.of(context).designToken.radius.lg),
        ),
        child: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close_sharp,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoSizeText(
                        valueOrDefault<String>(
                          widget.name,
                          'name',
                        ),
                        textAlign: TextAlign.center,
                        minFontSize: FFAppConstants.heading.toDouble(),
                        style: FlutterFlowTheme.of(context).arabiTitle.override(
                              fontFamily: 'arabic',
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 28.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      AutoSizeText(
                        functions.formatRTL(widget.explanation),
                        textAlign: TextAlign.end,
                        minFontSize: FFAppConstants.body.toDouble(),
                        style: FlutterFlowTheme.of(context).arabicBody.override(
                              fontFamily: 'arabic',
                              color: Colors.black,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
