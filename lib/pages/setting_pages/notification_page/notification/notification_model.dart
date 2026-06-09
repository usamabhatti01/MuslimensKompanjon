import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/on_boarding/prayer_notification/prayer_notification_widget.dart';
import '/pages/setting_pages/pages_heading_box/pages_heading_box_widget.dart';
import 'notification_widget.dart' show NotificationWidget;
import 'package:flutter/material.dart';

class NotificationModel extends FlutterFlowModel<NotificationWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // Model for PagesHeadingBox component.
  late PagesHeadingBoxModel pagesHeadingBoxModel;
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
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
    pagesHeadingBoxModel = createModel(context, () => PagesHeadingBoxModel());
    fazrModel = createModel(context, () => PrayerNotificationModel());
    shuruqModel = createModel(context, () => PrayerNotificationModel());
    dohtModel = createModel(context, () => PrayerNotificationModel());
    asrModel = createModel(context, () => PrayerNotificationModel());
    maghribModel = createModel(context, () => PrayerNotificationModel());
    ishaModel = createModel(context, () => PrayerNotificationModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    pagesHeadingBoxModel.dispose();
    fazrModel.dispose();
    shuruqModel.dispose();
    dohtModel.dispose();
    asrModel.dispose();
    maghribModel.dispose();
    ishaModel.dispose();
  }
}
