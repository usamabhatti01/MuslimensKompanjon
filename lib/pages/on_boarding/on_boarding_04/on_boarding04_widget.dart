import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/on_boarding/prayer_notification/prayer_notification_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(
                FlutterFlowTheme.of(context).designToken.spacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.safePop();
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'ihs7k9dt' /* Prayer Notifications */,
                          ),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.manrope(
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
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/mage_megaphone-a.png',
                            width: 120.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'urwz9ora' /* Never Miss a prayer! */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    font: GoogleFonts.manrope(
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
                          FFLocalizations.of(context).getText(
                            'mngumizw' /* Choose which times you want to... */,
                          ),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.manrope(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                wrapWithModel(
                                  model: _model.fazrModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: PrayerNotificationWidget(
                                    prayerName: 'Fazr',
                                    notificationCheck:
                                        FFAppState().user.notifications.fazr,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.shuruqModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: PrayerNotificationWidget(
                                    prayerName: 'Shuruq',
                                    notificationCheck:
                                        FFAppState().user.notifications.shuruq,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.dohtModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: PrayerNotificationWidget(
                                    prayerName: 'Dohr',
                                    notificationCheck:
                                        FFAppState().user.notifications.dohr,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.asrModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: PrayerNotificationWidget(
                                    prayerName: 'Asr',
                                    notificationCheck:
                                        FFAppState().user.notifications.asr,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.maghribModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: PrayerNotificationWidget(
                                    prayerName: 'Maghrib',
                                    notificationCheck:
                                        FFAppState().user.notifications.maghrib,
                                  ),
                                ),
                                wrapWithModel(
                                  model: _model.ishaModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: PrayerNotificationWidget(
                                    prayerName: 'Isha',
                                    notificationCheck:
                                        FFAppState().user.notifications.isha,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'a2usqzrp' /* You can select different adhan... */,
                          ),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.manrope(
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
                        FFButtonWidget(
                          onPressed: () async {
                            FFAppState().updateUserStruct(
                              (e) => e
                                ..updateNotifications(
                                  (e) => e
                                    ..fazr = _model.fazrModel.switchValue
                                    ..shuruq = _model.shuruqModel.switchValue
                                    ..dohr = _model.dohtModel.switchValue
                                    ..asr = _model.asrModel.switchValue
                                    ..maghrib = _model.maghribModel.switchValue
                                    ..isha = _model.ishaModel.switchValue,
                                ),
                            );
                            safeSetState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Notification Update Successfully.',
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

                            context.pushNamed(HomeWidget.routeName);
                          },
                          text: FFLocalizations.of(context).getText(
                            'wlfhuhub' /* Enable Notifications */,
                          ),
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
                                  font: GoogleFonts.manrope(
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
                            FFLocalizations.of(context).getText(
                              's060smtr' /* Skip */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.manrope(
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
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
