import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/akallan_dua/akallan_dua_box_ar/akallan_dua_box_ar_widget.dart';
import '/pages/categories/azhkar_quranic_verse/akallan_dua/akallan_dua_box_sv/akallan_dua_box_sv_widget.dart';
import '/index.dart';
import 'tasbih_widget.dart' show TasbihWidget;
import 'package:flutter/material.dart';

class TasbihModel extends FlutterFlowModel<TasbihWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AdhkarHeader component.
  late AdhkarHeaderModel adhkarHeaderModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for AkallanDuaBoxAr dynamic component.
  late FlutterFlowDynamicModels<AkallanDuaBoxArModel> akallanDuaBoxArModels;
  // Models for AkallanDuaBoxSv dynamic component.
  late FlutterFlowDynamicModels<AkallanDuaBoxSvModel> akallanDuaBoxSvModels;

  @override
  void initState(BuildContext context) {
    adhkarHeaderModel = createModel(context, () => AdhkarHeaderModel());
    akallanDuaBoxArModels =
        FlutterFlowDynamicModels(() => AkallanDuaBoxArModel());
    akallanDuaBoxSvModels =
        FlutterFlowDynamicModels(() => AkallanDuaBoxSvModel());
  }

  @override
  void dispose() {
    adhkarHeaderModel.dispose();
    tabBarController?.dispose();
    akallanDuaBoxArModels.dispose();
    akallanDuaBoxSvModels.dispose();
  }
}
