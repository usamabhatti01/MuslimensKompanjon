import '/custom_header_footer/adhkar_header/adhkar_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/categories/azhkar_quranic_verse/mornng_and_evebing_adhkar/adhkar_component/adhkar_component_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'morning_evening_adhkar_model.dart';
export 'morning_evening_adhkar_model.dart';

class MorningEveningAdhkarWidget extends StatefulWidget {
  const MorningEveningAdhkarWidget({
    super.key,
    required this.adkar,
  });

  final String? adkar;

  static String routeName = 'MorningEveningAdhkar';
  static String routePath = '/morningEveningAdhkar';

  @override
  State<MorningEveningAdhkarWidget> createState() =>
      _MorningEveningAdhkarWidgetState();
}

class _MorningEveningAdhkarWidgetState extends State<MorningEveningAdhkarWidget>
    with TickerProviderStateMixin {
  late MorningEveningAdhkarModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MorningEveningAdhkarModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
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
        body: Padding(
          padding: EdgeInsets.all(
              FlutterFlowTheme.of(context).designToken.spacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.adhkarHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: AdhkarHeaderWidget(
                  pageName: widget.adkar!,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0.0, 0),
                          child: TabBar(
                            labelColor: FlutterFlowTheme.of(context).primary,
                            unselectedLabelColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            labelStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            unselectedLabelStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  font: GoogleFonts.plusJakartaSans(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                            indicatorColor:
                                FlutterFlowTheme.of(context).primary,
                            tabs: [
                              Tab(
                                text: 'Arabiska',
                              ),
                              Tab(
                                text: 'Svenska',
                              ),
                            ],
                            controller: _model.tabBarController,
                            onTap: (i) async {
                              [() async {}, () async {}][i]();
                            },
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _model.tabBarController,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 120.0,
                                    child: custom_widgets.SimpleAudioPlayer(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 120.0,
                                      audioUrl:
                                          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.adhkarComponentModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: AdhkarComponentWidget(
                                      value:
                                          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ (1) الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ (2) الرَّحْمَٰنِ الرَّحِيمِ (3) مَالِكِ يَوْمِ الدِّينِ (4) إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ (5) اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ (6) صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ (7)',
                                      total: 10,
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height: 120.0,
                                    child: custom_widgets.SimpleAudioPlayer(
                                      width: MediaQuery.sizeOf(context).width *
                                          1.0,
                                      height: 120.0,
                                      audioUrl:
                                          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.adhkarComponentModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: AdhkarComponentWidget(
                                      value:
                                          'I Guds, Den Nåderikes, Den Barmhärtiges namn. Lov och pris tillkommer Gud, världarnas Herre, den Nåderike, den Barmhärtige, som allsmäktig råder över Domens dag! Dig tillber vi; Dig anropar vi om hjälp. Led oss på den raka vägen - den väg de vandrat som Du har välsignat med Dina gåvor; inte de som har drabbats av [Din] vrede och inte de som har gått vilse! ',
                                      total: 10,
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ].divide(SizedBox(height: 20.0)).addToStart(SizedBox(
                height: FlutterFlowTheme.of(context).designToken.spacing.xxl)),
          ),
        ),
      ),
    );
  }
}
