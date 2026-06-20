import '/custom_header_footer/koran_page_sub_header/koran_page_sub_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/kuran/surah_header/surah_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'kuran_copy_model.dart';
export 'kuran_copy_model.dart';

/// Quranic Text Display Screen
class KuranCopyWidget extends StatefulWidget {
  const KuranCopyWidget({super.key});

  static String routeName = 'kuranCopy';
  static String routePath = '/kuranCopy';

  @override
  State<KuranCopyWidget> createState() => _KuranCopyWidgetState();
}

class _KuranCopyWidgetState extends State<KuranCopyWidget> {
  late KuranCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KuranCopyModel());
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.koranPageSubHeaderModel,
                  updateCallback: () => safeSetState(() {}),
                  child: KoranPageSubHeaderWidget(
                    pageName: 'Koran',
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '(28:85–88)',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            Text(
                              'سورة القصص',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 21.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            wrapWithModel(
                              model: _model.surahHeaderModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: SurahHeaderWidget(
                                headerValue: 'Juz :1',
                                width: 150.0,
                                height: 25.0,
                                fontSize: 14,
                              ),
                            ),
                            wrapWithModel(
                              model: _model.surahHeaderModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: SurahHeaderWidget(
                                headerValue: 'سورة القصص',
                                width: 150.0,
                                height: 25.0,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 550.0,
                          child: Stack(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/frame.jpg',
                                  width: MediaQuery.sizeOf(context).width * 1.0,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.7,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          '﴿٨٥﴾ إِنَّ الَّذِي فَرَضَ عَلَيْكَ ٱلْقُرْءَانَ لَرَآدُّكَ إِلَىٰ مَعَادٍۚ قُل رَّبِّيٓ أَعْلَمُ مَن جَآءَ بِٱلْهُدَىٰ وَمَنْ هُوَ فِي ضَلَٰلٍ مُّبِينٍ ﴿٨٦﴾ وَمَا كُنتَ تَرْجُوٓا۟ أَن يُلْقَىٰٓ إِلَيْكَ ٱلْكِتَٰبُ إِلَّا رَحْمَةً مِّن رَّبِّكَۖ فَلَا تَكُونَنَّ ظَهِيرًا لِّلْكَٰفِرِينَ ﴿٨٧﴾ وَلَا يَصُدُّنَّكَ عَنْ ءَايَٰتِ ٱللَّهِ بَعْدَ إِذْ أُنزِلَتْ إِلَيْكَۖ وَٱدْعُ إِلَىٰ رَبِّكَۖ وَلَا تَكُونَنَّ مِنَ ٱلْمُشْرِكِينَ\n﴿٨٨﴾ وَلَا تَدْعُ مَعَ ٱللَّهِ إِلَٰهًا ءَاخَرَۘ لَآ إِلَٰهَ إِلَّا هُوَۚ كُلُّ شَىْءٍ هَالِكٌ إِلَّا وَجْهَهُۥۚ لَهُ ٱلْحُكْمُ وَإِلَيْهِ تُرْجَعُونَ',
                                          textAlign: TextAlign.end,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 2.0,
                                              ),
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.surahHeaderModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SurahHeaderWidget(
                                          headerValue: 'سُورَةُ الْعَنكَبُوتِ',
                                          width: 225.0,
                                          height: 45.0,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          '﴿٨٥﴾ إِنَّ الَّذِي فَرَضَ عَلَيْكَ ٱلْقُرْءَانَ لَرَآدُّكَ إِلَىٰ مَعَادٍۚ قُل رَّبِّيٓ أَعْلَمُ مَن جَآءَ بِٱلْهُدَىٰ وَمَنْ هُوَ فِي ضَلَٰلٍ مُّبِينٍ ﴿٨٦﴾ وَمَا كُنتَ تَرْجُوٓا۟ أَن يُلْقَىٰٓ إِلَيْكَ ٱلْكِتَٰبُ إِلَّا رَحْمَةً مِّن رَّبِّكَۖ فَلَا تَكُونَنَّ ظَهِيرًا لِّلْكَٰفِرِينَ ﴿٨٧﴾ وَلَا يَصُدُّنَّكَ عَنْ ءَايَٰتِ ٱللَّهِ بَعْدَ إِذْ أُنزِلَتْ إِلَيْكَۖ وَٱدْعُ إِلَىٰ رَبِّكَۖ وَلَا تَكُونَنَّ مِنَ ٱلْمُشْرِكِينَ\n﴿٨٨﴾ وَلَا تَدْعُ مَعَ ٱللَّهِ إِلَٰهًا ءَاخَرَۘ لَآ إِلَٰهَ إِلَّا هُوَۚ كُلُّ شَىْءٍ هَالِكٌ إِلَّا وَجْهَهُۥۚ لَهُ ٱلْحُكْمُ وَإِلَيْهِ تُرْجَعُونَ',
                                          textAlign: TextAlign.end,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 2.0,
                                              ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(height: 20.0))
                                        .around(SizedBox(height: 20.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 16.0))
                        .addToStart(SizedBox(height: 16.0))
                        .addToEnd(SizedBox(height: 24.0)),
                  ),
                ),
              ].divide(SizedBox(height: 20.0)).around(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
