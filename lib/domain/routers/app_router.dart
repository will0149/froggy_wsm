import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/pages/auth/auth_page.dart';
import 'package:parkea/app/pages/auth/login_page.dart';
import 'package:parkea/app/pages/auth/password_reset_page.dart';
import 'package:parkea/app/pages/auth/sign_up_page.dart';
import 'package:parkea/app/pages/user/user_settings.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:parkea/domain/models/auth/auth_state.dart';
import 'package:parkea/domain/usecases/auth/rest_auth_uc.dart';

import '../../app/navigator.dart';
import '../../app/pages/auth/splash_screen.dart';
import '../../app/pages/auth/welcome_slide_page.dart';
import '../../app/pages/event/event_detail_page.dart';
import '../../app/pages/event/ticket_purchase_page.dart';
import '../../app/pages/home/home_feed_page.dart';
import '../../app/pages/ticket/tickets_page.dart';
import '../../app/pages/user/profile_page.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 11/02/23

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final routerProvider = Provider<GoRouter>((Ref ref) {
  final authNotifier = ValueNotifier<AsyncValue<AuthState>>(const AsyncValue.loading());
  ref.listen(restAuthUCProvider, (_, next) {
    authNotifier.value = next;
  });

  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: "/auth/splash",
      refreshListenable: authNotifier,
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
                        routes: <RouteBase>[
                          GoRoute(
                            name: TicketPurchasePage.routeName,
                            path: TicketPurchasePage.routeLocation,
                            builder: (context, state) => TicketPurchasePage(
                              eventId: int.parse(state.pathParameters['id']!),
                            ),
                          ),
                        ],
                    ),
                  ],
                ),
              ],
            ),

            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  // The screen to display as the root in the third tab of the
                  // bottom navigation bar.
                  name: TicketsPage.routeName,
                  path: TicketsPage.routeLocation,
                  builder: (BuildContext context, GoRouterState state) => const TicketsPage(),
                  routes: <RouteBase>[
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
        logger.i("route ${state.matchedLocation}");
        final isLoginRoute = state.matchedLocation == '/auth/login';
        final isRegisterRoute = state.matchedLocation == '/auth/signup';
        final isAuthRoute = state.matchedLocation == '/auth';
        final isLoadingRoute = state.matchedLocation == '/auth/splash';
        final isResetPasswordRoute = state.matchedLocation == '/auth/resetPassword';

        logger.w(
          "isLoginRoute $isLoginRoute isRegisterRoute $isRegisterRoute isAuthRoute $isAuthRoute isLoadingRoute $isLoadingRoute",
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
                return WelcomeSlidePage.routeLocation;
              case AuthStatus.initial:
                if (kDebugMode) {
                  logger.i("initial ${state.matchedLocation}");
                }
                return AuthPage.routeLocation;
              case AuthStatus.loading:
                return null;
              case AuthStatus.authenticated:
                if (kDebugMode) {
                  logger.i("authenticated ${state.matchedLocation}");
                }
                if (isAuthRoute ||
                    isLoginRoute ||
                    isRegisterRoute ||
                    isLoadingRoute) {
                  return HomeFeedPage.routeLocation;
                }
                return null;
              case AuthStatus.unauthenticated:
                if (kDebugMode) {
                  logger.i("unauthenticated ${state.matchedLocation}");
                }
                if (isLoginRoute || isRegisterRoute || isAuthRoute || isResetPasswordRoute) {
                  return null;
                }
                return AuthPage.routeLocation;
              case AuthStatus.error:
                if (kDebugMode) logger.i("error");
                return LoginPage.routeLocation;
            }
          },
          error: (error, stack) {
            if (kDebugMode) logger.e("Auth error $error");
            return AuthPage.routeLocation;
          },
          loading: () => null,
        );
      });
});

//context.go() es para shell route
//context.pushNamed(EventDetailPage.routeName, pathParameters: {"id": id}); para pasar path params al router
