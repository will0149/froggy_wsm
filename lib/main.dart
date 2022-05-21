import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:parkea/src/constants/colors.dart';
import 'package:parkea/src/pages/auth/auth_page.dart';
import 'package:parkea/src/pages/auth/login_page.dart';
import 'package:parkea/src/pages/auth/sign_up_page.dart';
import 'package:parkea/src/themes/parkea_input_decoration_theme.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Parkea',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          fontFamily: 'Gothic A1',
          inputDecorationTheme: parkeaInputDecorationTheme,
        // textTheme: const TextTheme(
        //   titleLarge: TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 24,
        //   ),
        //   titleMedium: TextStyle(
        //     color: parkeaBlueAccent,
        //     fontWeight: FontWeight.normal,
        //     fontSize: 28,
        //   ),
        //   bodySmall: TextStyle(
        //     color: parkeaBlueAccent,
        //     fontWeight: FontWeight.normal,
        //     fontSize: 12,
        //   ),
        //   bodyMedium: TextStyle(
        //     color: parkeaBlueAccent,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 12,
        //   ),
        //   bodyLarge: TextStyle(
        //     color: parkeaBlueAccent,
        //     fontWeight: FontWeight.normal,
        //     fontSize: 20,
        //   ),
        // ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/main":
            return MaterialPageRoute(builder: (_) => const AuthPage());
          case "/login":
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case "/signup":
            return MaterialPageRoute(builder: (_)  => const SignUpPage());
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
      home: const AuthPage(),
    );
  }
}
