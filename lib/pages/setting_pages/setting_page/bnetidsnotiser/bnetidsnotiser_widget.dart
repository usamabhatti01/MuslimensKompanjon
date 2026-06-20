import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/setting_pages/setting_page/bnetidsnotiser_without_time/bnetidsnotiser_without_time_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bnetidsnotiser_model.dart';
export 'bnetidsnotiser_model.dart';

class BnetidsnotiserWidget extends StatefulWidget {
  const BnetidsnotiserWidget({super.key});

  @override
  State<BnetidsnotiserWidget> createState() => _BnetidsnotiserWidgetState();
}

class _BnetidsnotiserWidgetState extends State<BnetidsnotiserWidget> {
  late BnetidsnotiserModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BnetidsnotiserModel());
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      'Bönetidsnotiser',
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
                    child: Text(
                      'Anpassa hur du vill bli påmind inför varje bön.',
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
                  Padding(
                    padding: EdgeInsets.all(
                        FlutterFlowTheme.of(context).designToken.spacing.sm),
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Notis',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                                Text(
                                  'Adhan',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ]
                                  .divide(SizedBox(width: 15.0))
                                  .addToEnd(SizedBox(width: 10.0)),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                wrapWithModel(
                                  model: _model.fajrModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BnetidsnotiserWithoutTimeWidget(
                                    label: 'Fajr',
                                    icon: FaIcon(
                                      FontAwesomeIcons.cloudSun,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    notice: FFAppState()
                                        .user
                                        .notifications
                                        .fazr
                                        .notice,
                                    adhan: FFAppState()
                                        .user
                                        .notifications
                                        .fazr
                                        .adhan,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.dhohrModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BnetidsnotiserWithoutTimeWidget(
                                    label: 'Dhohr',
                                    icon: FaIcon(
                                      FontAwesomeIcons.sun,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    notice: FFAppState()
                                        .user
                                        .notifications
                                        .dohr
                                        .notice,
                                    adhan: FFAppState()
                                        .user
                                        .notifications
                                        .dohr
                                        .adhan,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.asrModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BnetidsnotiserWithoutTimeWidget(
                                    label: 'Asr',
                                    icon: Icon(
                                      Icons.sunny_snowing,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    notice: FFAppState()
                                        .user
                                        .notifications
                                        .asr
                                        .notice,
                                    adhan: FFAppState()
                                        .user
                                        .notifications
                                        .asr
                                        .adhan,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.maghribModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BnetidsnotiserWithoutTimeWidget(
                                    label: 'Maghrib',
                                    icon: FaIcon(
                                      FontAwesomeIcons.cloudMoon,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    notice: FFAppState()
                                        .user
                                        .notifications
                                        .maghrib
                                        .notice,
                                    adhan: FFAppState()
                                        .user
                                        .notifications
                                        .maghrib
                                        .adhan,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.ishaModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: BnetidsnotiserWithoutTimeWidget(
                                    label: 'Isha',
                                    icon: FaIcon(
                                      FontAwesomeIcons.moon,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 18.0,
                                    ),
                                    notice: FFAppState()
                                        .user
                                        .notifications
                                        .isha
                                        .notice,
                                    adhan: FFAppState()
                                        .user
                                        .notifications
                                        .isha
                                        .adhan,
                                  ),
                                ),
                              ].divide(SizedBox(height: 10.0)),
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
                    (e) => e
                      ..notifications = NotificationsStruct(
                        fazr: NotificationCheckStruct(
                          notice: _model.fajrModel.notisValue,
                          adhan: _model.fajrModel.adhanValue,
                        ),
                        dohr: NotificationCheckStruct(
                          notice: _model.dhohrModel.notisValue,
                          adhan: _model.dhohrModel.adhanValue,
                        ),
                        asr: NotificationCheckStruct(
                          notice: _model.asrModel.notisValue,
                          adhan: _model.asrModel.adhanValue,
                        ),
                        maghrib: NotificationCheckStruct(
                          notice: _model.maghribModel.notisValue,
                          adhan: _model.maghribModel.adhanValue,
                        ),
                        isha: NotificationCheckStruct(
                          notice: _model.ishaModel.notisValue,
                          adhan: _model.ishaModel.adhanValue,
                        ),
                      ),
                  );
                  safeSetState(() {});
                  await actions.schedulePrayerNotifications();

                  context.pushNamed(HomeWidget.routeName);
                },
                text: 'Spara',
                options: FFButtonOptions(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.plusJakartaSans(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
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
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                  ),
                ],
              ),
            ].divide(SizedBox(height: 20.0)).around(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
