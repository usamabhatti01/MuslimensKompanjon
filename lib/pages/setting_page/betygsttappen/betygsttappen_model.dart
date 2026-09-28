import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_page/bottom_sheet_icon/bottom_sheet_icon_widget.dart';
import 'betygsttappen_widget.dart' show BetygsttappenWidget;
import 'package:flutter/material.dart';

class BetygsttappenModel extends FlutterFlowModel<BetygsttappenWidget> {
  ///  Local state fields for this component.

  bool fav = true;

  ///  State fields for stateful widgets in this component.

  // Model for bottomSheetIcon component.
  late BottomSheetIconModel bottomSheetIconModel;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    bottomSheetIconModel = createModel(context, () => BottomSheetIconModel());
  }

  @override
  void dispose() {
    bottomSheetIconModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
