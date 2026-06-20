import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/mornng_and_evebing_adhkar/adhkar_component/adhkar_component_widget.dart';
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

  // Model for adhkarComponent component.
  late AdhkarComponentModel adhkarComponentModel1;
  // Model for adhkarComponent component.
  late AdhkarComponentModel adhkarComponentModel2;

  @override
  void initState(BuildContext context) {
    adhkarHeaderModel = createModel(context, () => AdhkarHeaderModel());
    adhkarComponentModel1 = createModel(context, () => AdhkarComponentModel());
    adhkarComponentModel2 = createModel(context, () => AdhkarComponentModel());
  }

  @override
  void dispose() {
    adhkarHeaderModel.dispose();
    tabBarController?.dispose();
    adhkarComponentModel1.dispose();
    adhkarComponentModel2.dispose();
  }
}
