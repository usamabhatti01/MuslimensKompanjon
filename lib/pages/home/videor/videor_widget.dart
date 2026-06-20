import '/custom_header_footer/page_sub_header/page_sub_header_widget.dart';
import '/extra/search_bar/search_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/home/video_item_card/video_item_card_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'videor_model.dart';
export 'videor_model.dart';

class VideorWidget extends StatefulWidget {
  const VideorWidget({super.key});

  static String routeName = 'Videor';
  static String routePath = '/videor';

  @override
  State<VideorWidget> createState() => _VideorWidgetState();
}

class _VideorWidgetState extends State<VideorWidget> {
  late VideorModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VideorModel());
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
                    pageName: 'Videor',
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      wrapWithModel(
                        model: _model.searchBarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: SearchBarWidget(
                          hintText: 'Sök Videor...',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: ListView(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              0,
                              0,
                              50.0,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context
                                      .pushNamed(SenasteLiveWidget.routeName);
                                },
                                child: wrapWithModel(
                                  model: _model.videoItemCardModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: VideoItemCardWidget(
                                    videoDesc:
                                        'https://assets.mixkit.co/videos/529/529-720.mp4',
                                    meta: '98K visningar • 1 vecka sedan',
                                    title:
                                        'Hur man förbättrar sin Salah steg för steg',
                                  ),
                                ),
                              ),
                              wrapWithModel(
                                model: _model.videoItemCardModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: VideoItemCardWidget(
                                  videoDesc:
                                      'https://assets.mixkit.co/videos/529/529-720.mp4',
                                  meta: '23K visningar • 4 dagar sedan',
                                  title: 'Quranlektion för nybörjare – Del 1',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.videoItemCardModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: VideoItemCardWidget(
                                  videoDesc:
                                      'https://assets.mixkit.co/videos/529/529-720.mp4',
                                  meta: '42K visningar • 2 veckor sedan',
                                  title: 'Vikten av Fajr-bönen i vardagen',
                                ),
                              ),
                              wrapWithModel(
                                model: _model.videoItemCardModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: VideoItemCardWidget(
                                  videoDesc:
                                      'https://assets.mixkit.co/videos/529/529-720.mp4',
                                  meta: '15K visningar • 1 månad sedan',
                                  title: 'Dua för inre frid och tacksamhet',
                                ),
                              ),
                            ].divide(SizedBox(height: 20.0)),
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
