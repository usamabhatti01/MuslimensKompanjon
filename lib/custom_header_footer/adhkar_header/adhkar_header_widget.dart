import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'adhkar_header_model.dart';
export 'adhkar_header_model.dart';

class AdhkarHeaderWidget extends StatefulWidget {
  const AdhkarHeaderWidget({
    super.key,
    required this.pageName,
  });

  final String? pageName;

  @override
  State<AdhkarHeaderWidget> createState() => _AdhkarHeaderWidgetState();
}

class _AdhkarHeaderWidgetState extends State<AdhkarHeaderWidget> {
  late AdhkarHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdhkarHeaderModel());
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
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.safePop();
              },
              child: Icon(
                Icons.chevron_left_outlined,
                color: FlutterFlowTheme.of(context).black,
                size: 24.0,
              ),
            ),
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
            Container(
              width: 75.0,
              height: 30.0,
              child: custom_widgets.CustomPowerSwitch(
                width: 75.0,
                height: 30.0,
              ),
            ),
            Icon(
              Icons.notifications_none_sharp,
              color: FlutterFlowTheme.of(context).black,
              size: 24.0,
            ),
            Icon(
              FFIcons.kmenu,
              color: FlutterFlowTheme.of(context).black,
              size: 24.0,
            ),
          ].divide(SizedBox(width: 10.0)),
        ),
      ],
    );
  }
}
