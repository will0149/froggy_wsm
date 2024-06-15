import 'package:cct_management/app/pages/count/count_page.dart';
import 'package:cct_management/app/pages/outgoing/outgoing_page.dart';
import 'package:cct_management/app/pages/relocation/relocation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'entry/entry_page.dart';
import 'main_page.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/09/24
 */

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final routerProvider = Provider<GoRouter>((ref) {
  // final authState = ref.watch(authSessionProvider);
  final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: "/main",
      routes: <RouteBase>[
        GoRoute(
          name: MainPage.routeName,
          path: MainPage.routeLocation,
          builder: (BuildContext context, GoRouterState state) {
            return const MainPage();
          },
        ),
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
      ]);
  return router;
});
