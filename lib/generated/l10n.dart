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

  /// `Froggy`
  String get appName {
    return Intl.message('Froggy', name: 'appName', desc: '', args: []);
  }

  /// `Froggy Soft`
  String get appFullName {
    return Intl.message('Froggy Soft', name: 'appFullName', desc: '', args: []);
  }

  /// `No tienes una cuenta todavia?`
  String get dontHaveAnAccountYet {
    return Intl.message(
      'No tienes una cuenta todavia?',
      name: 'dontHaveAnAccountYet',
      desc: '',
      args: [],
    );
  }

  /// `Entrada`
  String get entryMenuName {
    return Intl.message('Entrada', name: 'entryMenuName', desc: '', args: []);
  }

  /// `Reubicación`
  String get relocationMenuName {
    return Intl.message(
      'Reubicación',
      name: 'relocationMenuName',
      desc: '',
      args: [],
    );
  }

  /// `Conteo`
  String get countMenuName {
    return Intl.message('Conteo', name: 'countMenuName', desc: '', args: []);
  }

  /// `Salida`
  String get outgoingMenuName {
    return Intl.message('Salida', name: 'outgoingMenuName', desc: '', args: []);
  }

  /// `Búsqueda`
  String get searchMenuName {
    return Intl.message('Búsqueda', name: 'searchMenuName', desc: '', args: []);
  }

  /// `Ajustes`
  String get settingsMenuName {
    return Intl.message(
      'Ajustes',
      name: 'settingsMenuName',
      desc: '',
      args: [],
    );
  }

  /// `Correo Electrónico`
  String get emailInput {
    return Intl.message(
      'Correo Electrónico',
      name: 'emailInput',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get passwordInput {
    return Intl.message(
      'Contraseña',
      name: 'passwordInput',
      desc: '',
      args: [],
    );
  }

  /// `Es Serie?`
  String get isSeriesInput {
    return Intl.message('Es Serie?', name: 'isSeriesInput', desc: '', args: []);
  }

  /// `Cantidad de series`
  String get countSeriesInput {
    return Intl.message(
      'Cantidad de series',
      name: 'countSeriesInput',
      desc: '',
      args: [],
    );
  }

  /// `Agregar Series`
  String get addSeriesInput {
    return Intl.message(
      'Agregar Series',
      name: 'addSeriesInput',
      desc: '',
      args: [],
    );
  }

  /// `Clientes`
  String get customersListInput {
    return Intl.message(
      'Clientes',
      name: 'customersListInput',
      desc: '',
      args: [],
    );
  }

  /// `Bodegas`
  String get warehouseListInput {
    return Intl.message(
      'Bodegas',
      name: 'warehouseListInput',
      desc: '',
      args: [],
    );
  }

  /// `Bodega Origen`
  String get warehouseOriginListInput {
    return Intl.message(
      'Bodega Origen',
      name: 'warehouseOriginListInput',
      desc: '',
      args: [],
    );
  }

  /// `Bodega Destino`
  String get warehouseDestinyListInput {
    return Intl.message(
      'Bodega Destino',
      name: 'warehouseDestinyListInput',
      desc: '',
      args: [],
    );
  }

  /// `Carton ID`
  String get cartonIdInput {
    return Intl.message('Carton ID', name: 'cartonIdInput', desc: '', args: []);
  }

  /// `Carton ID origen`
  String get cartonIdOriginInput {
    return Intl.message(
      'Carton ID origen',
      name: 'cartonIdOriginInput',
      desc: '',
      args: [],
    );
  }

  /// `Carton ID destino`
  String get cartonIdDestinyInput {
    return Intl.message(
      'Carton ID destino',
      name: 'cartonIdDestinyInput',
      desc: '',
      args: [],
    );
  }

  /// `Número de contenedor`
  String get containerInput {
    return Intl.message(
      'Número de contenedor',
      name: 'containerInput',
      desc: '',
      args: [],
    );
  }

  /// `DMC`
  String get dmcInput {
    return Intl.message('DMC', name: 'dmcInput', desc: '', args: []);
  }

  /// `Ubicación`
  String get locationInput {
    return Intl.message('Ubicación', name: 'locationInput', desc: '', args: []);
  }

  /// `Ubicación origen`
  String get locationOriginInput {
    return Intl.message(
      'Ubicación origen',
      name: 'locationOriginInput',
      desc: '',
      args: [],
    );
  }

  /// `Ubicación destino`
  String get locationDestinyInput {
    return Intl.message(
      'Ubicación destino',
      name: 'locationDestinyInput',
      desc: '',
      args: [],
    );
  }

  /// `Lote`
  String get batchInput {
    return Intl.message('Lote', name: 'batchInput', desc: '', args: []);
  }

  /// `Activo`
  String get assetInput {
    return Intl.message('Activo', name: 'assetInput', desc: '', args: []);
  }

  /// `Fecha de llegada`
  String get incomingDateInput {
    return Intl.message(
      'Fecha de llegada',
      name: 'incomingDateInput',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de salida`
  String get outgoingDateInput {
    return Intl.message(
      'Fecha de salida',
      name: 'outgoingDateInput',
      desc: '',
      args: [],
    );
  }

  /// `Peso en KG`
  String get weightInput {
    return Intl.message('Peso en KG', name: 'weightInput', desc: '', args: []);
  }

  /// `Dimensiones`
  String get dimensionInput {
    return Intl.message(
      'Dimensiones',
      name: 'dimensionInput',
      desc: '',
      args: [],
    );
  }

  /// `Altura`
  String get heightInput {
    return Intl.message('Altura', name: 'heightInput', desc: '', args: []);
  }

  /// `Anchura`
  String get widthInput {
    return Intl.message('Anchura', name: 'widthInput', desc: '', args: []);
  }

  /// `LArgo`
  String get longInput {
    return Intl.message('LArgo', name: 'longInput', desc: '', args: []);
  }

  /// `Observaciones`
  String get remarksInput {
    return Intl.message(
      'Observaciones',
      name: 'remarksInput',
      desc: '',
      args: [],
    );
  }

  /// `Búsqueda de Stocks`
  String get searchInput {
    return Intl.message(
      'Búsqueda de Stocks',
      name: 'searchInput',
      desc: '',
      args: [],
    );
  }

  /// `Dañado`
  String get damaged {
    return Intl.message('Dañado', name: 'damaged', desc: '', args: []);
  }

  /// `Entradas`
  String get entryPageTitle {
    return Intl.message('Entradas', name: 'entryPageTitle', desc: '', args: []);
  }

  /// `Reubicaciones`
  String get relocationPageTitle {
    return Intl.message(
      'Reubicaciones',
      name: 'relocationPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Conteos`
  String get countPageTitle {
    return Intl.message('Conteos', name: 'countPageTitle', desc: '', args: []);
  }

  /// `Salidas`
  String get outgoingPageTitle {
    return Intl.message(
      'Salidas',
      name: 'outgoingPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Búsquedas`
  String get searchPageTitle {
    return Intl.message(
      'Búsquedas',
      name: 'searchPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Ajustes`
  String get settingsPageTitle {
    return Intl.message(
      'Ajustes',
      name: 'settingsPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Agregar Entrada`
  String get entryFormTitle {
    return Intl.message(
      'Agregar Entrada',
      name: 'entryFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reubicar mercancía`
  String get relocationFormTitle {
    return Intl.message(
      'Reubicar mercancía',
      name: 'relocationFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Conteo de mercancía`
  String get countPageFormTitle {
    return Intl.message(
      'Conteo de mercancía',
      name: 'countPageFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Salida de mercancía`
  String get outgoingFormTitle {
    return Intl.message(
      'Salida de mercancía',
      name: 'outgoingFormTitle',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get searchFormTitle {
    return Intl.message('', name: 'searchFormTitle', desc: '', args: []);
  }

  /// `Buscar mercancía`
  String get settingsFormTitle {
    return Intl.message(
      'Buscar mercancía',
      name: 'settingsFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Entorno`
  String get environment {
    return Intl.message('Entorno', name: 'environment', desc: '', args: []);
  }

  /// `versión`
  String get version {
    return Intl.message('versión', name: 'version', desc: '', args: []);
  }

  /// `Iniciar Sesión`
  String get loginButton {
    return Intl.message(
      'Iniciar Sesión',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar Sesión`
  String get logoutButton {
    return Intl.message(
      'Cerrar Sesión',
      name: 'logoutButton',
      desc: '',
      args: [],
    );
  }

  /// `Pulgadas`
  String get inches {
    return Intl.message('Pulgadas', name: 'inches', desc: '', args: []);
  }

  /// `El campo no puede estar vacío`
  String get fieldCantBeEmpty {
    return Intl.message(
      'El campo no puede estar vacío',
      name: 'fieldCantBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Realizado Exitosamente`
  String get successToast {
    return Intl.message(
      'Realizado Exitosamente',
      name: 'successToast',
      desc: '',
      args: [],
    );
  }

  /// `Algo a Fallado`
  String get failedToast {
    return Intl.message(
      'Algo a Fallado',
      name: 'failedToast',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get saveButton {
    return Intl.message('Guardar', name: 'saveButton', desc: '', args: []);
  }

  /// `Quieres Salir?`
  String get wantToExit {
    return Intl.message(
      'Quieres Salir?',
      name: 'wantToExit',
      desc: '',
      args: [],
    );
  }

  /// `Estas seguro que quieres abandonar esta pagina?`
  String get sureWantToExit {
    return Intl.message(
      'Estas seguro que quieres abandonar esta pagina?',
      name: 'sureWantToExit',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get cancel {
    return Intl.message('Cancelar', name: 'cancel', desc: '', args: []);
  }

  /// `Salir`
  String get exit {
    return Intl.message('Salir', name: 'exit', desc: '', args: []);
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
