import 'dart:convert';

import 'package:flutter/services.dart';

import '../constants.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/01/22
 */

class EventRepository {

  Future<Map<String, dynamic>> fetchEventsList() async {
    final String response = await rootBundle.loadString(eventsPath);
    final data = await json.decode(response);
    return data;
  }

}