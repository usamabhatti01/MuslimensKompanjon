import '/extra/feature_item/feature_item_widget.dart';
import '/extra/social_link/social_link_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'about_page_model.dart';
export 'about_page_model.dart';

/// i also need about page for my app
class AboutPageWidget extends StatefulWidget {
  const AboutPageWidget({super.key});

  static String routeName = 'AboutPage';
  static String routePath = '/aboutPage';

  @override
  State<AboutPageWidget> createState() => _AboutPageWidgetState();
}

class _AboutPageWidgetState extends State<AboutPageWidget> {
  late AboutPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutPageModel());
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
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 240.0,
                child: Stack(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  children: [
                    CachedNetworkImage(
                      fadeInDuration: Duration(milliseconds: 0),
                      fadeOutDuration: Duration(milliseconds: 0),
                      imageUrl:
                          'https://dimg.dreamflow.cloud/v1/image/beautiful%20islamic%20architecture%20mosque%20silhouette%20at%20sunset',
                      height: 240.0,
                      fit: BoxFit.cover,
                      alignment: Alignment(0.0, 0.0),
                    ),
                    Container(
                      height: 240.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            FlutterFlowTheme.of(context).primaryBackground
                          ],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(0.0, -1.0),
                          end: AlignmentDirectional(0, 1.0),
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 1.0),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(24.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Icon(
                                Icons.mosque_rounded,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 40.0,
                              ),
                            ),
                            Text(
                              'MuslimensKompanjon',
                              style: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                            Text(
                              'Version 1.2.0',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Mission',
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                        ),
                        Text(
                          'MuslimensKompanjon is dedicated to providing a seamless, ad-free experience for Muslims worldwide. Our goal is to blend modern technology with spiritual necessity, helping you stay connected to your faith wherever you are.',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                                lineHeight: 1.6,
                              ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Key Features',
                          style: FlutterFlowTheme.of(context)
                              .titleLarge
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .fontStyle,
                                lineHeight: 1.4,
                              ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            wrapWithModel(
                              model: _model.featureItemModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: FeatureItemWidget(
                                icon: Icon(
                                  Icons.schedule_rounded,
                                  size: 24.0,
                                ),
                                title: 'Accurate Prayer Times',
                                description:
                                    'Precise timings based on your exact location with customizable notifications.',
                              ),
                            ),
                            wrapWithModel(
                              model: _model.featureItemModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: FeatureItemWidget(
                                icon: Icon(
                                  Icons.explore_rounded,
                                  size: 24.0,
                                ),
                                title: 'Qibla Finder',
                                description:
                                    'Highly accurate compass to find the direction of the Kaaba from anywhere.',
                              ),
                            ),
                            wrapWithModel(
                              model: _model.featureItemModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: FeatureItemWidget(
                                icon: Icon(
                                  Icons.menu_book_rounded,
                                  size: 24.0,
                                ),
                                title: 'Holy Quran',
                                description:
                                    'Read and listen to the Quran with multiple translations and tajweed rules.',
                              ),
                            ),
                            wrapWithModel(
                              model: _model.featureItemModel4,
                              updateCallback: () => safeSetState(() {}),
                              child: FeatureItemWidget(
                                icon: Icon(
                                  Icons.favorite_rounded,
                                  size: 24.0,
                                ),
                                title: 'Daily Azkar',
                                description:
                                    'A collection of authentic morning, evening, and after-prayer supplications.',
                              ),
                            ),
                          ].divide(SizedBox(height: 24.0)),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Connect With Us',
                          style: FlutterFlowTheme.of(context)
                              .titleLarge
                              .override(
                                font: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .fontStyle,
                                lineHeight: 1.4,
                              ),
                        ),
                        Wrap(
                          spacing: 16.0,
                          runSpacing: 16.0,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: [
                            wrapWithModel(
                              model: _model.socialLinkModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: SocialLinkWidget(
                                platform:
                                    'https://cdn.simpleicons.org/github/056f00.svg',
                                label: 'Open Source',
                              ),
                            ),
                            wrapWithModel(
                              model: _model.socialLinkModel2,
                              updateCallback: () => safeSetState(() {}),
                              child: SocialLinkWidget(
                                platform:
                                    'https://cdn.simpleicons.org/twitter/056f00.svg',
                                label: 'Updates',
                              ),
                            ),
                            wrapWithModel(
                              model: _model.socialLinkModel3,
                              updateCallback: () => safeSetState(() {}),
                              child: SocialLinkWidget(
                                platform:
                                    'https://cdn.simpleicons.org/discord/056f00.svg',
                                label: 'Community',
                              ),
                            ),
                            wrapWithModel(
                              model: _model.socialLinkModel4,
                              updateCallback: () => safeSetState(() {}),
                              child: SocialLinkWidget(
                                platform:
                                    'https://cdn.simpleicons.org/instagram/056f00.svg',
                                label: 'Gallery',
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(20.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.volunteer_activism_rounded,
                                    color: FlutterFlowTheme.of(context).error,
                                    size: 24.0,
                                  ),
                                  Text(
                                    'Support the Project',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.manrope(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                              Text(
                                'This app is developed as Sadaqah Jariyah. If you find it beneficial, please keep the developers in your Duas.',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ].divide(SizedBox(height: 16.0)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Made with ❤️ for the Ummah',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).accent3,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          Text(
                            '© 2024 MuslimensKompanjon Team',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).accent3,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                          ),
                          Container(
                            height: 32.0,
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                    ),
                  ].divide(SizedBox(height: 32.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
