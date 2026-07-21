import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/name_of_allaha/name_arabic_box/name_arabic_box_widget.dart';
import '/pages/categories/azhkar_quranic_verse/name_of_allaha/name_svenska_box/name_svenska_box_widget.dart';
import '/index.dart';
import 'allah_names_widget.dart' show AllahNamesWidget;
import 'package:flutter/material.dart';

class AllahNamesModel extends FlutterFlowModel<AllahNamesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AdhkarHeader component.
  late AdhkarHeaderModel adhkarHeaderModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for NameBox.
  late FlutterFlowDynamicModels<NameArabicBoxModel> nameBoxModels;
  // Models for NameSvenskaBox dynamic component.
  late FlutterFlowDynamicModels<NameSvenskaBoxModel> nameSvenskaBoxModels;

  @override
  void initState(BuildContext context) {
    adhkarHeaderModel = createModel(context, () => AdhkarHeaderModel());
    nameBoxModels = FlutterFlowDynamicModels(() => NameArabicBoxModel());
    nameSvenskaBoxModels =
        FlutterFlowDynamicModels(() => NameSvenskaBoxModel());
  }

  @override
  void dispose() {
    adhkarHeaderModel.dispose();
    tabBarController?.dispose();
    nameBoxModels.dispose();
    nameSvenskaBoxModels.dispose();
  }
}
