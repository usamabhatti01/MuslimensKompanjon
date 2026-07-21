import '/backend/schema/structs/index.dart';
import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/mornng_and_evebing_adhkar/adhkar_ar_component/adhkar_ar_component_widget.dart';
import '/pages/categories/azhkar_quranic_verse/mornng_and_evebing_adhkar/adhkar_sv_component/adhkar_sv_component_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'morning_evening_adhkar_model.dart';
export 'morning_evening_adhkar_model.dart';

class MorningEveningAdhkarWidget extends StatefulWidget {
  const MorningEveningAdhkarWidget({
    super.key,
    required this.adkar,
    this.adhkar,
  });

  final String? adkar;
  final List<AdhkarStruct>? adhkar;

  static String routeName = 'MorningEveningAdhkar';
  static String routePath = '/morningEveningAdhkar';

  @override
  State<MorningEveningAdhkarWidget> createState() =>
      _MorningEveningAdhkarWidgetState();
}

class _MorningEveningAdhkarWidgetState extends State<MorningEveningAdhkarWidget>
    with TickerProviderStateMixin {
  late MorningEveningAdhkarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MorningEveningAdhkarModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
                        context.pushNamed(
                          AdhkarWidget.routeName,
                          extra: <String, dynamic>{
                            '__transition_info__': TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: FFAppConstants.iconSize.toDouble(),
                      ),
                    ),
                    Expanded(
                      child: wrapWithModel(
                        model: _model.adhkarHeaderModel,
                        updateCallback: () => safeSetState(() {}),
                        child: AdhkarHeaderWidget(
                          pageName: widget.adkar!,
                          volume: true,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.7,
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment(0.0, 0),
                                child: TabBar(
                                  labelColor:
                                      FlutterFlowTheme.of(context).primary,
                                  unselectedLabelColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.plusJakartaSans(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                                  unselectedLabelStyle:
                                      FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.plusJakartaSans(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                  indicatorColor:
                                      FlutterFlowTheme.of(context).primary,
                                  tabs: [
                                    Tab(
                                      text: 'Arabiska',
                                    ),
                                    Tab(
                                      text: 'Svenska',
                                    ),
                                  ],
                                  controller: _model.tabBarController,
                                  onTap: (i) async {
                                    [() async {}, () async {}][i]();
                                  },
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _model.tabBarController,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        final adhkarList =
                                            widget.adhkar?.toList() ?? [];

                                        return SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                    adhkarList.length,
                                                    (adhkarListIndex) {
                                              final adhkarListItem =
                                                  adhkarList[adhkarListIndex];
                                              return wrapWithModel(
                                                model: _model
                                                    .adhkarArComponentModels
                                                    .getModel(
                                                  adhkarListIndex.toString(),
                                                  adhkarListIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: AdhkarArComponentWidget(
                                                  key: Key(
                                                    'Keyzqr_${adhkarListIndex.toString()}',
                                                  ),
                                                  value: adhkarListItem.arabic,
                                                  total: adhkarListItem.counter,
                                                  audio: adhkarListItem.audio,
                                                ),
                                              );
                                            })
                                                .divide(SizedBox(height: 20.0))
                                                .around(SizedBox(height: 20.0)),
                                          ),
                                        );
                                      },
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final adhkarListSv =
                                            widget.adhkar?.toList() ?? [];

                                        return SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                    adhkarListSv.length,
                                                    (adhkarListSvIndex) {
                                              final adhkarListSvItem =
                                                  adhkarListSv[
                                                      adhkarListSvIndex];
                                              return wrapWithModel(
                                                model: _model
                                                    .adhkarSvComponentModels
                                                    .getModel(
                                                  adhkarListSvIndex.toString(),
                                                  adhkarListSvIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: AdhkarSvComponentWidget(
                                                  key: Key(
                                                    'Keynsu_${adhkarListSvIndex.toString()}',
                                                  ),
                                                  value:
                                                      adhkarListSvItem.swedish,
                                                  total:
                                                      adhkarListSvItem.counter,
                                                  audio: adhkarListSvItem.audio,
                                                ),
                                              );
                                            })
                                                .divide(SizedBox(height: 20.0))
                                                .around(SizedBox(height: 20.0)),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
