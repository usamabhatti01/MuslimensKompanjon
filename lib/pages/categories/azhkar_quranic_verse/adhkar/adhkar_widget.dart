import '/custom_header_footer/page_footer/page_footer_widget.dart';
import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adkha_page_component/adkha_page_component_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'adhkar_model.dart';
export 'adhkar_model.dart';

class AdhkarWidget extends StatefulWidget {
  const AdhkarWidget({super.key});

  static String routeName = 'Adhkar';
  static String routePath = '/adhkar';

  @override
  State<AdhkarWidget> createState() => _AdhkarWidgetState();
}

class _AdhkarWidgetState extends State<AdhkarWidget> {
  late AdhkarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdhkarModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              wrapWithModel(
                model: _model.pageSubHeaderWithIconModel,
                updateCallback: () => safeSetState(() {}),
                child: PageSubHeaderWithIconWidget(
                  pageName: 'Adhkar',
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: () {
                            if (MediaQuery.sizeOf(context).width <
                                kBreakpointSmall) {
                              return 2;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointMedium) {
                              return 2;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointLarge) {
                              return 3;
                            } else {
                              return 4;
                            }
                          }(),
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.5,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                MorningEveningAdhkarWidget.routeName,
                                queryParameters: {
                                  'adkar': serializeParam(
                                    'Morgon Adhkar',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: wrapWithModel(
                              model: _model.adkhaPageComponentModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: AdkhaPageComponentWidget(
                                icon: Icon(
                                  FFIcons.ksun,
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  size: 32.0,
                                ),
                                title: 'Morgon \nAdhkar',
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                MorningEveningAdhkarWidget.routeName,
                                queryParameters: {
                                  'adkar': serializeParam(
                                    'KvällAdhkar',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: wrapWithModel(
                              model: _model.adkhaPageComponentModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: AdkhaPageComponentWidget(
                                icon: Icon(
                                  Icons.tsunami_rounded,
                                  color: FlutterFlowTheme.of(context).success,
                                  size: 32.0,
                                ),
                                title: 'Kväll\nAdhkar',
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                TasbihWidget.routeName,
                                queryParameters: {
                                  'adkar': serializeParam(
                                    'Tasbih',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: wrapWithModel(
                              model: _model.adkhaPageComponentModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: AdkhaPageComponentWidget(
                                icon: Icon(
                                  FFIcons.ktasbia,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 32.0,
                                ),
                                title: 'Tasbih',
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                AllahNamesWidget.routeName,
                                queryParameters: {
                                  'adkar': serializeParam(
                                    'Allah 99 Names',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: wrapWithModel(
                              model: _model.adkhaPageComponentModel4,
                              updateCallback: () => safeSetState(() {}),
                              child: AdkhaPageComponentWidget(
                                icon: Icon(
                                  FFIcons.k99,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 32.0,
                                ),
                                title: 'Allahs  namn',
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                AkallanDuaWidget.routeName,
                                queryParameters: {
                                  'adkar': serializeParam(
                                    'Åkallan & Dua',
                                    ParamType.String,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: wrapWithModel(
                              model: _model.adkhaPageComponentModel5,
                              updateCallback: () => safeSetState(() {}),
                              child: AdkhaPageComponentWidget(
                                icon: Icon(
                                  FFIcons.kdua,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 32.0,
                                ),
                                title: 'Åkallan & Dua',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              wrapWithModel(
                model: _model.pageFooterModel,
                updateCallback: () => safeSetState(() {}),
                child: PageFooterWidget(
                  activeTab: 3,
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
