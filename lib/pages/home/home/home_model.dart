import '/backend/schema/structs/index.dart';
import '/custom_header_footer/page_footer/page_footer_widget.dart';
import '/custom_header_footer/section_header/section_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - loadCitiesFromAsset] action in Home widget.
  List<CityRecordStruct>? cityResult;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Model for SectionHeader component.
  late SectionHeaderModel sectionHeaderModel1;
  // Model for SectionHeader component.
  late SectionHeaderModel sectionHeaderModel2;
  // Model for pageFooter component.
  late PageFooterModel pageFooterModel;

  @override
  void initState(BuildContext context) {
    sectionHeaderModel1 = createModel(context, () => SectionHeaderModel());
    sectionHeaderModel2 = createModel(context, () => SectionHeaderModel());
    pageFooterModel = createModel(context, () => PageFooterModel());
  }

  @override
  void dispose() {
    sectionHeaderModel1.dispose();
    sectionHeaderModel2.dispose();
    pageFooterModel.dispose();
  }
}
