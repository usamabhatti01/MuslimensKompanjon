import '/components/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/on_boarding/prayer_notification/prayer_notification_widget.dart';
import '/pages/setting_pages/pages_heading_box/pages_heading_box_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notification_model.dart';
export 'notification_model.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  static String routeName = 'Notification';
  static String routePath = '/notification';

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late NotificationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationModel());

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
                FlutterFlowTheme.of(context).designToken.spacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.pageSubHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PageSubHeaderWidget(
                    pageName: 'Notification',
                  ),
                ),
                wrapWithModel(
                  model: _model.pagesHeadingBoxModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PagesHeadingBoxWidget(
                    title: 'Stay Connected',
                    subTitle:
                        'Receive prayer reminders, Imam alerts, and Islamic updates directly in MK App.',
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
                        Text(
                          FFLocalizations.of(context).getText(
                            'xu2eyxv3' /* Never Miss a prayer! */,
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
                            'zfw0kuao' /* Choose which times you want to... */,
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
                            '703n8kne' /* You can select different adhan... */,
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
                            await actions.schedulePrayerNotifications();
                            ScaffoldMessenger.of(context).clearSnackBars();
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
                                    FlutterFlowTheme.of(context).success,
                              ),
                            );
                          },
                          text: FFLocalizations.of(context).getText(
                            'gwrkyhlk' /* Enable Notifications */,
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
                      ],
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
