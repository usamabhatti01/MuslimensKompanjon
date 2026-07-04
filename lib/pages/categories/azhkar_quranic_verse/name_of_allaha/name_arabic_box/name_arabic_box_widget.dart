import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'name_arabic_box_model.dart';
export 'name_arabic_box_model.dart';

class NameArabicBoxWidget extends StatefulWidget {
  const NameArabicBoxWidget({
    super.key,
    required this.allahName,
  });

  final String? allahName;

  @override
  State<NameArabicBoxWidget> createState() => _NameArabicBoxWidgetState();
}

class _NameArabicBoxWidgetState extends State<NameArabicBoxWidget> {
  late NameArabicBoxModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NameArabicBoxModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.md),
        border: Border.all(
          color: FlutterFlowTheme.of(context).containerBg,
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.sm),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tint,
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.all(
                        FlutterFlowTheme.of(context).designToken.spacing.sm),
                    child: AutoSizeText(
                      widget.allahName!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      minFontSize: 12.0,
                      style: FlutterFlowTheme.of(context).arabiTitle.override(
                            fontFamily: 'arabic',
                            color: FlutterFlowTheme.of(context).primary,
                            fontSize: 22.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 2.0)),
          ),
        ),
      ),
    );
  }
}
