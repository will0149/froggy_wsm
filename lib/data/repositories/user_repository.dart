import 'dart:convert';

import 'package:flutter/services.dart';

import '../constants.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/03/22
 */

class UserRepository {

  Future<Map<String, dynamic>> fetchUsersList() async {
    final String response = await rootBundle.loadString(usersPath);
    final data = await json.decode(response);
    return data;
  }
}