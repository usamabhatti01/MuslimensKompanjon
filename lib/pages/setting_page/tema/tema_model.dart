import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/tema_component/tema_component_widget.dart';
import 'tema_widget.dart' show TemaWidget;
import 'package:flutter/material.dart';

class TemaModel extends FlutterFlowModel<TemaWidget> {
  ///  Local state fields for this component.

  String selectedCard = 'System';

  ///  State fields for stateful widgets in this component.

  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel1;
  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel2;
  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel3;

  @override
  void initState(BuildContext context) {
    temaComponentModel1 = createModel(context, () => TemaComponentModel());
    temaComponentModel2 = createModel(context, () => TemaComponentModel());
    temaComponentModel3 = createModel(context, () => TemaComponentModel());
  }

  @override
  void dispose() {
    temaComponentModel1.dispose();
    temaComponentModel2.dispose();
    temaComponentModel3.dispose();
  }
}
