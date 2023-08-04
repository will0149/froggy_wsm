import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/pages/auth/auth_page.dart';
import 'package:parkea/app/pages/auth/login_page.dart';
import 'package:parkea/app/pages/auth/sign_up_page.dart';

import 'app/navigator.dart';
import 'app/pages/onboarding_page.dart';
import 'app/pages/slide_show_page.dart';
import 'app/pages/validate_page/loading_page.dart';
import 'app/themes/custom_theme.dart';
import 'app/utils/transitions/FadeRoute.dart';
import 'app/utils/transitions/SlideRightRoute.dart';
import 'app/utils/transitions/slide_left_route.dart';
import 'domain/providers/app_theme_provider.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Parkea',
      theme: getAppTheme(context, ref.watch(appThemeProvider)),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/main":
            return MaterialPageRoute(builder: (_) => const AuthPage());
          case "/login":
            return SlideLeftRoute(page: const LoginPage());
          case "/signup":
            return SlideRightRoute(page: const SignUpPage());
          case "/onboarding":
            return MaterialPageRoute(builder: (_) => const OnboardingPage());
          case "/navigator":
            return FadeRoute(page: const NavigatorBar());
          case "/slideshow":
            return FadeRoute(page: const SlideshowPage());
        }
        return null;
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        // Obtain the current media query information.
        final mediaQueryData = MediaQuery.of(context);

        return MediaQuery(
          // Set the default textScaleFactor to 1.0 for
          // the whole subtree.
          data: mediaQueryData.copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: const SplashScreen(),
    );
  }
}
