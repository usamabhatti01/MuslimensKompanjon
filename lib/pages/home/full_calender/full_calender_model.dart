import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'full_calender_widget.dart' show FullCalenderWidget;
import 'package:flutter/material.dart';

class FullCalenderModel extends FlutterFlowModel<FullCalenderWidget> {
  ///  Local state fields for this page.

  String? month;

  int year = 2026;

  String? city;

  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeaderWithIcon component.
  late PageSubHeaderWithIconModel pageSubHeaderWithIconModel;
  // State field(s) for cityName widget.
  String? cityNameValue;
  FormFieldController<String>? cityNameValueController;
  // State field(s) for year widget.
  int? yearValue;
  FormFieldController<int>? yearValueController;

  @override
  void initState(BuildContext context) {
    pageSubHeaderWithIconModel =
        createModel(context, () => PageSubHeaderWithIconModel());
  }

  @override
  void dispose() {
    pageSubHeaderWithIconModel.dispose();
  }
}
