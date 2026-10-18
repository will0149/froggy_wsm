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

  static String m9(max) =>
      "Hasta ${max} imágenes. La portada es la que se ve en el feed.";

  static String m10(current, total) => "Imagen ${current} de ${total}";

  static String m11(max) =>
      "Un evento puede tener como máximo ${max} imágenes; se agregaron las primeras.";

  static String m12(error) => "No se pudo cerrar sesión: ${error}";

  static String m13(query) => "Nadie coincide con «${query}»";

  static String m14(link) => "Míralo en Parkea: ${link}";

  static String m15(count) => "${count} cupos disponibles";

  static String m16(current, total) => "Paso ${current} de ${total}";

  static String m17(id) => "Ticket #${id}";

  static String m18(amount) => "Pagado: ${amount}";

  static String m19(count) => "${count} tickets próximos";

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
    "accessCodeQrHint": MessageLookupByLibrary.simpleMessage(
      "Tus invitados lo escanean desde el inicio de Parkea.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Ingresa el código",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Cuenta"),
    "addImages": MessageLookupByLibrary.simpleMessage("Agregar imágenes"),
    "addressUnknown": MessageLookupByLibrary.simpleMessage(
      "Punto sin dirección conocida",
    ),
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
    "buyTicket": MessageLookupByLibrary.simpleMessage("Comprar Entrada"),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "No se pudo usar la cámara. Revisa el permiso en los ajustes o escribe el código.",
    ),
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
    "changeLocation": MessageLookupByLibrary.simpleMessage("Cambiar"),
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
    "confirmLocation": MessageLookupByLibrary.simpleMessage(
      "Confirmar ubicación",
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
    "coverImage": MessageLookupByLibrary.simpleMessage("Portada"),
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
    "enrolledPeople": MessageLookupByLibrary.simpleMessage(
      "Personas inscritas",
    ),
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
    "errLoadAttendees": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los inscritos",
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
    "errLoadSavedEvents": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar tus guardados",
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
    "errUnsaveEvent": MessageLookupByLibrary.simpleMessage(
      "No se pudo quitar de guardados",
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
    "findingAddress": MessageLookupByLibrary.simpleMessage(
      "Buscando dirección…",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Olvide mi Contraseña",
    ),
    "galleryHint": m9,
    "getDirections": MessageLookupByLibrary.simpleMessage("Cómo llegar"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Ayuda"),
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
    "imageOfTotal": m10,
    "imagesLimitReached": m11,
    "imagesPrepareFailed": MessageLookupByLibrary.simpleMessage(
      "Algunas imágenes no se pudieron preparar y no se agregaron.",
    ),
    "imagesSyncFailed": MessageLookupByLibrary.simpleMessage(
      "El evento se guardó, pero algunas imágenes no se pudieron actualizar.",
    ),
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
    "joinPrivateEvent": MessageLookupByLibrary.simpleMessage(
      "Unirme a un evento privado",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Mantener"),
    "language": MessageLookupByLibrary.simpleMessage("Idioma"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Idioma de la app",
    ),
    "lightMode": MessageLookupByLibrary.simpleMessage("Modo claro"),
    "loadingEvent": MessageLookupByLibrary.simpleMessage("Cargando evento…"),
    "locationNotSet": MessageLookupByLibrary.simpleMessage(
      "Sin ubicación: el evento no saldrá en el mapa",
    ),
    "locationsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar las ubicaciones",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Iniciar Sesión"),
    "logout": MessageLookupByLibrary.simpleMessage("Cerrar Sesión"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres cerrar sesión?",
    ),
    "logoutFailed": m12,
    "logoutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Cerrar la sesión de tu cuenta",
    ),
    "makeCoverImage": MessageLookupByLibrary.simpleMessage("Usar como portada"),
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
    "moveMapHint": MessageLookupByLibrary.simpleMessage(
      "Mueve el mapa para ubicar el pin",
    ),
    "myEvents": MessageLookupByLibrary.simpleMessage("Eventos"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Pagos"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Guardados"),
    "myLocationUnavailable": MessageLookupByLibrary.simpleMessage(
      "No pudimos obtener tu ubicación",
    ),
    "myTickets": MessageLookupByLibrary.simpleMessage("Mis Tickets"),
    "name": MessageLookupByLibrary.simpleMessage("Nombre de usuario"),
    "navCreate": MessageLookupByLibrary.simpleMessage("Crear"),
    "navHome": MessageLookupByLibrary.simpleMessage("Inicio"),
    "navMap": MessageLookupByLibrary.simpleMessage("Mapa"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Perfil"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Tickets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
    "noAttendeesMatch": m13,
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
    "noPlacesFound": MessageLookupByLibrary.simpleMessage(
      "No encontramos ese lugar",
    ),
    "noSavedEvents": MessageLookupByLibrary.simpleMessage(
      "Aún no has guardado eventos. Toca el corazón de un evento para verlo aquí.",
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
    "openEvent": MessageLookupByLibrary.simpleMessage("Abrir evento"),
    "orEnterCode": MessageLookupByLibrary.simpleMessage("O escribe el código"),
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
    "pickOnMap": MessageLookupByLibrary.simpleMessage("Elegir en el mapa"),
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
    "privateEvent": MessageLookupByLibrary.simpleMessage("Evento privado"),
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
    "publishEvent": MessageLookupByLibrary.simpleMessage("Publicar evento"),
    "register": MessageLookupByLibrary.simpleMessage("Registro"),
    "removeImage": MessageLookupByLibrary.simpleMessage("Quitar imagen"),
    "removeLocation": MessageLookupByLibrary.simpleMessage("Quitar ubicación"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Si el correo está registrado, te enviamos un enlace para restablecer la contraseña",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage(
      "Reestablecer Contraseña",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Reintentar"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Guardar cambios"),
    "saveEvent": MessageLookupByLibrary.simpleMessage("Guardar"),
    "scanQrHint": MessageLookupByLibrary.simpleMessage(
      "Escanea el QR que te compartió el organizador",
    ),
    "searchAttendees": MessageLookupByLibrary.simpleMessage(
      "Buscar por nombre o usuario",
    ),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Buscar actividad"),
    "searchPlace": MessageLookupByLibrary.simpleMessage(
      "Buscar dirección o lugar",
    ),
    "seeEvent": MessageLookupByLibrary.simpleMessage("Ir al Evento"),
    "settings": MessageLookupByLibrary.simpleMessage("Configuración"),
    "shareEvent": MessageLookupByLibrary.simpleMessage("Compartir evento"),
    "shareEventLink": m14,
    "showQr": MessageLookupByLibrary.simpleMessage("Mostrar QR"),
    "signUp": MessageLookupByLibrary.simpleMessage("Regístrate"),
    "similarEvents": MessageLookupByLibrary.simpleMessage("Eventos Similares"),
    "slideCreateText": MessageLookupByLibrary.simpleMessage(
      "Publica tu plan y llega a más personas.",
    ),
    "slideCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Crea tus eventos",
    ),
    "slideDiscoverText": MessageLookupByLibrary.simpleMessage(
      "Conciertos, talleres y planes cerca de ti para compartir con tus amigos.",
    ),
    "slideDiscoverTitle": MessageLookupByLibrary.simpleMessage(
      "Descubre eventos",
    ),
    "slideEnrollText": MessageLookupByLibrary.simpleMessage(
      "Tus tickets quedan en tu teléfono, siempre a mano.",
    ),
    "slideEnrollTitle": MessageLookupByLibrary.simpleMessage(
      "Inscríbete en un toque",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Agotado"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Algo salió mal",
    ),
    "spotsLeft": m15,
    "stepOfTotal": m16,
    "supportLegal": MessageLookupByLibrary.simpleMessage("Soporte y legal"),
    "theme": MessageLookupByLibrary.simpleMessage("Tema"),
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Inscripción cancelada",
    ),
    "ticketNumber": m17,
    "ticketPaid": m18,
    "ticketPassHint": MessageLookupByLibrary.simpleMessage(
      "Muéstralo en la entrada del evento.",
    ),
    "ticketQr": MessageLookupByLibrary.simpleMessage("Código QR del ticket"),
    "ticketUsed": MessageLookupByLibrary.simpleMessage("Ya usaste este ticket"),
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los tickets",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Anteriores"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Próximos"),
    "tooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Demasiados intentos, espera un minuto",
    ),
    "unsaveEvent": MessageLookupByLibrary.simpleMessage("Quitar de guardados"),
    "upcomingTicketsCount": m19,
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
    "welcomeNext": MessageLookupByLibrary.simpleMessage("Siguiente"),
    "welcomeSignIn": MessageLookupByLibrary.simpleMessage("Ya tengo cuenta"),
    "welcomeSignUp": MessageLookupByLibrary.simpleMessage("Crear cuenta"),
    "welcomeSkip": MessageLookupByLibrary.simpleMessage("Saltar"),
    "yourProfile": MessageLookupByLibrary.simpleMessage("Tu perfil"),
  };
}
