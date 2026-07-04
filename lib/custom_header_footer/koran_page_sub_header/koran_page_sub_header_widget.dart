import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'koran_page_sub_header_model.dart';
export 'koran_page_sub_header_model.dart';

class KoranPageSubHeaderWidget extends StatefulWidget {
  const KoranPageSubHeaderWidget({
    super.key,
    required this.pageName,
  });

  final String? pageName;

  @override
  State<KoranPageSubHeaderWidget> createState() =>
      _KoranPageSubHeaderWidgetState();
}

class _KoranPageSubHeaderWidgetState extends State<KoranPageSubHeaderWidget> {
  late KoranPageSubHeaderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KoranPageSubHeaderModel());

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
            Icon(
              Icons.search,
              color: FlutterFlowTheme.of(context).black,
              size: 24.0,
            ),
            Icon(
              Icons.menu_book,
              color: FlutterFlowTheme.of(context).black,
              size: 24.0,
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
                Icons.settings_sharp,
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
              child: FaIcon(
                FontAwesomeIcons.moon,
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
