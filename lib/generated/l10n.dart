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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Atheneox Studios`
  String get devStudio {
    return Intl.message(
      'Atheneox Studios',
      name: 'devStudio',
      desc: '',
      args: [],
    );
  }

  /// `Parkea!`
  String get parkeaAppName {
    return Intl.message('Parkea!', name: 'parkeaAppName', desc: '', args: []);
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

  /// `Únete a nuestro universo`
  String get joinOurUniverse {
    return Intl.message(
      'Únete a nuestro universo',
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
    return Intl.message('Autenticar', name: 'authenticate', desc: '', args: []);
  }

  /// `¡Bienvenido de nuevo!`
  String get welcomeAgain {
    return Intl.message(
      '¡Bienvenido de nuevo!',
      name: 'welcomeAgain',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar Sesión`
  String get login {
    return Intl.message('Iniciar Sesión', name: 'login', desc: '', args: []);
  }

  /// `Regístrate`
  String get signUp {
    return Intl.message('Regístrate', name: 'signUp', desc: '', args: []);
  }

  /// `Reestablecer Contraseña`
  String get resetPassword {
    return Intl.message(
      'Reestablecer Contraseña',
      name: 'resetPassword',
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
    return Intl.message('Contraseña', name: 'password', desc: '', args: []);
  }

  /// `Usuario o correo`
  String get usernameOrEmail {
    return Intl.message(
      'Usuario o correo',
      name: 'usernameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Ingresa tu usuario o correo`
  String get usernameOrEmailRequired {
    return Intl.message(
      'Ingresa tu usuario o correo',
      name: 'usernameOrEmailRequired',
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

  /// `Nombre de usuario`
  String get name {
    return Intl.message('Nombre de usuario', name: 'name', desc: '', args: []);
  }

  /// `Provincia`
  String get province {
    return Intl.message('Provincia', name: 'province', desc: '', args: []);
  }

  /// `Eventos Populares`
  String get popularEvents {
    return Intl.message(
      'Eventos Populares',
      name: 'popularEvents',
      desc: '',
      args: [],
    );
  }

  /// `Ir al Evento`
  String get seeEvent {
    return Intl.message('Ir al Evento', name: 'seeEvent', desc: '', args: []);
  }

  /// `Comprar Entrada`
  String get buyTicket {
    return Intl.message(
      'Comprar Entrada',
      name: 'buyTicket',
      desc: '',
      args: [],
    );
  }

  /// `Guardar Evento`
  String get saveEvent {
    return Intl.message(
      'Guardar Evento',
      name: 'saveEvent',
      desc: '',
      args: [],
    );
  }

  /// `Registro`
  String get register {
    return Intl.message('Registro', name: 'register', desc: '', args: []);
  }

  /// `Eventos`
  String get myEvents {
    return Intl.message('Eventos', name: 'myEvents', desc: '', args: []);
  }

  /// `Pagos`
  String get myEventsPaid {
    return Intl.message('Pagos', name: 'myEventsPaid', desc: '', args: []);
  }

  /// `Gardados`
  String get myEventsSaved {
    return Intl.message('Gardados', name: 'myEventsSaved', desc: '', args: []);
  }

  /// `Información`
  String get information {
    return Intl.message('Información', name: 'information', desc: '', args: []);
  }

  /// `Eventos Similares`
  String get similarEvents {
    return Intl.message(
      'Eventos Similares',
      name: 'similarEvents',
      desc: '',
      args: [],
    );
  }

  /// `Configuración`
  String get settings {
    return Intl.message('Configuración', name: 'settings', desc: '', args: []);
  }

  /// `Cerrar Sesión`
  String get logout {
    return Intl.message('Cerrar Sesión', name: 'logout', desc: '', args: []);
  }

  /// `Ayuda`
  String get getHelp {
    return Intl.message('Ayuda', name: 'getHelp', desc: '', args: []);
  }

  /// `Datos & Privacidad`
  String get dataAndPrivacy {
    return Intl.message(
      'Datos & Privacidad',
      name: 'dataAndPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Categorias`
  String get categories {
    return Intl.message('Categorias', name: 'categories', desc: '', args: []);
  }

  /// `Este campo es obligatorio`
  String get fieldRequired {
    return Intl.message(
      'Este campo es obligatorio',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Correo electrónico no válido`
  String get invalidEmail {
    return Intl.message(
      'Correo electrónico no válido',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña debe tener al menos 8 caracteres`
  String get passwordTooShort {
    return Intl.message(
      'La contraseña debe tener al menos 8 caracteres',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Las contraseñas no coinciden',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar contraseña`
  String get confirmPassword {
    return Intl.message(
      'Confirmar contraseña',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Nueva contraseña`
  String get newPassword {
    return Intl.message(
      'Nueva contraseña',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar contraseña`
  String get changePassword {
    return Intl.message(
      'Cambiar contraseña',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Si el correo está registrado, te enviamos un enlace para restablecer la contraseña`
  String get resetEmailSent {
    return Intl.message(
      'Si el correo está registrado, te enviamos un enlace para restablecer la contraseña',
      name: 'resetEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña actualizada. Inicia sesión.`
  String get passwordResetDone {
    return Intl.message(
      'Contraseña actualizada. Inicia sesión.',
      name: 'passwordResetDone',
      desc: '',
      args: [],
    );
  }

  /// `Ya tengo un enlace`
  String get haveResetLink {
    return Intl.message(
      'Ya tengo un enlace',
      name: 'haveResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Es una contraseña demasiado común`
  String get passwordTooCommon {
    return Intl.message(
      'Es una contraseña demasiado común',
      name: 'passwordTooCommon',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña no puede ser solo números`
  String get passwordEntirelyNumeric {
    return Intl.message(
      'La contraseña no puede ser solo números',
      name: 'passwordEntirelyNumeric',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña se parece demasiado a tu usuario o correo`
  String get passwordTooSimilar {
    return Intl.message(
      'La contraseña se parece demasiado a tu usuario o correo',
      name: 'passwordTooSimilar',
      desc: '',
      args: [],
    );
  }

  /// `Eventos para ti`
  String get eventsForYou {
    return Intl.message(
      'Eventos para ti',
      name: 'eventsForYou',
      desc: '',
      args: [],
    );
  }

  /// `Gratis`
  String get costFree {
    return Intl.message('Gratis', name: 'costFree', desc: '', args: []);
  }

  /// `Con invitación`
  String get costInvitation {
    return Intl.message(
      'Con invitación',
      name: 'costInvitation',
      desc: '',
      args: [],
    );
  }

  /// `Privado`
  String get costPrivate {
    return Intl.message('Privado', name: 'costPrivate', desc: '', args: []);
  }

  /// `{count} cupos disponibles`
  String spotsLeft(int count) {
    return Intl.message(
      '$count cupos disponibles',
      name: 'spotsLeft',
      desc: '',
      args: [count],
    );
  }

  /// `Agotado`
  String get soldOut {
    return Intl.message('Agotado', name: 'soldOut', desc: '', args: []);
  }

  /// `Aún no hay eventos`
  String get feedEmpty {
    return Intl.message(
      'Aún no hay eventos',
      name: 'feedEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No se pudieron cargar los eventos`
  String get feedLoadError {
    return Intl.message(
      'No se pudieron cargar los eventos',
      name: 'feedLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Reintentar`
  String get retry {
    return Intl.message('Reintentar', name: 'retry', desc: '', args: []);
  }

  /// `Ya viste todos los eventos`
  String get feedEnd {
    return Intl.message(
      'Ya viste todos los eventos',
      name: 'feedEnd',
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
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'zh'),
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
