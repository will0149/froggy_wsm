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

  static String m0(date) => "Inscrito el ${date}";

  static String m1(count) => "${count} cupos disponibles";

  static String m2(id) => "Ticket #${id}";

  static String m3(count) => "${count} tickets próximos";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutEvent": MessageLookupByLibrary.simpleMessage("Acerca del evento"),
    "addBanner": MessageLookupByLibrary.simpleMessage("Agregar imagen"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Autenticar"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Foto actualizada"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "No se pudo actualizar la foto",
    ),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage(
      "El evento se creó, pero la imagen no se pudo subir",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Comprar Entrada"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage(
      "Cancelar inscripción",
    ),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "¿Seguro que quieres cancelar tu inscripción?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage("Vacío = sin límite"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Aventura"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Camping"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Música"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Talleres"),
    "categories": MessageLookupByLibrary.simpleMessage("Categorias"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Sin categoría"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("Cambiar imagen"),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Cambiar contraseña",
    ),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Cambiar foto"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmar contraseña",
    ),
    "costFree": MessageLookupByLibrary.simpleMessage("Gratis"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("Con invitación"),
    "costPaid": MessageLookupByLibrary.simpleMessage("De pago"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Privado"),
    "costType": MessageLookupByLibrary.simpleMessage("Tipo de acceso"),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "No se pudo abrir la app de mapas",
    ),
    "createEvent": MessageLookupByLibrary.simpleMessage("Crear evento"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage(
      "Datos & Privacidad",
    ),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "La fecha debe ser futura",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studios"),
    "downloadTicket": MessageLookupByLibrary.simpleMessage("Descargar ticket"),
    "email": MessageLookupByLibrary.simpleMessage("Correo Electrónico"),
    "enrolledOn": m0,
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Cupo"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Categoría"),
    "eventCreated": MessageLookupByLibrary.simpleMessage("Evento creado"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Moneda"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Fecha y hora"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Descripción"),
    "eventLocation": MessageLookupByLibrary.simpleMessage("Ubicación"),
    "eventName": MessageLookupByLibrary.simpleMessage("Nombre del evento"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("Lugar"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("Precio"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage(
      "Descripción corta",
    ),
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
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Olvide mi Contraseña",
    ),
    "getDirections": MessageLookupByLibrary.simpleMessage("Cómo llegar"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Ayuda"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage("Ya tengo un enlace"),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Organiza"),
    "information": MessageLookupByLibrary.simpleMessage("Información"),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "Usa un código de 3 letras, p. ej. USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Correo electrónico no válido",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Número no válido"),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Únete a nuestro universo",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Mantener"),
    "login": MessageLookupByLibrary.simpleMessage("Iniciar Sesión"),
    "logout": MessageLookupByLibrary.simpleMessage("Cerrar Sesión"),
    "myEvents": MessageLookupByLibrary.simpleMessage("Eventos"),
    "myEventsEnrolled": MessageLookupByLibrary.simpleMessage("Inscritos"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Pagos"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Guardados"),
    "myTickets": MessageLookupByLibrary.simpleMessage("Mis Tickets"),
    "name": MessageLookupByLibrary.simpleMessage("Nombre de usuario"),
    "navHome": MessageLookupByLibrary.simpleMessage("Inicio"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Perfil"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Tickets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nueva contraseña"),
    "noEnrolledEvents": MessageLookupByLibrary.simpleMessage(
      "No estás inscrito en ningún evento",
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
    "popularEvents": MessageLookupByLibrary.simpleMessage("Eventos Populares"),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "El precio debe ser mayor que 0",
    ),
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
    "saveEvent": MessageLookupByLibrary.simpleMessage("Guardar Evento"),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Buscar actividad"),
    "seeEvent": MessageLookupByLibrary.simpleMessage("Ir al Evento"),
    "settings": MessageLookupByLibrary.simpleMessage("Configuración"),
    "signUp": MessageLookupByLibrary.simpleMessage("Regístrate"),
    "similarEvents": MessageLookupByLibrary.simpleMessage("Eventos Similares"),
    "soldOut": MessageLookupByLibrary.simpleMessage("Agotado"),
    "spotsLeft": m1,
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Inscripción cancelada",
    ),
    "ticketNumber": m2,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "No se pudieron cargar los tickets",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Anteriores"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Próximos"),
    "upcomingTicketsCount": m3,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage("Usuario o correo"),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Ingresa tu usuario o correo",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Ver evento"),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage(
      "¡Bienvenido de nuevo!",
    ),
  };
}
