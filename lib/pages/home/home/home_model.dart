import '/backend/schema/structs/index.dart';
import '/custom_header_footer/section_header/section_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  bool isValid = false;

  bool isLoading = false;

  bool isHistory = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - isImageValid] action in Home widget.
  bool? banner;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - searchCitiesByLatLon] action in Icon widget.
  CityRecordStruct? latlonResult;
  // Model for SectionHeader component.
  late SectionHeaderModel sectionHeaderModel;

  @override
  void initState(BuildContext context) {
    sectionHeaderModel = createModel(context, () => SectionHeaderModel());
  }

  @override
  void dispose() {
    sectionHeaderModel.dispose();
  }
}
