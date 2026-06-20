import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/setting_pages/setting_page/tema_component/tema_component_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adhanljud_model.dart';
export 'adhanljud_model.dart';

class AdhanljudWidget extends StatefulWidget {
  const AdhanljudWidget({super.key});

  @override
  State<AdhanljudWidget> createState() => _AdhanljudWidgetState();
}

class _AdhanljudWidgetState extends State<AdhanljudWidget> {
  late AdhanljudModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdhanljudModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Text(
                    'Adhan ljud',
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
                  child: Text(
                    'Välj vilket ljud som ska spelas upp vid böneutropet.',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
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
                          label: 'Endast vibration',
                          icon: Icon(
                            Icons.vibration,
                            size: 18.0,
                          ),
                          subLabel: 'Ingen ljudsignal, endast vibration',
                          checkValue: true,
                          onCheck: () async {},
                        ),
                      ),
                      wrapWithModel(
                        model: _model.temaComponentModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: TemaComponentWidget(
                          label: 'Standard (Systemljud)',
                          icon: FaIcon(
                            FontAwesomeIcons.volumeUp,
                            size: 18.0,
                          ),
                          subLabel: 'Kort standardnotis från telefonen',
                          checkValue: true,
                          onCheck: () async {},
                        ),
                      ),
                      wrapWithModel(
                        model: _model.temaComponentModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: TemaComponentWidget(
                          label: 'Kort Adhan',
                          icon: FaIcon(
                            FontAwesomeIcons.music,
                            size: 18.0,
                          ),
                          subLabel: 'Kortare version av Adhan',
                          checkValue: true,
                          onCheck: () async {},
                        ),
                      ),
                      wrapWithModel(
                        model: _model.temaComponentModel4,
                        updateCallback: () => safeSetState(() {}),
                        child: TemaComponentWidget(
                          label: 'Adhan 1 (Makkah)',
                          icon: FaIcon(
                            FontAwesomeIcons.kaaba,
                            size: 18.0,
                          ),
                          subLabel: 'Traditionellt Adhan från Makkah',
                          checkValue: true,
                          onCheck: () async {},
                        ),
                      ),
                      wrapWithModel(
                        model: _model.temaComponentModel5,
                        updateCallback: () => safeSetState(() {}),
                        child: TemaComponentWidget(
                          label: 'Adhan 2 (Madinah)',
                          icon: FaIcon(
                            FontAwesomeIcons.mosque,
                            size: 18.0,
                          ),
                          subLabel: 'Vackert Adhan från Madinah',
                          checkValue: true,
                          onCheck: () async {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
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
                Text(
                  'Du kan ändra dina bönetidsnotiser när som helst.',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.inter(
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
