import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/setting_page/bottom_sheet_icon/bottom_sheet_icon_widget.dart';
import 'plats_widget.dart' show PlatsWidget;
import 'package:flutter/material.dart';

class PlatsModel extends FlutterFlowModel<PlatsWidget> {
  ///  Local state fields for this component.

  bool isLoading = false;

  bool ishistory = false;

  ///  State fields for stateful widgets in this component.

  // Model for bottomSheetIcon component.
  late BottomSheetIconModel bottomSheetIconModel;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - searchCitiesByLatLon] action in Icon widget.
  CityRecordStruct? latlonResult;

  @override
  void initState(BuildContext context) {
    bottomSheetIconModel = createModel(context, () => BottomSheetIconModel());
  }

  @override
  void dispose() {
    bottomSheetIconModel.dispose();
  }
}
