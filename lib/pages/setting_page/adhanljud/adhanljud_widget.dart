import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/setting_page/tema_component/tema_component_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.selectedCard = FFAppState().user.adhanSound != ''
          ? FFAppState().user.adhanSound
          : AdhanSound.Vibration.name;
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
                    'Adhan ljud',
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
                    'Välj vilket ljud som ska spelas upp vid böneutropet.',
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
                  child: SingleChildScrollView(
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
                            checkValue: _model.selectedCard ==
                                AdhanSound.Vibration.name,
                            azanName: FFAppConstants.NullValue,
                            onCheck: () async {
                              _model.selectedCard = AdhanSound.Vibration.name;
                              safeSetState(() {});
                            },
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
                            checkValue:
                                _model.selectedCard == AdhanSound.Standard.name,
                            azanName: SoundName.standard_adhan.name,
                            onCheck: () async {
                              _model.selectedCard = AdhanSound.Standard.name;
                              safeSetState(() {});
                            },
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
                            checkValue: _model.selectedCard ==
                                AdhanSound.ShortAdhan.name,
                            azanName: SoundName.short_adhan.name,
                            onCheck: () async {
                              _model.selectedCard = AdhanSound.ShortAdhan.name;
                              safeSetState(() {});
                            },
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
                            checkValue: _model.selectedCard ==
                                AdhanSound.AdhanMakkah.name,
                            azanName: SoundName.adhan_makkah.name,
                            onCheck: () async {
                              _model.selectedCard = AdhanSound.AdhanMakkah.name;
                              safeSetState(() {});
                            },
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
                            checkValue: _model.selectedCard ==
                                AdhanSound.AdhanMadinah.name,
                            azanName: SoundName.adhan_madinah.name,
                            onCheck: () async {
                              _model.selectedCard =
                                  AdhanSound.AdhanMadinah.name;
                              safeSetState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            FFButtonWidget(
              onPressed: () async {
                FFAppState().updateUserStruct(
                  (e) => e..adhanSound = _model.selectedCard,
                );
                safeSetState(() {});
                await actions.schedulePrayerNotifications();
                await actions.audioPlay(
                  FFAppConstants.NullValue,
                );
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
