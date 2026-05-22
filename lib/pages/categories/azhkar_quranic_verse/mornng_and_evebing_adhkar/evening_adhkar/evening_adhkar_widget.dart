import '/components/page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/adhkar_all_pages_banner/adhkar_all_pages_banner_widget.dart';
import '/pages/categories/azhkar_quranic_verse/mornng_and_evebing_adhkar/adkhar_box/adkhar_box_widget.dart';
import 'package:flutter/material.dart';
import 'evening_adhkar_model.dart';
export 'evening_adhkar_model.dart';

class EveningAdhkarWidget extends StatefulWidget {
  const EveningAdhkarWidget({super.key});

  static String routeName = 'EveningAdhkar';
  static String routePath = '/eveningAdhkar';

  @override
  State<EveningAdhkarWidget> createState() => _EveningAdhkarWidgetState();
}

class _EveningAdhkarWidgetState extends State<EveningAdhkarWidget> {
  late EveningAdhkarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EveningAdhkarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  wrapWithModel(
                    model: _model.pageSubHeaderModel,
                    updateCallback: () => safeSetState(() {}),
                    child: PageSubHeaderWidget(
                      pageName: 'Evening Adhkar',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.adhkarAllPagesBannerModel,
                    updateCallback: () => safeSetState(() {}),
                    child: AdhkarAllPagesBannerWidget(
                      pageName: 'Evening Adhkar',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.adkharBoxModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: AdkharBoxWidget(
                      azkarNumber: 1,
                      azkarNmae: 'ٱلْفَاتِحَة‎',
                      azkar:
                          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ (1) الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ (2) الرَّحْمَٰنِ الرَّحِيمِ (3) مَالِكِ يَوْمِ الدِّينِ (4) إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ (5) اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ (6) صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ (7)',
                      azkarTranslation:
                          'I Guds, Den Nåderikes, Den Barmhärtiges namn. Lov och pris tillkommer Gud, världarnas Herre, den Nåderike, den Barmhärtige, som allsmäktig råder över Domens dag! Dig tillber vi; Dig anropar vi om hjälp. Led oss på den raka vägen - den väg de vandrat som Du har välsignat med Dina gåvor; inte de som har drabbats av [Din] vrede och inte de som har gått vilse! ',
                    ),
                  ),
                  wrapWithModel(
                    model: _model.adkharBoxModel2,
                    updateCallback: () => safeSetState(() {}),
                    child: AdkharBoxWidget(
                      azkarNumber: 2,
                      azkarNmae: 'البقرة',
                      azkar:
                          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ. الٓمٓ (١) ذَٰلِكَ ٱلْكِتَـٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًۭى لِّلْمُتَّقِينَ (٢) ٱلَّذِينَ يُؤْمِنُونَ بِٱلْغَيْبِ وَيُقِيمُونَ ٱلصَّلَوٰةَ وَمِمَّا رَزَقْنَـٰهُمْ يُنفِقُونَ (٣) وَٱلَّذِينَ يُؤْمِنُونَ بِمَآ أُنزِلَ إِلَيْكَ وَمَآ أُنزِلَ مِن قَبْلِكَ وَبِٱلْـَٔاخِرَةِ هُمْ يُوقِنُونَ (٤) أُو۟لَـٰٓئِكَ عَلَىٰ هُدًۭى مِّن رَّبِّهِمْ ۖ وَأُو۟لَـٰٓئِكَ هُمُ ٱلْمُفْلِحُونَ (٥) [1]',
                      azkarTranslation:
                          '1.Alif Lam Mim. 2. DENNA SKRIFT - här råder inget tvivel - är en vägledning för dem som fruktar Gud [och ständigt har Honom för ögonen], 3. dem som tror på [existensen av] det som är dolt för människor, dem som förrättar bönen och som ger åt andra av vad Vi har skänkt dem för deras försörjning, 4. och dem som tror på det som har uppenbarats för dig [Muhammad] och på det som har uppenbarats före din tid och som har förvissningen att det eviga livet [väntar]. 5. Det är de som följer [den sanna] vägledningen från sin Herre och det är de som kommer att nå målet [5].',
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
