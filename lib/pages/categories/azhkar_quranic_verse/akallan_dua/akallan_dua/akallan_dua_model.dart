import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'akallan_dua_widget.dart' show AkallanDuaWidget;
import 'package:flutter/material.dart';

class AkallanDuaModel extends FlutterFlowModel<AkallanDuaWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AdhkarHeader component.
  late AdhkarHeaderModel adhkarHeaderModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {
    adhkarHeaderModel = createModel(context, () => AdhkarHeaderModel());
  }

  @override
  void dispose() {
    adhkarHeaderModel.dispose();
    tabBarController?.dispose();
  }
}
