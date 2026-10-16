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

  static String m0(country) => "Ganz ${country}";

  static String m1(year) => "© ${year} Parkea. Alle Rechte vorbehalten.";

  static String m2(distance) => "${distance} entfernt";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'Noch niemand angemeldet', one: '1 angemeldet', other: '${count} angemeldet')}";

  static String m4(enrolled, capacity) =>
      "${enrolled} von ${capacity} angemeldet";

  static String m5(date) => "Angemeldet am ${date}";

  static String m6(code) => "Fehler (Code: ${code})";

  static String m7(percent) =>
      "Deine Veranstaltung ist zu ${percent} % vollständig";

  static String m8(capacity, name) =>
      "${Intl.plural(capacity, one: 'Der einzige Platz für „${name}“ ist vergeben.', other: 'Alle ${capacity} Plätze für „${name}“ sind vergeben.')}";

  static String m9(error) => "Abmeldung fehlgeschlagen: ${error}";

  static String m10(count) => "${count} Plätze frei";

  static String m11(id) => "Ticket #${id}";

  static String m12(count) => "${count} anstehende Tickets";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("Über"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "Entdecke, erstelle und teile Veranstaltungen.",
    ),
    "aboutEvent": MessageLookupByLibrary.simpleMessage("Über das Event"),
    "aboutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Version und Nutzungsbedingungen",
    ),
    "accessCode": MessageLookupByLibrary.simpleMessage("Zugangscode"),
    "accessCodeHint": MessageLookupByLibrary.simpleMessage(
      "Diese Veranstaltung ist privat. Gib den Code ein, den du vom Veranstalter erhalten hast.",
    ),
    "accessCodeOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Teile ihn mit deinen Gästen, damit sie sich anmelden können.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Gib den Code ein",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Konto"),
    "addBanner": MessageLookupByLibrary.simpleMessage("Bild hinzufügen"),
    "allLocations": MessageLookupByLibrary.simpleMessage("Alle Orte"),
    "allOfCountry": m0,
    "allRightsReserved": m1,
    "attendees": MessageLookupByLibrary.simpleMessage("Teilnehmende"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Authentifizieren"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Foto aktualisiert"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Foto konnte nicht aktualisiert werden",
    ),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Das Event wurde erstellt, aber das Bild konnte nicht hochgeladen werden",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("kauf ein Ticket"),
    "cancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage(
      "Anmeldung stornieren",
    ),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "Möchtest du deine Anmeldung wirklich stornieren?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage("Leer = unbegrenzt"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Abenteuer"),
    "catAll": MessageLookupByLibrary.simpleMessage("Alle"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Camping"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Musik"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Workshops"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Keine Kategorie"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("Bild ändern"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Passwort ändern"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Foto ändern"),
    "codeCopied": MessageLookupByLibrary.simpleMessage("Code kopiert"),
    "completenessBanner": MessageLookupByLibrary.simpleMessage(
      "Füge ein Bild hinzu: Veranstaltungen mit Bild fallen im Feed auf.",
    ),
    "completenessCategory": MessageLookupByLibrary.simpleMessage(
      "Wähle eine Kategorie, damit sie in den Filtern erscheint.",
    ),
    "completenessDescription": MessageLookupByLibrary.simpleMessage(
      "Beschreibe, worum es bei der Veranstaltung geht.",
    ),
    "completenessPlace": MessageLookupByLibrary.simpleMessage(
      "Gib den Ort an, damit alle wissen, wohin.",
    ),
    "completenessShortDescription": MessageLookupByLibrary.simpleMessage(
      "Füge eine Kurzbeschreibung hinzu: Sie erscheint im Feed.",
    ),
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
    "darkMode": MessageLookupByLibrary.simpleMessage("Dunkler Modus"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage(
      "Daten und Privatsphäre",
    ),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "Das Datum muss in der Zukunft liegen",
    ),
    "deleteEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung löschen",
    ),
    "deleteEventConfirm": MessageLookupByLibrary.simpleMessage(
      "Alle Anmeldungen werden ebenfalls gelöscht. Das kann nicht rückgängig gemacht werden.",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studien"),
    "distanceAway": m2,
    "downloadTicket": MessageLookupByLibrary.simpleMessage(
      "Ticket herunterladen",
    ),
    "editEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung bearbeiten",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "enroll": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "enrolledCount": m3,
    "enrolledOfCapacity": m4,
    "enrolledOn": m5,
    "enrolledSuccess": MessageLookupByLibrary.simpleMessage(
      "Fertig! Du bist angemeldet",
    ),
    "errCancelTicket": MessageLookupByLibrary.simpleMessage(
      "Ticket konnte nicht storniert werden",
    ),
    "errCheckFields": MessageLookupByLibrary.simpleMessage(
      "Überprüfe die markierten Felder",
    ),
    "errConnection": MessageLookupByLibrary.simpleMessage(
      "Verbindung zum Server fehlgeschlagen",
    ),
    "errCreateEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung konnte nicht erstellt werden",
    ),
    "errDeleteEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung konnte nicht gelöscht werden",
    ),
    "errEnroll": MessageLookupByLibrary.simpleMessage(
      "Anmeldung konnte nicht abgeschlossen werden",
    ),
    "errInvalidResetLink": MessageLookupByLibrary.simpleMessage(
      "Der Link ist ungültig oder wurde bereits verwendet",
    ),
    "errLoadEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung konnte nicht geladen werden",
    ),
    "errLoadEvents": MessageLookupByLibrary.simpleMessage(
      "Veranstaltungen konnten nicht geladen werden",
    ),
    "errLoadOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Deine Veranstaltungen konnten nicht geladen werden",
    ),
    "errLoadProfile": MessageLookupByLibrary.simpleMessage(
      "Profil konnte nicht geladen werden",
    ),
    "errLoadPromotions": MessageLookupByLibrary.simpleMessage(
      "Aktionen konnten nicht geladen werden",
    ),
    "errLoadSimilar": MessageLookupByLibrary.simpleMessage(
      "Ähnliche Veranstaltungen konnten nicht geladen werden",
    ),
    "errLoadTickets": MessageLookupByLibrary.simpleMessage(
      "Tickets konnten nicht geladen werden",
    ),
    "errLogin": MessageLookupByLibrary.simpleMessage(
      "Anmeldung fehlgeschlagen",
    ),
    "errSaveEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung konnte nicht gespeichert werden",
    ),
    "errSignUp": MessageLookupByLibrary.simpleMessage(
      "Registrierung fehlgeschlagen",
    ),
    "errSignUpIncomplete": MessageLookupByLibrary.simpleMessage(
      "Registrierung konnte nicht abgeschlossen werden",
    ),
    "errWithCode": m6,
    "errWrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Benutzername oder Passwort falsch",
    ),
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Kapazität"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Kategorie"),
    "eventComplete": MessageLookupByLibrary.simpleMessage(
      "Deine Veranstaltung ist vollständig!",
    ),
    "eventCompleteness": m7,
    "eventCreated": MessageLookupByLibrary.simpleMessage("Event erstellt"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Währung"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Datum und Uhrzeit"),
    "eventDeleted": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung gelöscht",
    ),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Beschreibung"),
    "eventFinished": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung beendet",
    ),
    "eventFull": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung ausgebucht!",
    ),
    "eventFullMessage": m8,
    "eventLocation": MessageLookupByLibrary.simpleMessage("Ort"),
    "eventName": MessageLookupByLibrary.simpleMessage("Eventname"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("Ort"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("Preis"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage(
      "Kurzbeschreibung",
    ),
    "eventUpdated": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung aktualisiert",
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
    "filterByLocation": MessageLookupByLibrary.simpleMessage(
      "Nach Ort filtern",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Ich habe mein Passwort vergessen",
    ),
    "getDirections": MessageLookupByLibrary.simpleMessage("Route planen"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Hilfe"),
    "getStarted": MessageLookupByLibrary.simpleMessage("Los geht\'s"),
    "great": MessageLookupByLibrary.simpleMessage("Super!"),
    "greetingAfternoon": MessageLookupByLibrary.simpleMessage("Guten Tag!"),
    "greetingEvening": MessageLookupByLibrary.simpleMessage("Guten Abend!"),
    "greetingMorning": MessageLookupByLibrary.simpleMessage("Guten Morgen!"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage(
      "Ich habe bereits einen Link",
    ),
    "helpSubtitle": MessageLookupByLibrary.simpleMessage("FAQ und Support"),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Veranstaltet von"),
    "information": MessageLookupByLibrary.simpleMessage("Information"),
    "invalidAccessCode": MessageLookupByLibrary.simpleMessage(
      "Ungültiger Zugangscode",
    ),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "Nutze einen 3-Buchstaben-Code, z. B. USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Ungültige E-Mail-Adresse",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Ungültige Zahl"),
    "invitationOnly": MessageLookupByLibrary.simpleMessage("Nur auf Einladung"),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Tritt unserem Universum bei",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Behalten"),
    "language": MessageLookupByLibrary.simpleMessage("Sprache"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage("Sprache der App"),
    "lightMode": MessageLookupByLibrary.simpleMessage("Heller Modus"),
    "loadingEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung wird geladen…",
    ),
    "locationsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Orte konnten nicht geladen werden",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Einloggen"),
    "logout": MessageLookupByLibrary.simpleMessage("Ausloggen"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Möchtest du dich wirklich abmelden?",
    ),
    "logoutFailed": m9,
    "logoutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Von deinem Konto abmelden",
    ),
    "manageProfile": MessageLookupByLibrary.simpleMessage(
      "Verwalte deine Profilinformationen",
    ),
    "mapEnableLocation": MessageLookupByLibrary.simpleMessage("Aktivieren"),
    "mapLocationOff": MessageLookupByLibrary.simpleMessage(
      "Aktiviere deinen Standort, um Events in deiner Nähe zu sehen",
    ),
    "mapMyLocation": MessageLookupByLibrary.simpleMessage("Mein Standort"),
    "mapNoEvents": MessageLookupByLibrary.simpleMessage(
      "Keine anstehenden Events mit Standort",
    ),
    "mapOpenSettings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "myEvents": MessageLookupByLibrary.simpleMessage("Veranstaltungen"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Bezahlt"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Gerettet"),
    "myTickets": MessageLookupByLibrary.simpleMessage("Meine Tickets"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "navCreate": MessageLookupByLibrary.simpleMessage("Erstellen"),
    "navHome": MessageLookupByLibrary.simpleMessage("Start"),
    "navMap": MessageLookupByLibrary.simpleMessage("Karte"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profil"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Tickets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Neues Passwort"),
    "noCapacityLimit": MessageLookupByLibrary.simpleMessage(
      "Keine Platzbegrenzung",
    ),
    "noEventsInLocation": MessageLookupByLibrary.simpleMessage(
      "Keine bevorstehenden Veranstaltungen an diesem Ort",
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
    "notifications": MessageLookupByLibrary.simpleMessage("Benachrichtigungen"),
    "notificationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Push-Benachrichtigungen und Hinweise",
    ),
    "ownEvent": MessageLookupByLibrary.simpleMessage("Deine Veranstaltung"),
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
    "paymentsComingSoon": MessageLookupByLibrary.simpleMessage(
      "Zahlung in Kürze",
    ),
    "popularEvents": MessageLookupByLibrary.simpleMessage(
      "beliebte Veranstaltungen",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "pressBackToExit": MessageLookupByLibrary.simpleMessage(
      "Zum Beenden erneut Zurück drücken",
    ),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "Der Preis muss größer als 0 sein",
    ),
    "privacySubtitle": MessageLookupByLibrary.simpleMessage(
      "Datenschutz und Datennutzung",
    ),
    "profileUnavailable": MessageLookupByLibrary.simpleMessage(
      "Profil nicht verfügbar",
    ),
    "promotions": MessageLookupByLibrary.simpleMessage("Aktionen"),
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
    "saveChanges": MessageLookupByLibrary.simpleMessage("Änderungen speichern"),
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
    "slideCelebrateText": MessageLookupByLibrary.simpleMessage(
      "Melde dich mit einem Tipp an und hab deine Tickets immer dabei.",
    ),
    "slideCelebrateTitle": MessageLookupByLibrary.simpleMessage(
      "Feiert zusammen",
    ),
    "slideRelaxText": MessageLookupByLibrary.simpleMessage(
      "Erstelle eigene Veranstaltungen und erreiche mehr Menschen.",
    ),
    "slideRelaxTitle": MessageLookupByLibrary.simpleMessage(
      "Entspann dich in guter Gesellschaft",
    ),
    "slideShareText": MessageLookupByLibrary.simpleMessage(
      "Entdecke Veranstaltungen in deiner Nähe und teile sie mit Freunden.",
    ),
    "slideShareTitle": MessageLookupByLibrary.simpleMessage(
      "Teile mit Freunden",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Ausverkauft"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Etwas ist schiefgelaufen",
    ),
    "spotsLeft": m10,
    "supportLegal": MessageLookupByLibrary.simpleMessage(
      "Support & Rechtliches",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Design"),
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Anmeldung storniert",
    ),
    "ticketNumber": m11,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Tickets konnten nicht geladen werden",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Vergangen"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Anstehend"),
    "upcomingTicketsCount": m12,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Benutzername oder E-Mail",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Gib deinen Benutzernamen oder deine E-Mail ein",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Event ansehen"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("Mein Ticket ansehen"),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage("¡Willkommen zurück!"),
    "yourProfile": MessageLookupByLibrary.simpleMessage("Dein Profil"),
  };
}
