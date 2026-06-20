import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_pages/setting_page/bnetidsnotiser_with_switch/bnetidsnotiser_with_switch_widget.dart';
import 'bnetidsnotiser_copyy_widget.dart' show BnetidsnotiserCopyyWidget;
import 'package:flutter/material.dart';

class BnetidsnotiserCopyyModel
    extends FlutterFlowModel<BnetidsnotiserCopyyWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Fajr.
  late BnetidsnotiserWithSwitchModel fajrModel1;
  // Model for Fajr.
  late BnetidsnotiserWithSwitchModel fajrModel2;
  // Model for Fajr.
  late BnetidsnotiserWithSwitchModel fajrModel3;
  // Model for Fajr.
  late BnetidsnotiserWithSwitchModel fajrModel4;
  // Model for Fajr.
  late BnetidsnotiserWithSwitchModel fajrModel5;

  @override
  void initState(BuildContext context) {
    fajrModel1 = createModel(context, () => BnetidsnotiserWithSwitchModel());
    fajrModel2 = createModel(context, () => BnetidsnotiserWithSwitchModel());
    fajrModel3 = createModel(context, () => BnetidsnotiserWithSwitchModel());
    fajrModel4 = createModel(context, () => BnetidsnotiserWithSwitchModel());
    fajrModel5 = createModel(context, () => BnetidsnotiserWithSwitchModel());
  }

  @override
  void dispose() {
    fajrModel1.dispose();
    fajrModel2.dispose();
    fajrModel3.dispose();
    fajrModel4.dispose();
    fajrModel5.dispose();
  }
}
