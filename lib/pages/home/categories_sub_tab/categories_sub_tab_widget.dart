import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'categories_sub_tab_model.dart';
export 'categories_sub_tab_model.dart';

class CategoriesSubTabWidget extends StatefulWidget {
  const CategoriesSubTabWidget({
    super.key,
    required this.icon,
    String? catogeryName,
    this.image,
  }) : this.catogeryName = catogeryName ?? 'Catogery';

  final Widget? icon;
  final String catogeryName;
  final String? image;

  @override
  State<CategoriesSubTabWidget> createState() => _CategoriesSubTabWidgetState();
}

class _CategoriesSubTabWidgetState extends State<CategoriesSubTabWidget> {
  late CategoriesSubTabModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CategoriesSubTabModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 102.0,
      height: 76.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.sm),
        border: Border.all(
          color: Color(0xFFF0F0F0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon!,
          Text(
            widget.catogeryName,
            style: FlutterFlowTheme.of(context).youtubeVideoTitle.override(
                  font: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontStyle: FlutterFlowTheme.of(context)
                        .youtubeVideoTitle
                        .fontStyle,
                  ),
                  color: Colors.black,
                  fontSize: 12.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).youtubeVideoTitle.fontStyle,
                ),
          ),
        ].divide(SizedBox(height: 5.0)),
      ),
    );
  }
}
