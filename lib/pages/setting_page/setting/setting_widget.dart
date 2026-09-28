import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/adhanljud/adhanljud_widget.dart';
import '/pages/setting_page/bnetidsnotiser/bnetidsnotiser_widget.dart';
import '/pages/setting_page/fljoss_dialogue_box/fljoss_dialogue_box_widget.dart';
import '/pages/setting_page/omappen/omappen_widget.dart';
import '/pages/setting_page/plats/plats_widget.dart';
import '/pages/setting_page/pminnelsefre_adhan/pminnelsefre_adhan_widget.dart';
import '/pages/setting_page/setting_tab/setting_tab_widget.dart';
import '/pages/setting_page/setting_tab_with_switch/setting_tab_with_switch_widget.dart';
import '/pages/setting_page/tema/tema_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'setting_model.dart';
export 'setting_model.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({
    super.key,
    bool? headerNav,
  }) : this.headerNav = headerNav ?? false;

  final bool headerNav;

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
      if (widget.headerNav) {
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
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Padding(
                  padding: MediaQuery.viewInsetsOf(context),
                  child: BnetidsnotiserWidget(),
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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                FlutterFlowTheme.of(context).designToken.spacing.md,
                FlutterFlowTheme.of(context).designToken.spacing.sm,
                FlutterFlowTheme.of(context).designToken.spacing.md,
                0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
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
                        context.pushNamed(HomeWidget.routeName);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: FFAppConstants.iconSize.toDouble(),
                      ),
                    ),
                    Expanded(
                      child: wrapWithModel(
                        model: _model.pageSubHeaderWithIconModel,
                        updateCallback: () => safeSetState(() {}),
                        child: PageSubHeaderWithIconWidget(
                          pageName: 'Inställningar',
                        ),
                      ),
                    ),
                  ].divide(SizedBox(
                      width:
                          FlutterFlowTheme.of(context).designToken.spacing.sm)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: AutoSizeText(
                            'Allmänt',
                            minFontSize: FFAppConstants.heading.toDouble(),
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
                              color: FlutterFlowTheme.of(context).alternate,
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
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: TemaWidget(),
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
                                    sunLabel: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? 'Ljus'
                                        : 'Mörk',
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
                                color: FlutterFlowTheme.of(context).alternate,
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
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: PlatsWidget(),
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
                          child: AutoSizeText(
                            'Notiser och Adhan',
                            minFontSize: FFAppConstants.heading.toDouble(),
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
                              color: FlutterFlowTheme.of(context).alternate,
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
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: BnetidsnotiserWidget(),
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
                                        'Slå på/av Adhan och notiser per bön',
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
                                color: FlutterFlowTheme.of(context).alternate,
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
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: AdhanljudWidget(),
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
                                    label: 'Adhan & Notisljud',
                                    sunLabel:
                                        'Välj ljud för böneutrop och vibration',
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
                                color: FlutterFlowTheme.of(context).alternate,
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
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: PminnelsefreAdhanWidget(),
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
                                    label: 'Tid för notis',
                                    sunLabel:
                                        'Välj 5, 10 eller 15 minuter före bön',
                                    icon: FaIcon(
                                      FontAwesomeIcons.bell,
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
                          child: AutoSizeText(
                            'Om',
                            minFontSize: FFAppConstants.heading.toDouble(),
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
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: OmappenWidget(),
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
                                    sunLabel: '',
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
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await actions.rateApp();
                                },
                                child: wrapWithModel(
                                  model: _model.settingTabModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingTabWidget(
                                    label: 'Betygsätt appen',
                                    sunLabel: '',
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
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                              Builder(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await Share.share(
                                      'com.mycompany.muslimenskompanjon',
                                      sharePositionOrigin:
                                          getWidgetBoundingBox(context),
                                    );
                                  },
                                  child: wrapWithModel(
                                    model: _model.settingTabModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SettingTabWidget(
                                      label: 'Dela appen',
                                      sunLabel: '',
                                      icon: Icon(
                                        Icons.share_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                                indent: 15.0,
                                endIndent: 15.0,
                                color: FlutterFlowTheme.of(context).alternate,
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
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: FljossDialogueBoxWidget(),
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
                                    label: 'Följ oss',
                                    sunLabel: '',
                                    icon: Icon(
                                      Icons.social_distance,
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
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await launchURL(
                                      'mailto:kontakt@muslimenskompanjon.se');
                                },
                                child: wrapWithModel(
                                  model: _model.settingTabModel5,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingTabWidget(
                                    label: 'Kontakta oss',
                                    sunLabel: '',
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              'Muslimens Kompanjon Version: 1.10',
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
                          ],
                        ),
                      ]
                          .divide(SizedBox(height: 15.0))
                          .around(SizedBox(height: 15.0)),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: FFAppConstants.footerHeight.toDouble(),
                  child: custom_widgets.CustomPageFooter(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: FFAppConstants.footerHeight.toDouble(),
                    selectedIndex: 4,
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
