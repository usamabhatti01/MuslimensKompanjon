import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'on_boarding03_widget.dart' show OnBoarding03Widget;
import 'package:flutter/material.dart';

class OnBoarding03Model extends FlutterFlowModel<OnBoarding03Widget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - loadCitiesFromAsset] action in OnBoarding_03 widget.
  List<CityRecordStruct>? allResult;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - loadCitiesFromAsset] action in Icon widget.
  List<CityRecordStruct>? singleCity;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
