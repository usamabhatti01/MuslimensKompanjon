import '/custom_header_footer/mk_home_page_header/mk_home_page_header_widget.dart';
import '/custom_header_footer/section_header/section_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'm_kkanalen_widget.dart' show MKkanalenWidget;
import 'package:flutter/material.dart';

class MKkanalenModel extends FlutterFlowModel<MKkanalenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for MkHomePageHeader component.
  late MkHomePageHeaderModel mkHomePageHeaderModel;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel1;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel2;
  // Model for SectionHeader.
  late SectionHeaderModel sectionHeaderModel3;

  @override
  void initState(BuildContext context) {
    mkHomePageHeaderModel = createModel(context, () => MkHomePageHeaderModel());
    sectionHeaderModel1 = createModel(context, () => SectionHeaderModel());
    sectionHeaderModel2 = createModel(context, () => SectionHeaderModel());
    sectionHeaderModel3 = createModel(context, () => SectionHeaderModel());
  }

  @override
  void dispose() {
    mkHomePageHeaderModel.dispose();
    sectionHeaderModel1.dispose();
    sectionHeaderModel2.dispose();
    sectionHeaderModel3.dispose();
  }
}
