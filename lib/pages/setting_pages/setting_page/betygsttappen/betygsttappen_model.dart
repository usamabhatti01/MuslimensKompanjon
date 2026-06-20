import '/flutter_flow/flutter_flow_util.dart';
import 'betygsttappen_widget.dart' show BetygsttappenWidget;
import 'package:flutter/material.dart';

class BetygsttappenModel extends FlutterFlowModel<BetygsttappenWidget> {
  ///  Local state fields for this component.

  bool fav = true;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
