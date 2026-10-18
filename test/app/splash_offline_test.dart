import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/pages/auth/splash_screen.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/data/entities/user/user_profile_dto.dart';
import 'package:parkea/domain/models/auth/auth_state.dart';
import 'package:parkea/domain/usecases/auth/rest_auth_uc.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

/// Sin red en el primer intento; al reintentar, la sesión abre.
class _OfflineThenOnline extends RestAuthUC {
  static var attempts = 0;

  @override
  Future<AuthState> build() async => ++attempts == 1
      ? AuthState.offline()
      : AuthState.authenticated(UserProfileDTO(username: 'yo'));
}

void main() {
  setUpAll(setUpDomainTests);

  testWidgets('sin conexión: avisa y reintentar vuelve a abrir la sesión',
      (tester) async {
    _OfflineThenOnline.attempts = 0;
    final container = ProviderContainer(
      overrides: [restAuthUCProvider.overrideWith(_OfflineThenOnline.new)],
      retry: (_, __) => null,
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('es'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const SplashScreen(),
      ),
    ));
    await tester.pump();

    expect(find.text('Sin conexión'), findsOneWidget);

    await tester.tap(find.text('Reintentar'));
    await tester.pump();
    await tester.pump();

    expect(_OfflineThenOnline.attempts, 2);
    expect(container.read(restAuthUCProvider).value?.isAuthenticated, isTrue);
  });
}
