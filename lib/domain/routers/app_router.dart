import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/pages/auth/auth_page.dart';
import 'package:parkea/app/pages/auth/login_page.dart';
import 'package:parkea/app/pages/auth/password_reset_page.dart';
import 'package:parkea/app/pages/auth/sign_up_page.dart';
import 'package:parkea/app/pages/user/user_settings.dart';

import '../../app/navigator.dart';
import '../../app/pages/auth/splash_screen.dart';
import '../../app/pages/auth/welcome_slide_page.dart';
import '../../app/pages/event/event_detail_page.dart';
import '../../app/pages/event/saved_event_page.dart';
import '../../app/pages/home/home_feed_page.dart';
import '../../app/pages/user/profile_page.dart';
import '../../device/utils/is_first_run.dart';
import '../utils/impl/build_headers_utils_impl.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/02/23
 */

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

// class AppRouter {
//
//   Provider<GoRouter> routerProvider(){
//     return
final routerProvider = Provider<GoRouter>((Ref ref) {
  // final authState = ref.watch(authSessionProviderProvider);
  final router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: "/auth/splash",
      routes: <RouteBase>[
        GoRoute(
          name: WelcomeSlidePage.routeName,
          path: WelcomeSlidePage.routeLocation,
          builder: (BuildContext context, GoRouterState state) {
            return const WelcomeSlidePage();
          },
        ),
        GoRoute(
          name: AuthPage.routeName,
          path: AuthPage.routeLocation,
          builder: (BuildContext context, GoRouterState state) {
            return const AuthPage();
          },
          routes: <RouteBase>[
            GoRoute(
              name: LoginPage.routeName,
              path: LoginPage.routeLocation,
              builder: (BuildContext context, GoRouterState state) {
                return const LoginPage();
              },
            ),
            GoRoute(
              name: SignUpPage.routeName,
              path: SignUpPage.routeLocation,
              builder: (BuildContext context, GoRouterState state) {
                return const SignUpPage();
              },
            ),
            GoRoute(
              name: PasswordResetPage.routeName,
              path: PasswordResetPage.routeLocation,
              builder: (BuildContext context, GoRouterState state) {
                return const PasswordResetPage();
              },
            ),
            GoRoute(
              name: SplashScreen.routeName,
              path: SplashScreen.routeLocation,
              builder: (BuildContext context, GoRouterState state) {
                return const SplashScreen();
              },
            ),
          ],
        ),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state,
              StatefulNavigationShell navigationShell) {
            // Return the widget that implements the custom shell (in this case
            // using a BottomNavigationBar). The StatefulNavigationShell is passed
            // to be able access the state of the shell and to navigate to other
            // branches in a stateful way.
            return NavigatorBar(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            // The route branch for the first tab of the bottom navigation bar.
            StatefulShellBranch(
              navigatorKey: _sectionANavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  // The screen to display as the root in the first tab of the
                  // bottom navigation bar.
                  name: HomeFeedPage.routeName,
                  path: "/",
                  builder: (BuildContext context, GoRouterState state) =>
                  const HomeFeedPage(),
                  routes: <RouteBase>[
                    GoRoute(
                        name: EventDetailPage.routeName,
                        path: EventDetailPage.routeLocation,
                        builder: (context, state) => EventDetailPage(
                            eventId: int.parse(state.pathParameters['id']!),
                          ),
                    ),
                  ],
                ),
              ],
            ),

            // The route branch for the third tab of the bottom navigation bar.
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  // The screen to display as the root in the third tab of the
                  // bottom navigation bar.
                  name: ProfilePage.routeName,
                  path: ProfilePage.routeLocation,
                  builder: (BuildContext context, GoRouterState state) => const ProfilePage(),
                  routes: <RouteBase>[
                    GoRoute(
                      name: UserSettingsPage.routeName,
                      path: UserSettingsPage.routeLocation,
                      builder: ( context,  state) =>
                      const UserSettingsPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      redirect: (context, state) async {
        var firstRun = IsFirstRun();
        bool firstCall = await firstRun.isFirstRun();
        final isSplash = state.matchedLocation == "/auth/splash";
        final storageUtils = BuildHeadersUtilsImpl();
        bool hasStorage = await storageUtils.validateStorage();
        if (firstCall) {
          return WelcomeSlidePage.routeLocation;
        }
        //hasta aqui
        if (isSplash) {
          return hasStorage ? HomeFeedPage.routeLocation : AuthPage.routeLocation;
        }
        if (state.matchedLocation != AuthPage.routeLocation &&
            state.matchedLocation != "/auth/splash") {
          return state.matchedLocation;
        }
      });
  return router;
});

//context.go() es para shell route
//context.pushNamed(EventDetailPage.routeName, pathParameters: {"id": id}); para pasar path params al router
