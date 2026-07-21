import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/setting_page/tema_component/tema_component_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tema_model.dart';
export 'tema_model.dart';

class TemaWidget extends StatefulWidget {
  const TemaWidget({super.key});

  @override
  State<TemaWidget> createState() => _TemaWidgetState();
}

class _TemaWidgetState extends State<TemaWidget> {
  late TemaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TemaModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.selectedCard =
          FFAppState().user.mode != ''
              ? FFAppState().user.mode
              : Mode.System.name;
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: AutoSizeText(
                    'Tema',
                    minFontSize: FFAppConstants.heading.toDouble(),
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          font: GoogleFonts.plusJakartaSans(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleLarge
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleLarge.fontStyle,
                        ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: AutoSizeText(
                    'Anpassa appens utseende efter dina preferenser.',
                    minFontSize: FFAppConstants.body.toDouble(),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.manrope(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      wrapWithModel(
                        model: _model.temaComponentModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: TemaComponentWidget(
                          label: 'Systemets förval',
                          icon: FaIcon(
                            FontAwesomeIcons.sun,
                            size: 18.0,
                          ),
                          subLabel: 'Följer telefonens tema automatiskt',
                          checkValue: _model.selectedCard == Mode.System.name,
                          azanName: FFAppConstants.NullValue,
                          onCheck: () async {
                            _model.selectedCard = Mode.System.name;
                            safeSetState(() {});
                          },
                        ),
                      ),
                      wrapWithModel(
                        model: _model.temaComponentModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: TemaComponentWidget(
                          label: 'Ljus',
                          icon: Icon(
                            Icons.wb_sunny_outlined,
                            size: 18.0,
                          ),
                          subLabel: 'Ljust och rent utseende',
                          checkValue: _model.selectedCard == Mode.Light.name,
                          azanName: FFAppConstants.NullValue,
                          onCheck: () async {
                            _model.selectedCard = Mode.Light.name;
                            safeSetState(() {});
                          },
                        ),
                      ),
                      wrapWithModel(
                        model: _model.temaComponentModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: TemaComponentWidget(
                          label: 'Mörkt',
                          icon: FaIcon(
                            FontAwesomeIcons.moon,
                            size: 18.0,
                          ),
                          subLabel: 'Bekvämt för mörka miljöer',
                          checkValue: _model.selectedCard == Mode.Dark.name,
                          azanName: FFAppConstants.NullValue,
                          onCheck: () async {
                            _model.selectedCard = Mode.Dark.name;
                            safeSetState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FFButtonWidget(
              onPressed: () async {
                if (_model.selectedCard == Mode.System.name) {
                  setDarkModeSetting(context, ThemeMode.system);
                } else {
                  if (_model.selectedCard == Mode.Light.name) {
                    setDarkModeSetting(context, ThemeMode.light);
                  } else {
                    setDarkModeSetting(context, ThemeMode.dark);
                  }
                }

                FFAppState().updateUserStruct(
                  (e) => e..mode = _model.selectedCard,
                );
                safeSetState(() {});
                Navigator.pop(context);
              },
              text: 'Spara',
              options: FFButtonOptions(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.plusJakartaSans(
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
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
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                AutoSizeText(
                  'Du kan ändra dina bönetidsnotiser när som helst.',
                  minFontSize: FFAppConstants.body.toDouble(),
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                ),
              ],
            ),
          ].divide(SizedBox(height: 20.0)).around(SizedBox(height: 20.0)),
        ),
      ),
    );
  }
}
