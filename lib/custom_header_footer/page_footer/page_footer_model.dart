import '/custom_header_footer/footer_component/footer_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'page_footer_widget.dart' show PageFooterWidget;
import 'package:flutter/material.dart';

class PageFooterModel extends FlutterFlowModel<PageFooterWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Hem.
  late FooterComponentModel hemModel;
  // Model for Koran.
  late FooterComponentModel koranModel;
  // Model for Adhkaricon.
  late FooterComponentModel adhkariconModel;
  // Model for Qibla.
  late FooterComponentModel qiblaModel;
  // Model for Mer.
  late FooterComponentModel merModel;

  @override
  void initState(BuildContext context) {
    hemModel = createModel(context, () => FooterComponentModel());
    koranModel = createModel(context, () => FooterComponentModel());
    adhkariconModel = createModel(context, () => FooterComponentModel());
    qiblaModel = createModel(context, () => FooterComponentModel());
    merModel = createModel(context, () => FooterComponentModel());
  }

  @override
  void dispose() {
    hemModel.dispose();
    koranModel.dispose();
    adhkariconModel.dispose();
    qiblaModel.dispose();
    merModel.dispose();
  }
}
