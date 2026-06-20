import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_pages/setting_page/tema_component/tema_component_widget.dart';
import 'adhanljud_widget.dart' show AdhanljudWidget;
import 'package:flutter/material.dart';

class AdhanljudModel extends FlutterFlowModel<AdhanljudWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel1;
  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel2;
  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel3;
  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel4;
  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel5;

  @override
  void initState(BuildContext context) {
    temaComponentModel1 = createModel(context, () => TemaComponentModel());
    temaComponentModel2 = createModel(context, () => TemaComponentModel());
    temaComponentModel3 = createModel(context, () => TemaComponentModel());
    temaComponentModel4 = createModel(context, () => TemaComponentModel());
    temaComponentModel5 = createModel(context, () => TemaComponentModel());
  }

  @override
  void dispose() {
    temaComponentModel1.dispose();
    temaComponentModel2.dispose();
    temaComponentModel3.dispose();
    temaComponentModel4.dispose();
    temaComponentModel5.dispose();
  }
}
