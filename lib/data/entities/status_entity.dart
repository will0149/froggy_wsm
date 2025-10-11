

import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 06/12/24
 */

part 'status_entity.g.dart';

@JsonSerializable()
class StatusEntity {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'msg')
  String? msg;

  StatusEntity({this.code, this.msg});


  factory StatusEntity.fromJson(Map<String, dynamic> json) => _$StatusEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StatusEntityToJson(this);
}
