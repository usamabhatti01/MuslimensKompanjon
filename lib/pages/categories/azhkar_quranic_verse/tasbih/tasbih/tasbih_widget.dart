import '/backend/schema/enums/enums.dart';
import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasbih_model.dart';
export 'tasbih_model.dart';

class TasbihWidget extends StatefulWidget {
  const TasbihWidget({
    super.key,
    required this.adkar,
  });

  final String? adkar;

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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                FlutterFlowTheme.of(context).designToken.spacing.md,
                FlutterFlowTheme.of(context).designToken.spacing.sm,
                FlutterFlowTheme.of(context).designToken.spacing.md,
                0.0),
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
                        context.pushNamed(AdhkarWidget.routeName);
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: FFAppConstants.iconSize.toDouble(),
                      ),
                    ),
                    Expanded(
                      child: wrapWithModel(
                        model: _model.adhkarHeaderModel,
                        updateCallback: () => safeSetState(() {}),
                        child: AdhkarHeaderWidget(
                          pageName: widget.adkar!,
                          heptic: true,
                          textSize: true,
                          audio: false,
                          initialValue: FFAppState().tasbihSetting,
                          fontType: Font.tasbih.name,
                        ),
                      ),
                    ),
                  ].divide(SizedBox(
                      width:
                          FlutterFlowTheme.of(context).designToken.spacing.sm)),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          child: custom_widgets.TasbihPageView(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 1.0,
                            tasbihList: FFAppState().tasbihList,
                          ),
                        ),
                      ),
                    ],
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
