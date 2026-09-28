import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/setting_page/bottom_sheet_icon/bottom_sheet_icon_widget.dart';
import '/pages/setting_page/tema_component/tema_component_widget.dart';
import '/pages/setting_page/tema_component_image/tema_component_image_widget.dart';
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

    return SafeArea(
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 0.8,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
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
              wrapWithModel(
                model: _model.bottomSheetIconModel,
                updateCallback: () => safeSetState(() {}),
                child: BottomSheetIconWidget(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              'Adhan & Notisljud',
                              minFontSize: FFAppConstants.heading.toDouble(),
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
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
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
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
                              'Välj vilket ljud som ska spelas på exakt bönetid',
                              minFontSize: FFAppConstants.body.toDouble(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
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
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                wrapWithModel(
                                  model: _model.temaComponentModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TemaComponentWidget(
                                    label: 'Endast vibration',
                                    subLabel: '',
                                    checkValue: _model.selectedCard ==
                                        AdhanSound.Vibration.name,
                                    azanName: FFAppConstants.NullValue,
                                    icon: Icon(
                                      Icons.vibration_outlined,
                                    ),
                                    onCheck: () async {
                                      _model.selectedCard =
                                          AdhanSound.Vibration.name;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.temaComponentModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TemaComponentWidget(
                                    label: 'Standard (Systemljud)',
                                    subLabel: '',
                                    checkValue: _model.selectedCard ==
                                        AdhanSound.Standard.name,
                                    azanName: SoundName.Standard.name,
                                    icon: FaIcon(
                                      FontAwesomeIcons.volumeUp,
                                      size: 18.0,
                                    ),
                                    onCheck: () async {
                                      _model.selectedCard =
                                          AdhanSound.Standard.name;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.temaComponentImageModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TemaComponentImageWidget(
                                    label: 'Kort Adhan 1',
                                    checkValue: _model.selectedCard ==
                                        AdhanSound.Adhan1.name,
                                    azanName: SoundName.Adhan_1.name,
                                    onCheck: () async {
                                      _model.selectedCard =
                                          AdhanSound.Adhan1.name;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.temaComponentImageModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TemaComponentImageWidget(
                                    label: 'Kort Adhan 2',
                                    checkValue: _model.selectedCard ==
                                        AdhanSound.Adhan2.name,
                                    azanName: SoundName.Adhan_2.name,
                                    onCheck: () async {
                                      _model.selectedCard =
                                          AdhanSound.Adhan2.name;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.temaComponentImageModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TemaComponentImageWidget(
                                    label: 'Kort Adhan 3',
                                    checkValue: _model.selectedCard ==
                                        AdhanSound.Adhan3.name,
                                    azanName: SoundName.Adhan_3.name,
                                    onCheck: () async {
                                      _model.selectedCard =
                                          AdhanSound.Adhan3.name;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.temaComponentImageModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: TemaComponentImageWidget(
                                    label: 'Kort Adhan 4',
                                    checkValue: _model.selectedCard ==
                                        AdhanSound.Adhan4.name,
                                    azanName: SoundName.Adhan_4.name,
                                    onCheck: () async {
                                      _model.selectedCard =
                                          AdhanSound.Adhan4.name;
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                              ].divide(SizedBox(height: 10.0)),
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
                          _model.result = await actions.testNotifications();
                          await actions.audioPlay(
                            FFAppConstants.NullValue,
                          );
                          Navigator.pop(context);

                          safeSetState(() {});
                        },
                        text: 'Spara',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 20.0))
                        .addToEnd(SizedBox(height: 20.0)),
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
