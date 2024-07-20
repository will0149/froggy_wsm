

import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/18/24
 */

part 'series_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SeriesDto {
  @JsonKey(name: 'series')
  List<String>? series;

  SeriesDto({this.series});

  factory SeriesDto.fromJson(Map<String, dynamic> json) => _$SeriesDtoFromJson(json);

  Map<String, dynamic> toJson()  => _$SeriesDtoToJson(this);
}