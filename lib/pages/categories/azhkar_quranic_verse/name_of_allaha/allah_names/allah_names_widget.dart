import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adhkar_all_pages_banner/adhkar_all_pages_banner_widget.dart';
import '/pages/categories/azhkar_quranic_verse/arabic_heading_and_translation/arabic_heading_and_translation_widget.dart';
import '/pages/categories/azhkar_quranic_verse/name_of_allaha/name_box/name_box_widget.dart';
import '/pages/categories/azhkar_quranic_verse/name_of_allaha/name_meaning_popup/name_meaning_popup_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'allah_names_model.dart';
export 'allah_names_model.dart';

class AllahNamesWidget extends StatefulWidget {
  const AllahNamesWidget({super.key});

  static String routeName = 'AllahNames';
  static String routePath = '/allahNames';

  @override
  State<AllahNamesWidget> createState() => _AllahNamesWidgetState();
}

class _AllahNamesWidgetState extends State<AllahNamesWidget> {
  late AllahNamesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AllahNamesModel());
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
                    pageName: 'Allah 99 Names',
                  ),
                ),
                wrapWithModel(
                  model: _model.adhkarAllPagesBannerModel,
                  updateCallback: () => safeSetState(() {}),
                  child: AdhkarAllPagesBannerWidget(
                    pageName: 'Allah 99 Names',
                  ),
                ),
                wrapWithModel(
                  model: _model.arabicHeadingAndTranslationModel,
                  updateCallback: () => safeSetState(() {}),
                  child: ArabicHeadingAndTranslationWidget(
                    heading:
                        'وَلِلَّهِ الْأَسْمَاءُ الْحُسْنَىٰ فَادْعُوهُ بِهَا',
                    translation:
                        'Wa lillaahil Asmaa\'ul Husna fad\'oohu bihaa [1]',
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: () {
                            if (MediaQuery.sizeOf(context).width <
                                kBreakpointSmall) {
                              return 3;
                            } else if (MediaQuery.sizeOf(context).width <
                                kBreakpointMedium) {
                              return 3;
                            } else if (MediaQuery.sizeOf(context).width <
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
                        itemBuilder: (context, myNamesListIndex) {
                          final myNamesListItem = myNamesList[myNamesListIndex];
                          return Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    return Dialog(
                                      elevation: 0,
                                      insetPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      alignment: AlignmentDirectional(0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      child: WebViewAware(
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: NameMeaningPopupWidget(
                                            popupNameArabic: getJsonField(
                                              myNamesListItem,
                                              r'''$.arabic''',
                                            ).toString(),
                                            popupNameEnglish: getJsonField(
                                              myNamesListItem,
                                              r'''$.english''',
                                            ).toString(),
                                            popupMeaningEn:
                                                valueOrDefault<String>(
                                              getJsonField(
                                                myNamesListItem,
                                                r'''$.meaning_en''',
                                              )?.toString(),
                                              '.meaning_en',
                                            ),
                                            popupMeaningAr: getJsonField(
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
                                    'Keya3x_${myNamesListIndex}_of_${myNamesList.length}'),
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
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
