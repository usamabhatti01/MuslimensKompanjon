import '/flutter_flow/flutter_flow_util.dart';
import '/pages/on_boarding/prayer_notification/prayer_notification_widget.dart';
import '/index.dart';
import 'on_boarding04_widget.dart' show OnBoarding04Widget;
import 'package:flutter/material.dart';

class OnBoarding04Model extends FlutterFlowModel<OnBoarding04Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for Fazr.
  late PrayerNotificationModel fazrModel;
  // Model for Shuruq.
  late PrayerNotificationModel shuruqModel;
  // Model for Doht.
  late PrayerNotificationModel dohtModel;
  // Model for Asr.
  late PrayerNotificationModel asrModel;
  // Model for Maghrib.
  late PrayerNotificationModel maghribModel;
  // Model for Isha.
  late PrayerNotificationModel ishaModel;

  @override
  void initState(BuildContext context) {
    fazrModel = createModel(context, () => PrayerNotificationModel());
    shuruqModel = createModel(context, () => PrayerNotificationModel());
    dohtModel = createModel(context, () => PrayerNotificationModel());
    asrModel = createModel(context, () => PrayerNotificationModel());
    maghribModel = createModel(context, () => PrayerNotificationModel());
    ishaModel = createModel(context, () => PrayerNotificationModel());
  }

  @override
  void dispose() {
    fazrModel.dispose();
    shuruqModel.dispose();
    dohtModel.dispose();
    asrModel.dispose();
    maghribModel.dispose();
    ishaModel.dispose();
  }
}
