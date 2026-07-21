import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kuran/tillbaka_component/tillbaka_component_widget.dart';
import 'tillbaka_widget.dart' show TillbakaWidget;
import 'package:flutter/material.dart';

class TillbakaModel extends FlutterFlowModel<TillbakaWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for TillbakaComponent component.
  late TillbakaComponentModel tillbakaComponentModel1;
  // Model for TillbakaComponent component.
  late TillbakaComponentModel tillbakaComponentModel2;
  // Model for TillbakaComponent component.
  late TillbakaComponentModel tillbakaComponentModel3;

  @override
  void initState(BuildContext context) {
    tillbakaComponentModel1 =
        createModel(context, () => TillbakaComponentModel());
    tillbakaComponentModel2 =
        createModel(context, () => TillbakaComponentModel());
    tillbakaComponentModel3 =
        createModel(context, () => TillbakaComponentModel());
  }

  @override
  void dispose() {
    tillbakaComponentModel1.dispose();
    tillbakaComponentModel2.dispose();
    tillbakaComponentModel3.dispose();
  }
}
