import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'namaz_name_model.dart';
export 'namaz_name_model.dart';

class NamazNameWidget extends StatefulWidget {
  const NamazNameWidget({
    super.key,
    required this.name,
  });

  final String? name;

  @override
  State<NamazNameWidget> createState() => _NamazNameWidgetState();
}

class _NamazNameWidgetState extends State<NamazNameWidget> {
  late NamazNameModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NamazNameModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      valueOrDefault<String>(
        widget.name,
        'EmptyString',
      ),
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            font: GoogleFonts.manrope(
              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
            ),
            letterSpacing: 0.0,
            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
          ),
    );
  }
}
