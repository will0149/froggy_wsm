import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 05/18/25*/

part 'common_type.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class CommonType{
  int? id;
  String? name;
  String? description;

  CommonType(
  {this.id,
  this.name,
  this.description});

  factory CommonType.fromJson(Map<String, dynamic> json)  => _$CommonTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CommonTypeToJson(this);

}