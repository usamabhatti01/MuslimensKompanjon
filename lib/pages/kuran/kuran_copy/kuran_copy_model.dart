import '/custom_header_footer/koran_page_sub_header/koran_page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kuran/surah_header/surah_header_widget.dart';
import 'kuran_copy_widget.dart' show KuranCopyWidget;
import 'package:flutter/material.dart';

class KuranCopyModel extends FlutterFlowModel<KuranCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for KoranPageSubHeader component.
  late KoranPageSubHeaderModel koranPageSubHeaderModel;
  // Model for surahHeader component.
  late SurahHeaderModel surahHeaderModel1;
  // Model for surahHeader component.
  late SurahHeaderModel surahHeaderModel2;
  // Model for surahHeader component.
  late SurahHeaderModel surahHeaderModel3;

  @override
  void initState(BuildContext context) {
    koranPageSubHeaderModel =
        createModel(context, () => KoranPageSubHeaderModel());
    surahHeaderModel1 = createModel(context, () => SurahHeaderModel());
    surahHeaderModel2 = createModel(context, () => SurahHeaderModel());
    surahHeaderModel3 = createModel(context, () => SurahHeaderModel());
  }

  @override
  void dispose() {
    koranPageSubHeaderModel.dispose();
    surahHeaderModel1.dispose();
    surahHeaderModel2.dispose();
    surahHeaderModel3.dispose();
  }
}
