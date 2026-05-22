import '/components/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/about_islam/about_islam_tabs/about_islam_tabs_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'about_islam_model.dart';
export 'about_islam_model.dart';

class AboutIslamWidget extends StatefulWidget {
  const AboutIslamWidget({super.key});

  static String routeName = 'AboutIslam';
  static String routePath = '/aboutIslam';

  @override
  State<AboutIslamWidget> createState() => _AboutIslamWidgetState();
}

class _AboutIslamWidgetState extends State<AboutIslamWidget> {
  late AboutIslamModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutIslamModel());

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
                    pageName: 'About Islam',
                  ),
                ),
                Text(
                  FFLocalizations.of(context).getText(
                    '5xodvrat' /* Guiding reminders */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineLarge.override(
                        font: GoogleFonts.manrope(
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineLarge
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineLarge
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .fontStyle,
                      ),
                ),
                Builder(
                  builder: (context) {
                    final aboutIslamicTabs = getJsonField(
                      FFAppState().AboutIslam,
                      r'''$.tabs''',
                    ).toList();

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: aboutIslamicTabs.length,
                      separatorBuilder: (_, __) => SizedBox(height: 20.0),
                      itemBuilder: (context, aboutIslamicTabsIndex) {
                        final aboutIslamicTabsItem =
                            aboutIslamicTabs[aboutIslamicTabsIndex];
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              AboutIslamDetailsPageWidget.routeName,
                              queryParameters: {
                                'tabData': serializeParam(
                                  aboutIslamicTabsItem,
                                  ParamType.JSON,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: AboutIslamTabsWidget(
                            key: Key(
                                'Keytvu_${aboutIslamicTabsIndex}_of_${aboutIslamicTabs.length}'),
                            title: getJsonField(
                              aboutIslamicTabsItem,
                              r'''$.title''',
                            ).toString(),
                            subtitle: getJsonField(
                              aboutIslamicTabsItem,
                              r'''$.subtitle''',
                            ).toString(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
