import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/app/pages/maintainance/settings_page.dart';
import 'package:froggy_soft/app/pages/outgoing/outgoing_page.dart';
import 'package:froggy_soft/app/pages/relocation/relocation_page.dart';
import 'package:froggy_soft/app/pages/warehouse/alegra/alegra_inventory_page.dart';
import 'package:froggy_soft/app/pages/warehouse/search_page.dart';
import 'package:froggy_soft/app/pages/warehouse/stocks_table_page.dart';
import 'package:go_router/go_router.dart';

import '../../device/utils/is_first_run.dart';
import '../../device/utils/logger_config.dart';
import '../../domain/logics/auth/rest_auth_uc.dart';
import '../../domain/models/auth/auth_state.dart';
import '../../domain/utils/impl/build_headers_utils_impl.dart';
import 'auth/login_page.dart';
import 'count/count_page.dart' show CountPage;
import 'entry/entry_page.dart';
import 'main_page.dart';
import 'maintainance/maintain_page.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/09/24
var loginEnable = false;
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier =
      ValueNotifier<AsyncValue<AuthState>>(const AsyncValue.loading());
  ref.listen(restAuthUCProvider, (_, next) {
    authNotifier.value = next;
  });
  final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: loginEnable ? "/login" : "/main",
      refreshListenable: authNotifier,
      routes: <RouteBase>[
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.routeLocation,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginPage();
          },
        ),
        GoRoute(
          name: MaintainPage.routeName,
          path: MaintainPage.routeLocation,
          builder: (BuildContext context, GoRouterState state) {
            return const MaintainPage();
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
            // GoRoute(
            //   name: AlegraCountPage.routeName,
            //   path: AlegraCountPage.routeLocation,
            //   builder: (BuildContext context, GoRouterState state) {
            //     return const AlegraCountPage();
            //   },
            //   routes: <RouteBase> [
            //     GoRoute(
            //       name: AlegraComparisonTablePage.routeName,
            //       path: AlegraComparisonTablePage.routeLocation,
            //       builder: (BuildContext context, GoRouterState state) {
            //         return const AlegraComparisonTablePage();
            //       },
            //     ),
            //   ]
            // ),
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
        logger.i("route ${state.matchedLocation}");
        final isLoginRoute = state.matchedLocation == '/auth/login';
        final isResetPasswordRoute =
            state.matchedLocation == '/auth/resetPassword';

        logger.w(
          "isLoginRoute $isLoginRoute",
        );

        return authNotifier.value.when(
          data: (loginState) {
            if (kDebugMode) {
              logger.i("loginState ${loginState.status.name}");
            }
            switch (loginState.status) {
              case AuthStatus.firstRun:
                if (kDebugMode) {
                  logger.i("firstRun ${state.matchedLocation}");
                }
                return LoginPage.routeLocation;
              case AuthStatus.initial:
                if (kDebugMode) {
                  logger.i("initial ${state.matchedLocation}");
                }
                return LoginPage.routeLocation;
              case AuthStatus.loading:
                return null;
              case AuthStatus.authenticated:
                if (kDebugMode) {
                  logger.i("authenticated ${state.matchedLocation}");
                }
                if (isLoginRoute) {
                  return MainPage.routeLocation;
                }
                return null;
              case AuthStatus.unauthenticated:
                if (kDebugMode) {
                  logger.i("unauthenticated ${state.matchedLocation}");
                }
                if (isLoginRoute || isResetPasswordRoute) {
                  return null;
                }
                return LoginPage.routeLocation;
              case AuthStatus.error:
                if (kDebugMode) logger.i("error");
                return LoginPage.routeLocation;
            }
          },
          error: (error, stack) {
            if (kDebugMode) logger.e("Auth error $error");
            return LoginPage.routeLocation;
          },
          loading: () => null,
        );
      });
  return router;
});
