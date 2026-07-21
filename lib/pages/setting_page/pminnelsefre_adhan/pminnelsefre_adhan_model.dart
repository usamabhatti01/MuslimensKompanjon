import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/pminnelsefre_adhan_component/pminnelsefre_adhan_component_widget.dart';
import 'pminnelsefre_adhan_widget.dart' show PminnelsefreAdhanWidget;
import 'package:flutter/material.dart';

class PminnelsefreAdhanModel extends FlutterFlowModel<PminnelsefreAdhanWidget> {
  ///  Local state fields for this component.

  int selectedCard = 5;

  ///  State fields for stateful widgets in this component.

  // Model for PminnelsefreAdhanComponent component.
  late PminnelsefreAdhanComponentModel pminnelsefreAdhanComponentModel1;
  // Model for PminnelsefreAdhanComponent component.
  late PminnelsefreAdhanComponentModel pminnelsefreAdhanComponentModel2;
  // Model for PminnelsefreAdhanComponent component.
  late PminnelsefreAdhanComponentModel pminnelsefreAdhanComponentModel3;

  @override
  void initState(BuildContext context) {
    pminnelsefreAdhanComponentModel1 =
        createModel(context, () => PminnelsefreAdhanComponentModel());
    pminnelsefreAdhanComponentModel2 =
        createModel(context, () => PminnelsefreAdhanComponentModel());
    pminnelsefreAdhanComponentModel3 =
        createModel(context, () => PminnelsefreAdhanComponentModel());
  }

  @override
  void dispose() {
    pminnelsefreAdhanComponentModel1.dispose();
    pminnelsefreAdhanComponentModel2.dispose();
    pminnelsefreAdhanComponentModel3.dispose();
  }
}
