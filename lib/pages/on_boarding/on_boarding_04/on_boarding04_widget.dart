import '/backend/schema/structs/index.dart';
import '/custom_header_footer/page_sub_header/page_sub_header_widget.dart';
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
import 'on_boarding04_model.dart';
export 'on_boarding04_model.dart';

class OnBoarding04Widget extends StatefulWidget {
  const OnBoarding04Widget({super.key});

  static String routeName = 'OnBoarding_04';
  static String routePath = '/onBoarding04';

  @override
  State<OnBoarding04Widget> createState() => _OnBoarding04WidgetState();
}

class _OnBoarding04WidgetState extends State<OnBoarding04Widget> {
  late OnBoarding04Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnBoarding04Model());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              wrapWithModel(
                model: _model.pageSubHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: PageSubHeaderWidget(
                  pageName: 'Bönenotiser',
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/mage_megaphone-a.png',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Missa aldrig en bön!',
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
                          Text(
                            'Välj för vilka tider du vill få påminnelser \noch notiser.',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
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
                          Padding(
                            padding: EdgeInsets.all(FlutterFlowTheme.of(context)
                                .designToken
                                .spacing
                                .sm),
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
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
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child:
                                              BnetidsnotiserWithoutTimeWidget(
                                            label: 'Fajr',
                                            icon: FaIcon(
                                              FontAwesomeIcons.cloudSun,
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child:
                                              BnetidsnotiserWithoutTimeWidget(
                                            label: 'Dhohr',
                                            icon: FaIcon(
                                              FontAwesomeIcons.sun,
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child:
                                              BnetidsnotiserWithoutTimeWidget(
                                            label: 'Asr',
                                            icon: Icon(
                                              Icons.sunny_snowing,
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child:
                                              BnetidsnotiserWithoutTimeWidget(
                                            label: 'Maghrib',
                                            icon: FaIcon(
                                              FontAwesomeIcons.cloudMoon,
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child:
                                              BnetidsnotiserWithoutTimeWidget(
                                            label: 'Isha',
                                            icon: FaIcon(
                                              FontAwesomeIcons.moon,
                                              color:
                                                  FlutterFlowTheme.of(context)
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
                          Text(
                            'Du kan välja olika adhan-röster och inställningar senare i appen.',
                            textAlign: TextAlign.center,
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              if (FFAppState().user.city != '') {
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
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'CityNot Select',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                              }
                            },
                            text: 'Aktivera notiser',
                            options: FFButtonOptions(
                              width: 250.0,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
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
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(HomeWidget.routeName);
                            },
                            child: Text(
                              'Hoppa över',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ].addToStart(SizedBox(
                height: FlutterFlowTheme.of(context).designToken.spacing.xxl)),
          ),
        ),
      ),
    );
  }
}
