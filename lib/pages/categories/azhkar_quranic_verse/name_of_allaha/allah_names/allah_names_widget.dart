import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/name_of_allaha/name_box/name_box_widget.dart';
import '/pages/categories/azhkar_quranic_verse/name_of_allaha/name_meaning_popup/name_meaning_popup_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'allah_names_model.dart';
export 'allah_names_model.dart';

class AllahNamesWidget extends StatefulWidget {
  const AllahNamesWidget({
    super.key,
    required this.adkar,
  });

  final String? adkar;

  static String routeName = 'AllahNames';
  static String routePath = '/allahNames';

  @override
  State<AllahNamesWidget> createState() => _AllahNamesWidgetState();
}

class _AllahNamesWidgetState extends State<AllahNamesWidget>
    with TickerProviderStateMixin {
  late AllahNamesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllahNamesModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              wrapWithModel(
                model: _model.adhkarHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: AdhkarHeaderWidget(
                  pageName: widget.adkar!,
                ),
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
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 110.0,
                                        child: custom_widgets.SimpleAudioPlayer(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 110.0,
                                          audioUrl:
                                              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              '(180:7)',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .ayatNumber
                                                  .override(
                                                    font: GoogleFonts.manrope(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .ayatNumber
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .ayatNumber
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .black,
                                                    fontSize: 11.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .ayatNumber
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .ayatNumber
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Text(
                                              'وَلِلَّهِ الْأَسْمَاءُ الْحُسْنَىٰ فَادْعُوهُ بِهَا',
                                              textAlign: TextAlign.center,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .arabiTitle
                                                  .override(
                                                    fontFamily: 'arabic',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    fontSize: 22.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Builder(
                                          builder: (context) {
                                            final myNamesList = getJsonField(
                                              FFAppState().namesList,
                                              r'''$.names''',
                                            ).toList();

                                            return GridView.builder(
                                              padding: EdgeInsets.zero,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                                childAspectRatio: 1.0,
                                              ),
                                              scrollDirection: Axis.vertical,
                                              itemCount: myNamesList.length,
                                              itemBuilder:
                                                  (context, myNamesListIndex) {
                                                final myNamesListItem =
                                                    myNamesList[
                                                        myNamesListIndex];
                                                return Builder(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
                                                          return Dialog(
                                                            elevation: 0,
                                                            insetPadding:
                                                                EdgeInsets.zero,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            alignment: AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                            child: WebViewAware(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          dialogContext)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child:
                                                                    NameMeaningPopupWidget(
                                                                  popupNameArabic:
                                                                      getJsonField(
                                                                    myNamesListItem,
                                                                    r'''$.arabic''',
                                                                  ).toString(),
                                                                  popupNameEnglish:
                                                                      getJsonField(
                                                                    myNamesListItem,
                                                                    r'''$.english''',
                                                                  ).toString(),
                                                                  popupMeaningEn:
                                                                      valueOrDefault<
                                                                          String>(
                                                                    getJsonField(
                                                                      myNamesListItem,
                                                                      r'''$.meaning_en''',
                                                                    )?.toString(),
                                                                    '.meaning_en',
                                                                  ),
                                                                  popupMeaningAr:
                                                                      getJsonField(
                                                                    myNamesListItem,
                                                                    r'''$.meaning_ar''',
                                                                  ).toString(),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: NameBoxWidget(
                                                      key: Key(
                                                          'Keyxcc_${myNamesListIndex}_of_${myNamesList.length}'),
                                                      arabicName: getJsonField(
                                                        myNamesListItem,
                                                        r'''$.arabic''',
                                                      ).toString(),
                                                      engishName: getJsonField(
                                                        myNamesListItem,
                                                        r'''$.english''',
                                                      ).toString(),
                                                      nameId: getJsonField(
                                                        myNamesListItem,
                                                        r'''$.id''',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 10.0)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 120.0,
                                        child: custom_widgets.SimpleAudioPlayer(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 120.0,
                                          audioUrl:
                                              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                ' Guds är fullkomlighetens sköna namn; anropa Honom alltså med dessa (7:180)',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .svenskaBody
                                                    .override(
                                                      font: GoogleFonts.manrope(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .svenskaBody
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .black,
                                                      fontSize: 14.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .svenskaBody
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 5.0)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Builder(
                                          builder: (context) {
                                            final myNamesList = getJsonField(
                                              FFAppState().namesList,
                                              r'''$.names''',
                                            ).toList();

                                            return GridView.builder(
                                              padding: EdgeInsets.zero,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: () {
                                                  if (MediaQuery.sizeOf(context)
                                                          .width <
                                                      kBreakpointSmall) {
                                                    return 3;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointMedium) {
                                                    return 3;
                                                  } else if (MediaQuery.sizeOf(
                                                              context)
                                                          .width <
                                                      kBreakpointLarge) {
                                                    return 4;
                                                  } else {
                                                    return 8;
                                                  }
                                                }(),
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                                childAspectRatio: 1.0,
                                              ),
                                              scrollDirection: Axis.vertical,
                                              itemCount: myNamesList.length,
                                              itemBuilder:
                                                  (context, myNamesListIndex) {
                                                final myNamesListItem =
                                                    myNamesList[
                                                        myNamesListIndex];
                                                return Builder(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
                                                          return Dialog(
                                                            elevation: 0,
                                                            insetPadding:
                                                                EdgeInsets.zero,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            alignment: AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                            child: WebViewAware(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          dialogContext)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child:
                                                                    NameMeaningPopupWidget(
                                                                  popupNameArabic:
                                                                      getJsonField(
                                                                    myNamesListItem,
                                                                    r'''$.arabic''',
                                                                  ).toString(),
                                                                  popupNameEnglish:
                                                                      getJsonField(
                                                                    myNamesListItem,
                                                                    r'''$.english''',
                                                                  ).toString(),
                                                                  popupMeaningEn:
                                                                      valueOrDefault<
                                                                          String>(
                                                                    getJsonField(
                                                                      myNamesListItem,
                                                                      r'''$.meaning_en''',
                                                                    )?.toString(),
                                                                    '.meaning_en',
                                                                  ),
                                                                  popupMeaningAr:
                                                                      getJsonField(
                                                                    myNamesListItem,
                                                                    r'''$.meaning_ar''',
                                                                  ).toString(),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: NameBoxWidget(
                                                      key: Key(
                                                          'Keyv02_${myNamesListIndex}_of_${myNamesList.length}'),
                                                      arabicName: getJsonField(
                                                        myNamesListItem,
                                                        r'''$.arabic''',
                                                      ).toString(),
                                                      engishName: getJsonField(
                                                        myNamesListItem,
                                                        r'''$.english''',
                                                      ).toString(),
                                                      nameId: getJsonField(
                                                        myNamesListItem,
                                                        r'''$.id''',
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 10.0)),
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
