// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Atheneox`
  String get devStudio {
    return Intl.message(
      'Atheneox',
      name: 'devStudio',
      desc: '',
      args: [],
    );
  }

  /// `Parkea!`
  String get parkeaAppName {
    return Intl.message(
      'Parkea!',
      name: 'parkeaAppName',
      desc: '',
      args: [],
    );
  }

  /// `Parkea & Comparte`
  String get parkeaAndShare {
    return Intl.message(
      'Parkea & Comparte',
      name: 'parkeaAndShare',
      desc: '',
      args: [],
    );
  }

  /// `Unete a nuestro universo`
  String get joinOurUniverse {
    return Intl.message(
      'Unete a nuestro universo',
      name: 'joinOurUniverse',
      desc: '',
      args: [],
    );
  }

  /// `Eventos para todos`
  String get eventsForAll {
    return Intl.message(
      'Eventos para todos',
      name: 'eventsForAll',
      desc: '',
      args: [],
    );
  }

  /// `Autenticar`
  String get authenticate {
    return Intl.message(
      'Autenticar',
      name: 'authenticate',
      desc: '',
      args: [],
    );
  }

  /// `Bienvenido de nuevo!`
  String get welcomeAgain {
    return Intl.message(
      'Bienvenido de nuevo!',
      name: 'welcomeAgain',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar Sesión`
  String get login {
    return Intl.message(
      'Iniciar Sesión',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Registrate`
  String get signUp {
    return Intl.message(
      'Registrate',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Correo Electrónico`
  String get email {
    return Intl.message(
      'Correo Electrónico',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get password {
    return Intl.message(
      'Contraseña',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Olvide mi Contraseña`
  String get forgotPassword {
    return Intl.message(
      'Olvide mi Contraseña',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
