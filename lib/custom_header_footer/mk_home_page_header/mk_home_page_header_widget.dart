import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mk_home_page_header_model.dart';
export 'mk_home_page_header_model.dart';

class MkHomePageHeaderWidget extends StatefulWidget {
  const MkHomePageHeaderWidget({
    super.key,
    required this.pageName,
  });

  final String? pageName;

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
          children: [
            Text(
              valueOrDefault<String>(
                widget.pageName,
                'Name',
              ),
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    font: GoogleFonts.plusJakartaSans(
                      fontWeight:
                          FlutterFlowTheme.of(context).titleMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).titleMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).titleMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).titleMedium.fontStyle,
                  ),
            ),
          ].divide(SizedBox(width: 20.0)),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.share_outlined,
              color: FlutterFlowTheme.of(context).black,
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
                color: FlutterFlowTheme.of(context).black,
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
                FFIcons.kmenu,
                color: FlutterFlowTheme.of(context).black,
                size: 24.0,
              ),
            ),
          ].divide(SizedBox(width: 10.0)),
        ),
      ],
    );
  }
}
