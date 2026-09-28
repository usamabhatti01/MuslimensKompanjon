import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/bottom_sheet_icon/bottom_sheet_icon_widget.dart';
import 'fljoss_dialogue_box_widget.dart' show FljossDialogueBoxWidget;
import 'package:flutter/material.dart';

class FljossDialogueBoxModel extends FlutterFlowModel<FljossDialogueBoxWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for bottomSheetIcon component.
  late BottomSheetIconModel bottomSheetIconModel;

  @override
  void initState(BuildContext context) {
    bottomSheetIconModel = createModel(context, () => BottomSheetIconModel());
  }

  @override
  void dispose() {
    bottomSheetIconModel.dispose();
  }
}
