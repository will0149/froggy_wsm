import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/pages/auth/auth_page.dart';
import 'package:parkea/app/pages/auth/login_page.dart';
import 'package:parkea/app/pages/auth/password_reset_confirm_page.dart';
import 'package:parkea/app/pages/auth/password_reset_page.dart';
import 'package:parkea/app/pages/auth/sign_up_page.dart';
import 'package:parkea/app/pages/user/user_settings.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:parkea/domain/models/auth/auth_state.dart';
import 'package:parkea/domain/usecases/auth/rest_auth_uc.dart';

import '../../app/navigator.dart';
import '../../app/pages/auth/splash_screen.dart';
import '../../app/pages/auth/welcome_slide_page.dart';
import '../../app/pages/event/create_event_page.dart';
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
  final authNotifier =
      ValueNotifier<AsyncValue<AuthState>>(const AsyncValue.loading());
  ref.listen(restAuthUCProvider, (_, next) {
    authNotifier.value = next;
  });

  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: '/auth/splash',
    refreshListenable: authNotifier,
    routes: <RouteBase>[
      GoRoute(
        name: WelcomeSlidePage.routeName,
        path: WelcomeSlidePage.routeLocation,
        builder: (context, state) => const WelcomeSlidePage(),
      ),
      GoRoute(
        name: AuthPage.routeName,
        path: AuthPage.routeLocation,
        builder: (context, state) => const AuthPage(),
        routes: <RouteBase>[
          GoRoute(
            name: LoginPage.routeName,
            path: LoginPage.routeLocation,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            name: SignUpPage.routeName,
            path: SignUpPage.routeLocation,
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            name: PasswordResetPage.routeName,
            path: PasswordResetPage.routeLocation,
            builder: (context, state) => const PasswordResetPage(),
            routes: <RouteBase>[
              GoRoute(
                name: PasswordResetConfirmPage.routeName,
                path: PasswordResetConfirmPage.routeLocation,
                builder: (context, state) => PasswordResetConfirmPage(
                  uid: state.uri.queryParameters['uid'],
                  token: state.uri.queryParameters['token'],
                ),
              ),
            ],
          ),
          GoRoute(
            name: SplashScreen.routeName,
            path: SplashScreen.routeLocation,
            builder: (context, state) => const SplashScreen(),
          ),
        ],
      ),
      // A pantalla completa, sin la barra inferior.
      GoRoute(
        name: CreateEventPage.routeName,
        path: CreateEventPage.routeLocation,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CreateEventPage(),
      ),
      GoRoute(
        name: EditEventPage.routeName,
        path: EditEventPage.routeLocation,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => EditEventPage(
          eventId: int.parse(state.pathParameters['id']!),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            NavigatorBar(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          // Tab 1: Home
          StatefulShellBranch(
            navigatorKey: _sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                name: HomeFeedPage.routeName,
                path: '/',
                builder: (context, state) => const HomeFeedPage(),
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

          // Tab 2: Tickets
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: TicketsPage.routeName,
                path: TicketsPage.routeLocation,
                builder: (context, state) => const TicketsPage(),
              ),
            ],
          ),

          // Tab 3: Profile
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                name: ProfilePage.routeName,
                path: ProfilePage.routeLocation,
                builder: (context, state) => const ProfilePage(),
                routes: <RouteBase>[
                  GoRoute(
                    name: UserSettingsPage.routeName,
                    path: UserSettingsPage.routeLocation,
                    builder: (context, state) => const UserSettingsPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) async {
      if (kDebugMode) {
        logger.i('route ${state.matchedLocation}');
      }

      // Enlace del correo de reset: parkea://reset-password?uid=..&token=..
      if (state.uri.scheme == 'parkea' && state.uri.host == 'reset-password') {
        return state.namedLocation(
          PasswordResetConfirmPage.routeName,
          queryParameters: state.uri.queryParameters,
        );
      }

      final authBase = AuthPage.routeLocation;
      final isLoginRoute =
          state.matchedLocation == '$authBase/${LoginPage.routeLocation}';
      final isRegisterRoute =
          state.matchedLocation == '$authBase/${SignUpPage.routeLocation}';
      final isAuthRoute = state.matchedLocation == authBase;
      final isLoadingRoute =
          state.matchedLocation == '$authBase/${SplashScreen.routeLocation}';
      // Incluye la confirmación (…/resetPassword/confirm).
      final isResetPasswordRoute = state.matchedLocation
          .startsWith('$authBase/${PasswordResetPage.routeLocation}');

      return authNotifier.value.when(
        data: (loginState) {
          if (kDebugMode) {
            logger.i('loginState ${loginState.status.name}');
          }
          switch (loginState.status) {
            case AuthStatus.firstRun:
              if (kDebugMode) logger.i('firstRun ${state.matchedLocation}');
              return WelcomeSlidePage.routeLocation;
            case AuthStatus.initial:
              if (kDebugMode) logger.i('initial ${state.matchedLocation}');
              return AuthPage.routeLocation;
            case AuthStatus.loading:
              return null;
            case AuthStatus.authenticated:
              if (kDebugMode) {
                logger.i('authenticated ${state.matchedLocation}');
              }
              if (isAuthRoute ||
                  isLoginRoute ||
                  isRegisterRoute ||
                  isLoadingRoute ||
                  isResetPasswordRoute) {
                return HomeFeedPage.routeLocation;
              }
              return null;
            case AuthStatus.unauthenticated:
              if (kDebugMode) {
                logger.i('unauthenticated ${state.matchedLocation}');
              }
              if (isLoginRoute ||
                  isRegisterRoute ||
                  isAuthRoute ||
                  isResetPasswordRoute) {
                return null;
              }
              return AuthPage.routeLocation;
            case AuthStatus.error:
              if (kDebugMode) logger.i('error');
              // El formulario muestra el error; se queda en la pantalla actual.
              if (isLoginRoute ||
                  isRegisterRoute ||
                  isAuthRoute ||
                  isResetPasswordRoute) {
                return null;
              }
              return '$authBase/${LoginPage.routeLocation}';
          }
        },
        error: (error, stack) {
          if (kDebugMode) logger.e('Auth error $error');
          return AuthPage.routeLocation;
        },
        loading: () => null,
      );
    },
  );

  ref.onDispose(() {
    authNotifier.dispose();
    router.dispose();
  });

  return router;
});
