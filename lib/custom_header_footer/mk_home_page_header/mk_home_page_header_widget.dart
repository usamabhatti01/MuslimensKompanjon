import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'mk_home_page_header_model.dart';
export 'mk_home_page_header_model.dart';

class MkHomePageHeaderWidget extends StatefulWidget {
  const MkHomePageHeaderWidget({
    super.key,
    this.pageName,
    required this.searchBtn,
  });

  final String? pageName;
  final bool? searchBtn;

  @override
  State<MkHomePageHeaderWidget> createState() => _MkHomePageHeaderWidgetState();
}

class _MkHomePageHeaderWidgetState extends State<MkHomePageHeaderWidget> {
  late MkHomePageHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MkHomePageHeaderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[].divide(SizedBox(width: 20.0)),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (widget.searchBtn ?? true)
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  FFAppState().searchBar = !(FFAppState().searchBar ?? true);
                  FFAppState().update(() {});
                },
                child: Icon(
                  Icons.search,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            Icon(
              Icons.share_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(
                  SettingWidget.routeName,
                  queryParameters: {
                    'headerNav': serializeParam(
                      true,
                      ParamType.bool,
                    ),
                  }.withoutNulls,
                  extra: <String, dynamic>{
                    '__transition_info__': TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.bottomToTop,
                    ),
                  },
                );
              },
              child: Icon(
                Icons.notifications_none_sharp,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(SettingWidget.routeName);
              },
              child: Icon(
                Icons.more_vert,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
            ),
          ].divide(SizedBox(width: 10.0)),
        ),
      ],
    );
  }
}
