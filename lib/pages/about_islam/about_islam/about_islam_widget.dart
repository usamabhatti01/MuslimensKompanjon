import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/about_islam/about_islam_tabs/about_islam_tabs_widget.dart';
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
                        size: 24.0,
                      ),
                    ),
                    Expanded(
                      child: wrapWithModel(
                        model: _model.pageSubHeaderWithIconModel,
                        updateCallback: () => safeSetState(() {}),
                        child: PageSubHeaderWithIconWidget(
                          pageName: 'Om Islam',
                        ),
                      ),
                    ),
                  ].divide(SizedBox(
                      width:
                          FlutterFlowTheme.of(context).designToken.spacing.lg)),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: Text(
                          '11 korta videor. Från grunden.\nIngen press. Inga svåra ord. Bara islam från hjärtat.\nOavsett var du står idag – här börjar du där du är.',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            final aboutIslamicTabs = getJsonField(
                              FFAppState().AboutIslam,
                              r'''$.tabs''',
                            ).toList();

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: aboutIslamicTabs.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 20.0),
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
                                        AboutIslamDetailsPageWidget.routeName);
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
                                    alreadyready: true,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ].divide(SizedBox(height: 10.0)),
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
