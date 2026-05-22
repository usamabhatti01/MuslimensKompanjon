import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => OnBoarding00Widget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => OnBoarding00Widget(),
        ),
        FFRoute(
          name: OnBoarding01Widget.routeName,
          path: OnBoarding01Widget.routePath,
          builder: (context, params) => OnBoarding01Widget(),
        ),
        FFRoute(
          name: OnBoarding02Widget.routeName,
          path: OnBoarding02Widget.routePath,
          builder: (context, params) => OnBoarding02Widget(),
        ),
        FFRoute(
          name: OnBoarding04Widget.routeName,
          path: OnBoarding04Widget.routePath,
          builder: (context, params) => OnBoarding04Widget(),
        ),
        FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) =>
              params.isEmpty ? NavBarPage(initialPage: 'Home') : HomeWidget(),
        ),
        FFRoute(
          name: TashbihCounterWidget.routeName,
          path: TashbihCounterWidget.routePath,
          builder: (context, params) => TashbihCounterWidget(),
        ),
        FFRoute(
          name: QiblaFinderWidget.routeName,
          path: QiblaFinderWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'QiblaFinder')
              : QiblaFinderWidget(),
        ),
        FFRoute(
          name: YoutubeFeedWidget.routeName,
          path: YoutubeFeedWidget.routePath,
          builder: (context, params) => YoutubeFeedWidget(),
        ),
        FFRoute(
          name: AdhkarWidget.routeName,
          path: AdhkarWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Adhkar')
              : AdhkarWidget(),
        ),
        FFRoute(
          name: MorningAdhkarWidget.routeName,
          path: MorningAdhkarWidget.routePath,
          builder: (context, params) => MorningAdhkarWidget(),
        ),
        FFRoute(
          name: TasbihWidget.routeName,
          path: TasbihWidget.routePath,
          builder: (context, params) => TasbihWidget(),
        ),
        FFRoute(
          name: AllahNamesWidget.routeName,
          path: AllahNamesWidget.routePath,
          builder: (context, params) => AllahNamesWidget(),
        ),
        FFRoute(
          name: EveningAdhkarWidget.routeName,
          path: EveningAdhkarWidget.routePath,
          builder: (context, params) => EveningAdhkarWidget(),
        ),
        FFRoute(
          name: SupplicationsDuaWidget.routeName,
          path: SupplicationsDuaWidget.routePath,
          builder: (context, params) => SupplicationsDuaWidget(),
        ),
        FFRoute(
          name: AboutIslamWidget.routeName,
          path: AboutIslamWidget.routePath,
          builder: (context, params) => AboutIslamWidget(),
        ),
        FFRoute(
          name: AboutIslamDetailsPageWidget.routeName,
          path: AboutIslamDetailsPageWidget.routePath,
          builder: (context, params) => AboutIslamDetailsPageWidget(
            tabData: params.getParam(
              'tabData',
              ParamType.JSON,
            ),
          ),
        ),
        FFRoute(
          name: NotificationWidget.routeName,
          path: NotificationWidget.routePath,
          builder: (context, params) => NotificationWidget(),
        ),
        FFRoute(
          name: SettingWidget.routeName,
          path: SettingWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Setting')
              : SettingWidget(),
        ),
        FFRoute(
          name: InPage2Widget.routeName,
          path: InPage2Widget.routePath,
          builder: (context, params) => InPage2Widget(),
        ),
        FFRoute(
          name: IslamicCalenderWidget.routeName,
          path: IslamicCalenderWidget.routePath,
          builder: (context, params) => IslamicCalenderWidget(),
        ),
        FFRoute(
          name: OnBoarding00Widget.routeName,
          path: OnBoarding00Widget.routePath,
          builder: (context, params) => OnBoarding00Widget(),
        ),
        FFRoute(
          name: LoadDataWidget.routeName,
          path: LoadDataWidget.routePath,
          builder: (context, params) => LoadDataWidget(),
        ),
        FFRoute(
          name: RatingPageWidget.routeName,
          path: RatingPageWidget.routePath,
          builder: (context, params) => RatingPageWidget(),
        ),
        FFRoute(
          name: AboutPageWidget.routeName,
          path: AboutPageWidget.routePath,
          builder: (context, params) => AboutPageWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
      observers: [routeObserver],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
