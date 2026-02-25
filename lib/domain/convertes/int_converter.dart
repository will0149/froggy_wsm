import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 05/24/25
 */

class IntConverter implements JsonConverter<int, dynamic>  {
  const IntConverter();

  @override
  int fromJson(dynamic json) {
    if (json == null) return 0;
    if(json is int) {
      return json;
    }
    return int.parse(json);
  }

  @override
  dynamic toJson(int object) {
    return object.toString();
  }

}