// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(date) => "Inscrit le ${date}";

  static String m1(count) => "${count} places disponibles";

  static String m2(id) => "Billet n°${id}";

  static String m3(count) => "${count} billets à venir";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addBanner": MessageLookupByLibrary.simpleMessage("Ajouter une image"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Authentifier"),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage(
      "L\'événement a été créé, mais l\'image n\'a pas pu être envoyée",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Acheter un ticket"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage(
      "Annuler l\'inscription",
    ),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "Veux-tu vraiment annuler ton inscription ?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage("Vide = sans limite"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Aventure"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Camping"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Musique"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Ateliers"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Sans catégorie"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("Changer l\'image"),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Changer le mot de passe",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmer le mot de passe",
    ),
    "costFree": MessageLookupByLibrary.simpleMessage("Gratuit"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("Sur invitation"),
    "costPaid": MessageLookupByLibrary.simpleMessage("Payant"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Privé"),
    "costType": MessageLookupByLibrary.simpleMessage("Type d\'accès"),
    "createEvent": MessageLookupByLibrary.simpleMessage("Créer un événement"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage(
      "Données et Confidentialité",
    ),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "La date doit être dans le futur",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Studios Atheneox"),
    "downloadTicket": MessageLookupByLibrary.simpleMessage(
      "Télécharger le billet",
    ),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "enrolledOn": m0,
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Capacité"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Catégorie"),
    "eventCreated": MessageLookupByLibrary.simpleMessage("Événement créé"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Devise"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Date et heure"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Description"),
    "eventName": MessageLookupByLibrary.simpleMessage("Nom de l\'événement"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("Lieu"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("Prix"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage(
      "Description courte",
    ),
    "eventsForAll": MessageLookupByLibrary.simpleMessage(
      "Événements pour tous",
    ),
    "eventsForYou": MessageLookupByLibrary.simpleMessage("Événements pour toi"),
    "feedEmpty": MessageLookupByLibrary.simpleMessage(
      "Aucun événement pour l\'instant",
    ),
    "feedEnd": MessageLookupByLibrary.simpleMessage(
      "Tu as vu tous les événements",
    ),
    "feedLoadError": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les événements",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "Ce champ est obligatoire",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Vous avez oublié le mot de passe?",
    ),
    "getHelp": MessageLookupByLibrary.simpleMessage("Aider"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage("J\'ai déjà un lien"),
    "information": MessageLookupByLibrary.simpleMessage("Informations"),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "Utilise un code à 3 lettres, p. ex. USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Adresse e-mail invalide",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Nombre invalide"),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Rejoignez notre univers",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Garder"),
    "login": MessageLookupByLibrary.simpleMessage("Connectez-vous à"),
    "logout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "myEvents": MessageLookupByLibrary.simpleMessage("Événements"),
    "myEventsEnrolled": MessageLookupByLibrary.simpleMessage("Inscrit"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Payé"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage(
      "Mes événements enregistrés",
    ),
    "myTickets": MessageLookupByLibrary.simpleMessage("Mes billets"),
    "name": MessageLookupByLibrary.simpleMessage("Nom"),
    "navHome": MessageLookupByLibrary.simpleMessage("Accueil"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profil"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Billets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
    "noEnrolledEvents": MessageLookupByLibrary.simpleMessage(
      "Tu n\'es inscrit à aucun événement",
    ),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Tu n\'as encore créé aucun événement",
    ),
    "noPastTickets": MessageLookupByLibrary.simpleMessage("Aucun billet passé"),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage(
      "Aucun billet à venir",
    ),
    "parkeaAndShare": MessageLookupByLibrary.simpleMessage(
      "Parkea et partager",
    ),
    "parkeaAppName": MessageLookupByLibrary.simpleMessage("Parkea!"),
    "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "passwordEntirelyNumeric": MessageLookupByLibrary.simpleMessage(
      "Le mot de passe ne peut pas contenir uniquement des chiffres",
    ),
    "passwordResetDone": MessageLookupByLibrary.simpleMessage(
      "Mot de passe mis à jour. Connecte-toi.",
    ),
    "passwordTooCommon": MessageLookupByLibrary.simpleMessage(
      "Ce mot de passe est trop courant",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Le mot de passe doit contenir au moins 8 caractères",
    ),
    "passwordTooSimilar": MessageLookupByLibrary.simpleMessage(
      "Le mot de passe ressemble trop à ton nom d\'utilisateur ou à ton e-mail",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Les mots de passe ne correspondent pas",
    ),
    "popularEvents": MessageLookupByLibrary.simpleMessage(
      "Événements populaires",
    ),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "Le prix doit être supérieur à 0",
    ),
    "province": MessageLookupByLibrary.simpleMessage("Province"),
    "publishEvent": MessageLookupByLibrary.simpleMessage(
      "Publier l\'événement",
    ),
    "register": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Si l\'e-mail est enregistré, nous t\'avons envoyé un lien pour réinitialiser ton mot de passe",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "saveEvent": MessageLookupByLibrary.simpleMessage(
      "Enregistrer l\'événement",
    ),
    "seeEvent": MessageLookupByLibrary.simpleMessage("Voir événement"),
    "settings": MessageLookupByLibrary.simpleMessage("Paramètre"),
    "signUp": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
    "similarEvents": MessageLookupByLibrary.simpleMessage(
      "Événements similaires",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Complet"),
    "spotsLeft": m1,
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Inscription annulée",
    ),
    "ticketNumber": m2,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les billets",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Passés"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("À venir"),
    "upcomingTicketsCount": m3,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Nom d\'utilisateur ou e-mail",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Saisis ton nom d\'utilisateur ou ton e-mail",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Voir l\'événement"),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage(
      "¡Bienvenue à nouveau!",
    ),
  };
}
