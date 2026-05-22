import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prayer_notification_model.dart';
export 'prayer_notification_model.dart';

class PrayerNotificationWidget extends StatefulWidget {
  const PrayerNotificationWidget({
    super.key,
    required this.prayerName,
    required this.notificationCheck,
  });

  final String? prayerName;
  final bool? notificationCheck;

  @override
  State<PrayerNotificationWidget> createState() =>
      _PrayerNotificationWidgetState();
}

class _PrayerNotificationWidgetState extends State<PrayerNotificationWidget> {
  late PrayerNotificationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrayerNotificationModel());

    _model.switchValue = widget.notificationCheck!;
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
        Text(
          valueOrDefault<String>(
            widget.prayerName,
            'Fazr',
          ),
          style: FlutterFlowTheme.of(context).titleMedium.override(
                font: GoogleFonts.manrope(
                  fontWeight:
                      FlutterFlowTheme.of(context).titleMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                ),
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
              ),
        ),
        Switch.adaptive(
          value: _model.switchValue!,
          onChanged: (newValue) async {
            safeSetState(() => _model.switchValue = newValue);
          },
          activeColor: FlutterFlowTheme.of(context).primary,
          activeTrackColor: FlutterFlowTheme.of(context).primary,
          inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
          inactiveThumbColor: FlutterFlowTheme.of(context).secondaryBackground,
        ),
      ],
    );
  }
}
