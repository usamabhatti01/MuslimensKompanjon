import '/custom_header_footer/footer_component/footer_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'page_footer_model.dart';
export 'page_footer_model.dart';

class PageFooterWidget extends StatefulWidget {
  const PageFooterWidget({
    super.key,
    required this.activeTab,
  });

  final int? activeTab;

  @override
  State<PageFooterWidget> createState() => _PageFooterWidgetState();
}

class _PageFooterWidgetState extends State<PageFooterWidget> {
  late PageFooterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PageFooterModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (getCurrentRoute(context) != '/home') {
              context.pushNamed(
                HomeWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
          },
          child: wrapWithModel(
            model: _model.hemModel,
            updateCallback: () => safeSetState(() {}),
            child: FooterComponentWidget(
              icon: FaIcon(
                FontAwesomeIcons.home,
                color: valueOrDefault<Color>(
                  widget.activeTab == 1
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).footerInActive,
                  FlutterFlowTheme.of(context).footerInActive,
                ),
                size: FFAppConstants.footerIcon.toDouble(),
              ),
              name: 'Hem',
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (getCurrentRoute(context) != '/kuranHome') {
              context.pushNamed(
                KuranHomeWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
          },
          child: wrapWithModel(
            model: _model.koranModel,
            updateCallback: () => safeSetState(() {}),
            child: FooterComponentWidget(
              icon: FaIcon(
                FontAwesomeIcons.bookOpen,
                color: valueOrDefault<Color>(
                  widget.activeTab == 2
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).footerInActive,
                  FlutterFlowTheme.of(context).footerInActive,
                ),
                size: FFAppConstants.footerIcon.toDouble(),
              ),
              name: 'Koran',
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (getCurrentRoute(context) != '/adhkar') {
              context.pushNamed(
                AdhkarWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
          },
          child: wrapWithModel(
            model: _model.adhkariconModel,
            updateCallback: () => safeSetState(() {}),
            child: FooterComponentWidget(
              icon: FaIcon(
                FontAwesomeIcons.moon,
                color: valueOrDefault<Color>(
                  widget.activeTab == 3
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).footerInActive,
                  FlutterFlowTheme.of(context).footerInActive,
                ),
                size: FFAppConstants.footerIcon.toDouble(),
              ),
              name: 'Adhkar',
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (getCurrentRoute(context) != '/qiblaFinder') {
              context.pushNamed(
                QiblaFinderWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
          },
          child: wrapWithModel(
            model: _model.qiblaModel,
            updateCallback: () => safeSetState(() {}),
            child: FooterComponentWidget(
              icon: FaIcon(
                FontAwesomeIcons.compass,
                color: valueOrDefault<Color>(
                  widget.activeTab == 4
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).footerInActive,
                  FlutterFlowTheme.of(context).footerInActive,
                ),
                size: FFAppConstants.footerIcon.toDouble(),
              ),
              name: 'Qibla ',
            ),
          ),
        ),
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (getCurrentRoute(context) != '/setting') {
              context.pushNamed(
                SettingWidget.routeName,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                  ),
                },
              );
            }
          },
          child: wrapWithModel(
            model: _model.merModel,
            updateCallback: () => safeSetState(() {}),
            child: FooterComponentWidget(
              icon: Icon(
                Icons.menu,
                color: valueOrDefault<Color>(
                  widget.activeTab == 5
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context).footerInActive,
                  FlutterFlowTheme.of(context).footerInActive,
                ),
                size: FFAppConstants.footerIcon.toDouble(),
              ),
              name: 'Mer',
            ),
          ),
        ),
      ],
    );
  }
}
