import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/about_islam/about_islam_tabs/about_islam_tabs_widget.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
            padding: EdgeInsetsDirectional.fromSTEB(
                FlutterFlowTheme.of(context).designToken.spacing.md,
                0.0,
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
                          pageName: 'Om Islam',
                        ),
                      ),
                    ),
                  ].divide(SizedBox(
                      width:
                          FlutterFlowTheme.of(context).designToken.spacing.sm)),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            15.0, 0.0, 15.0, 0.0),
                        child: AutoSizeText(
                          '11 korta videor. Från grunden.\nIngen press. Inga svåra ord. Bara islam från hjärtat.\nOavsett var du står idag – här börjar du där du är.',
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
                                color: FlutterFlowTheme.of(context).primaryText,
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
                            final aboutIslamicTabs =
                                FFAppState().aboutIslam.toList();

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: aboutIslamicTabs.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 20.0),
                              itemBuilder: (context, aboutIslamicTabsIndex) {
                                final aboutIslamicTabsItem =
                                    aboutIslamicTabs[aboutIslamicTabsIndex];
                                return wrapWithModel(
                                  model: _model.aboutIslamTabsModels.getModel(
                                    aboutIslamicTabsIndex.toString(),
                                    aboutIslamicTabsIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: AboutIslamTabsWidget(
                                    key: Key(
                                      'Keytvu_${aboutIslamicTabsIndex.toString()}',
                                    ),
                                    title: aboutIslamicTabsItem.title,
                                    subtitle: aboutIslamicTabsItem.introduction,
                                    alreadyready:
                                        aboutIslamicTabsItem.alreadyRead,
                                    index: aboutIslamicTabsIndex,
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
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
