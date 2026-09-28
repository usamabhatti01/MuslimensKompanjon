import '/extra/lsinstllningar_component/lsinstllningar_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/bottom_sheet_icon/bottom_sheet_icon_widget.dart';
import 'lsinstllningar_widget.dart' show LsinstllningarWidget;
import 'package:flutter/material.dart';

class LsinstllningarModel extends FlutterFlowModel<LsinstllningarWidget> {
  ///  Local state fields for this component.

  String direction = 'portrait';

  ///  State fields for stateful widgets in this component.

  // Model for bottomSheetIcon component.
  late BottomSheetIconModel bottomSheetIconModel;
  // Model for LsinstllningarComponent component.
  late LsinstllningarComponentModel lsinstllningarComponentModel1;
  // Model for LsinstllningarComponent component.
  late LsinstllningarComponentModel lsinstllningarComponentModel2;

  @override
  void initState(BuildContext context) {
    bottomSheetIconModel = createModel(context, () => BottomSheetIconModel());
    lsinstllningarComponentModel1 =
        createModel(context, () => LsinstllningarComponentModel());
    lsinstllningarComponentModel2 =
        createModel(context, () => LsinstllningarComponentModel());
  }

  @override
  void dispose() {
    bottomSheetIconModel.dispose();
    lsinstllningarComponentModel1.dispose();
    lsinstllningarComponentModel2.dispose();
  }
}
