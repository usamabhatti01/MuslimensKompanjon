import '/custom_header_footer/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_pages/setting_page/bnetidsnotiser_without_time/bnetidsnotiser_without_time_widget.dart';
import '/index.dart';
import 'on_boarding04_widget.dart' show OnBoarding04Widget;
import 'package:flutter/material.dart';

class OnBoarding04Model extends FlutterFlowModel<OnBoarding04Widget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeader component.
  late PageSubHeaderModel pageSubHeaderModel;
  // Model for Fajr.
  late BnetidsnotiserWithoutTimeModel fajrModel;
  // Model for Dhohr.
  late BnetidsnotiserWithoutTimeModel dhohrModel;
  // Model for Asr.
  late BnetidsnotiserWithoutTimeModel asrModel;
  // Model for Maghrib.
  late BnetidsnotiserWithoutTimeModel maghribModel;
  // Model for Isha.
  late BnetidsnotiserWithoutTimeModel ishaModel;

  @override
  void initState(BuildContext context) {
    pageSubHeaderModel = createModel(context, () => PageSubHeaderModel());
    fajrModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
    dhohrModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
    asrModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
    maghribModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
    ishaModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
  }

  @override
  void dispose() {
    pageSubHeaderModel.dispose();
    fajrModel.dispose();
    dhohrModel.dispose();
    asrModel.dispose();
    maghribModel.dispose();
    ishaModel.dispose();
  }
}
