// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(date) => "Angemeldet am ${date}";

  static String m1(count) => "${count} Plätze frei";

  static String m2(id) => "Ticket #${id}";

  static String m3(count) => "${count} anstehende Tickets";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutEvent": MessageLookupByLibrary.simpleMessage("Über das Event"),
    "addBanner": MessageLookupByLibrary.simpleMessage("Bild hinzufügen"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Authentifizieren"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Foto aktualisiert"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Foto konnte nicht aktualisiert werden",
    ),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Das Event wurde erstellt, aber das Bild konnte nicht hochgeladen werden",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("kauf ein Ticket"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage(
      "Anmeldung stornieren",
    ),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "Möchtest du deine Anmeldung wirklich stornieren?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage("Leer = unbegrenzt"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Abenteuer"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Camping"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Musik"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Workshops"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Keine Kategorie"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("Bild ändern"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Passwort ändern"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Foto ändern"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Passwort bestätigen",
    ),
    "costFree": MessageLookupByLibrary.simpleMessage("Kostenlos"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("Mit Einladung"),
    "costPaid": MessageLookupByLibrary.simpleMessage("Kostenpflichtig"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Privat"),
    "costType": MessageLookupByLibrary.simpleMessage("Zugangsart"),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "Karten-App konnte nicht geöffnet werden",
    ),
    "createEvent": MessageLookupByLibrary.simpleMessage("Event erstellen"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage(
      "Daten und Privatsphäre",
    ),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "Das Datum muss in der Zukunft liegen",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studien"),
    "downloadTicket": MessageLookupByLibrary.simpleMessage(
      "Ticket herunterladen",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "enrolledOn": m0,
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Kapazität"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Kategorie"),
    "eventCreated": MessageLookupByLibrary.simpleMessage("Event erstellt"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Währung"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Datum und Uhrzeit"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Beschreibung"),
    "eventLocation": MessageLookupByLibrary.simpleMessage("Ort"),
    "eventName": MessageLookupByLibrary.simpleMessage("Eventname"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("Ort"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("Preis"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage(
      "Kurzbeschreibung",
    ),
    "eventsForAll": MessageLookupByLibrary.simpleMessage(
      "Veranstaltungen für alle",
    ),
    "eventsForYou": MessageLookupByLibrary.simpleMessage("Events für dich"),
    "feedEmpty": MessageLookupByLibrary.simpleMessage("Noch keine Events"),
    "feedEnd": MessageLookupByLibrary.simpleMessage(
      "Du hast alle Events gesehen",
    ),
    "feedLoadError": MessageLookupByLibrary.simpleMessage(
      "Events konnten nicht geladen werden",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Dieses Feld ist erforderlich",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Ich habe mein Passwort vergessen",
    ),
    "getDirections": MessageLookupByLibrary.simpleMessage("Route planen"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Hilfe"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage(
      "Ich habe bereits einen Link",
    ),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Veranstaltet von"),
    "information": MessageLookupByLibrary.simpleMessage("Information"),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "Nutze einen 3-Buchstaben-Code, z. B. USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Ungültige E-Mail-Adresse",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Ungültige Zahl"),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Tritt unserem Universum bei",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Behalten"),
    "login": MessageLookupByLibrary.simpleMessage("Einloggen"),
    "logout": MessageLookupByLibrary.simpleMessage("Ausloggen"),
    "myEvents": MessageLookupByLibrary.simpleMessage("Veranstaltungen"),
    "myEventsEnrolled": MessageLookupByLibrary.simpleMessage("Angemeldet"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Bezahlt"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Gerettet"),
    "myTickets": MessageLookupByLibrary.simpleMessage("Meine Tickets"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "navHome": MessageLookupByLibrary.simpleMessage("Start"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profil"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Tickets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Neues Passwort"),
    "noEnrolledEvents": MessageLookupByLibrary.simpleMessage(
      "Du bist für kein Event angemeldet",
    ),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Du hast noch keine Events erstellt",
    ),
    "noPastTickets": MessageLookupByLibrary.simpleMessage(
      "Keine vergangenen Tickets",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "Keine Events passen zu deiner Suche",
    ),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage(
      "Keine anstehenden Tickets",
    ),
    "parkeaAndShare": MessageLookupByLibrary.simpleMessage(
      "Parkea und teilen!",
    ),
    "parkeaAppName": MessageLookupByLibrary.simpleMessage("Parkea!"),
    "password": MessageLookupByLibrary.simpleMessage("Passwort"),
    "passwordEntirelyNumeric": MessageLookupByLibrary.simpleMessage(
      "Das Passwort darf nicht nur aus Zahlen bestehen",
    ),
    "passwordResetDone": MessageLookupByLibrary.simpleMessage(
      "Passwort aktualisiert. Bitte melde dich an.",
    ),
    "passwordTooCommon": MessageLookupByLibrary.simpleMessage(
      "Dieses Passwort ist zu häufig",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Das Passwort muss mindestens 8 Zeichen lang sein",
    ),
    "passwordTooSimilar": MessageLookupByLibrary.simpleMessage(
      "Das Passwort ist deinem Benutzernamen oder deiner E-Mail zu ähnlich",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Die Passwörter stimmen nicht überein",
    ),
    "popularEvents": MessageLookupByLibrary.simpleMessage(
      "beliebte Veranstaltungen",
    ),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "Der Preis muss größer als 0 sein",
    ),
    "province": MessageLookupByLibrary.simpleMessage("Provinz"),
    "publishEvent": MessageLookupByLibrary.simpleMessage(
      "Event veröffentlichen",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Wenn die E-Mail registriert ist, haben wir dir einen Link zum Zurücksetzen des Passworts gesendet",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("Erneut versuchen"),
    "saveEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung speichern",
    ),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Aktivitäten suchen"),
    "seeEvent": MessageLookupByLibrary.simpleMessage("siehe Veranstaltung"),
    "settings": MessageLookupByLibrary.simpleMessage("Einstellung"),
    "signUp": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "similarEvents": MessageLookupByLibrary.simpleMessage(
      "ähnliche Veranstaltungen",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Ausverkauft"),
    "spotsLeft": m1,
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Anmeldung storniert",
    ),
    "ticketNumber": m2,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Tickets konnten nicht geladen werden",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Vergangen"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Anstehend"),
    "upcomingTicketsCount": m3,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Benutzername oder E-Mail",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Gib deinen Benutzernamen oder deine E-Mail ein",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Event ansehen"),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage("¡Willkommen zurück!"),
  };
}
