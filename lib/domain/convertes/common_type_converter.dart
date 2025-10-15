import 'package:froggy_soft/data/entities/commons/common_type.dart';
import 'package:froggy_soft/device/utils/logger_config.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 05/18/25
 */

class CommonTypeConverter
    implements JsonConverter<CommonType, Map<String, dynamic>> {
  const CommonTypeConverter();

  @override
  CommonType fromJson(Map<String, dynamic> json) {
    // if (kDebugMode) logger.i("*****************");
    // if (kDebugMode) logger.w(json);
    int id = 0;
    String name = "", description = "";
    if (json['id'] != null) {
      id = json['id'];
    }
    if (json['name'] != null) {
      name = json['name'];
    }
    if (json['description'] != null) {
      description = json['description'];
    }
    return CommonType(id: id, name: name, description: description);
  }

  @override
  Map<String, dynamic> toJson(CommonType object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = object.id;
    data['name'] = object.name;
    data['description'] = object.description;
    return data;
  }
}
