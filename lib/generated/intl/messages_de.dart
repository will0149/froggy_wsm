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

  static String m9(max) =>
      "Bis zu ${max} Bilder. Das Titelbild wird im Feed angezeigt.";

  static String m10(current, total) => "Bild ${current} von ${total}";

  static String m11(max) =>
      "Ein Event kann höchstens ${max} Bilder haben; die ersten wurden hinzugefügt.";

  static String m12(error) => "Abmeldung fehlgeschlagen: ${error}";

  static String m13(query) => "Niemand passt zu „${query}“";

  static String m14(link) => "Auf Parkea ansehen: ${link}";

  static String m15(count) => "${count} Plätze frei";

  static String m16(current, total) => "Schritt ${current} von ${total}";

  static String m17(id) => "Ticket #${id}";

  static String m18(count) => "${count} anstehende Tickets";

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
    "accessCodeQrHint": MessageLookupByLibrary.simpleMessage(
      "Deine Gäste scannen ihn auf dem Parkea-Startbildschirm.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Gib den Code ein",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Konto"),
    "addImages": MessageLookupByLibrary.simpleMessage("Bilder hinzufügen"),
    "addressUnknown": MessageLookupByLibrary.simpleMessage(
      "Keine bekannte Adresse für diesen Punkt",
    ),
    "allLocations": MessageLookupByLibrary.simpleMessage("Alle Orte"),
    "allOfCountry": m0,
    "allRightsReserved": m1,
    "attendees": MessageLookupByLibrary.simpleMessage("Teilnehmende"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Authentifizieren"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Foto aktualisiert"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Foto konnte nicht aktualisiert werden",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("kauf ein Ticket"),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Die Kamera konnte nicht verwendet werden. Prüfe die Berechtigung in den Einstellungen oder gib den Code ein.",
    ),
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
    "catVolunteering": MessageLookupByLibrary.simpleMessage("Ehrenamt"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Workshops"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Keine Kategorie"),
    "changeLocation": MessageLookupByLibrary.simpleMessage("Ändern"),
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
    "confirmLocation": MessageLookupByLibrary.simpleMessage(
      "Standort bestätigen",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Passwort bestätigen",
    ),
    "costFree": MessageLookupByLibrary.simpleMessage("Kostenlos"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("Mit Einladung"),
    "costPaid": MessageLookupByLibrary.simpleMessage("Kostenpflichtig"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Privat"),
    "costType": MessageLookupByLibrary.simpleMessage("Zugangsart"),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "Link konnte nicht geöffnet werden",
    ),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "Karten-App konnte nicht geöffnet werden",
    ),
    "coverImage": MessageLookupByLibrary.simpleMessage("Titelbild"),
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
    "editProfile": MessageLookupByLibrary.simpleMessage("Profil bearbeiten"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "enroll": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "enrolledCount": m3,
    "enrolledOfCapacity": m4,
    "enrolledOn": m5,
    "enrolledPeople": MessageLookupByLibrary.simpleMessage(
      "Angemeldete Personen",
    ),
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
    "errLoadAttendees": MessageLookupByLibrary.simpleMessage(
      "Teilnehmer konnten nicht geladen werden",
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
    "eventLocation": MessageLookupByLibrary.simpleMessage("Standort"),
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
    "findingAddress": MessageLookupByLibrary.simpleMessage(
      "Adresse wird gesucht…",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Ich habe mein Passwort vergessen",
    ),
    "galleryHint": m9,
    "getDirections": MessageLookupByLibrary.simpleMessage("Route planen"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Hilfe"),
    "great": MessageLookupByLibrary.simpleMessage("Super!"),
    "greetingAfternoon": MessageLookupByLibrary.simpleMessage("Guten Tag!"),
    "greetingEvening": MessageLookupByLibrary.simpleMessage("Guten Abend!"),
    "greetingMorning": MessageLookupByLibrary.simpleMessage("Guten Morgen!"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage(
      "Ich habe bereits einen Link",
    ),
    "helpSubtitle": MessageLookupByLibrary.simpleMessage("FAQ und Support"),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Veranstaltet von"),
    "imageOfTotal": m10,
    "imagesLimitReached": m11,
    "imagesPrepareFailed": MessageLookupByLibrary.simpleMessage(
      "Einige Bilder konnten nicht vorbereitet werden und wurden nicht hinzugefügt.",
    ),
    "imagesSyncFailed": MessageLookupByLibrary.simpleMessage(
      "Das Event wurde gespeichert, aber einige Bilder konnten nicht aktualisiert werden.",
    ),
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
    "invalidWebsite": MessageLookupByLibrary.simpleMessage(
      "Gib eine gültige Webadresse ein, z. B. https://parkea.app",
    ),
    "invitationOnly": MessageLookupByLibrary.simpleMessage("Nur auf Einladung"),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Tritt unserem Universum bei",
    ),
    "joinPrivateEvent": MessageLookupByLibrary.simpleMessage(
      "Privater Veranstaltung beitreten",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Behalten"),
    "language": MessageLookupByLibrary.simpleMessage("Sprache"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage("Sprache der App"),
    "lightMode": MessageLookupByLibrary.simpleMessage("Heller Modus"),
    "loadingEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung wird geladen…",
    ),
    "locationNotSet": MessageLookupByLibrary.simpleMessage(
      "Kein Standort: Das Event erscheint nicht auf der Karte",
    ),
    "locationsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Orte konnten nicht geladen werden",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Einloggen"),
    "logout": MessageLookupByLibrary.simpleMessage("Ausloggen"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Möchtest du dich wirklich abmelden?",
    ),
    "logoutFailed": m12,
    "logoutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Von deinem Konto abmelden",
    ),
    "makeCoverImage": MessageLookupByLibrary.simpleMessage(
      "Als Titelbild verwenden",
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
    "moveMapHint": MessageLookupByLibrary.simpleMessage(
      "Bewege die Karte, um den Pin zu setzen",
    ),
    "myEvents": MessageLookupByLibrary.simpleMessage("Veranstaltungen"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Bezahlt"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Gerettet"),
    "myLocationUnavailable": MessageLookupByLibrary.simpleMessage(
      "Dein Standort konnte nicht ermittelt werden",
    ),
    "myTickets": MessageLookupByLibrary.simpleMessage("Meine Tickets"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "navCreate": MessageLookupByLibrary.simpleMessage("Erstellen"),
    "navHome": MessageLookupByLibrary.simpleMessage("Start"),
    "navMap": MessageLookupByLibrary.simpleMessage("Karte"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profil"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Tickets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Neues Passwort"),
    "noAttendeesMatch": m13,
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
    "noPlacesFound": MessageLookupByLibrary.simpleMessage(
      "Diesen Ort haben wir nicht gefunden",
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
    "openEvent": MessageLookupByLibrary.simpleMessage("Veranstaltung öffnen"),
    "orEnterCode": MessageLookupByLibrary.simpleMessage(
      "Oder gib den Code ein",
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
    "pickOnMap": MessageLookupByLibrary.simpleMessage("Auf der Karte wählen"),
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
    "privateEvent": MessageLookupByLibrary.simpleMessage(
      "Private Veranstaltung",
    ),
    "profileBio": MessageLookupByLibrary.simpleMessage("Beschreibung"),
    "profileBioHint": MessageLookupByLibrary.simpleMessage(
      "Erzähl, wer du bist oder was du organisierst",
    ),
    "profileUnavailable": MessageLookupByLibrary.simpleMessage(
      "Profil nicht verfügbar",
    ),
    "profileUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Profil konnte nicht aktualisiert werden",
    ),
    "profileUpdated": MessageLookupByLibrary.simpleMessage(
      "Profil aktualisiert",
    ),
    "profileWebsite": MessageLookupByLibrary.simpleMessage("Website"),
    "promotions": MessageLookupByLibrary.simpleMessage("Aktionen"),
    "publishEvent": MessageLookupByLibrary.simpleMessage(
      "Event veröffentlichen",
    ),
    "register": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "removeImage": MessageLookupByLibrary.simpleMessage("Bild entfernen"),
    "removeLocation": MessageLookupByLibrary.simpleMessage(
      "Standort entfernen",
    ),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Wenn die E-Mail registriert ist, haben wir dir einen Link zum Zurücksetzen des Passworts gesendet",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("Erneut versuchen"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Änderungen speichern"),
    "saveEvent": MessageLookupByLibrary.simpleMessage(
      "Veranstaltung speichern",
    ),
    "scanQrHint": MessageLookupByLibrary.simpleMessage(
      "Scanne den QR-Code, den dir der Veranstalter geschickt hat",
    ),
    "searchAttendees": MessageLookupByLibrary.simpleMessage(
      "Nach Name oder Benutzername suchen",
    ),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Aktivitäten suchen"),
    "searchPlace": MessageLookupByLibrary.simpleMessage(
      "Adresse oder Ort suchen",
    ),
    "seeEvent": MessageLookupByLibrary.simpleMessage("siehe Veranstaltung"),
    "settings": MessageLookupByLibrary.simpleMessage("Einstellung"),
    "shareEvent": MessageLookupByLibrary.simpleMessage("Event teilen"),
    "shareEventLink": m14,
    "showQr": MessageLookupByLibrary.simpleMessage("QR-Code anzeigen"),
    "signUp": MessageLookupByLibrary.simpleMessage("Anmelden"),
    "similarEvents": MessageLookupByLibrary.simpleMessage(
      "ähnliche Veranstaltungen",
    ),
    "slideCreateText": MessageLookupByLibrary.simpleMessage(
      "Veröffentliche deinen Plan und erreiche mehr Menschen.",
    ),
    "slideCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Erstelle deine Events",
    ),
    "slideDiscoverText": MessageLookupByLibrary.simpleMessage(
      "Konzerte, Workshops und Pläne in deiner Nähe zum Teilen mit Freunden.",
    ),
    "slideDiscoverTitle": MessageLookupByLibrary.simpleMessage(
      "Entdecke Events",
    ),
    "slideEnrollText": MessageLookupByLibrary.simpleMessage(
      "Deine Tickets bleiben auf deinem Handy, immer griffbereit.",
    ),
    "slideEnrollTitle": MessageLookupByLibrary.simpleMessage(
      "Mit einem Tipp dabei",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Ausverkauft"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Etwas ist schiefgelaufen",
    ),
    "spotsLeft": m15,
    "stepOfTotal": m16,
    "supportLegal": MessageLookupByLibrary.simpleMessage(
      "Support & Rechtliches",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Design"),
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Anmeldung storniert",
    ),
    "ticketNumber": m17,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Tickets konnten nicht geladen werden",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Vergangen"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Anstehend"),
    "tooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Zu viele Versuche, warte eine Minute",
    ),
    "upcomingTicketsCount": m18,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Benutzername oder E-Mail",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Gib deinen Benutzernamen oder deine E-Mail ein",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Event ansehen"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("Mein Ticket ansehen"),
    "volunteeringFreeNote": MessageLookupByLibrary.simpleMessage(
      "Ehrenamtliche Events sind kostenlos und offen für alle.",
    ),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage("¡Willkommen zurück!"),
    "welcomeNext": MessageLookupByLibrary.simpleMessage("Weiter"),
    "welcomeSignIn": MessageLookupByLibrary.simpleMessage(
      "Ich habe schon ein Konto",
    ),
    "welcomeSignUp": MessageLookupByLibrary.simpleMessage("Konto erstellen"),
    "welcomeSkip": MessageLookupByLibrary.simpleMessage("Überspringen"),
    "yourProfile": MessageLookupByLibrary.simpleMessage("Dein Profil"),
  };
}
