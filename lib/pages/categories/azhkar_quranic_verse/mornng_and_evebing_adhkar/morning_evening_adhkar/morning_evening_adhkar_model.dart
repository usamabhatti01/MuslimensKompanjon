import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/mornng_and_evebing_adhkar/adhkar_ar_component/adhkar_ar_component_widget.dart';
import '/pages/categories/azhkar_quranic_verse/mornng_and_evebing_adhkar/adhkar_sv_component/adhkar_sv_component_widget.dart';
import '/index.dart';
import 'morning_evening_adhkar_widget.dart' show MorningEveningAdhkarWidget;
import 'package:flutter/material.dart';

class MorningEveningAdhkarModel
    extends FlutterFlowModel<MorningEveningAdhkarWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AdhkarHeader component.
  late AdhkarHeaderModel adhkarHeaderModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Models for adhkarArComponent dynamic component.
  late FlutterFlowDynamicModels<AdhkarArComponentModel> adhkarArComponentModels;
  // Models for adhkarSvComponent dynamic component.
  late FlutterFlowDynamicModels<AdhkarSvComponentModel> adhkarSvComponentModels;

  @override
  void initState(BuildContext context) {
    adhkarHeaderModel = createModel(context, () => AdhkarHeaderModel());
    adhkarArComponentModels =
        FlutterFlowDynamicModels(() => AdhkarArComponentModel());
    adhkarSvComponentModels =
        FlutterFlowDynamicModels(() => AdhkarSvComponentModel());
  }

  @override
  void dispose() {
    adhkarHeaderModel.dispose();
    tabBarController?.dispose();
    adhkarArComponentModels.dispose();
    adhkarSvComponentModels.dispose();
  }
}
