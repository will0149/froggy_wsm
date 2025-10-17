import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/app/pages/maintainance/settings_page.dart';
import 'package:froggy_soft/app/pages/outgoing/outgoing_page.dart';
import 'package:froggy_soft/app/pages/relocation/relocation_page.dart';
import 'package:froggy_soft/app/pages/warehouse/alegra_comparison_table_page.dart';
import 'package:froggy_soft/app/pages/warehouse/alegra_inventory_page.dart';
import 'package:froggy_soft/app/pages/warehouse/search_page.dart';
import 'package:froggy_soft/app/pages/warehouse/stocks_table_page.dart';
import 'package:go_router/go_router.dart';

import '../../device/utils/logger_config.dart';
import 'auth/login_page.dart';
import 'count/alegra/alegra_count_page.dart';
import 'entry/entry_page.dart';
import 'main_page.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/09/24
var loginEnable = false;
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final routerProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authSessionProvider);
  final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: loginEnable ? "/login" : "/main",
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
            // GoRoute(
            //   name: CountPage.routeName,
            //   path: CountPage.routeLocation,
            //   builder: (BuildContext context, GoRouterState state) {
            //     return const CountPage();
            //   },
            // ),
            GoRoute(
              name: AlegraCountPage.routeName,
              path: AlegraCountPage.routeLocation,
              builder: (BuildContext context, GoRouterState state) {
                return const AlegraCountPage();
              },
              routes: <RouteBase> [
                GoRoute(
                  name: AlegraComparisonTablePage.routeName,
                  path: AlegraComparisonTablePage.routeLocation,
                  builder: (BuildContext context, GoRouterState state) {
                    return const AlegraComparisonTablePage();
                  },
                ),
              ]
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
              name: AlegraInventoryPage.routeName,
              path: AlegraInventoryPage.routeLocation,
              builder: (BuildContext context, GoRouterState state) {
                return const AlegraInventoryPage();
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
                    Map<String, String>? request =
                        state.extra as Map<String, String>?;
                    return StocksTablePage(
                      request: request,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
      redirect: (context, state) async {
        if (kDebugMode) logger.w("matchedLocation ${state.matchedLocation}");
        // var firstRun = IsFirstRun();
        // bool firstCall = await firstRun.isFirstRun();
        // final storageUtils = BuildHeadersUtilsImpl();
        // bool hasStorage = await storageUtils.validateStorage();
        // if (firstCall) {
        //   return LoginPage.routeLocation;
        // }
        // if (kDebugMode) logger.i('match location ${state.matchedLocation}');
        // if(hasStorage && state.matchedLocation == LoginPage.routeLocation){
        //   return MainPage.routeLocation;
        // }
        //
        // if (state.matchedLocation != LoginPage.routeLocation) {
        //   return state.matchedLocation;
        // }
        // return null;
        if (state.matchedLocation != LoginPage.routeLocation) {
          return state.matchedLocation;
        }
        return null;
      });
  return router;
});
