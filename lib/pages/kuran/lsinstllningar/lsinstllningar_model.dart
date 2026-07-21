import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kuran/lsinstllningar_component/lsinstllningar_component_widget.dart';
import 'lsinstllningar_widget.dart' show LsinstllningarWidget;
import 'package:flutter/material.dart';

class LsinstllningarModel extends FlutterFlowModel<LsinstllningarWidget> {
  ///  Local state fields for this component.

  String direction = 'portrait';

  ///  State fields for stateful widgets in this component.

  // Model for LsinstllningarComponent component.
  late LsinstllningarComponentModel lsinstllningarComponentModel1;
  // Model for LsinstllningarComponent component.
  late LsinstllningarComponentModel lsinstllningarComponentModel2;

  @override
  void initState(BuildContext context) {
    lsinstllningarComponentModel1 =
        createModel(context, () => LsinstllningarComponentModel());
    lsinstllningarComponentModel2 =
        createModel(context, () => LsinstllningarComponentModel());
  }

  @override
  void dispose() {
    lsinstllningarComponentModel1.dispose();
    lsinstllningarComponentModel2.dispose();
  }
}
