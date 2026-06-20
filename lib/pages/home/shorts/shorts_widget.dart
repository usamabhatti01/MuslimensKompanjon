import '/custom_header_footer/page_sub_header/page_sub_header_widget.dart';
import '/extra/search_bar/search_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home/short_card2/short_card2_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'shorts_model.dart';
export 'shorts_model.dart';

class ShortsWidget extends StatefulWidget {
  const ShortsWidget({super.key});

  static String routeName = 'Shorts';
  static String routePath = '/shorts';

  @override
  State<ShortsWidget> createState() => _ShortsWidgetState();
}

class _ShortsWidgetState extends State<ShortsWidget> {
  late ShortsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShortsModel());
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
                FlutterFlowTheme.of(context).designToken.spacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.pageSubHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: PageSubHeaderWidget(
                    pageName: 'Shorts',
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      wrapWithModel(
                        model: _model.searchBarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: SearchBarWidget(
                          hintText: 'Sök shorts...',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context
                                            .pushNamed(ReelsWidget.routeName);
                                      },
                                      child: wrapWithModel(
                                        model: _model.shortCardModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ShortCard2Widget(
                                          imageDesc:
                                              'https://dimg.dreamflow.cloud/v1/image/Grand%20Mosque%20architecture%20with%20white%20marble%20and%20blue%20sky',
                                          title:
                                              'Påminnelse om sabr och tawakkul',
                                          views: '12K visningar',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.shortCardModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ShortCard2Widget(
                                        imageDesc:
                                            'https://dimg.dreamflow.cloud/v1/image/Blue%20Mosque%20dome%20at%20dusk',
                                        title:
                                            '3 viktiga adhkar varje muslim bör..',
                                        views: '18K visningar',
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.shortCardModel3,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ShortCard2Widget(
                                        imageDesc:
                                            'https://dimg.dreamflow.cloud/v1/image/Interior%20of%20a%20mosque%20with%20hanging%20chandeliers',
                                        title: 'Vad betyder Surah Fatiha?',
                                        views: '12K visningar',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.shortCardModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ShortCard2Widget(
                                        imageDesc:
                                            'https://dimg.dreamflow.cloud/v1/image/Istanbul%20skyline%20with%20mosques%20at%20sunset',
                                        title: 'Vikten av Fajr-bönen varje dag',
                                        views: '18K visningar',
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.shortCardModel5,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ShortCard2Widget(
                                        imageDesc:
                                            'https://dimg.dreamflow.cloud/v1/image/Close%20up%20of%20mosque%20ceiling%20calligraphy',
                                        title: 'Dua före sömn',
                                        views: '12K visningar',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: wrapWithModel(
                                      model: _model.shortCardModel6,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ShortCard2Widget(
                                        imageDesc:
                                            'https://dimg.dreamflow.cloud/v1/image/City%20lights%20and%20minarets%20during%20twilight',
                                        title: 'När ska man läsa Ayatul Kursi?',
                                        views: '18K visningar',
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 16.0)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 24.0)),
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
