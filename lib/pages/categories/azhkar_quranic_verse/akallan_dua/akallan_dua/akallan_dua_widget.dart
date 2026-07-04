import '/backend/schema/structs/index.dart';
import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/akallan_dua/akallan_dua_box_ar/akallan_dua_box_ar_widget.dart';
import '/pages/categories/azhkar_quranic_verse/akallan_dua/akallan_dua_box_sv/akallan_dua_box_sv_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'akallan_dua_model.dart';
export 'akallan_dua_model.dart';

class AkallanDuaWidget extends StatefulWidget {
  const AkallanDuaWidget({
    super.key,
    required this.adkarList,
    required this.pageHeader,
  });

  final List<DuaChildStruct>? adkarList;
  final String? pageHeader;

  static String routeName = 'AkallanDua';
  static String routePath = '/akallanDua';

  @override
  State<AkallanDuaWidget> createState() => _AkallanDuaWidgetState();
}

class _AkallanDuaWidgetState extends State<AkallanDuaWidget>
    with TickerProviderStateMixin {
  late AkallanDuaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AkallanDuaModel());

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
        body: Padding(
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
                      context.pushNamed(
                        AkallanAndDuaWidget.routeName,
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
                      size: 24.0,
                    ),
                  ),
                  Expanded(
                    child: wrapWithModel(
                      model: _model.adhkarHeaderModel,
                      updateCallback: () => safeSetState(() {}),
                      child: AdhkarHeaderWidget(
                        pageName: widget.pageHeader!,
                        volume: false,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        decoration: BoxDecoration(),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment(0.0, 0),
                              child: TabBar(
                                labelColor:
                                    FlutterFlowTheme.of(context).primary,
                                unselectedLabelColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                labelStyle: FlutterFlowTheme.of(context)
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
                                unselectedLabelStyle: FlutterFlowTheme.of(
                                        context)
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
                                      final arabic =
                                          widget.adkarList!.toList();

                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List.generate(arabic.length,
                                                  (arabicIndex) {
                                            final arabicItem =
                                                arabic[arabicIndex];
                                            return Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        AkallanDuaBoxArWidget(
                                                      key: Key(
                                                          'Keyp85_${arabicIndex}_of_${arabic.length}'),
                                                      tasbihName:
                                                          arabicItem.titleAr,
                                                      tasbih: arabicItem.arabic,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                              .divide(SizedBox(height: 12.0))
                                              .around(SizedBox(height: 12.0)),
                                        ),
                                      );
                                    },
                                  ),
                                  Builder(
                                    builder: (context) {
                                      final svenska =
                                          widget.adkarList!.toList();

                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: List
                                                  .generate(svenska.length,
                                                      (svenskaIndex) {
                                            final svenskaItem =
                                                svenska[svenskaIndex];
                                            return Padding(
                                              padding: EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child:
                                                        AkallanDuaBoxSvWidget(
                                                      key: Key(
                                                          'Keyqu9_${svenskaIndex}_of_${svenska.length}'),
                                                      tasbihName:
                                                          svenskaItem.titleSv,
                                                      tasbih:
                                                          svenskaItem.swedish,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          })
                                              .divide(SizedBox(height: 12.0))
                                              .around(SizedBox(height: 12.0)),
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
            ].divide(SizedBox(height: 20.0)).addToStart(SizedBox(
                height: FlutterFlowTheme.of(context).designToken.spacing.xxl)),
          ),
        ),
      ),
    );
  }
}
