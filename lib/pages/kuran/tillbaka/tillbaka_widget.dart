import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kuran/tillbaka_component/tillbaka_component_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'tillbaka_model.dart';
export 'tillbaka_model.dart';

class TillbakaWidget extends StatefulWidget {
  const TillbakaWidget({super.key});

  @override
  State<TillbakaWidget> createState() => _TillbakaWidgetState();
}

class _TillbakaWidgetState extends State<TillbakaWidget> {
  late TillbakaModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TillbakaModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding:
            EdgeInsets.all(FlutterFlowTheme.of(context).designToken.spacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'Innehåll',
                  minFontSize: FFAppConstants.heading.toDouble(),
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.plusJakartaSans(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AutoSizeText(
                  'Visa i läsvyn',
                  minFontSize: FFAppConstants.heading.toDouble(),
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.plusJakartaSans(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                ),
              ],
            ),
            wrapWithModel(
              model: _model.tillbakaComponentModel1,
              updateCallback: () => safeSetState(() {}),
              child: TillbakaComponentWidget(
                label: 'Arabisk text',
                icon: Icon(
                  Icons.rtt_rounded,
                ),
                initialValue: FFAppState().qurantSetting.arActive,
                onSwitchOn: () async {
                  FFAppState().updateQurantSettingStruct(
                    (e) => e..arActive = !e.arActive,
                  );
                  safeSetState(() {});
                },
              ),
            ),
            Divider(
              thickness: 2.0,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            wrapWithModel(
              model: _model.tillbakaComponentModel2,
              updateCallback: () => safeSetState(() {}),
              child: TillbakaComponentWidget(
                label: 'Translitterering',
                icon: Icon(
                  Icons.translate,
                ),
                initialValue: FFAppState().qurantSetting.enActive,
                onSwitchOn: () async {
                  FFAppState().updateQurantSettingStruct(
                    (e) => e..enActive = !e.enActive,
                  );
                  safeSetState(() {});
                },
              ),
            ),
            Divider(
              thickness: 2.0,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            wrapWithModel(
              model: _model.tillbakaComponentModel3,
              updateCallback: () => safeSetState(() {}),
              child: TillbakaComponentWidget(
                label: 'Översättning',
                icon: Icon(
                  Icons.g_translate,
                ),
                initialValue: FFAppState().qurantSetting.swActive,
                onSwitchOn: () async {
                  FFAppState().updateQurantSettingStruct(
                    (e) => e..swActive = !e.swActive,
                  );
                  safeSetState(() {});
                },
              ),
            ),
            Divider(
              thickness: 2.0,
              color: FlutterFlowTheme.of(context).alternate,
            ),
            Container(
              height: 30.0,
              decoration: BoxDecoration(),
            ),
          ],
        ),
      ),
    );
  }
}
