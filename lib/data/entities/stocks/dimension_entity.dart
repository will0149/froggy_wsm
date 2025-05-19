import 'package:json_annotation/json_annotation.dart';
/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 05/18/25
 */

part 'dimension_entity.g.dart';

@JsonSerializable()
class DimensionEntity {
  @JsonKey(name: 'height')
  int? height;
  @JsonKey(name: 'width')
  int? width;
  @JsonKey(name: 'long')
  int? long;

  DimensionEntity({this.height, this.width, this.long});

  factory DimensionEntity.fromJson(Map<String, dynamic> json) => _$DimensionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionEntityToJson(this);
}