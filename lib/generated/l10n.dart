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

  /// `Guardados`
  String get myEventsSaved {
    return Intl.message('Guardados', name: 'myEventsSaved', desc: '', args: []);
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

  /// `Inicio`
  String get navHome {
    return Intl.message('Inicio', name: 'navHome', desc: '', args: []);
  }

  /// `Tickets`
  String get navTickets {
    return Intl.message('Tickets', name: 'navTickets', desc: '', args: []);
  }

  /// `Perfil`
  String get navProfile {
    return Intl.message('Perfil', name: 'navProfile', desc: '', args: []);
  }

  /// `Crear evento`
  String get createEvent {
    return Intl.message(
      'Crear evento',
      name: 'createEvent',
      desc: '',
      args: [],
    );
  }

  /// `{count} tickets próximos`
  String upcomingTicketsCount(int count) {
    return Intl.message(
      '$count tickets próximos',
      name: 'upcomingTicketsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Mis Tickets`
  String get myTickets {
    return Intl.message('Mis Tickets', name: 'myTickets', desc: '', args: []);
  }

  /// `Próximos`
  String get ticketsUpcoming {
    return Intl.message(
      'Próximos',
      name: 'ticketsUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `Anteriores`
  String get ticketsPast {
    return Intl.message('Anteriores', name: 'ticketsPast', desc: '', args: []);
  }

  /// `Descargar ticket`
  String get downloadTicket {
    return Intl.message(
      'Descargar ticket',
      name: 'downloadTicket',
      desc: '',
      args: [],
    );
  }

  /// `Nombre del evento`
  String get eventName {
    return Intl.message(
      'Nombre del evento',
      name: 'eventName',
      desc: '',
      args: [],
    );
  }

  /// `Descripción corta`
  String get eventShortDescription {
    return Intl.message(
      'Descripción corta',
      name: 'eventShortDescription',
      desc: '',
      args: [],
    );
  }

  /// `Descripción`
  String get eventDescription {
    return Intl.message(
      'Descripción',
      name: 'eventDescription',
      desc: '',
      args: [],
    );
  }

  /// `Fecha y hora`
  String get eventDateTime {
    return Intl.message(
      'Fecha y hora',
      name: 'eventDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Lugar`
  String get eventPlace {
    return Intl.message('Lugar', name: 'eventPlace', desc: '', args: []);
  }

  /// `Categoría`
  String get eventCategory {
    return Intl.message('Categoría', name: 'eventCategory', desc: '', args: []);
  }

  /// `Sin categoría`
  String get categoryNone {
    return Intl.message(
      'Sin categoría',
      name: 'categoryNone',
      desc: '',
      args: [],
    );
  }

  /// `Música`
  String get catMusic {
    return Intl.message('Música', name: 'catMusic', desc: '', args: []);
  }

  /// `Camping`
  String get catCamping {
    return Intl.message('Camping', name: 'catCamping', desc: '', args: []);
  }

  /// `Aventura`
  String get catAdventure {
    return Intl.message('Aventura', name: 'catAdventure', desc: '', args: []);
  }

  /// `Talleres`
  String get catWorkshops {
    return Intl.message('Talleres', name: 'catWorkshops', desc: '', args: []);
  }

  /// `Tipo de acceso`
  String get costType {
    return Intl.message('Tipo de acceso', name: 'costType', desc: '', args: []);
  }

  /// `De pago`
  String get costPaid {
    return Intl.message('De pago', name: 'costPaid', desc: '', args: []);
  }

  /// `Precio`
  String get eventPrice {
    return Intl.message('Precio', name: 'eventPrice', desc: '', args: []);
  }

  /// `Moneda`
  String get eventCurrency {
    return Intl.message('Moneda', name: 'eventCurrency', desc: '', args: []);
  }

  /// `Cupo`
  String get eventCapacity {
    return Intl.message('Cupo', name: 'eventCapacity', desc: '', args: []);
  }

  /// `Vacío = sin límite`
  String get capacityHint {
    return Intl.message(
      'Vacío = sin límite',
      name: 'capacityHint',
      desc: '',
      args: [],
    );
  }

  /// `Agregar imagen`
  String get addBanner {
    return Intl.message(
      'Agregar imagen',
      name: 'addBanner',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar imagen`
  String get changeBanner {
    return Intl.message(
      'Cambiar imagen',
      name: 'changeBanner',
      desc: '',
      args: [],
    );
  }

  /// `Publicar evento`
  String get publishEvent {
    return Intl.message(
      'Publicar evento',
      name: 'publishEvent',
      desc: '',
      args: [],
    );
  }

  /// `Evento creado`
  String get eventCreated {
    return Intl.message(
      'Evento creado',
      name: 'eventCreated',
      desc: '',
      args: [],
    );
  }

  /// `El evento se creó, pero la imagen no se pudo subir`
  String get bannerUploadFailed {
    return Intl.message(
      'El evento se creó, pero la imagen no se pudo subir',
      name: 'bannerUploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `La fecha debe ser futura`
  String get dateMustBeFuture {
    return Intl.message(
      'La fecha debe ser futura',
      name: 'dateMustBeFuture',
      desc: '',
      args: [],
    );
  }

  /// `El precio debe ser mayor que 0`
  String get pricePositive {
    return Intl.message(
      'El precio debe ser mayor que 0',
      name: 'pricePositive',
      desc: '',
      args: [],
    );
  }

  /// `Usa un código de 3 letras, p. ej. USD`
  String get invalidCurrency {
    return Intl.message(
      'Usa un código de 3 letras, p. ej. USD',
      name: 'invalidCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Número no válido`
  String get invalidNumber {
    return Intl.message(
      'Número no válido',
      name: 'invalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Inscritos`
  String get myEventsEnrolled {
    return Intl.message(
      'Inscritos',
      name: 'myEventsEnrolled',
      desc: '',
      args: [],
    );
  }

  /// `Aún no has creado eventos`
  String get noOwnEvents {
    return Intl.message(
      'Aún no has creado eventos',
      name: 'noOwnEvents',
      desc: '',
      args: [],
    );
  }

  /// `No estás inscrito en ningún evento`
  String get noEnrolledEvents {
    return Intl.message(
      'No estás inscrito en ningún evento',
      name: 'noEnrolledEvents',
      desc: '',
      args: [],
    );
  }

  /// `No tienes tickets próximos`
  String get noUpcomingTickets {
    return Intl.message(
      'No tienes tickets próximos',
      name: 'noUpcomingTickets',
      desc: '',
      args: [],
    );
  }

  /// `No tienes tickets anteriores`
  String get noPastTickets {
    return Intl.message(
      'No tienes tickets anteriores',
      name: 'noPastTickets',
      desc: '',
      args: [],
    );
  }

  /// `Ticket #{id}`
  String ticketNumber(int id) {
    return Intl.message(
      'Ticket #$id',
      name: 'ticketNumber',
      desc: '',
      args: [id],
    );
  }

  /// `Inscrito el {date}`
  String enrolledOn(String date) {
    return Intl.message(
      'Inscrito el $date',
      name: 'enrolledOn',
      desc: '',
      args: [date],
    );
  }

  /// `Ver evento`
  String get viewEvent {
    return Intl.message('Ver evento', name: 'viewEvent', desc: '', args: []);
  }

  /// `Cancelar inscripción`
  String get cancelTicket {
    return Intl.message(
      'Cancelar inscripción',
      name: 'cancelTicket',
      desc: '',
      args: [],
    );
  }

  /// `¿Seguro que quieres cancelar tu inscripción?`
  String get cancelTicketConfirm {
    return Intl.message(
      '¿Seguro que quieres cancelar tu inscripción?',
      name: 'cancelTicketConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Mantener`
  String get keepTicket {
    return Intl.message('Mantener', name: 'keepTicket', desc: '', args: []);
  }

  /// `Inscripción cancelada`
  String get ticketCancelled {
    return Intl.message(
      'Inscripción cancelada',
      name: 'ticketCancelled',
      desc: '',
      args: [],
    );
  }

  /// `No se pudieron cargar los tickets`
  String get ticketsLoadError {
    return Intl.message(
      'No se pudieron cargar los tickets',
      name: 'ticketsLoadError',
      desc: '',
      args: [],
    );
  }

  /// `Ubicación`
  String get eventLocation {
    return Intl.message('Ubicación', name: 'eventLocation', desc: '', args: []);
  }

  /// `Organiza`
  String get hostedBy {
    return Intl.message('Organiza', name: 'hostedBy', desc: '', args: []);
  }

  /// `Acerca del evento`
  String get aboutEvent {
    return Intl.message(
      'Acerca del evento',
      name: 'aboutEvent',
      desc: '',
      args: [],
    );
  }

  /// `Cómo llegar`
  String get getDirections {
    return Intl.message(
      'Cómo llegar',
      name: 'getDirections',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo abrir la app de mapas`
  String get couldNotOpenMaps {
    return Intl.message(
      'No se pudo abrir la app de mapas',
      name: 'couldNotOpenMaps',
      desc: '',
      args: [],
    );
  }

  /// `Buscar actividad`
  String get searchEvents {
    return Intl.message(
      'Buscar actividad',
      name: 'searchEvents',
      desc: '',
      args: [],
    );
  }

  /// `No hay eventos que coincidan con tu búsqueda`
  String get noSearchResults {
    return Intl.message(
      'No hay eventos que coincidan con tu búsqueda',
      name: 'noSearchResults',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar foto`
  String get changePhoto {
    return Intl.message(
      'Cambiar foto',
      name: 'changePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Foto actualizada`
  String get avatarUpdated {
    return Intl.message(
      'Foto actualizada',
      name: 'avatarUpdated',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo actualizar la foto`
  String get avatarUploadFailed {
    return Intl.message(
      'No se pudo actualizar la foto',
      name: 'avatarUploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Inscribirme`
  String get enroll {
    return Intl.message('Inscribirme', name: 'enroll', desc: '', args: []);
  }

  /// `Ver mi ticket`
  String get viewMyTicket {
    return Intl.message(
      'Ver mi ticket',
      name: 'viewMyTicket',
      desc: '',
      args: [],
    );
  }

  /// `Evento finalizado`
  String get eventFinished {
    return Intl.message(
      'Evento finalizado',
      name: 'eventFinished',
      desc: '',
      args: [],
    );
  }

  /// `Es tu evento`
  String get ownEvent {
    return Intl.message('Es tu evento', name: 'ownEvent', desc: '', args: []);
  }

  /// `Pago próximamente`
  String get paymentsComingSoon {
    return Intl.message(
      'Pago próximamente',
      name: 'paymentsComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Solo por invitación`
  String get invitationOnly {
    return Intl.message(
      'Solo por invitación',
      name: 'invitationOnly',
      desc: '',
      args: [],
    );
  }

  /// `¡Listo! Ya estás inscrito`
  String get enrolledSuccess {
    return Intl.message(
      '¡Listo! Ya estás inscrito',
      name: 'enrolledSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Código de acceso`
  String get accessCode {
    return Intl.message(
      'Código de acceso',
      name: 'accessCode',
      desc: '',
      args: [],
    );
  }

  /// `Este evento es privado. Ingresa el código que te dio el organizador.`
  String get accessCodeHint {
    return Intl.message(
      'Este evento es privado. Ingresa el código que te dio el organizador.',
      name: 'accessCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Ingresa el código`
  String get accessCodeRequired {
    return Intl.message(
      'Ingresa el código',
      name: 'accessCodeRequired',
      desc: '',
      args: [],
    );
  }

  /// `Código de acceso inválido`
  String get invalidAccessCode {
    return Intl.message(
      'Código de acceso inválido',
      name: 'invalidAccessCode',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get cancel {
    return Intl.message('Cancelar', name: 'cancel', desc: '', args: []);
  }

  /// `Editar evento`
  String get editEvent {
    return Intl.message('Editar evento', name: 'editEvent', desc: '', args: []);
  }

  /// `Guardar cambios`
  String get saveChanges {
    return Intl.message(
      'Guardar cambios',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Evento actualizado`
  String get eventUpdated {
    return Intl.message(
      'Evento actualizado',
      name: 'eventUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Borrar evento`
  String get deleteEvent {
    return Intl.message(
      'Borrar evento',
      name: 'deleteEvent',
      desc: '',
      args: [],
    );
  }

  /// `Se borrarán también todas las inscripciones. Esta acción no se puede deshacer.`
  String get deleteEventConfirm {
    return Intl.message(
      'Se borrarán también todas las inscripciones. Esta acción no se puede deshacer.',
      name: 'deleteEventConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Evento borrado`
  String get eventDeleted {
    return Intl.message(
      'Evento borrado',
      name: 'eventDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Compártelo con tus invitados para que puedan inscribirse.`
  String get accessCodeOwnerHint {
    return Intl.message(
      'Compártelo con tus invitados para que puedan inscribirse.',
      name: 'accessCodeOwnerHint',
      desc: '',
      args: [],
    );
  }

  /// `Código copiado`
  String get codeCopied {
    return Intl.message(
      'Código copiado',
      name: 'codeCopied',
      desc: '',
      args: [],
    );
  }

  /// `Todas las ubicaciones`
  String get allLocations {
    return Intl.message(
      'Todas las ubicaciones',
      name: 'allLocations',
      desc: '',
      args: [],
    );
  }

  /// `Filtrar por ubicación`
  String get filterByLocation {
    return Intl.message(
      'Filtrar por ubicación',
      name: 'filterByLocation',
      desc: '',
      args: [],
    );
  }

  /// `Todo {country}`
  String allOfCountry(String country) {
    return Intl.message(
      'Todo $country',
      name: 'allOfCountry',
      desc: '',
      args: [country],
    );
  }

  /// `No se pudieron cargar las ubicaciones`
  String get locationsLoadFailed {
    return Intl.message(
      'No se pudieron cargar las ubicaciones',
      name: 'locationsLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `No hay eventos próximos en esta ubicación`
  String get noEventsInLocation {
    return Intl.message(
      'No hay eventos próximos en esta ubicación',
      name: 'noEventsInLocation',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo conectar con el servidor`
  String get errConnection {
    return Intl.message(
      'No se pudo conectar con el servidor',
      name: 'errConnection',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo cargar el evento`
  String get errLoadEvent {
    return Intl.message(
      'No se pudo cargar el evento',
      name: 'errLoadEvent',
      desc: '',
      args: [],
    );
  }

  /// `No se pudieron cargar los eventos`
  String get errLoadEvents {
    return Intl.message(
      'No se pudieron cargar los eventos',
      name: 'errLoadEvents',
      desc: '',
      args: [],
    );
  }

  /// `No se pudieron cargar tus eventos`
  String get errLoadOwnEvents {
    return Intl.message(
      'No se pudieron cargar tus eventos',
      name: 'errLoadOwnEvents',
      desc: '',
      args: [],
    );
  }

  /// `No se pudieron cargar eventos similares`
  String get errLoadSimilar {
    return Intl.message(
      'No se pudieron cargar eventos similares',
      name: 'errLoadSimilar',
      desc: '',
      args: [],
    );
  }

  /// `No se pudieron cargar las promociones`
  String get errLoadPromotions {
    return Intl.message(
      'No se pudieron cargar las promociones',
      name: 'errLoadPromotions',
      desc: '',
      args: [],
    );
  }

  /// `No se pudieron cargar los tickets`
  String get errLoadTickets {
    return Intl.message(
      'No se pudieron cargar los tickets',
      name: 'errLoadTickets',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo crear el evento`
  String get errCreateEvent {
    return Intl.message(
      'No se pudo crear el evento',
      name: 'errCreateEvent',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo guardar el evento`
  String get errSaveEvent {
    return Intl.message(
      'No se pudo guardar el evento',
      name: 'errSaveEvent',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo borrar el evento`
  String get errDeleteEvent {
    return Intl.message(
      'No se pudo borrar el evento',
      name: 'errDeleteEvent',
      desc: '',
      args: [],
    );
  }

  /// `Revisa los campos marcados`
  String get errCheckFields {
    return Intl.message(
      'Revisa los campos marcados',
      name: 'errCheckFields',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo completar la inscripción`
  String get errEnroll {
    return Intl.message(
      'No se pudo completar la inscripción',
      name: 'errEnroll',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo cancelar el ticket`
  String get errCancelTicket {
    return Intl.message(
      'No se pudo cancelar el ticket',
      name: 'errCancelTicket',
      desc: '',
      args: [],
    );
  }

  /// `Error al iniciar sesión`
  String get errLogin {
    return Intl.message(
      'Error al iniciar sesión',
      name: 'errLogin',
      desc: '',
      args: [],
    );
  }

  /// `Error al registrarse`
  String get errSignUp {
    return Intl.message(
      'Error al registrarse',
      name: 'errSignUp',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo completar el registro`
  String get errSignUpIncomplete {
    return Intl.message(
      'No se pudo completar el registro',
      name: 'errSignUpIncomplete',
      desc: '',
      args: [],
    );
  }

  /// `Usuario o contraseña incorrectos`
  String get errWrongCredentials {
    return Intl.message(
      'Usuario o contraseña incorrectos',
      name: 'errWrongCredentials',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo cargar el perfil`
  String get errLoadProfile {
    return Intl.message(
      'No se pudo cargar el perfil',
      name: 'errLoadProfile',
      desc: '',
      args: [],
    );
  }

  /// `El enlace no es válido o ya se usó`
  String get errInvalidResetLink {
    return Intl.message(
      'El enlace no es válido o ya se usó',
      name: 'errInvalidResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Error (código: {code})`
  String errWithCode(int code) {
    return Intl.message(
      'Error (código: $code)',
      name: 'errWithCode',
      desc: '',
      args: [code],
    );
  }

  /// `¡Buenos días!`
  String get greetingMorning {
    return Intl.message(
      '¡Buenos días!',
      name: 'greetingMorning',
      desc: '',
      args: [],
    );
  }

  /// `¡Buenas tardes!`
  String get greetingAfternoon {
    return Intl.message(
      '¡Buenas tardes!',
      name: 'greetingAfternoon',
      desc: '',
      args: [],
    );
  }

  /// `¡Buenas noches!`
  String get greetingEvening {
    return Intl.message(
      '¡Buenas noches!',
      name: 'greetingEvening',
      desc: '',
      args: [],
    );
  }

  /// `Todas`
  String get catAll {
    return Intl.message('Todas', name: 'catAll', desc: '', args: []);
  }

  /// `Promociones`
  String get promotions {
    return Intl.message('Promociones', name: 'promotions', desc: '', args: []);
  }

  /// `Cargando evento…`
  String get loadingEvent {
    return Intl.message(
      'Cargando evento…',
      name: 'loadingEvent',
      desc: '',
      args: [],
    );
  }

  /// `Algo salió mal`
  String get somethingWentWrong {
    return Intl.message(
      'Algo salió mal',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Perfil no disponible`
  String get profileUnavailable {
    return Intl.message(
      'Perfil no disponible',
      name: 'profileUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Tu perfil`
  String get yourProfile {
    return Intl.message('Tu perfil', name: 'yourProfile', desc: '', args: []);
  }

  /// `Administra la información de tu perfil`
  String get manageProfile {
    return Intl.message(
      'Administra la información de tu perfil',
      name: 'manageProfile',
      desc: '',
      args: [],
    );
  }

  /// `Preferencias`
  String get preferences {
    return Intl.message(
      'Preferencias',
      name: 'preferences',
      desc: '',
      args: [],
    );
  }

  /// `Tema`
  String get theme {
    return Intl.message('Tema', name: 'theme', desc: '', args: []);
  }

  /// `Modo oscuro`
  String get darkMode {
    return Intl.message('Modo oscuro', name: 'darkMode', desc: '', args: []);
  }

  /// `Modo claro`
  String get lightMode {
    return Intl.message('Modo claro', name: 'lightMode', desc: '', args: []);
  }

  /// `Notificaciones`
  String get notifications {
    return Intl.message(
      'Notificaciones',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Notificaciones push y alertas`
  String get notificationsSubtitle {
    return Intl.message(
      'Notificaciones push y alertas',
      name: 'notificationsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Idioma`
  String get language {
    return Intl.message('Idioma', name: 'language', desc: '', args: []);
  }

  /// `Idioma de la app`
  String get languageSubtitle {
    return Intl.message(
      'Idioma de la app',
      name: 'languageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Soporte y legal`
  String get supportLegal {
    return Intl.message(
      'Soporte y legal',
      name: 'supportLegal',
      desc: '',
      args: [],
    );
  }

  /// `Preguntas frecuentes y soporte`
  String get helpSubtitle {
    return Intl.message(
      'Preguntas frecuentes y soporte',
      name: 'helpSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Política de privacidad y uso de datos`
  String get privacySubtitle {
    return Intl.message(
      'Política de privacidad y uso de datos',
      name: 'privacySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Acerca de`
  String get about {
    return Intl.message('Acerca de', name: 'about', desc: '', args: []);
  }

  /// `Versión y términos del servicio`
  String get aboutSubtitle {
    return Intl.message(
      'Versión y términos del servicio',
      name: 'aboutSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Descubre, crea y comparte eventos.`
  String get aboutDescription {
    return Intl.message(
      'Descubre, crea y comparte eventos.',
      name: 'aboutDescription',
      desc: '',
      args: [],
    );
  }

  /// `© {year} Parkea. Todos los derechos reservados.`
  String allRightsReserved(int year) {
    return Intl.message(
      '© $year Parkea. Todos los derechos reservados.',
      name: 'allRightsReserved',
      desc: '',
      args: [year],
    );
  }

  /// `Cuenta`
  String get account {
    return Intl.message('Cuenta', name: 'account', desc: '', args: []);
  }

  /// `Cerrar la sesión de tu cuenta`
  String get logoutSubtitle {
    return Intl.message(
      'Cerrar la sesión de tu cuenta',
      name: 'logoutSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `¿Seguro que quieres cerrar sesión?`
  String get logoutConfirm {
    return Intl.message(
      '¿Seguro que quieres cerrar sesión?',
      name: 'logoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `No se pudo cerrar sesión: {error}`
  String logoutFailed(String error) {
    return Intl.message(
      'No se pudo cerrar sesión: $error',
      name: 'logoutFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Comparte con amigos`
  String get slideShareTitle {
    return Intl.message(
      'Comparte con amigos',
      name: 'slideShareTitle',
      desc: '',
      args: [],
    );
  }

  /// `Descubre eventos cerca de ti y compártelos con tus amigos.`
  String get slideShareText {
    return Intl.message(
      'Descubre eventos cerca de ti y compártelos con tus amigos.',
      name: 'slideShareText',
      desc: '',
      args: [],
    );
  }

  /// `Celebra juntos`
  String get slideCelebrateTitle {
    return Intl.message(
      'Celebra juntos',
      name: 'slideCelebrateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Inscríbete en un toque y lleva tus tickets siempre contigo.`
  String get slideCelebrateText {
    return Intl.message(
      'Inscríbete en un toque y lleva tus tickets siempre contigo.',
      name: 'slideCelebrateText',
      desc: '',
      args: [],
    );
  }

  /// `Relájate en compañía`
  String get slideRelaxTitle {
    return Intl.message(
      'Relájate en compañía',
      name: 'slideRelaxTitle',
      desc: '',
      args: [],
    );
  }

  /// `Crea tus propios eventos y llega a más personas.`
  String get slideRelaxText {
    return Intl.message(
      'Crea tus propios eventos y llega a más personas.',
      name: 'slideRelaxText',
      desc: '',
      args: [],
    );
  }

  /// `Empezar`
  String get getStarted {
    return Intl.message('Empezar', name: 'getStarted', desc: '', args: []);
  }

  /// `Presiona atrás de nuevo para salir`
  String get pressBackToExit {
    return Intl.message(
      'Presiona atrás de nuevo para salir',
      name: 'pressBackToExit',
      desc: '',
      args: [],
    );
  }

  /// `Crear`
  String get navCreate {
    return Intl.message('Crear', name: 'navCreate', desc: '', args: []);
  }

  /// `Tu evento está al {percent} %`
  String eventCompleteness(int percent) {
    return Intl.message(
      'Tu evento está al $percent %',
      name: 'eventCompleteness',
      desc: '',
      args: [percent],
    );
  }

  /// `¡Tu evento está completo!`
  String get eventComplete {
    return Intl.message(
      '¡Tu evento está completo!',
      name: 'eventComplete',
      desc: '',
      args: [],
    );
  }

  /// `Agrega una imagen: los eventos con imagen destacan en el feed.`
  String get completenessBanner {
    return Intl.message(
      'Agrega una imagen: los eventos con imagen destacan en el feed.',
      name: 'completenessBanner',
      desc: '',
      args: [],
    );
  }

  /// `Agrega una descripción corta: es lo que se ve en el feed.`
  String get completenessShortDescription {
    return Intl.message(
      'Agrega una descripción corta: es lo que se ve en el feed.',
      name: 'completenessShortDescription',
      desc: '',
      args: [],
    );
  }

  /// `Cuenta de qué se trata el evento en la descripción.`
  String get completenessDescription {
    return Intl.message(
      'Cuenta de qué se trata el evento en la descripción.',
      name: 'completenessDescription',
      desc: '',
      args: [],
    );
  }

  /// `Indica el lugar para que sepan a dónde ir.`
  String get completenessPlace {
    return Intl.message(
      'Indica el lugar para que sepan a dónde ir.',
      name: 'completenessPlace',
      desc: '',
      args: [],
    );
  }

  /// `Elige una categoría para que aparezca en los filtros.`
  String get completenessCategory {
    return Intl.message(
      'Elige una categoría para que aparezca en los filtros.',
      name: 'completenessCategory',
      desc: '',
      args: [],
    );
  }

  /// `Inscritos`
  String get attendees {
    return Intl.message('Inscritos', name: 'attendees', desc: '', args: []);
  }

  /// `{enrolled} de {capacity} inscritos`
  String enrolledOfCapacity(int enrolled, int capacity) {
    return Intl.message(
      '$enrolled de $capacity inscritos',
      name: 'enrolledOfCapacity',
      desc: '',
      args: [enrolled, capacity],
    );
  }

  /// `{count, plural, =0{Nadie inscrito todavía} =1{1 inscrito} other{{count} inscritos}}`
  String enrolledCount(int count) {
    return Intl.plural(
      count,
      zero: 'Nadie inscrito todavía',
      one: '1 inscrito',
      other: '$count inscritos',
      name: 'enrolledCount',
      desc: '',
      args: [count],
    );
  }

  /// `Sin límite de cupo`
  String get noCapacityLimit {
    return Intl.message(
      'Sin límite de cupo',
      name: 'noCapacityLimit',
      desc: '',
      args: [],
    );
  }

  /// `¡Evento lleno!`
  String get eventFull {
    return Intl.message(
      '¡Evento lleno!',
      name: 'eventFull',
      desc: '',
      args: [],
    );
  }

  /// `{capacity, plural, =1{El único cupo de «{name}» ya está ocupado.} other{Los {capacity} cupos de «{name}» ya están ocupados.}}`
  String eventFullMessage(int capacity, String name) {
    return Intl.plural(
      capacity,
      one: 'El único cupo de «$name» ya está ocupado.',
      other: 'Los $capacity cupos de «$name» ya están ocupados.',
      name: 'eventFullMessage',
      desc: '',
      args: [capacity, name],
    );
  }

  /// `¡Genial!`
  String get great {
    return Intl.message('¡Genial!', name: 'great', desc: '', args: []);
  }

  /// `Mapa`
  String get navMap {
    return Intl.message('Mapa', name: 'navMap', desc: '', args: []);
  }

  /// `Activa tu ubicación para ver los eventos cerca de ti`
  String get mapLocationOff {
    return Intl.message(
      'Activa tu ubicación para ver los eventos cerca de ti',
      name: 'mapLocationOff',
      desc: '',
      args: [],
    );
  }

  /// `Activar`
  String get mapEnableLocation {
    return Intl.message(
      'Activar',
      name: 'mapEnableLocation',
      desc: '',
      args: [],
    );
  }

  /// `Ajustes`
  String get mapOpenSettings {
    return Intl.message('Ajustes', name: 'mapOpenSettings', desc: '', args: []);
  }

  /// `No hay eventos próximos con ubicación`
  String get mapNoEvents {
    return Intl.message(
      'No hay eventos próximos con ubicación',
      name: 'mapNoEvents',
      desc: '',
      args: [],
    );
  }

  /// `Mi ubicación`
  String get mapMyLocation {
    return Intl.message(
      'Mi ubicación',
      name: 'mapMyLocation',
      desc: '',
      args: [],
    );
  }

  /// `a {distance}`
  String distanceAway(String distance) {
    return Intl.message(
      'a $distance',
      name: 'distanceAway',
      desc: '',
      args: [distance],
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
