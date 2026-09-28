import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/bnetidsnotiser_without_time/bnetidsnotiser_without_time_widget.dart';
import '/pages/setting_page/bottom_sheet_icon/bottom_sheet_icon_widget.dart';
import 'bnetidsnotiser_widget.dart' show BnetidsnotiserWidget;
import 'package:flutter/material.dart';

class BnetidsnotiserModel extends FlutterFlowModel<BnetidsnotiserWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for bottomSheetIcon component.
  late BottomSheetIconModel bottomSheetIconModel;
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
    bottomSheetIconModel = createModel(context, () => BottomSheetIconModel());
    fajrModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
    dhohrModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
    asrModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
    maghribModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
    ishaModel = createModel(context, () => BnetidsnotiserWithoutTimeModel());
  }

  @override
  void dispose() {
    bottomSheetIconModel.dispose();
    fajrModel.dispose();
    dhohrModel.dispose();
    asrModel.dispose();
    maghribModel.dispose();
    ishaModel.dispose();
  }
}
