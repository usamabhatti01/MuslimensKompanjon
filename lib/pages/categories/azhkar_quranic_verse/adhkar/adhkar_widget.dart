import '/extra/page_sub_header/page_sub_header_widget.dart';
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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(
                FlutterFlowTheme.of(context).designToken.spacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.pageSubHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PageSubHeaderWidget(
                    pageName: 'Adhkar',
                  ),
                ),
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
                    scrollDirection: Axis.vertical,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(MorningAdhkarWidget.routeName);
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
                          context.pushNamed(EveningAdhkarWidget.routeName);
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
                          context.pushNamed(TasbihWidget.routeName);
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
                          context.pushNamed(AllahNamesWidget.routeName);
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
                            title: 'Allahs namn',
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(SupplicationsDuaWidget.routeName);
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
              ].divide(SizedBox(height: 20.0)).around(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
