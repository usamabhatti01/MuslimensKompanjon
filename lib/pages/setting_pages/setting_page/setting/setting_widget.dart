import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/setting_pages/pages_heading_box/pages_heading_box_widget.dart';
import '/pages/setting_pages/setting_page/setting_tab/setting_tab_widget.dart';
import '/pages/setting_pages/setting_page/setting_tab_with_switch/setting_tab_with_switch_widget.dart';
import '/pages/setting_pages/setting_pages_header/setting_pages_header_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'setting_model.dart';
export 'setting_model.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key});

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

    _model.switchValue1 = FFAppState().user.language == 'sv' ? true : false;
    _model.switchValue2 = FFAppState().user.darkMode ? true : false;
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
              children: [
                wrapWithModel(
                  model: _model.settingPagesHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: SettingPagesHeaderWidget(
                    pageName: 'Setting',
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        wrapWithModel(
                          model: _model.pagesHeadingBoxModel,
                          updateCallback: () => safeSetState(() {}),
                          child: PagesHeadingBoxWidget(
                            title: 'Muslimens Kompanjon',
                            subTitle: 'Prayer & Lifestyle Companion',
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'GENERAL',
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
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                              ))
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Switch.adaptive(
                                      value: _model.switchValue1!,
                                      onChanged: (newValue) async {
                                        safeSetState(() =>
                                            _model.switchValue1 = newValue);
                                        if (newValue) {
                                          setAppLanguage(context, 'sv');
                                          FFAppState().user = UserDataStruct(
                                            language: 'sv',
                                          );
                                          safeSetState(() {});
                                        }
                                      },
                                      activeColor: FlutterFlowTheme.of(context)
                                          .alternate,
                                      activeTrackColor:
                                          FlutterFlowTheme.of(context).primary,
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .alternate,
                                      inactiveThumbColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                    ),
                                  ],
                                ),
                              Divider(
                                thickness: 1.0,
                                indent: 15.0,
                                endIndent: 15.0,
                                color: FlutterFlowTheme.of(context).containerBg,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  wrapWithModel(
                                    model: _model.settingTabWithSwitchModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: SettingTabWithSwitchWidget(
                                      label: 'Dark Mode',
                                      sunLabel: 'Enable night theme',
                                      icon: Icon(
                                        Icons.dark_mode_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 18.0,
                                      ),
                                    ),
                                  ),
                                  Switch.adaptive(
                                    value: _model.switchValue2!,
                                    onChanged: (newValue) async {
                                      safeSetState(() =>
                                          _model.switchValue2 = newValue);
                                      if (newValue) {
                                        setDarkModeSetting(
                                            context, ThemeMode.dark);
                                        FFAppState().updateUserStruct(
                                          (e) => e..darkMode = true,
                                        );
                                        safeSetState(() {});
                                      } else {
                                        setDarkModeSetting(
                                            context, ThemeMode.light);
                                        FFAppState().updateUserStruct(
                                          (e) => e..darkMode = false,
                                        );
                                        safeSetState(() {});
                                      }
                                    },
                                    activeColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    activeTrackColor:
                                        FlutterFlowTheme.of(context).primary,
                                    inactiveTrackColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    inactiveThumbColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1.0,
                                indent: 15.0,
                                endIndent: 15.0,
                                color: FlutterFlowTheme.of(context).containerBg,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 44.0,
                                    height: 44.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(
                                          FlutterFlowTheme.of(context)
                                              .designToken
                                              .radius
                                              .sm),
                                    ),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: FlutterFlowDropDown<String>(
                                      controller:
                                          _model.dropDownValueController ??=
                                              FormFieldController<String>(
                                        _model.dropDownValue ??=
                                            valueOrDefault<String>(
                                          FFAppState().user.city,
                                          'EmptyString',
                                        ),
                                      ),
                                      options: FFAppState()
                                          .cityList
                                          .map((e) => e.name)
                                          .toList(),
                                      onChanged: (val) async {
                                        safeSetState(
                                            () => _model.dropDownValue = val);
                                        FFAppState().updateUserStruct(
                                          (e) => e..city = _model.dropDownValue,
                                        );
                                        safeSetState(() {});
                                        await actions
                                            .schedulePrayerNotifications();
                                      },
                                      width: 200.0,
                                      height: 40.0,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.manrope(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      hintText: 'Select...',
                                      icon: Icon(
                                        Icons.search,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 18.0,
                                      ),
                                      fillColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      elevation: 2.0,
                                      borderColor: Colors.transparent,
                                      borderWidth: 0.0,
                                      borderRadius: 8.0,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 0.0, 12.0, 0.0),
                                      hidesUnderline: true,
                                      isOverButton: false,
                                      isSearchable: false,
                                      isMultiSelect: false,
                                    ),
                                  ),
                                ]
                                    .divide(SizedBox(width: 20.0))
                                    .addToStart(SizedBox(width: 20.0))
                                    .addToEnd(SizedBox(width: 10.0)),
                              ),
                            ]
                                .addToStart(SizedBox(height: 10.0))
                                .addToEnd(SizedBox(height: 10.0)),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'NOTIFICATIONS',
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
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(NotificationWidget.routeName);
                          },
                          child: Container(
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
                                wrapWithModel(
                                  model: _model.settingTabWithSwitchModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: SettingTabWithSwitchWidget(
                                    label: 'Prayer Alerts',
                                    sunLabel: 'Adhan & reminders',
                                    icon: Icon(
                                      Icons.mosque_outlined,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                              ]
                                  .addToStart(SizedBox(height: 10.0))
                                  .addToEnd(SizedBox(height: 10.0)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Text(
                            'ABOUT',
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
                              wrapWithModel(
                                model: _model.settingTabModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWidget(
                                  label: 'About App',
                                  sunLabel: ' ',
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1.0,
                                indent: 15.0,
                                endIndent: 15.0,
                                color: FlutterFlowTheme.of(context).containerBg,
                              ),
                              wrapWithModel(
                                model: _model.settingTabModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: SettingTabWidget(
                                  label: 'Rate App',
                                  sunLabel: 'Ask Imam notifications',
                                  icon: Icon(
                                    Icons.star_border,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 18.0,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
