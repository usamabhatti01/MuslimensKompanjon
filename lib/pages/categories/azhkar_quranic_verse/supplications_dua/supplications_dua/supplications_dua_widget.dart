import '/extra/page_sub_header/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adhkar_all_pages_banner/adhkar_all_pages_banner_widget.dart';
import '/pages/categories/azhkar_quranic_verse/arabic_heading_and_translation/arabic_heading_and_translation_widget.dart';
import '/pages/categories/azhkar_quranic_verse/supplications_dua/supplications_dua_box/supplications_dua_box_widget.dart';
import 'package:flutter/material.dart';
import 'supplications_dua_model.dart';
export 'supplications_dua_model.dart';

class SupplicationsDuaWidget extends StatefulWidget {
  const SupplicationsDuaWidget({super.key});

  static String routeName = 'SupplicationsDua';
  static String routePath = '/supplicationsDua';

  @override
  State<SupplicationsDuaWidget> createState() => _SupplicationsDuaWidgetState();
}

class _SupplicationsDuaWidgetState extends State<SupplicationsDuaWidget> {
  late SupplicationsDuaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupplicationsDuaModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(
                FlutterFlowTheme.of(context).designToken.spacing.md),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  wrapWithModel(
                    model: _model.pageSubHeaderModel,
                    updateCallback: () => safeSetState(() {}),
                    child: PageSubHeaderWidget(
                      pageName: 'Supplicati-ons (Dua)',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.adhkarAllPagesBannerModel,
                    updateCallback: () => safeSetState(() {}),
                    child: AdhkarAllPagesBannerWidget(
                      pageName: 'Supplicati-ons\n(Dua)',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.arabicHeadingAndTranslationModel,
                    updateCallback: () => safeSetState(() {}),
                    child: ArabicHeadingAndTranslationWidget(
                      heading: 'وَقَالَ رَبُّكُمُ ادْعُونِي أَسْتَجِبْ لَكُمْ',
                      translation:
                          'And your Lord says, \'Call upon Me; I will respond to',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.supplicationsDuaBoxModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: SupplicationsDuaBoxWidget(
                      tasbihName: 'دعاء الصائم عند الإفطار',
                      tasbih:
                          '\"اللهم لك صمت، وعلى رزقك أفطرت\"\n\"ذهب الظمأ، وابتلت العروق، وثبت الأجر إن شاء الله\"',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.supplicationsDuaBoxModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: SupplicationsDuaBoxWidget(
                      tasbihName: 'دعاء من أفطر عند قوم',
                      tasbih:
                          '\"أفطر عندكم الصائمون، وغشيتكم الرحمة، وأكل طعامكم الأبرار، ونزلت عليكم الملائكة\"',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.supplicationsDuaBoxModel3,
                    updateCallback: () => safeSetState(() {}),
                    child: SupplicationsDuaBoxWidget(
                      tasbihName: 'دعاء ليلة القدر',
                      tasbih: '\"اللهم إنك عفو كريم تحب العفو فاعفُ عني\"',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.supplicationsDuaBoxModel4,
                    updateCallback: () => safeSetState(() {}),
                    child: SupplicationsDuaBoxWidget(
                      tasbihName: 'الدعاء الطويل',
                      tasbih:
                          'اللهم إني أسألك من الخير كله عاجله وآجله ما علمت منه وما لم أعلم، وأعوذ بك من الشر كله  \n وما لم أعلم، \nاللهم إني أسألك من خير ما سألك به عبدك ونبيك، \nوأعوذ بك من شر ما عاذ به عبدك ونبيك، \nاللهم إني أسألك الجنة وما قرّب إليها من قول أو عمل، \nوأعوذ بك من النار وما قرّب إليها من قول أو عمل، \nوأسألك أن تجعل كل قضاء قضيته لي خيرًا.',
                    ),
                  ),
                ].divide(SizedBox(height: 20.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
