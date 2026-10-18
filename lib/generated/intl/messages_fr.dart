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

  static String m0(country) => "Tout ${country}";

  static String m1(year) => "© ${year} Parkea. Tous droits réservés.";

  static String m2(distance) => "à ${distance}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'Personne d\'inscrit pour l\'instant', one: '1 inscrit', other: '${count} inscrits')}";

  static String m4(enrolled, capacity) =>
      "${enrolled} inscrits sur ${capacity}";

  static String m5(date) => "Inscrit le ${date}";

  static String m6(code) => "Erreur (code : ${code})";

  static String m7(percent) => "Ton événement est complet à ${percent} %";

  static String m8(capacity, name) =>
      "${Intl.plural(capacity, one: 'L\'unique place de « ${name} » est prise.', other: 'Les ${capacity} places de « ${name} » sont prises.')}";

  static String m9(max) =>
      "Jusqu\'à ${max} images. La couverture est celle affichée dans le fil.";

  static String m10(current, total) => "Image ${current} sur ${total}";

  static String m11(max) =>
      "Un événement peut avoir au maximum ${max} images ; les premières ont été ajoutées.";

  static String m12(error) => "Impossible de se déconnecter : ${error}";

  static String m13(query) => "Personne ne correspond à « ${query} »";

  static String m14(count) => "${count} places disponibles";

  static String m15(current, total) => "Étape ${current} sur ${total}";

  static String m16(id) => "Billet n°${id}";

  static String m17(count) => "${count} billets à venir";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("À propos"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "Découvre, crée et partage des événements.",
    ),
    "aboutEvent": MessageLookupByLibrary.simpleMessage(
      "À propos de l\'événement",
    ),
    "aboutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Version et conditions d\'utilisation",
    ),
    "accessCode": MessageLookupByLibrary.simpleMessage("Code d\'accès"),
    "accessCodeHint": MessageLookupByLibrary.simpleMessage(
      "Cet événement est privé. Saisis le code fourni par l\'organisateur.",
    ),
    "accessCodeOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Partage-le avec tes invités pour qu\'ils puissent s\'inscrire.",
    ),
    "accessCodeQrHint": MessageLookupByLibrary.simpleMessage(
      "Tes invités le scannent depuis l\'accueil de Parkea.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Saisis le code",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Compte"),
    "addImages": MessageLookupByLibrary.simpleMessage("Ajouter des images"),
    "addressUnknown": MessageLookupByLibrary.simpleMessage(
      "Aucune adresse connue pour ce point",
    ),
    "allLocations": MessageLookupByLibrary.simpleMessage("Tous les lieux"),
    "allOfCountry": m0,
    "allRightsReserved": m1,
    "attendees": MessageLookupByLibrary.simpleMessage("Inscrits"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Authentifier"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Photo mise à jour"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de mettre à jour la photo",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Acheter un ticket"),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'utiliser la caméra. Vérifie l\'autorisation dans les réglages ou saisis le code.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage(
      "Annuler l\'inscription",
    ),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "Veux-tu vraiment annuler ton inscription ?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage("Vide = sans limite"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Aventure"),
    "catAll": MessageLookupByLibrary.simpleMessage("Toutes"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Camping"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Musique"),
    "catVolunteering": MessageLookupByLibrary.simpleMessage("Bénévolat"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Ateliers"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("Sans catégorie"),
    "changeLocation": MessageLookupByLibrary.simpleMessage("Modifier"),
    "changePassword": MessageLookupByLibrary.simpleMessage(
      "Changer le mot de passe",
    ),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Changer la photo"),
    "codeCopied": MessageLookupByLibrary.simpleMessage("Code copié"),
    "completenessBanner": MessageLookupByLibrary.simpleMessage(
      "Ajoute une image : les événements illustrés ressortent dans le fil.",
    ),
    "completenessCategory": MessageLookupByLibrary.simpleMessage(
      "Choisis une catégorie pour apparaître dans les filtres.",
    ),
    "completenessDescription": MessageLookupByLibrary.simpleMessage(
      "Explique de quoi parle l\'événement dans la description.",
    ),
    "completenessPlace": MessageLookupByLibrary.simpleMessage(
      "Indique le lieu pour qu\'on sache où aller.",
    ),
    "completenessShortDescription": MessageLookupByLibrary.simpleMessage(
      "Ajoute une description courte : c\'est ce qu\'on voit dans le fil.",
    ),
    "confirmLocation": MessageLookupByLibrary.simpleMessage(
      "Confirmer l\'emplacement",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirmer le mot de passe",
    ),
    "costFree": MessageLookupByLibrary.simpleMessage("Gratuit"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("Sur invitation"),
    "costPaid": MessageLookupByLibrary.simpleMessage("Payant"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Privé"),
    "costType": MessageLookupByLibrary.simpleMessage("Type d\'accès"),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'ouvrir le lien",
    ),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'ouvrir l\'app de cartes",
    ),
    "coverImage": MessageLookupByLibrary.simpleMessage("Couverture"),
    "createEvent": MessageLookupByLibrary.simpleMessage("Créer un événement"),
    "darkMode": MessageLookupByLibrary.simpleMessage("Mode sombre"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage(
      "Données et Confidentialité",
    ),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "La date doit être dans le futur",
    ),
    "deleteEvent": MessageLookupByLibrary.simpleMessage(
      "Supprimer l\'événement",
    ),
    "deleteEventConfirm": MessageLookupByLibrary.simpleMessage(
      "Toutes les inscriptions seront aussi supprimées. Cette action est irréversible.",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Studios Atheneox"),
    "distanceAway": m2,
    "downloadTicket": MessageLookupByLibrary.simpleMessage(
      "Télécharger le billet",
    ),
    "editEvent": MessageLookupByLibrary.simpleMessage("Modifier l\'événement"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Modifier le profil"),
    "email": MessageLookupByLibrary.simpleMessage("E-mail"),
    "enroll": MessageLookupByLibrary.simpleMessage("M\'inscrire"),
    "enrolledCount": m3,
    "enrolledOfCapacity": m4,
    "enrolledOn": m5,
    "enrolledPeople": MessageLookupByLibrary.simpleMessage(
      "Personnes inscrites",
    ),
    "enrolledSuccess": MessageLookupByLibrary.simpleMessage(
      "C\'est fait ! Tu es inscrit",
    ),
    "errCancelTicket": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'annuler le ticket",
    ),
    "errCheckFields": MessageLookupByLibrary.simpleMessage(
      "Vérifie les champs signalés",
    ),
    "errConnection": MessageLookupByLibrary.simpleMessage(
      "Impossible de se connecter au serveur",
    ),
    "errCreateEvent": MessageLookupByLibrary.simpleMessage(
      "Impossible de créer l\'événement",
    ),
    "errDeleteEvent": MessageLookupByLibrary.simpleMessage(
      "Impossible de supprimer l\'événement",
    ),
    "errEnroll": MessageLookupByLibrary.simpleMessage(
      "Impossible de finaliser l\'inscription",
    ),
    "errInvalidResetLink": MessageLookupByLibrary.simpleMessage(
      "Le lien est invalide ou a déjà été utilisé",
    ),
    "errLoadAttendees": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les inscrits",
    ),
    "errLoadEvent": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger l\'événement",
    ),
    "errLoadEvents": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les événements",
    ),
    "errLoadOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger tes événements",
    ),
    "errLoadProfile": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger le profil",
    ),
    "errLoadPromotions": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les promotions",
    ),
    "errLoadSimilar": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les événements similaires",
    ),
    "errLoadTickets": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les tickets",
    ),
    "errLogin": MessageLookupByLibrary.simpleMessage("Échec de la connexion"),
    "errSaveEvent": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'enregistrer l\'événement",
    ),
    "errSignUp": MessageLookupByLibrary.simpleMessage(
      "Échec de l\'inscription",
    ),
    "errSignUpIncomplete": MessageLookupByLibrary.simpleMessage(
      "Impossible de finaliser l\'inscription",
    ),
    "errWithCode": m6,
    "errWrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Nom d\'utilisateur ou mot de passe incorrect",
    ),
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Capacité"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Catégorie"),
    "eventComplete": MessageLookupByLibrary.simpleMessage(
      "Ton événement est complet !",
    ),
    "eventCompleteness": m7,
    "eventCreated": MessageLookupByLibrary.simpleMessage("Événement créé"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Devise"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Date et heure"),
    "eventDeleted": MessageLookupByLibrary.simpleMessage("Événement supprimé"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Description"),
    "eventFinished": MessageLookupByLibrary.simpleMessage("Événement terminé"),
    "eventFull": MessageLookupByLibrary.simpleMessage("Événement complet !"),
    "eventFullMessage": m8,
    "eventLocation": MessageLookupByLibrary.simpleMessage("Emplacement"),
    "eventName": MessageLookupByLibrary.simpleMessage("Nom de l\'événement"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("Lieu"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("Prix"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage(
      "Description courte",
    ),
    "eventUpdated": MessageLookupByLibrary.simpleMessage(
      "Événement mis à jour",
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
    "filterByLocation": MessageLookupByLibrary.simpleMessage(
      "Filtrer par lieu",
    ),
    "findingAddress": MessageLookupByLibrary.simpleMessage(
      "Recherche de l\'adresse…",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "Vous avez oublié le mot de passe?",
    ),
    "galleryHint": m9,
    "getDirections": MessageLookupByLibrary.simpleMessage("Itinéraire"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Aider"),
    "great": MessageLookupByLibrary.simpleMessage("Génial !"),
    "greetingAfternoon": MessageLookupByLibrary.simpleMessage(
      "Bon après-midi !",
    ),
    "greetingEvening": MessageLookupByLibrary.simpleMessage("Bonsoir !"),
    "greetingMorning": MessageLookupByLibrary.simpleMessage("Bonjour !"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage("J\'ai déjà un lien"),
    "helpSubtitle": MessageLookupByLibrary.simpleMessage("FAQ et assistance"),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Organisé par"),
    "imageOfTotal": m10,
    "imagesLimitReached": m11,
    "imagesPrepareFailed": MessageLookupByLibrary.simpleMessage(
      "Certaines images n\'ont pas pu être préparées et n\'ont pas été ajoutées.",
    ),
    "imagesSyncFailed": MessageLookupByLibrary.simpleMessage(
      "L\'événement a été enregistré, mais certaines images n\'ont pas pu être mises à jour.",
    ),
    "information": MessageLookupByLibrary.simpleMessage("Informations"),
    "invalidAccessCode": MessageLookupByLibrary.simpleMessage(
      "Code d\'accès invalide",
    ),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "Utilise un code à 3 lettres, p. ex. USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Adresse e-mail invalide",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Nombre invalide"),
    "invalidWebsite": MessageLookupByLibrary.simpleMessage(
      "Saisissez une adresse valide, ex. https://parkea.app",
    ),
    "invitationOnly": MessageLookupByLibrary.simpleMessage(
      "Sur invitation uniquement",
    ),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Rejoignez notre univers",
    ),
    "joinPrivateEvent": MessageLookupByLibrary.simpleMessage(
      "Rejoindre un événement privé",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Garder"),
    "language": MessageLookupByLibrary.simpleMessage("Langue"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Langue de l\'app",
    ),
    "lightMode": MessageLookupByLibrary.simpleMessage("Mode clair"),
    "loadingEvent": MessageLookupByLibrary.simpleMessage(
      "Chargement de l\'événement…",
    ),
    "locationNotSet": MessageLookupByLibrary.simpleMessage(
      "Sans emplacement : l\'événement n\'apparaîtra pas sur la carte",
    ),
    "locationsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les lieux",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Connectez-vous à"),
    "logout": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Veux-tu vraiment te déconnecter ?",
    ),
    "logoutFailed": m12,
    "logoutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Se déconnecter de ton compte",
    ),
    "makeCoverImage": MessageLookupByLibrary.simpleMessage(
      "Utiliser comme couverture",
    ),
    "manageProfile": MessageLookupByLibrary.simpleMessage(
      "Gère les informations de ton profil",
    ),
    "mapEnableLocation": MessageLookupByLibrary.simpleMessage("Activer"),
    "mapLocationOff": MessageLookupByLibrary.simpleMessage(
      "Activez votre position pour voir les événements près de chez vous",
    ),
    "mapMyLocation": MessageLookupByLibrary.simpleMessage("Ma position"),
    "mapNoEvents": MessageLookupByLibrary.simpleMessage(
      "Aucun événement à venir avec une adresse",
    ),
    "mapOpenSettings": MessageLookupByLibrary.simpleMessage("Réglages"),
    "moveMapHint": MessageLookupByLibrary.simpleMessage(
      "Déplacez la carte pour placer l\'épingle",
    ),
    "myEvents": MessageLookupByLibrary.simpleMessage("Événements"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Payé"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage(
      "Mes événements enregistrés",
    ),
    "myLocationUnavailable": MessageLookupByLibrary.simpleMessage(
      "Impossible d\'obtenir votre position",
    ),
    "myTickets": MessageLookupByLibrary.simpleMessage("Mes billets"),
    "name": MessageLookupByLibrary.simpleMessage("Nom"),
    "navCreate": MessageLookupByLibrary.simpleMessage("Créer"),
    "navHome": MessageLookupByLibrary.simpleMessage("Accueil"),
    "navMap": MessageLookupByLibrary.simpleMessage("Carte"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profil"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Billets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("Nouveau mot de passe"),
    "noAttendeesMatch": m13,
    "noCapacityLimit": MessageLookupByLibrary.simpleMessage(
      "Pas de limite de places",
    ),
    "noEventsInLocation": MessageLookupByLibrary.simpleMessage(
      "Aucun événement à venir à cet endroit",
    ),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Tu n\'as encore créé aucun événement",
    ),
    "noPastTickets": MessageLookupByLibrary.simpleMessage("Aucun billet passé"),
    "noPlacesFound": MessageLookupByLibrary.simpleMessage("Lieu introuvable"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "Aucun événement ne correspond à ta recherche",
    ),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage(
      "Aucun billet à venir",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notificationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Notifications push et alertes",
    ),
    "openEvent": MessageLookupByLibrary.simpleMessage("Ouvrir l\'événement"),
    "orEnterCode": MessageLookupByLibrary.simpleMessage("Ou saisis le code"),
    "ownEvent": MessageLookupByLibrary.simpleMessage("Ton événement"),
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
    "paymentsComingSoon": MessageLookupByLibrary.simpleMessage(
      "Paiement bientôt disponible",
    ),
    "pickOnMap": MessageLookupByLibrary.simpleMessage("Choisir sur la carte"),
    "popularEvents": MessageLookupByLibrary.simpleMessage(
      "Événements populaires",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("Préférences"),
    "pressBackToExit": MessageLookupByLibrary.simpleMessage(
      "Appuie à nouveau sur Retour pour quitter",
    ),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "Le prix doit être supérieur à 0",
    ),
    "privacySubtitle": MessageLookupByLibrary.simpleMessage(
      "Politique de confidentialité et données",
    ),
    "privateEvent": MessageLookupByLibrary.simpleMessage("Événement privé"),
    "profileBio": MessageLookupByLibrary.simpleMessage("Description"),
    "profileBioHint": MessageLookupByLibrary.simpleMessage(
      "Dites qui vous êtes ou ce que vous organisez",
    ),
    "profileUnavailable": MessageLookupByLibrary.simpleMessage(
      "Profil indisponible",
    ),
    "profileUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Impossible de mettre à jour le profil",
    ),
    "profileUpdated": MessageLookupByLibrary.simpleMessage("Profil mis à jour"),
    "profileWebsite": MessageLookupByLibrary.simpleMessage("Site web"),
    "promotions": MessageLookupByLibrary.simpleMessage("Promotions"),
    "province": MessageLookupByLibrary.simpleMessage("Province"),
    "publishEvent": MessageLookupByLibrary.simpleMessage(
      "Publier l\'événement",
    ),
    "register": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
    "removeImage": MessageLookupByLibrary.simpleMessage("Retirer l\'image"),
    "removeLocation": MessageLookupByLibrary.simpleMessage(
      "Retirer l\'emplacement",
    ),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "Si l\'e-mail est enregistré, nous t\'avons envoyé un lien pour réinitialiser ton mot de passe",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Enregistrer"),
    "saveEvent": MessageLookupByLibrary.simpleMessage(
      "Enregistrer l\'événement",
    ),
    "scanQrHint": MessageLookupByLibrary.simpleMessage(
      "Scanne le QR code que l\'organisateur t\'a partagé",
    ),
    "searchAttendees": MessageLookupByLibrary.simpleMessage(
      "Rechercher par nom ou nom d\'utilisateur",
    ),
    "searchEvents": MessageLookupByLibrary.simpleMessage(
      "Rechercher des activités",
    ),
    "searchPlace": MessageLookupByLibrary.simpleMessage(
      "Rechercher une adresse ou un lieu",
    ),
    "seeEvent": MessageLookupByLibrary.simpleMessage("Voir événement"),
    "settings": MessageLookupByLibrary.simpleMessage("Paramètre"),
    "showQr": MessageLookupByLibrary.simpleMessage("Afficher le QR code"),
    "signUp": MessageLookupByLibrary.simpleMessage("S\'inscrire"),
    "similarEvents": MessageLookupByLibrary.simpleMessage(
      "Événements similaires",
    ),
    "slideCreateText": MessageLookupByLibrary.simpleMessage(
      "Publie ton projet et touche plus de monde.",
    ),
    "slideCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Crée tes événements",
    ),
    "slideDiscoverText": MessageLookupByLibrary.simpleMessage(
      "Concerts, ateliers et sorties près de chez toi à partager avec tes amis.",
    ),
    "slideDiscoverTitle": MessageLookupByLibrary.simpleMessage(
      "Découvre des événements",
    ),
    "slideEnrollText": MessageLookupByLibrary.simpleMessage(
      "Tes tickets restent sur ton téléphone, toujours à portée de main.",
    ),
    "slideEnrollTitle": MessageLookupByLibrary.simpleMessage(
      "Inscris-toi en un geste",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Complet"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Un problème est survenu",
    ),
    "spotsLeft": m14,
    "stepOfTotal": m15,
    "supportLegal": MessageLookupByLibrary.simpleMessage(
      "Support et mentions légales",
    ),
    "theme": MessageLookupByLibrary.simpleMessage("Thème"),
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Inscription annulée",
    ),
    "ticketNumber": m16,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Impossible de charger les billets",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Passés"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("À venir"),
    "tooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Trop de tentatives, attends une minute",
    ),
    "upcomingTicketsCount": m17,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Nom d\'utilisateur ou e-mail",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Saisis ton nom d\'utilisateur ou ton e-mail",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("Voir l\'événement"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("Voir mon ticket"),
    "volunteeringFreeNote": MessageLookupByLibrary.simpleMessage(
      "Le bénévolat est gratuit et ouvert à tous.",
    ),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage(
      "¡Bienvenue à nouveau!",
    ),
    "welcomeNext": MessageLookupByLibrary.simpleMessage("Suivant"),
    "welcomeSignIn": MessageLookupByLibrary.simpleMessage(
      "J\'ai déjà un compte",
    ),
    "welcomeSignUp": MessageLookupByLibrary.simpleMessage("Créer un compte"),
    "welcomeSkip": MessageLookupByLibrary.simpleMessage("Passer"),
    "yourProfile": MessageLookupByLibrary.simpleMessage("Ton profil"),
  };
}
