import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/bottom_sheet_icon/bottom_sheet_icon_widget.dart';
import '/pages/setting_page/tema_component/tema_component_widget.dart';
import '/pages/setting_page/tema_component_image/tema_component_image_widget.dart';
import 'adhanljud_widget.dart' show AdhanljudWidget;
import 'package:flutter/material.dart';

class AdhanljudModel extends FlutterFlowModel<AdhanljudWidget> {
  ///  Local state fields for this component.

  String selectedCard = 'Vibration';

  ///  State fields for stateful widgets in this component.

  // Model for bottomSheetIcon component.
  late BottomSheetIconModel bottomSheetIconModel;
  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel1;
  // Model for TemaComponent component.
  late TemaComponentModel temaComponentModel2;
  // Model for TemaComponentImage component.
  late TemaComponentImageModel temaComponentImageModel1;
  // Model for TemaComponentImage component.
  late TemaComponentImageModel temaComponentImageModel2;
  // Model for TemaComponentImage component.
  late TemaComponentImageModel temaComponentImageModel3;
  // Model for TemaComponentImage component.
  late TemaComponentImageModel temaComponentImageModel4;
  // Stores action output result for [Custom Action - testNotifications] action in Button widget.
  String? result;

  @override
  void initState(BuildContext context) {
    bottomSheetIconModel = createModel(context, () => BottomSheetIconModel());
    temaComponentModel1 = createModel(context, () => TemaComponentModel());
    temaComponentModel2 = createModel(context, () => TemaComponentModel());
    temaComponentImageModel1 =
        createModel(context, () => TemaComponentImageModel());
    temaComponentImageModel2 =
        createModel(context, () => TemaComponentImageModel());
    temaComponentImageModel3 =
        createModel(context, () => TemaComponentImageModel());
    temaComponentImageModel4 =
        createModel(context, () => TemaComponentImageModel());
  }

  @override
  void dispose() {
    bottomSheetIconModel.dispose();
    temaComponentModel1.dispose();
    temaComponentModel2.dispose();
    temaComponentImageModel1.dispose();
    temaComponentImageModel2.dispose();
    temaComponentImageModel3.dispose();
    temaComponentImageModel4.dispose();
  }
}
