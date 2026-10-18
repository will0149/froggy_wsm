// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(country) => "All of ${country}";

  static String m1(year) => "© ${year} Parkea. All rights reserved.";

  static String m2(distance) => "${distance} away";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'No one enrolled yet', one: '1 enrolled', other: '${count} enrolled')}";

  static String m4(enrolled, capacity) => "${enrolled} of ${capacity} enrolled";

  static String m5(date) => "Enrolled on ${date}";

  static String m6(code) => "Error (code: ${code})";

  static String m7(percent) => "Your event is ${percent}% complete";

  static String m8(capacity, name) =>
      "${Intl.plural(capacity, one: 'The only spot for “${name}” is taken.', other: 'All ${capacity} spots for “${name}” are taken.')}";

  static String m9(max) =>
      "Up to ${max} images. The cover is the one shown in the feed.";

  static String m10(current, total) => "Image ${current} of ${total}";

  static String m11(max) =>
      "An event can have at most ${max} images; the first ones were added.";

  static String m12(error) => "Couldn\'t sign out: ${error}";

  static String m13(query) => "No one matches “${query}”";

  static String m14(count) => "${count} spots left";

  static String m15(current, total) => "Step ${current} of ${total}";

  static String m16(id) => "Ticket #${id}";

  static String m17(count) => "${count} upcoming tickets";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "Discover, create and share events.",
    ),
    "aboutEvent": MessageLookupByLibrary.simpleMessage("About the event"),
    "aboutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Version and terms of service",
    ),
    "accessCode": MessageLookupByLibrary.simpleMessage("Access code"),
    "accessCodeHint": MessageLookupByLibrary.simpleMessage(
      "This event is private. Enter the code the organizer gave you.",
    ),
    "accessCodeOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Share it with your guests so they can enroll.",
    ),
    "accessCodeQrHint": MessageLookupByLibrary.simpleMessage(
      "Your guests scan it from the Parkea home screen.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the code",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "addImages": MessageLookupByLibrary.simpleMessage("Add images"),
    "addressUnknown": MessageLookupByLibrary.simpleMessage(
      "No known address for this point",
    ),
    "allLocations": MessageLookupByLibrary.simpleMessage("All locations"),
    "allOfCountry": m0,
    "allRightsReserved": m1,
    "attendees": MessageLookupByLibrary.simpleMessage("Attendees"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Authenticate"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Photo updated"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t update the photo",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Get ticket"),
    "cameraUnavailable": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t use the camera. Check the permission in settings or enter the code.",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage("Cancel enrollment"),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel your enrollment?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage("Empty = no limit"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Adventure"),
    "catAll": MessageLookupByLibrary.simpleMessage("All"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Camping"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Music"),
    "catVolunteering": MessageLookupByLibrary.simpleMessage("Volunteering"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Workshops"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("No category"),
    "changeLocation": MessageLookupByLibrary.simpleMessage("Change"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change password"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Change photo"),
    "codeCopied": MessageLookupByLibrary.simpleMessage("Code copied"),
    "completenessBanner": MessageLookupByLibrary.simpleMessage(
      "Add an image: events with one stand out in the feed.",
    ),
    "completenessCategory": MessageLookupByLibrary.simpleMessage(
      "Pick a category so it shows up in the filters.",
    ),
    "completenessDescription": MessageLookupByLibrary.simpleMessage(
      "Tell people what the event is about in the description.",
    ),
    "completenessPlace": MessageLookupByLibrary.simpleMessage(
      "Add the place so people know where to go.",
    ),
    "completenessShortDescription": MessageLookupByLibrary.simpleMessage(
      "Add a short description: it\'s what people see in the feed.",
    ),
    "confirmLocation": MessageLookupByLibrary.simpleMessage("Confirm location"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm password"),
    "costFree": MessageLookupByLibrary.simpleMessage("Free"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("By invitation"),
    "costPaid": MessageLookupByLibrary.simpleMessage("Paid"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Private"),
    "costType": MessageLookupByLibrary.simpleMessage("Access type"),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t open the link",
    ),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t open the maps app",
    ),
    "coverImage": MessageLookupByLibrary.simpleMessage("Cover"),
    "createEvent": MessageLookupByLibrary.simpleMessage("Create event"),
    "darkMode": MessageLookupByLibrary.simpleMessage("Dark mode"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage("Data & Privacy"),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "The date must be in the future",
    ),
    "deleteEvent": MessageLookupByLibrary.simpleMessage("Delete event"),
    "deleteEventConfirm": MessageLookupByLibrary.simpleMessage(
      "All enrollments will be deleted too. This can\'t be undone.",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studios"),
    "distanceAway": m2,
    "downloadTicket": MessageLookupByLibrary.simpleMessage("Download ticket"),
    "editEvent": MessageLookupByLibrary.simpleMessage("Edit event"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "enroll": MessageLookupByLibrary.simpleMessage("Enroll"),
    "enrolledCount": m3,
    "enrolledOfCapacity": m4,
    "enrolledOn": m5,
    "enrolledPeople": MessageLookupByLibrary.simpleMessage("Enrolled people"),
    "enrolledSuccess": MessageLookupByLibrary.simpleMessage(
      "Done! You\'re enrolled",
    ),
    "errCancelTicket": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t cancel the ticket",
    ),
    "errCheckFields": MessageLookupByLibrary.simpleMessage(
      "Check the highlighted fields",
    ),
    "errConnection": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t connect to the server",
    ),
    "errCreateEvent": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t create the event",
    ),
    "errDeleteEvent": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t delete the event",
    ),
    "errEnroll": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t complete the enrollment",
    ),
    "errInvalidResetLink": MessageLookupByLibrary.simpleMessage(
      "The link is invalid or has already been used",
    ),
    "errLoadAttendees": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load the attendees",
    ),
    "errLoadEvent": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load the event",
    ),
    "errLoadEvents": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load events",
    ),
    "errLoadOwnEvents": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load your events",
    ),
    "errLoadProfile": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load the profile",
    ),
    "errLoadPromotions": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load promotions",
    ),
    "errLoadSimilar": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load similar events",
    ),
    "errLoadTickets": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load tickets",
    ),
    "errLogin": MessageLookupByLibrary.simpleMessage("Couldn\'t sign in"),
    "errSaveEvent": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t save the event",
    ),
    "errSignUp": MessageLookupByLibrary.simpleMessage("Couldn\'t sign up"),
    "errSignUpIncomplete": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t complete the sign-up",
    ),
    "errWithCode": m6,
    "errWrongCredentials": MessageLookupByLibrary.simpleMessage(
      "Wrong username or password",
    ),
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Capacity"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Category"),
    "eventComplete": MessageLookupByLibrary.simpleMessage(
      "Your event is complete!",
    ),
    "eventCompleteness": m7,
    "eventCreated": MessageLookupByLibrary.simpleMessage("Event created"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Currency"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Date and time"),
    "eventDeleted": MessageLookupByLibrary.simpleMessage("Event deleted"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Description"),
    "eventFinished": MessageLookupByLibrary.simpleMessage("Event ended"),
    "eventFull": MessageLookupByLibrary.simpleMessage("Event full!"),
    "eventFullMessage": m8,
    "eventLocation": MessageLookupByLibrary.simpleMessage("Location"),
    "eventName": MessageLookupByLibrary.simpleMessage("Event name"),
    "eventPlace": MessageLookupByLibrary.simpleMessage("Place"),
    "eventPrice": MessageLookupByLibrary.simpleMessage("Price"),
    "eventShortDescription": MessageLookupByLibrary.simpleMessage(
      "Short description",
    ),
    "eventUpdated": MessageLookupByLibrary.simpleMessage("Event updated"),
    "eventsForAll": MessageLookupByLibrary.simpleMessage("Events for everyone"),
    "eventsForYou": MessageLookupByLibrary.simpleMessage("Events for you"),
    "feedEmpty": MessageLookupByLibrary.simpleMessage("No events yet"),
    "feedEnd": MessageLookupByLibrary.simpleMessage("You\'re all caught up"),
    "feedLoadError": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load events",
    ),
    "fieldRequired": MessageLookupByLibrary.simpleMessage(
      "This field is required",
    ),
    "filterByLocation": MessageLookupByLibrary.simpleMessage(
      "Filter by location",
    ),
    "findingAddress": MessageLookupByLibrary.simpleMessage("Finding address…"),
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "I forgot my password",
    ),
    "galleryHint": m9,
    "getDirections": MessageLookupByLibrary.simpleMessage("Get directions"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Help"),
    "great": MessageLookupByLibrary.simpleMessage("Great!"),
    "greetingAfternoon": MessageLookupByLibrary.simpleMessage(
      "Good afternoon!",
    ),
    "greetingEvening": MessageLookupByLibrary.simpleMessage("Good evening!"),
    "greetingMorning": MessageLookupByLibrary.simpleMessage("Good morning!"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage(
      "I already have a link",
    ),
    "helpSubtitle": MessageLookupByLibrary.simpleMessage("FAQ and support"),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Hosted by"),
    "imageOfTotal": m10,
    "imagesLimitReached": m11,
    "imagesPrepareFailed": MessageLookupByLibrary.simpleMessage(
      "Some images couldn\'t be prepared and weren\'t added.",
    ),
    "imagesSyncFailed": MessageLookupByLibrary.simpleMessage(
      "The event was saved, but some images couldn\'t be updated.",
    ),
    "information": MessageLookupByLibrary.simpleMessage("Information"),
    "invalidAccessCode": MessageLookupByLibrary.simpleMessage(
      "Invalid access code",
    ),
    "invalidCurrency": MessageLookupByLibrary.simpleMessage(
      "Use a 3-letter code, e.g. USD",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "Invalid email address",
    ),
    "invalidNumber": MessageLookupByLibrary.simpleMessage("Invalid number"),
    "invalidWebsite": MessageLookupByLibrary.simpleMessage(
      "Enter a valid web address, e.g. https://parkea.app",
    ),
    "invitationOnly": MessageLookupByLibrary.simpleMessage("Invitation only"),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Join our universe",
    ),
    "joinPrivateEvent": MessageLookupByLibrary.simpleMessage(
      "Join a private event",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Keep"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage("App language"),
    "lightMode": MessageLookupByLibrary.simpleMessage("Light mode"),
    "loadingEvent": MessageLookupByLibrary.simpleMessage("Loading event…"),
    "locationNotSet": MessageLookupByLibrary.simpleMessage(
      "No location: the event won\'t show on the map",
    ),
    "locationsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load locations",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Sign In"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to sign out?",
    ),
    "logoutFailed": m12,
    "logoutSubtitle": MessageLookupByLibrary.simpleMessage(
      "Sign out of your account",
    ),
    "makeCoverImage": MessageLookupByLibrary.simpleMessage("Make cover"),
    "manageProfile": MessageLookupByLibrary.simpleMessage(
      "Manage your profile information",
    ),
    "mapEnableLocation": MessageLookupByLibrary.simpleMessage("Turn on"),
    "mapLocationOff": MessageLookupByLibrary.simpleMessage(
      "Turn on your location to see events near you",
    ),
    "mapMyLocation": MessageLookupByLibrary.simpleMessage("My location"),
    "mapNoEvents": MessageLookupByLibrary.simpleMessage(
      "No upcoming events with a location",
    ),
    "mapOpenSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "moveMapHint": MessageLookupByLibrary.simpleMessage(
      "Move the map to place the pin",
    ),
    "myEvents": MessageLookupByLibrary.simpleMessage("Events"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Paid"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Saved"),
    "myLocationUnavailable": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t get your location",
    ),
    "myTickets": MessageLookupByLibrary.simpleMessage("My Tickets"),
    "name": MessageLookupByLibrary.simpleMessage("User Name"),
    "navCreate": MessageLookupByLibrary.simpleMessage("Create"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navMap": MessageLookupByLibrary.simpleMessage("Map"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Tickets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "noAttendeesMatch": m13,
    "noCapacityLimit": MessageLookupByLibrary.simpleMessage(
      "No capacity limit",
    ),
    "noEventsInLocation": MessageLookupByLibrary.simpleMessage(
      "No upcoming events in this location",
    ),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage(
      "You haven\'t created any events yet",
    ),
    "noPastTickets": MessageLookupByLibrary.simpleMessage("No past tickets"),
    "noPlacesFound": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t find that place",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "No events match your search",
    ),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage(
      "No upcoming tickets",
    ),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "notificationsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Push notifications and alerts",
    ),
    "openEvent": MessageLookupByLibrary.simpleMessage("Open event"),
    "orEnterCode": MessageLookupByLibrary.simpleMessage("Or enter the code"),
    "ownEvent": MessageLookupByLibrary.simpleMessage("Your event"),
    "parkeaAndShare": MessageLookupByLibrary.simpleMessage("Parkea & Share"),
    "parkeaAppName": MessageLookupByLibrary.simpleMessage("Parkea!"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordEntirelyNumeric": MessageLookupByLibrary.simpleMessage(
      "Password can\'t be entirely numeric",
    ),
    "passwordResetDone": MessageLookupByLibrary.simpleMessage(
      "Password updated. Please log in.",
    ),
    "passwordTooCommon": MessageLookupByLibrary.simpleMessage(
      "This password is too common",
    ),
    "passwordTooShort": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 8 characters",
    ),
    "passwordTooSimilar": MessageLookupByLibrary.simpleMessage(
      "Password is too similar to your username or email",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "paymentsComingSoon": MessageLookupByLibrary.simpleMessage(
      "Payment coming soon",
    ),
    "pickOnMap": MessageLookupByLibrary.simpleMessage("Pick on map"),
    "popularEvents": MessageLookupByLibrary.simpleMessage("Popular events"),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "pressBackToExit": MessageLookupByLibrary.simpleMessage(
      "Press back again to exit",
    ),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "Price must be greater than 0",
    ),
    "privacySubtitle": MessageLookupByLibrary.simpleMessage(
      "Privacy policy and data usage",
    ),
    "privateEvent": MessageLookupByLibrary.simpleMessage("Private event"),
    "profileBio": MessageLookupByLibrary.simpleMessage("Bio"),
    "profileBioHint": MessageLookupByLibrary.simpleMessage(
      "Tell people who you are or what you organize",
    ),
    "profileUnavailable": MessageLookupByLibrary.simpleMessage(
      "Profile unavailable",
    ),
    "profileUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t update the profile",
    ),
    "profileUpdated": MessageLookupByLibrary.simpleMessage("Profile updated"),
    "profileWebsite": MessageLookupByLibrary.simpleMessage("Website"),
    "promotions": MessageLookupByLibrary.simpleMessage("Promotions"),
    "province": MessageLookupByLibrary.simpleMessage("Province"),
    "publishEvent": MessageLookupByLibrary.simpleMessage("Publish event"),
    "register": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "removeImage": MessageLookupByLibrary.simpleMessage("Remove image"),
    "removeLocation": MessageLookupByLibrary.simpleMessage("Remove location"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "If the email is registered, we sent you a link to reset your password",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save changes"),
    "saveEvent": MessageLookupByLibrary.simpleMessage("Save event"),
    "scanQrHint": MessageLookupByLibrary.simpleMessage(
      "Scan the QR code the organizer shared with you",
    ),
    "searchAttendees": MessageLookupByLibrary.simpleMessage(
      "Search by name or username",
    ),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Search activities"),
    "searchPlace": MessageLookupByLibrary.simpleMessage(
      "Search address or place",
    ),
    "seeEvent": MessageLookupByLibrary.simpleMessage("Show event"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "showQr": MessageLookupByLibrary.simpleMessage("Show QR code"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "similarEvents": MessageLookupByLibrary.simpleMessage("Similar events"),
    "slideCreateText": MessageLookupByLibrary.simpleMessage(
      "Publish your plan and reach more people.",
    ),
    "slideCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Create your events",
    ),
    "slideDiscoverText": MessageLookupByLibrary.simpleMessage(
      "Concerts, workshops and plans near you to share with your friends.",
    ),
    "slideDiscoverTitle": MessageLookupByLibrary.simpleMessage(
      "Discover events",
    ),
    "slideEnrollText": MessageLookupByLibrary.simpleMessage(
      "Your tickets stay on your phone, always at hand.",
    ),
    "slideEnrollTitle": MessageLookupByLibrary.simpleMessage(
      "Enroll in one tap",
    ),
    "soldOut": MessageLookupByLibrary.simpleMessage("Sold out"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "spotsLeft": m14,
    "stepOfTotal": m15,
    "supportLegal": MessageLookupByLibrary.simpleMessage("Support & legal"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Enrollment cancelled",
    ),
    "ticketNumber": m16,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load tickets",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Past"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "tooManyAttempts": MessageLookupByLibrary.simpleMessage(
      "Too many attempts, wait a minute",
    ),
    "upcomingTicketsCount": m17,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Username or email",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Enter your username or email",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("View event"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("View my ticket"),
    "volunteeringFreeNote": MessageLookupByLibrary.simpleMessage(
      "Volunteering is free and anyone can sign up.",
    ),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage("¡Welcome back!"),
    "welcomeNext": MessageLookupByLibrary.simpleMessage("Next"),
    "welcomeSignIn": MessageLookupByLibrary.simpleMessage(
      "I already have an account",
    ),
    "welcomeSignUp": MessageLookupByLibrary.simpleMessage("Create account"),
    "welcomeSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "yourProfile": MessageLookupByLibrary.simpleMessage("Your profile"),
  };
}
