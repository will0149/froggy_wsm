import 'package:froggy_soft/domain/convertes/int_converter.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 05/18/25
 */

part 'dimension_entity.g.dart';

@JsonSerializable()
class DimensionEntity {
  @IntConverter()
  @JsonKey(name: 'height')
  int? height;
  @IntConverter()
  @JsonKey(name: 'width')
  int? width;
  @IntConverter()
  @JsonKey(name: 'long')
  int? long;

  DimensionEntity({this.height, this.width, this.long});

  factory DimensionEntity.fromJson(Map<String, dynamic> json) => _$DimensionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionEntityToJson(this);
}