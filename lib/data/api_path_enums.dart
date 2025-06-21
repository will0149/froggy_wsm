import 'package:flutter/material.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/14/25
 **/

enum ApiPathsEnums {
  v1(path: '/'),
  registerUser(path: '/register/'),
  signIn(path: '/login/'),
  logout(path: '/logout/'),
  refreshToken(path: '/token/refresh/'),
  tokenVerify(path: '/token/verify/'),
  profile(path: '/profile/'),
  profileImage(path: '/profile/image/'),
  profileUpdate(path: '/profile/update/'),
  eventDetails(path: '/event/details/'),
  events(path: '/events/all');

  const ApiPathsEnums({required this.path});

  final String path;
}