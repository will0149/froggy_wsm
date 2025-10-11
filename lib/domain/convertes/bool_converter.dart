import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 07/23/25
 */

class BoolConverter implements JsonConverter<bool, dynamic>  {
  const BoolConverter();

  @override
  bool fromJson(dynamic json) {
    if (json == null) return false;
    if(json is String){
      return int.parse(json) == 0 ? false : true;
    }
    if(json is bool) {
      return json;
    }
    return bool.parse(json);
  }

  @override
  dynamic toJson(bool object) {
    return object.toString();
  }

}