import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/home/categories_sub_tab/categories_sub_tab_widget.dart';
import '/pages/home/youtube_video_item/youtube_video_item_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.loadTodayHijriData();
      _model.cityResult = await actions.loadCitiesFromAsset(
        null,
      );
      FFAppState().cityList =
          _model.cityResult!.toList().cast<CityRecordStruct>();
      safeSetState(() {});
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return YoutubeFullScreenWrapper(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          FFLocalizations.of(context).getText(
                            'z0nfmsqo' /* Muslimens Kompanjon */,
                          ),
                          style:
                              FlutterFlowTheme.of(context).pxBoldGreen.override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .pxBoldGreen
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .pxBoldGreen
                                        .fontStyle,
                                  ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(NotificationWidget.routeName);
                              },
                              child: Icon(
                                Icons.notifications_none,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context
                                    .pushNamed(IslamicCalenderWidget.routeName);
                              },
                              child: Icon(
                                FFIcons.kcalender,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                            ),
                          ].divide(SizedBox(width: 10.0)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController ??=
                                  FormFieldController<String>(
                                _model.dropDownValue ??= valueOrDefault<String>(
                                  FFAppState().user.city,
                                  'EmptyString',
                                ),
                              ),
                              options: _model.cityResult != null &&
                                      (_model.cityResult)!.isNotEmpty
                                  ? _model.cityResult!
                                      .map((e) => valueOrDefault<String>(
                                            e.name,
                                            '.',
                                          ))
                                      .toList()
                                  : ([]),
                              onChanged: (val) async {
                                safeSetState(() => _model.dropDownValue = val);
                                safeSetState(() {});
                              },
                              width: 200.0,
                              height: 40.0,
                              textStyle: FlutterFlowTheme.of(context)
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
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              hintText: FFLocalizations.of(context).getText(
                                '1rmnuxcp' /* Select... */,
                              ),
                              icon: Icon(
                                Icons.search,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 18.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: Colors.transparent,
                              borderWidth: 0.0,
                              borderRadius: 8.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            ),
                            Icon(
                              Icons.star_outline,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 15.0,
                            ),
                          ].divide(SizedBox(width: 5.0)),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              dateTimeFormat(
                                "d MMMM yyyy",
                                getCurrentTimestamp,
                                locale:
                                    FFLocalizations.of(context).languageCode,
                              ),
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
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                            Text(
                              '${FFAppState().hijriData.hijriDay.toString()} ${FFAppState().hijriData.hijriMonthName} ${FFAppState().hijriData.hijriYear.toString()}',
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
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 50.0,
                            child: custom_widgets.CenteredDatePicker(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 50.0,
                              primaryColor:
                                  FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ].divide(SizedBox(width: 25.0)),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context
                                  .pushNamed(IslamicCalenderWidget.routeName);
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 150.0,
                              child: custom_widgets.PrayerTimeWidgets(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 150.0,
                                cityName: _model.dropDownValue!,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                          FlutterFlowTheme.of(context).designToken.radius.sm),
                      child: Image.asset(
                        'assets/images/b1329b49518ab836456f1bbad64397a7f3777b25.png',
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 210.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'egooxlu9' /* MK Channel */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).blackBold.override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .blackBold
                                            .fontStyle,
                                      ),
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .blackBold
                                          .fontStyle,
                                    ),
                          ),
                          Builder(
                            builder: (context) {
                              final youtubeVideo =
                                  FFAppState().youtubeData.toList();

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(youtubeVideo.length,
                                      (youtubeVideoIndex) {
                                    final youtubeVideoItem =
                                        youtubeVideo[youtubeVideoIndex];
                                    return Container(
                                      width: 200.0,
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .radius
                                                .sm),
                                      ),
                                      child: YoutubeVideoItemWidget(
                                        key: Key(
                                            'Key37y_${youtubeVideoIndex}_of_${youtubeVideo.length}'),
                                        youtubeLink: youtubeVideoItem.video,
                                        videoTitle: youtubeVideoItem.title,
                                        videoTopic: youtubeVideoItem.topic,
                                      ),
                                    );
                                  }).divide(SizedBox(width: 10.0)),
                                ),
                              );
                            },
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 210.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              'etzm8l1t' /* Recommended Content */,
                            ),
                            style:
                                FlutterFlowTheme.of(context).blackBold.override(
                                      font: GoogleFonts.manrope(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .blackBold
                                            .fontStyle,
                                      ),
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .blackBold
                                          .fontStyle,
                                    ),
                          ),
                          Builder(
                            builder: (context) {
                              final content = FFAppState().youtubeData.toList();

                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(content.length,
                                      (contentIndex) {
                                    final contentItem = content[contentIndex];
                                    return Container(
                                      width: 200.0,
                                      height: 160.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            FlutterFlowTheme.of(context)
                                                .designToken
                                                .radius
                                                .sm),
                                      ),
                                      child: YoutubeVideoItemWidget(
                                        key: Key(
                                            'Key02g_${contentIndex}_of_${content.length}'),
                                        youtubeLink: contentItem.video,
                                        videoTitle: contentItem.title,
                                        videoTopic: contentItem.topic,
                                      ),
                                    );
                                  }).divide(SizedBox(width: 10.0)),
                                ),
                              );
                            },
                          ),
                        ].divide(SizedBox(height: 10.0)),
                      ),
                    ),
                    Container(
                      height: 214.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        borderRadius: BorderRadius.circular(
                            FlutterFlowTheme.of(context).designToken.radius.md),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            FlutterFlowTheme.of(context).designToken.spacing.md,
                            FlutterFlowTheme.of(context).designToken.spacing.sm,
                            FlutterFlowTheme.of(context).designToken.spacing.md,
                            FlutterFlowTheme.of(context)
                                .designToken
                                .spacing
                                .sm),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'errzcqel' /* Categories */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.manrope(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                            ),
                            Expanded(
                              child: GridView(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: () {
                                    if (MediaQuery.sizeOf(context).width <
                                        kBreakpointSmall) {
                                      return 3;
                                    } else if (MediaQuery.sizeOf(context)
                                            .width <
                                        kBreakpointMedium) {
                                      return 4;
                                    } else if (MediaQuery.sizeOf(context)
                                            .width <
                                        kBreakpointLarge) {
                                      return 5;
                                    } else {
                                      return 6;
                                    }
                                  }(),
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 1.37,
                                ),
                                primary: false,
                                scrollDirection: Axis.vertical,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                          IslamicCalenderWidget.routeName);
                                    },
                                    child: wrapWithModel(
                                      model: _model.categoriesSubTabModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: CategoriesSubTabWidget(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                        catogeryName: 'Kalender',
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                          AboutIslamWidget.routeName);
                                    },
                                    child: wrapWithModel(
                                      model: _model.categoriesSubTabModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: CategoriesSubTabWidget(
                                        icon: Icon(
                                          Icons.menu_book,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                        catogeryName: 'Om Islam',
                                      ),
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.categoriesSubTabModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: CategoriesSubTabWidget(
                                      icon: Icon(
                                        Icons.bookmark_sharp,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                      catogeryName: 'Quran',
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(AdhkarWidget.routeName);
                                    },
                                    child: wrapWithModel(
                                      model: _model.categoriesSubTabModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: CategoriesSubTabWidget(
                                        icon: Icon(
                                          Icons.menu_book,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                        catogeryName: 'Dhikr',
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                          QiblaFinderWidget.routeName);
                                    },
                                    child: wrapWithModel(
                                      model: _model.categoriesSubTabModel5,
                                      updateCallback: () => safeSetState(() {}),
                                      child: CategoriesSubTabWidget(
                                        icon: Icon(
                                          Icons.my_location,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                        catogeryName: 'Moskéer',
                                      ),
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.categoriesSubTabModel6,
                                    updateCallback: () => safeSetState(() {}),
                                    child: CategoriesSubTabWidget(
                                      icon: Icon(
                                        Icons.add,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                      catogeryName: 'Reserverad',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ].divide(SizedBox(height: 9.0)),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(height: 20.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
