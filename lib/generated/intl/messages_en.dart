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

  static String m0(date) => "Enrolled on ${date}";

  static String m1(count) => "${count} spots left";

  static String m2(id) => "Ticket #${id}";

  static String m3(count) => "${count} upcoming tickets";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutEvent": MessageLookupByLibrary.simpleMessage("About the event"),
    "accessCode": MessageLookupByLibrary.simpleMessage("Access code"),
    "accessCodeHint": MessageLookupByLibrary.simpleMessage(
      "This event is private. Enter the code the organizer gave you.",
    ),
    "accessCodeOwnerHint": MessageLookupByLibrary.simpleMessage(
      "Share it with your guests so they can enroll.",
    ),
    "accessCodeRequired": MessageLookupByLibrary.simpleMessage(
      "Enter the code",
    ),
    "addBanner": MessageLookupByLibrary.simpleMessage("Add image"),
    "authenticate": MessageLookupByLibrary.simpleMessage("Authenticate"),
    "avatarUpdated": MessageLookupByLibrary.simpleMessage("Photo updated"),
    "avatarUploadFailed": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t update the photo",
    ),
    "bannerUploadFailed": MessageLookupByLibrary.simpleMessage(
      "The event was created, but the image couldn\'t be uploaded",
    ),
    "buyTicket": MessageLookupByLibrary.simpleMessage("Get ticket"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelTicket": MessageLookupByLibrary.simpleMessage("Cancel enrollment"),
    "cancelTicketConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to cancel your enrollment?",
    ),
    "capacityHint": MessageLookupByLibrary.simpleMessage("Empty = no limit"),
    "catAdventure": MessageLookupByLibrary.simpleMessage("Adventure"),
    "catCamping": MessageLookupByLibrary.simpleMessage("Camping"),
    "catMusic": MessageLookupByLibrary.simpleMessage("Music"),
    "catWorkshops": MessageLookupByLibrary.simpleMessage("Workshops"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryNone": MessageLookupByLibrary.simpleMessage("No category"),
    "changeBanner": MessageLookupByLibrary.simpleMessage("Change image"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change password"),
    "changePhoto": MessageLookupByLibrary.simpleMessage("Change photo"),
    "codeCopied": MessageLookupByLibrary.simpleMessage("Code copied"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm password"),
    "costFree": MessageLookupByLibrary.simpleMessage("Free"),
    "costInvitation": MessageLookupByLibrary.simpleMessage("By invitation"),
    "costPaid": MessageLookupByLibrary.simpleMessage("Paid"),
    "costPrivate": MessageLookupByLibrary.simpleMessage("Private"),
    "costType": MessageLookupByLibrary.simpleMessage("Access type"),
    "couldNotOpenMaps": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t open the maps app",
    ),
    "createEvent": MessageLookupByLibrary.simpleMessage("Create event"),
    "dataAndPrivacy": MessageLookupByLibrary.simpleMessage("Data & Privacy"),
    "dateMustBeFuture": MessageLookupByLibrary.simpleMessage(
      "The date must be in the future",
    ),
    "deleteEvent": MessageLookupByLibrary.simpleMessage("Delete event"),
    "deleteEventConfirm": MessageLookupByLibrary.simpleMessage(
      "All enrollments will be deleted too. This can\'t be undone.",
    ),
    "devStudio": MessageLookupByLibrary.simpleMessage("Atheneox Studios"),
    "downloadTicket": MessageLookupByLibrary.simpleMessage("Download ticket"),
    "editEvent": MessageLookupByLibrary.simpleMessage("Edit event"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "enroll": MessageLookupByLibrary.simpleMessage("Enroll"),
    "enrolledOn": m0,
    "enrolledSuccess": MessageLookupByLibrary.simpleMessage(
      "Done! You\'re enrolled",
    ),
    "eventCapacity": MessageLookupByLibrary.simpleMessage("Capacity"),
    "eventCategory": MessageLookupByLibrary.simpleMessage("Category"),
    "eventCreated": MessageLookupByLibrary.simpleMessage("Event created"),
    "eventCurrency": MessageLookupByLibrary.simpleMessage("Currency"),
    "eventDateTime": MessageLookupByLibrary.simpleMessage("Date and time"),
    "eventDeleted": MessageLookupByLibrary.simpleMessage("Event deleted"),
    "eventDescription": MessageLookupByLibrary.simpleMessage("Description"),
    "eventFinished": MessageLookupByLibrary.simpleMessage("Event ended"),
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
    "forgotPassword": MessageLookupByLibrary.simpleMessage(
      "I forgot my password",
    ),
    "getDirections": MessageLookupByLibrary.simpleMessage("Get directions"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Help"),
    "haveResetLink": MessageLookupByLibrary.simpleMessage(
      "I already have a link",
    ),
    "hostedBy": MessageLookupByLibrary.simpleMessage("Hosted by"),
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
    "invitationOnly": MessageLookupByLibrary.simpleMessage("Invitation only"),
    "joinOurUniverse": MessageLookupByLibrary.simpleMessage(
      "Join our universe",
    ),
    "keepTicket": MessageLookupByLibrary.simpleMessage("Keep"),
    "login": MessageLookupByLibrary.simpleMessage("Sign In"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "myEvents": MessageLookupByLibrary.simpleMessage("Events"),
    "myEventsEnrolled": MessageLookupByLibrary.simpleMessage("Enrolled"),
    "myEventsPaid": MessageLookupByLibrary.simpleMessage("Paid"),
    "myEventsSaved": MessageLookupByLibrary.simpleMessage("Saved"),
    "myTickets": MessageLookupByLibrary.simpleMessage("My Tickets"),
    "name": MessageLookupByLibrary.simpleMessage("User Name"),
    "navHome": MessageLookupByLibrary.simpleMessage("Home"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "navTickets": MessageLookupByLibrary.simpleMessage("Tickets"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New password"),
    "noEnrolledEvents": MessageLookupByLibrary.simpleMessage(
      "You aren\'t enrolled in any event",
    ),
    "noOwnEvents": MessageLookupByLibrary.simpleMessage(
      "You haven\'t created any events yet",
    ),
    "noPastTickets": MessageLookupByLibrary.simpleMessage("No past tickets"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "No events match your search",
    ),
    "noUpcomingTickets": MessageLookupByLibrary.simpleMessage(
      "No upcoming tickets",
    ),
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
    "popularEvents": MessageLookupByLibrary.simpleMessage("Popular events"),
    "pricePositive": MessageLookupByLibrary.simpleMessage(
      "Price must be greater than 0",
    ),
    "province": MessageLookupByLibrary.simpleMessage("Province"),
    "publishEvent": MessageLookupByLibrary.simpleMessage("Publish event"),
    "register": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "resetEmailSent": MessageLookupByLibrary.simpleMessage(
      "If the email is registered, we sent you a link to reset your password",
    ),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save changes"),
    "saveEvent": MessageLookupByLibrary.simpleMessage("Save event"),
    "searchEvents": MessageLookupByLibrary.simpleMessage("Search activities"),
    "seeEvent": MessageLookupByLibrary.simpleMessage("Show event"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "similarEvents": MessageLookupByLibrary.simpleMessage("Similar events"),
    "soldOut": MessageLookupByLibrary.simpleMessage("Sold out"),
    "spotsLeft": m1,
    "ticketCancelled": MessageLookupByLibrary.simpleMessage(
      "Enrollment cancelled",
    ),
    "ticketNumber": m2,
    "ticketsLoadError": MessageLookupByLibrary.simpleMessage(
      "Couldn\'t load tickets",
    ),
    "ticketsPast": MessageLookupByLibrary.simpleMessage("Past"),
    "ticketsUpcoming": MessageLookupByLibrary.simpleMessage("Upcoming"),
    "upcomingTicketsCount": m3,
    "usernameOrEmail": MessageLookupByLibrary.simpleMessage(
      "Username or email",
    ),
    "usernameOrEmailRequired": MessageLookupByLibrary.simpleMessage(
      "Enter your username or email",
    ),
    "viewEvent": MessageLookupByLibrary.simpleMessage("View event"),
    "viewMyTicket": MessageLookupByLibrary.simpleMessage("View my ticket"),
    "welcomeAgain": MessageLookupByLibrary.simpleMessage("¡Welcome back!"),
  };
}
