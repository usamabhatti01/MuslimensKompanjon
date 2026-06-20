import '/flutter_flow/flutter_flow_util.dart';
import '/pages/setting_pages/setting_page/kontaktaoss_component/kontaktaoss_component_widget.dart';
import 'kontaktaoss_widget.dart' show KontaktaossWidget;
import 'package:flutter/material.dart';

class KontaktaossModel extends FlutterFlowModel<KontaktaossWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for KontaktaossComponent component.
  late KontaktaossComponentModel kontaktaossComponentModel1;
  // Model for KontaktaossComponent component.
  late KontaktaossComponentModel kontaktaossComponentModel2;
  // Model for KontaktaossComponent component.
  late KontaktaossComponentModel kontaktaossComponentModel3;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;

  @override
  void initState(BuildContext context) {
    kontaktaossComponentModel1 =
        createModel(context, () => KontaktaossComponentModel());
    kontaktaossComponentModel2 =
        createModel(context, () => KontaktaossComponentModel());
    kontaktaossComponentModel3 =
        createModel(context, () => KontaktaossComponentModel());
  }

  @override
  void dispose() {
    kontaktaossComponentModel1.dispose();
    kontaktaossComponentModel2.dispose();
    kontaktaossComponentModel3.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();
  }
}
