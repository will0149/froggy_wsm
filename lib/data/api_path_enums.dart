import 'package:flutter/material.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25
///

enum ApiPathsEnums {
  v1(path: '/'),
  registerUser(path: '/user/register/'),
  signIn(path: '/user/login/'),
  logout(path: '/user/logout/'),
  refreshToken(path: '/user/token/refresh/'),
  tokenVerify(path: '/user/token/verify/'),
  profile(path: '/user/profile/'),
  profileImage(path: '/user/profile/image/'),
  profileUpdate(path: '/user/profile/update/'),
  eventDetails(path: '/event/details/'),
  events(path: '/events/all');

  const ApiPathsEnums({required this.path});

  final String path;
}