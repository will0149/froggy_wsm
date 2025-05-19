import 'dart:collection';

import 'package:cct_management/app/pages/count/count_page.dart';
import 'package:cct_management/app/pages/maintainance/settings_page.dart';
import 'package:cct_management/app/pages/outgoing/outgoing_page.dart';
import 'package:cct_management/app/pages/relocation/relocation_page.dart';
import 'package:cct_management/app/pages/warehouse/search_page.dart';
import 'package:cct_management/app/pages/warehouse/stocks_table_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../device/utils/is_first_run.dart';
import '../../device/utils/logger_config.dart';
import '../../domain/dtos/series_dto.dart';
import '../../domain/utils/impl/build_headers_utils_impl.dart';
import 'auth/login_page.dart';
import 'entry/entry_page.dart';
import 'main_page.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/09/24

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final routerProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authSessionProvider);
  final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: "/login",
      routes: <RouteBase>[
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.routeLocation,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          name: MainPage.routeName,
          path: MainPage.routeLocation,
          builder: (BuildContext context, GoRouterState state) {
            return const MainPage();
          },
            routes: <RouteBase>[
              GoRoute(
                name: EntryPage.routeName,
                path: EntryPage.routeLocation,
                builder: (BuildContext context, GoRouterState state) {
                  return const EntryPage();
                },
              ),
              GoRoute(
                name: RelocationPage.routeName,
                path: RelocationPage.routeLocation,
                builder: (BuildContext context, GoRouterState state) {
                  return const RelocationPage();
                },
              ),
              GoRoute(
                name: CountPage.routeName,
                path: CountPage.routeLocation,
                builder: (BuildContext context, GoRouterState state) {
                  return const CountPage();
                },
              ),
              GoRoute(
                name: OutgoingPage.routeName,
                path: OutgoingPage.routeLocation,
                builder: (BuildContext context, GoRouterState state) {
                  return const OutgoingPage();
                },
              ),
              GoRoute(
                name: SettingsPage.routeName,
                path: SettingsPage.routeLocation,
                builder: (BuildContext context, GoRouterState state) {
                  return const SettingsPage();
                },
              ),
              GoRoute(
                name: SearchPage.routeName,
                path: SearchPage.routeLocation,
                builder: (BuildContext context, GoRouterState state) {
                  return const SearchPage();
                },
                routes: <RouteBase>[
                  GoRoute(
                    name: StocksTablePage.routeName,
                    path: StocksTablePage.routeLocation,
                    builder: (BuildContext context, GoRouterState state) {
                      Map<String, String>? request = state.extra as Map<String, String>?;
                      return StocksTablePage(
                        request: request,
                      );
                    },

              )
                ]
              ),
            ]
        ),
      ],
      redirect: (context, state) async {
        var firstRun = IsFirstRun();
        bool firstCall = await firstRun.isFirstRun();
        final storageUtils = BuildHeadersUtilsImpl();
        bool hasStorage = await storageUtils.validateStorage();
        if (firstCall) {
          return LoginPage.routeLocation;
        }
        logger.i('match location ${state.matchedLocation}');
        if(hasStorage && state.matchedLocation == LoginPage.routeLocation){
          return MainPage.routeLocation;
        }

        if (state.matchedLocation != LoginPage.routeLocation) {
          return state.matchedLocation;
        }
        return null;
      });
  return router;
});
