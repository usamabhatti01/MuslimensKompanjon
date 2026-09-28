import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/extra/tillbaka_component/tillbaka_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tillbaka_model.dart';
export 'tillbaka_model.dart';

class TillbakaWidget extends StatefulWidget {
  const TillbakaWidget({
    super.key,
    required this.updatedValue,
    required this.value,
  });

  final FontSettingStruct? updatedValue;
  final String? value;

  @override
  State<TillbakaWidget> createState() => _TillbakaWidgetState();
}

class _TillbakaWidgetState extends State<TillbakaWidget> {
  late TillbakaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TillbakaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
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
                      Icons.arrow_back,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Visa innehåll',
                        minFontSize: FFAppConstants.heading.toDouble(),
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(-1.0, -1.0),
                    child: wrapWithModel(
                      model: _model.arabisktextModel,
                      updateCallback: () => safeSetState(() {}),
                      updateOnChange: true,
                      child: TillbakaComponentWidget(
                        label: 'Arabisk text',
                        icon: Icon(
                          Icons.rtt_rounded,
                        ),
                        initialValue: widget.updatedValue?.arActive,
                        onSwitchOn: () async {
                          await _model.switchUpdate(
                            context,
                            widgetValue: widget.value,
                            switchType: Font.arActive.name,
                            action: () async {
                              safeSetState(() {
                                _model.arabisktextModel.arValue = true;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  wrapWithModel(
                    model: _model.translittereringModel,
                    updateCallback: () => safeSetState(() {}),
                    updateOnChange: true,
                    child: TillbakaComponentWidget(
                      label: 'Translitterering',
                      icon: Icon(
                        Icons.g_translate,
                      ),
                      initialValue: widget.updatedValue?.enActive,
                      onSwitchOn: () async {
                        await _model.switchUpdate(
                          context,
                          widgetValue: widget.value,
                          switchType: Font.enActive.name,
                          action: () async {
                            safeSetState(() {
                              _model.translittereringModel.arValue = true;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  wrapWithModel(
                    model: _model.versttningModel,
                    updateCallback: () => safeSetState(() {}),
                    updateOnChange: true,
                    child: TillbakaComponentWidget(
                      label: 'Svensk översättning',
                      icon: Icon(
                        Icons.translate,
                      ),
                      initialValue: widget.updatedValue?.swActive,
                      onSwitchOn: () async {
                        await _model.switchUpdate(
                          context,
                          widgetValue: widget.value,
                          switchType: Font.swActive.name,
                          action: () async {
                            safeSetState(() {
                              _model.versttningModel.arValue = true;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                  Container(
                    height: 30.0,
                    decoration: BoxDecoration(),
                  ),
                ].addToStart(SizedBox(height: 10.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
