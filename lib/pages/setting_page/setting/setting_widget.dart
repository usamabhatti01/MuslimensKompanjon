import '/custom_header_footer/page_footer/page_footer_widget.dart';
import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/adhanljud/adhanljud_widget.dart';
import '/pages/setting_page/betygsttappen/betygsttappen_widget.dart';
import '/pages/setting_page/bnetidsnotiser/bnetidsnotiser_widget.dart';
import '/pages/setting_page/kontaktaoss/kontaktaoss_widget.dart';
import '/pages/setting_page/omappen/omappen_widget.dart';
import '/pages/setting_page/plats/plats_widget.dart';
import '/pages/setting_page/pminnelsefre_adhan/pminnelsefre_adhan_widget.dart';
import '/pages/setting_page/setting_tab/setting_tab_widget.dart';
import '/pages/setting_page/setting_tab_with_switch/setting_tab_with_switch_widget.dart';
import '/pages/setting_page/tema/tema_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'setting_model.dart';
export 'setting_model.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({
    super.key,
    this.headerNav,
  });

  final bool? headerNav;

  static String routeName = 'Setting';
  static String routePath = '/setting';

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  late SettingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.headerNav!) {
        await showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          enableDrag: false,
          context: context,
          builder: (context) {
            return WebViewAware(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: Container(
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    child: BnetidsnotiserWidget(),
                  ),
                ),
              ),
            );
          },
        ).then((value) => safeSetState(() {}));
      }
    });

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
        body: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.pageSubHeaderWithIconModel,
                updateCallback: () => safeSetState(() {}),
                child: PageSubHeaderWithIconWidget(
                  pageName: 'Inställningar',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          'Allmänt',
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .radius
                                  .md),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).containerBg,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.6,
                                            child: TemaWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.settingTabWithSwitchModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWithSwitchWidget(
                                  label: 'Tema',
                                  sunLabel: 'Ljus',
                                  icon: Icon(
                                    Icons.wb_sunny_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.0,
                              indent: 15.0,
                              endIndent: 15.0,
                              color: FlutterFlowTheme.of(context).containerBg,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.9,
                                            child: PlatsWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.settingTabWithSwitchModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWithSwitchWidget(
                                  label: 'Plats',
                                  sunLabel: FFAppState().user.city,
                                  icon: Icon(
                                    Icons.location_pin,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ]
                              .addToStart(SizedBox(height: 10.0))
                              .addToEnd(SizedBox(height: 10.0)),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          'Notiser',
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                                  ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .radius
                                  .md),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).containerBg,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  useSafeArea: true,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.8,
                                            child: BnetidsnotiserWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.settingTabWithSwitchModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWithSwitchWidget(
                                  label: 'Bönetidsnotiser',
                                  sunLabel:
                                      'Slå på/av notiser för specifika böner',
                                  icon: Icon(
                                    Icons.message_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.0,
                              indent: 15.0,
                              endIndent: 15.0,
                              color: FlutterFlowTheme.of(context).containerBg,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.8,
                                            child: AdhanljudWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.settingTabWithSwitchModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWithSwitchWidget(
                                  label: 'Adhan',
                                  sunLabel: 'Välj ljud för böneutropet',
                                  icon: Icon(
                                    Icons.vibration_sharp,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.0,
                              indent: 15.0,
                              endIndent: 15.0,
                              color: FlutterFlowTheme.of(context).containerBg,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.8,
                                            child: PminnelsefreAdhanWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.settingTabWithSwitchModel5,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWithSwitchWidget(
                                  label: 'Påminnelse före Adhan',
                                  sunLabel:
                                      'Få en notis 5, 10 eller 15 minuter innan',
                                  icon: Icon(
                                    FFIcons.kbell,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ]
                              .addToStart(SizedBox(height: 10.0))
                              .addToEnd(SizedBox(height: 10.0)),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          'Om',
                          style:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                                  ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .radius
                                  .md),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).containerBg,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.7,
                                            child: OmappenWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.settingTabModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWidget(
                                  label: 'Om appen',
                                  sunLabel: ' ',
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.0,
                              indent: 15.0,
                              endIndent: 15.0,
                              color: FlutterFlowTheme.of(context).containerBg,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.75,
                                            child: BetygsttappenWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.settingTabModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWidget(
                                  label: 'Betygsätt appen',
                                  sunLabel: ' ',
                                  icon: Icon(
                                    Icons.star_border,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.0,
                              indent: 15.0,
                              endIndent: 15.0,
                              color: FlutterFlowTheme.of(context).containerBg,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await launchURL('');
                              },
                              child: wrapWithModel(
                                model: _model.settingTabModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWidget(
                                  label: 'Dela appen',
                                  sunLabel: ' ',
                                  icon: Icon(
                                    Icons.share_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.0,
                              indent: 15.0,
                              endIndent: 15.0,
                              color: FlutterFlowTheme.of(context).containerBg,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        },
                                        child: Padding(
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.9,
                                            child: KontaktaossWidget(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              child: wrapWithModel(
                                model: _model.settingTabModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWidget(
                                  label: 'Kontakta oss',
                                  sunLabel: ' ',
                                  icon: Icon(
                                    Icons.mail_outline_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ]
                              .addToStart(SizedBox(height: 10.0))
                              .addToEnd(SizedBox(height: 10.0)),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 20.0))
                        .around(SizedBox(height: 20.0)),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Muslimens Kompanjon Version: 1.0',
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
                ],
              ),
              wrapWithModel(
                model: _model.pageFooterModel,
                updateCallback: () => safeSetState(() {}),
                child: PageFooterWidget(
                  activeTab: 5,
                ),
              ),
            ].divide(SizedBox(height: 20.0)).addToStart(SizedBox(
                height: FlutterFlowTheme.of(context).designToken.spacing.xxl)),
          ),
        ),
      ),
    );
  }
}
