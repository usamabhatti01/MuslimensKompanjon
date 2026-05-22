import '/components/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adhkar_all_pages_banner/adhkar_all_pages_banner_widget.dart';
import '/pages/categories/azhkar_quranic_verse/arabic_heading_and_translation/arabic_heading_and_translation_widget.dart';
import '/pages/categories/azhkar_quranic_verse/tasbih/tasbih_box/tasbih_box_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasbih_model.dart';
export 'tasbih_model.dart';

class TasbihWidget extends StatefulWidget {
  const TasbihWidget({super.key});

  static String routeName = 'Tasbih';
  static String routePath = '/tasbih';

  @override
  State<TasbihWidget> createState() => _TasbihWidgetState();
}

class _TasbihWidgetState extends State<TasbihWidget> {
  late TasbihModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TasbihModel());

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.pageSubHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: PageSubHeaderWidget(
                  pageName: FFLocalizations.of(context).getText(
                    '68pvqi4h' /* Tasbih */,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                    FlutterFlowTheme.of(context).designToken.spacing.md),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      wrapWithModel(
                        model: _model.adhkarAllPagesBannerModel,
                        updateCallback: () => safeSetState(() {}),
                        child: AdhkarAllPagesBannerWidget(
                          pageName: FFLocalizations.of(context).getText(
                            '8ebjar5s' /* Tasbih */,
                          ),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.arabicHeadingAndTranslationModel,
                        updateCallback: () => safeSetState(() {}),
                        child: ArabicHeadingAndTranslationWidget(
                          heading:
                              'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ',
                          translation:
                              'Translation: Surely, in the remembrance of Allah do hearts find peace.',
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          final tasbihItem = getJsonField(
                            FFAppState().tasbihList,
                            r'''$''',
                          ).toList();

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: tasbihItem.length,
                            separatorBuilder: (_, __) => SizedBox(height: 20.0),
                            itemBuilder: (context, tasbihItemIndex) {
                              final tasbihItemItem =
                                  tasbihItem[tasbihItemIndex];
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  FFAppState().currentTasbihId = getJsonField(
                                    tasbihItemItem,
                                    r'''$.id''',
                                  );
                                  safeSetState(() {});

                                  context.pushNamed(
                                      TashbihCounterWidget.routeName);
                                },
                                child: TasbihBoxWidget(
                                  key: Key(
                                      'Keyypw_${tasbihItemIndex}_of_${tasbihItem.length}'),
                                  tasbihName: getJsonField(
                                    tasbihItemItem,
                                    r'''$.tasbihName''',
                                  ).toString(),
                                  tasbih: getJsonField(
                                    tasbihItemItem,
                                    r'''$.tasbih''',
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
            ],
          ),
        ),
      ),
    );
  }
}
