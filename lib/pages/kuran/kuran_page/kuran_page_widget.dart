import '/backend/schema/enums/enums.dart';
import '/custom_header_footer/koran_page_sub_header/koran_page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kuran/english_value/english_value_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'kuran_page_model.dart';
export 'kuran_page_model.dart';

class KuranPageWidget extends StatefulWidget {
  const KuranPageWidget({
    super.key,
    required this.id,
    required this.type,
    this.ayat,
  });

  final int? id;
  final String? type;
  final int? ayat;

  static String routeName = 'kuranPage';
  static String routePath = '/kuranPage';

  @override
  State<KuranPageWidget> createState() => _KuranPageWidgetState();
}

class _KuranPageWidgetState extends State<KuranPageWidget> {
  late KuranPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KuranPageModel());

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
        backgroundColor: FlutterFlowTheme.of(context).quranBg,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).quranBg,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        FlutterFlowTheme.of(context).designToken.spacing.md,
                        0.0,
                        FlutterFlowTheme.of(context).designToken.spacing.md,
                        FlutterFlowTheme.of(context).designToken.spacing.md),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(KuranHomeWidget.routeName);
                          },
                          child: Icon(
                            Icons.chevron_left,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                        ),
                        Expanded(
                          child: wrapWithModel(
                            model: _model.koranPageSubHeaderModel,
                            updateCallback: () => safeSetState(() {}),
                            child: KoranPageSubHeaderWidget(
                              pageName: 'Koran',
                            ),
                          ),
                        ),
                      ].divide(SizedBox(
                          width: FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .sm)),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Builder(
                  builder: (context) {
                    final surahsOrjuzs = (widget.type == Quran.sura.name
                            ? FFAppState().surahsList
                            : FFAppState().juzList)
                        .toList();

                    return Container(
                      width: double.infinity,
                      height: 500.0,
                      child: PageView.builder(
                        controller: _model.pageViewController ??=
                            PageController(
                                initialPage: max(
                                    0,
                                    min(
                                        valueOrDefault<int>(
                                          (widget.id!) - 1,
                                          0,
                                        ),
                                        surahsOrjuzs.length - 1))),
                        scrollDirection: Axis.horizontal,
                        itemCount: surahsOrjuzs.length,
                        itemBuilder: (context, surahsOrjuzsIndex) {
                          final surahsOrjuzsItem =
                              surahsOrjuzs[surahsOrjuzsIndex];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              EnglishValueWidget(
                                key: Key(
                                    'Key883_${surahsOrjuzsIndex}_of_${surahsOrjuzs.length}'),
                                englishValue: surahsOrjuzsItem.englishName,
                                width: 300.0,
                                height: 40.0,
                                fontSize: 12,
                                id: surahsOrjuzsItem.number,
                                swValue: surahsOrjuzsItem.swedishName,
                              ),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 1.0,
                                  child: custom_widgets.QuranPageView(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
                                    ayahsList: widget.type == Quran.sura.name
                                        ? FFAppState()
                                            .ayahsList
                                            .where((e) =>
                                                e.surah ==
                                                surahsOrjuzsItem.number)
                                            .toList()
                                            .sortedList(
                                                keyOf: (e) => e.ayah,
                                                desc: false)
                                        : FFAppState()
                                            .ayahsList
                                            .where((e) =>
                                                e.juz ==
                                                surahsOrjuzsItem.number)
                                            .toList()
                                            .sortedList(
                                                keyOf: (e) => e.ayah,
                                                desc: false),
                                    currentAyat: widget.ayat,
                                  ),
                                ),
                              ),
                            ]
                                .divide(SizedBox(height: 20.0))
                                .around(SizedBox(height: 20.0)),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ].addToStart(SizedBox(
              height: FlutterFlowTheme.of(context).designToken.spacing.xxxl)),
        ),
      ),
    );
  }
}
