import '/custom_header_footer/page_footer/page_footer_widget.dart';
import '/custom_header_footer/page_sub_header_with_icon/page_sub_header_with_icon_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'akallan_and_dua_widget.dart' show AkallanAndDuaWidget;
import 'package:flutter/material.dart';

class AkallanAndDuaModel extends FlutterFlowModel<AkallanAndDuaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for PageSubHeaderWithIcon component.
  late PageSubHeaderWithIconModel pageSubHeaderWithIconModel;
  // Model for PageFooter component.
  late PageFooterModel pageFooterModel;

  @override
  void initState(BuildContext context) {
    pageSubHeaderWithIconModel =
        createModel(context, () => PageSubHeaderWithIconModel());
    pageFooterModel = createModel(context, () => PageFooterModel());
  }

  @override
  void dispose() {
    pageSubHeaderWithIconModel.dispose();
    pageFooterModel.dispose();
  }
}
