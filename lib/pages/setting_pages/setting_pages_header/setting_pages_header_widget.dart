import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'setting_pages_header_model.dart';
export 'setting_pages_header_model.dart';

class SettingPagesHeaderWidget extends StatefulWidget {
  const SettingPagesHeaderWidget({
    super.key,
    required this.pageName,
  });

  final String? pageName;

  @override
  State<SettingPagesHeaderWidget> createState() =>
      _SettingPagesHeaderWidgetState();
}

class _SettingPagesHeaderWidgetState extends State<SettingPagesHeaderWidget> {
  late SettingPagesHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingPagesHeaderModel());
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
          style: FlutterFlowTheme.of(context).pageTitle.override(
                font: GoogleFonts.manrope(
                  fontWeight: FontWeight.w500,
                  fontStyle: FlutterFlowTheme.of(context).pageTitle.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).black,
                fontSize: 17.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                fontStyle: FlutterFlowTheme.of(context).pageTitle.fontStyle,
              ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              Icons.notifications_none,
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
