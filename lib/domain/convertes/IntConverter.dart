import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 05/24/25
 */

class IntConverter implements JsonConverter<int, String>  {
  const IntConverter();

  @override
  int fromJson(String json) {
    if (json == null) return 0;
    return int.parse(json);
  }

  @override
  String toJson(int object) {
    return object.toString();
  }

}