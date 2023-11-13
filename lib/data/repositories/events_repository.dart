import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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

  Future<Map<String, dynamic>> fetchSearchResult(String searchText) async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    final jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  }
}
