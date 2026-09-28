import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/setting_page/bottom_sheet_icon/bottom_sheet_icon_widget.dart';
import 'on_boarding03_widget.dart' show OnBoarding03Widget;
import 'package:flutter/material.dart';

class OnBoarding03Model extends FlutterFlowModel<OnBoarding03Widget> {
  ///  State fields for stateful widgets in this component.

  // Model for bottomSheetIcon component.
  late BottomSheetIconModel bottomSheetIconModel;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {
    bottomSheetIconModel = createModel(context, () => BottomSheetIconModel());
  }

  @override
  void dispose() {
    bottomSheetIconModel.dispose();
  }
}
