import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/about_islam/islamic_details_page/islamic_details_page_widget.dart';
import 'package:flutter/material.dart';
import 'about_islam_details_page_model.dart';
export 'about_islam_details_page_model.dart';

class AboutIslamDetailsPageWidget extends StatefulWidget {
  const AboutIslamDetailsPageWidget({
    super.key,
    required this.tabData,
  });

  final dynamic tabData;

  static String routeName = 'AboutIslamDetailsPage';
  static String routePath = '/aboutIslamDetailsPage';

  @override
  State<AboutIslamDetailsPageWidget> createState() =>
      _AboutIslamDetailsPageWidgetState();
}

class _AboutIslamDetailsPageWidgetState
    extends State<AboutIslamDetailsPageWidget> {
  late AboutIslamDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutIslamDetailsPageModel());

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
          child: wrapWithModel(
            model: _model.islamicDetailsPageModel,
            updateCallback: () => safeSetState(() {}),
            child: IslamicDetailsPageWidget(
              pageHeading: getJsonField(
                widget.tabData,
                r'''$.pageHeading''',
              ).toString(),
              imagePath: getJsonField(
                widget.tabData,
                r'''$.imagePath''',
              ).toString(),
              audioPath: getJsonField(
                widget.tabData,
                r'''$.audioPath''',
              ).toString(),
              contentBody: getJsonField(
                widget.tabData,
                r'''$.contentBody''',
              ).toString(),
              contentBody2: getJsonField(
                widget.tabData,
                r'''$.contentBody2''',
              ).toString(),
              contentBody3: getJsonField(
                widget.tabData,
                r'''$.contentBody3''',
              ).toString(),
              pageName: getJsonField(
                widget.tabData,
                r'''$.title''',
              ).toString(),
            ),
          ),
        ),
      ),
    );
  }
}
