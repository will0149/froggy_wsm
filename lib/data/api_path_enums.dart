import 'package:flutter/material.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25
///

enum ApiPathsEnums {
  v1(path: 'http://0.0.0.0:8000/v1/'),
  //user authentication and enrollment
  registerUser(path: '/user/register/'),
  signIn(path: '/user/login/'),
  logout(path: '/user/logout/'),
  passwordReset(path: '/user/password/reset/'),
  passwordResetConfirm(path: '/user/password/reset/confirm'),
  refreshToken(path: '/user/token/refresh/'),
  tokenVerify(path: '/user/token/verify/'),
  //profile
  profile(path: '/user/profile/'),
  profileImage(path: '/user/profile/image/'),
  profileUpdate(path: '/user/profile/update/'),
  //path de eventos
  events(path: '/events/all'),
  eventCreate(path: '/events/create/'),
  eventOwner(path: '/events/owner/'),
  eventUpdateImage(path: '/events/update/image/{id}/'),
  eventDetails(path: '/events/details/'),
  eventUpdate(path: '/events/update/'),
  // tickets
  ticketEnroll(path: '/ticket/enroll/'),
  ticketEventOwner(path: '/ticket/event/owner/'),
  ticketsByUser(path: '/ticket/user/all/'),
  ticketCountByEvent(path: '/tickets/count/{event_id}/');

  const ApiPathsEnums({required this.path});

  final String path;

}