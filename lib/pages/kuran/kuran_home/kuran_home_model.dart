import '/custom_header_footer/koran_page_sub_header/koran_page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kuran/bok_fvt_heading/bok_fvt_heading_widget.dart';
import '/pages/kuran/bokmrke_heading/bokmrke_heading_widget.dart';
import '/pages/kuran/juz_heading/juz_heading_widget.dart';
import '/pages/kuran/sur_haeading/sur_haeading_widget.dart';
import '/index.dart';
import 'kuran_home_widget.dart' show KuranHomeWidget;
import 'package:flutter/material.dart';

class KuranHomeModel extends FlutterFlowModel<KuranHomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for KoranPageSubHeader component.
  late KoranPageSubHeaderModel koranPageSubHeaderModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for surHaeading component.
  late SurHaeadingModel surHaeadingModel1;
  // Model for surHaeading component.
  late SurHaeadingModel surHaeadingModel2;
  // Model for JuzHeading component.
  late JuzHeadingModel juzHeadingModel1;
  // Model for JuzHeading component.
  late JuzHeadingModel juzHeadingModel2;
  // Model for JuzHeading component.
  late JuzHeadingModel juzHeadingModel3;
  // Model for BokmrkeHeading component.
  late BokmrkeHeadingModel bokmrkeHeadingModel1;
  // Model for BokmrkeHeading component.
  late BokmrkeHeadingModel bokmrkeHeadingModel2;
  // Model for BokFvtHeading component.
  late BokFvtHeadingModel bokFvtHeadingModel;

  @override
  void initState(BuildContext context) {
    koranPageSubHeaderModel =
        createModel(context, () => KoranPageSubHeaderModel());
    surHaeadingModel1 = createModel(context, () => SurHaeadingModel());
    surHaeadingModel2 = createModel(context, () => SurHaeadingModel());
    juzHeadingModel1 = createModel(context, () => JuzHeadingModel());
    juzHeadingModel2 = createModel(context, () => JuzHeadingModel());
    juzHeadingModel3 = createModel(context, () => JuzHeadingModel());
    bokmrkeHeadingModel1 = createModel(context, () => BokmrkeHeadingModel());
    bokmrkeHeadingModel2 = createModel(context, () => BokmrkeHeadingModel());
    bokFvtHeadingModel = createModel(context, () => BokFvtHeadingModel());
  }

  @override
  void dispose() {
    koranPageSubHeaderModel.dispose();
    tabBarController?.dispose();
    surHaeadingModel1.dispose();
    surHaeadingModel2.dispose();
    juzHeadingModel1.dispose();
    juzHeadingModel2.dispose();
    juzHeadingModel3.dispose();
    bokmrkeHeadingModel1.dispose();
    bokmrkeHeadingModel2.dispose();
    bokFvtHeadingModel.dispose();
  }
}
