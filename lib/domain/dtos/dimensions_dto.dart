

import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 06/19/24
 */

part 'dimensions_dto.g.dart';

@JsonSerializable()
class DimensionsDto {
  @JsonKey(name: 'height')
  String? height;
  @JsonKey(name: 'width')
  String? width;
  @JsonKey(name: 'long')
  String? long;

  DimensionsDto({this.height, this.width, this.long});

  factory DimensionsDto.fromJson(Map<String, dynamic> json) => _$DimensionsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsDtoToJson(this);
}