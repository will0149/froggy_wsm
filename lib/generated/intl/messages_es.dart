// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(country) => "Todo ${country}";

  static String m1(year) => "© ${year} Parkea. Todos los derechos reservados.";

  static String m2(distance) => "a ${distance}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'Nadie inscrito todavía', one: '1 inscrito', other: '${count} inscritos')}";

  static String m4(enrolled, capacity) =>
      "${enrolled} de ${capacity} inscritos";

  static String m5(date) => "Inscrito el ${date}";

  static String m6(code) => "Error (código: ${code})";

  static String m7(percent) => "Tu evento está al ${percent} %";

  static String m8(capacity, name) =>
      "${Intl.plural(capacity, one: 'El único cupo de «${name}» ya está ocupado.', other: 'Los ${capacity} cupos de «${name}» ya están ocupados.')}";

  static String m9(error) => "No se pudo cerrar sesión: ${error}";

  static String m10(count) => "${count} cupos disponibles";

  static String m11(id) => "Ticket #${id}";

  static String m12(count) => "${count} tickets próximos";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Acerca de"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "Descubre, crea y comparte eventos.",
    ),
    "aboutEvent": MessageLookupByLibrary.simpleMessage("Acerca del evento"),
    "aboutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Versión y términos del servicio",
    ),
    "accessCode": MessageLookupByLibrary.simpleMessage("Código de acceso"),
    "accessCodeHint": MessageLookupByLibrary.simpleMessage(
      "Este evento es privado. Ingresa el código que te dio el organizador.",
    ),
    "accessCodeOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Compártelo con tus invitados para que puedan inscribirse.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Ingresa el código",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Cuenta"),
    "addBanner": MessageLookupByLibrary.simpleMessage("Agregar imagen"),
    "allLocations": MessageLookupByLibrary.simpleMessage(
      "Todas las ubicaciones",
    ),
    "allOfCountry": m0,
    "allRightsReserved": m1,
    "attendees": MessageLookupByLibrary.simpleMessage("Inscritos"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Autenticar"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Foto actualizada"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo actualizar la foto",
    ),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage(
      "El evento se creó, pero la imagen no se pudo subir",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Comprar Entrada"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage(
      "Cancelar inscripción",
    ),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres cancelar tu inscripción?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage("Vacío = sin límite"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Aventura"),
    "catAll": MessageLookupByLibrary.simpleMessage("Todas"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Camping"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Música"),
    "catVolunteering": MessageLookupByLibrary.simpleMessage("Voluntariado"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Talleres"),
    "categories": MessageLookupByLibrary.simpleMessage("Categorias"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Sin categoría"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("Cambiar imagen"),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Cambiar contraseña",
    ),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Cambiar foto"),
    "codeCopied": MessageLookupByLibrary.simpleMessage("Código copiado"),
    "completenessBanner": MessageLookupByLibrary.simpleMessage(
      "Agrega una imagen: los eventos con imagen destacan en el feed.",
    ),
    "completenessCategory": MessageLookupByLibrary.simpleMessage(
      "Elige una categoría para que aparezca en los filtros.",
    ),
    "completenessDescription": MessageLookupByLibrary.simpleMessage(
      "Cuenta de qué se trata el evento en la descripción.",
    ),
    "completenessPlace": MessageLookupByLibrary.simpleMessage(
      "Indica el lugar para que sepan a dónde ir.",
    ),
    "completenessShortDescription": MessageLookupByLibrary.simpleMessage(
      "Agrega una descripción corta: es lo que se ve en el feed.",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmar contraseña",
    ),
    "costFree": MessageLookupByLibrary.simpleMessage("Gratis"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("Con invitación"),
    "costPaid": MessageLookupByLibrary.simpleMessage("De pago"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Privado"),
    "costType": MessageLookupByLibrary.simpleMessage("Tipo de acceso"),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir el enlace",
    ),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir la app de mapas",
    ),
    "createEvent": MessageLookupByLibrary.simpleMessage("Crear evento"),
    "darkMode": MessageLookupByLibrary.simpleMessage("Modo oscuro"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage(
      "Datos & Privacidad",
    ),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "La fecha debe ser futura",
    ),
    "deleteEvent": MessageLookupByLibrary.simpleMessage("Borrar evento"),
    "deleteEventConfirm": MessageLookupByLibrary.simpleMessage(
      "Se borrarán también todas las inscripciones. Esta acción no se puede deshacer.",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studios"),
    "distanceAway": m2,
    "downloadTicket": MessageLookupByLibrary.simpleMessage("Descargar ticket"),
    "editEvent": MessageLookupByLibrary.simpleMessage("Editar evento"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Editar perfil"),
    "email": MessageLookupByLibrary.simpleMessage("Correo Electrónico"),
    "enroll": MessageLookupByLibrary.simpleMessage("Inscribirme"),
    "enrolledCount": m3,
    "enrolledOfCapacity": m4,
    "enrolledOn": m5,
    "enrolledSuccess": MessageLookupByLibrary.simpleMessage(
      "¡Listo! Ya estás inscrito",
    ),
    "errCancelTicket": MessageLookupByLibrary.simpleMessage(
      "No se pudo cancelar el ticket",
    ),
    "errCheckFields": MessageLookupByLibrary.simpleMessage(
      "Revisa los campos marcados",
    ),
    "errConnection": MessageLookupByLibrary.simpleMessage(
      "No se pudo conectar con el servidor",
    ),
    "errCreateEvent": MessageLookupByLibrary.simpleMessage(
      "No se pudo crear el evento",
    ),
    "errDeleteEvent": MessageLookupByLibrary.simpleMessage(
      "No se pudo borrar el evento",
    ),
    "errEnroll": MessageLookupByLibrary.simpleMessage(
      "No se pudo completar la inscripción",
    ),
    "errInvalidResetLink": MessageLookupByLibrary.simpleMessage(
      "El enlace no es válido o ya se usó",
    ),
    "errLoadEvent": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar el evento",
    ),
    "errLoadEvents": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los eventos",
    ),
    "errLoadOwnEvents": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar tus eventos",
    ),
    "errLoadProfile": MessageLookupByLibrary.simpleMessage(
      "No se pudo cargar el perfil",
    ),
    "errLoadPromotions": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar las promociones",
    ),
    "errLoadSimilar": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar eventos similares",
    ),
    "errLoadTickets": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los tickets",
    ),
    "errLogin": MessageLookupByLibrary.simpleMessage("Error al iniciar sesión"),
    "errSaveEvent": MessageLookupByLibrary.simpleMessage(
      "No se pudo guardar el evento",
    ),
    "errSignUp": MessageLookupByLibrary.simpleMessage("Error al registrarse"),
    "errSignUpIncomplete": MessageLookupByLibrary.simpleMessage(
      "No se pudo completar el registro",
    ),
    "errWithCode": m6,
    "errWrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Usuario o contraseña incorrectos",
    ),
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Cupo"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Categoría"),
    "eventComplete": MessageLookupByLibrary.simpleMessage(
      "¡Tu evento está completo!",
    ),
    "eventCompleteness": m7,
    "eventCreated": MessageLookupByLibrary.simpleMessage("Evento creado"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Moneda"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Fecha y hora"),
    "eventDeleted": MessageLookupByLibrary.simpleMessage("Evento borrado"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Descripción"),
    "eventFinished": MessageLookupByLibrary.simpleMessage("Evento finalizado"),
    "eventFull": MessageLookupByLibrary.simpleMessage("¡Evento lleno!"),
    "eventFullMessage": m8,
    "eventLocation": MessageLookupByLibrary.simpleMessage("Ubicación"),
    "eventName": MessageLookupByLibrary.simpleMessage("Nombre del evento"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("Lugar"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("Precio"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage(
      "Descripción corta",
    ),
    "eventUpdated": MessageLookupByLibrary.simpleMessage("Evento actualizado"),
    "eventsForAll": MessageLookupByLibrary.simpleMessage("Eventos para todos"),
    "eventsForYou": MessageLookupByLibrary.simpleMessage("Eventos para ti"),
    "feedEmpty": MessageLookupByLibrary.simpleMessage("Aún no hay eventos"),
    "feedEnd": MessageLookupByLibrary.simpleMessage(
      "Ya viste todos los eventos",
    ),
    "feedLoadError": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los eventos",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Este campo es obligatorio",
    ),
    "filterByLocation": MessageLookupByLibrary.simpleMessage(
      "Filtrar por ubicación",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Olvide mi Contraseña",
    ),
    "getDirections": MessageLookupByLibrary.simpleMessage("Cómo llegar"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Ayuda"),
    "getStarted": MessageLookupByLibrary.simpleMessage("Empezar"),
    "great": MessageLookupByLibrary.simpleMessage("¡Genial!"),
    "greetingAfternoon": MessageLookupByLibrary.simpleMessage(
      "¡Buenas tardes!",
    ),
    "greetingEvening": MessageLookupByLibrary.simpleMessage("¡Buenas noches!"),
    "greetingMorning": MessageLookupByLibrary.simpleMessage("¡Buenos días!"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage("Ya tengo un enlace"),
    "helpSubtitle": MessageLookupByLibrary.simpleMessage(
      "Preguntas frecuentes y soporte",
    ),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Organiza"),
    "information": MessageLookupByLibrary.simpleMessage("Información"),
    "invalidAccessCode": MessageLookupByLibrary.simpleMessage(
      "Código de acceso inválido",
    ),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "Usa un código de 3 letras, p. ej. USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Correo electrónico no válido",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Número no válido"),
    "invalidWebsite": MessageLookupByLibrary.simpleMessage(
      "Escribe una dirección web válida, p. ej. https://parkea.app",
    ),
    "invitationOnly": MessageLookupByLibrary.simpleMessage(
      "Solo por invitación",
    ),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Únete a nuestro universo",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Mantener"),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Idioma de la app",
    ),
    "lightMode": MessageLookupByLibrary.simpleMessage("Modo claro"),
    "loadingEvent": MessageLookupByLibrary.simpleMessage("Cargando evento…"),
    "locationsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar las ubicaciones",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Iniciar Sesión"),
    "logout": MessageLookupByLibrary.simpleMessage("Cerrar Sesión"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres cerrar sesión?",
    ),
    "logoutFailed": m9,
    "logoutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Cerrar la sesión de tu cuenta",
    ),
    "manageProfile": MessageLookupByLibrary.simpleMessage(
      "Administra la información de tu perfil",
    ),
    "mapEnableLocation": MessageLookupByLibrary.simpleMessage("Activar"),
    "mapLocationOff": MessageLookupByLibrary.simpleMessage(
      "Activa tu ubicación para ver los eventos cerca de ti",
    ),
    "mapMyLocation": MessageLookupByLibrary.simpleMessage("Mi ubicación"),
    "mapNoEvents": MessageLookupByLibrary.simpleMessage(
      "No hay eventos próximos con ubicación",
    ),
    "mapOpenSettings": MessageLookupByLibrary.simpleMessage("Ajustes"),
    "myEvents": MessageLookupByLibrary.simpleMessage("Eventos"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Pagos"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Guardados"),
    "myTickets": MessageLookupByLibrary.simpleMessage("Mis Tickets"),
    "name": MessageLookupByLibrary.simpleMessage("Nombre de usuario"),
    "navCreate": MessageLookupByLibrary.simpleMessage("Crear"),
    "navHome": MessageLookupByLibrary.simpleMessage("Inicio"),
    "navMap": MessageLookupByLibrary.simpleMessage("Mapa"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Perfil"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Tickets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
    "noCapacityLimit": MessageLookupByLibrary.simpleMessage(
      "Sin límite de cupo",
    ),
    "noEventsInLocation": MessageLookupByLibrary.simpleMessage(
      "No hay eventos próximos en esta ubicación",
    ),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Aún no has creado eventos",
    ),
    "noPastTickets": MessageLookupByLibrary.simpleMessage(
      "No tienes tickets anteriores",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "No hay eventos que coincidan con tu búsqueda",
    ),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage(
      "No tienes tickets próximos",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notificaciones"),
    "notificationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Notificaciones push y alertas",
    ),
    "ownEvent": MessageLookupByLibrary.simpleMessage("Es tu evento"),
    "parkeaAndShare": MessageLookupByLibrary.simpleMessage("Parkea & Comparte"),
    "parkeaAppName": MessageLookupByLibrary.simpleMessage("Parkea!"),
    "password": MessageLookupByLibrary.simpleMessage("Contraseña"),
    "passwordEntirelyNumeric": MessageLookupByLibrary.simpleMessage(
      "La contraseña no puede ser solo números",
    ),
    "passwordResetDone": MessageLookupByLibrary.simpleMessage(
      "Contraseña actualizada. Inicia sesión.",
    ),
    "passwordTooCommon": MessageLookupByLibrary.simpleMessage(
      "Es una contraseña demasiado común",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "La contraseña debe tener al menos 8 caracteres",
    ),
    "passwordTooSimilar": MessageLookupByLibrary.simpleMessage(
      "La contraseña se parece demasiado a tu usuario o correo",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Las contraseñas no coinciden",
    ),
    "paymentsComingSoon": MessageLookupByLibrary.simpleMessage(
      "Pago próximamente",
    ),
    "popularEvents": MessageLookupByLibrary.simpleMessage("Eventos Populares"),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferencias"),
    "pressBackToExit": MessageLookupByLibrary.simpleMessage(
      "Presiona atrás de nuevo para salir",
    ),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "El precio debe ser mayor que 0",
    ),
    "privacySubtitle": MessageLookupByLibrary.simpleMessage(
      "Política de privacidad y uso de datos",
    ),
    "profileBio": MessageLookupByLibrary.simpleMessage("Descripción"),
    "profileBioHint": MessageLookupByLibrary.simpleMessage(
      "Cuéntale a la gente quién eres o qué organizas",
    ),
    "profileUnavailable": MessageLookupByLibrary.simpleMessage(
      "Perfil no disponible",
    ),
    "profileUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo actualizar el perfil",
    ),
    "profileUpdated": MessageLookupByLibrary.simpleMessage(
      "Perfil actualizado",
    ),
    "profileWebsite": MessageLookupByLibrary.simpleMessage("Sitio web"),
    "promotions": MessageLookupByLibrary.simpleMessage("Promociones"),
    "province": MessageLookupByLibrary.simpleMessage("Provincia"),
    "publishEvent": MessageLookupByLibrary.simpleMessage("Publicar evento"),
    "register": MessageLookupByLibrary.simpleMessage("Registro"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Si el correo está registrado, te enviamos un enlace para restablecer la contraseña",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "Reestablecer Contraseña",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Reintentar"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Guardar cambios"),
    "saveEvent": MessageLookupByLibrary.simpleMessage("Guardar Evento"),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Buscar actividad"),
    "seeEvent": MessageLookupByLibrary.simpleMessage("Ir al Evento"),
    "settings": MessageLookupByLibrary.simpleMessage("Configuración"),
    "signUp": MessageLookupByLibrary.simpleMessage("Regístrate"),
    "similarEvents": MessageLookupByLibrary.simpleMessage("Eventos Similares"),
    "slideCelebrateText": MessageLookupByLibrary.simpleMessage(
      "Inscríbete en un toque y lleva tus tickets siempre contigo.",
    ),
    "slideCelebrateTitle": MessageLookupByLibrary.simpleMessage(
      "Celebra juntos",
    ),
    "slideRelaxText": MessageLookupByLibrary.simpleMessage(
      "Crea tus propios eventos y llega a más personas.",
    ),
    "slideRelaxTitle": MessageLookupByLibrary.simpleMessage(
      "Relájate en compañía",
    ),
    "slideShareText": MessageLookupByLibrary.simpleMessage(
      "Descubre eventos cerca de ti y compártelos con tus amigos.",
    ),
    "slideShareTitle": MessageLookupByLibrary.simpleMessage(
      "Comparte con amigos",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Agotado"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Algo salió mal",
    ),
    "spotsLeft": m10,
    "supportLegal": MessageLookupByLibrary.simpleMessage("Soporte y legal"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Inscripción cancelada",
    ),
    "ticketNumber": m11,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los tickets",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Anteriores"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Próximos"),
    "upcomingTicketsCount": m12,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage("Usuario o correo"),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Ingresa tu usuario o correo",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Ver evento"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("Ver mi ticket"),
    "volunteeringFreeNote": MessageLookupByLibrary.simpleMessage(
      "El voluntariado es gratis y cualquiera puede inscribirse.",
    ),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage(
      "¡Bienvenido de nuevo!",
    ),
    "yourProfile": MessageLookupByLibrary.simpleMessage("Tu perfil"),
  };
}
