import 'package:cct_management/domain/dtos/series_dto.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 08/13/24
 */

part 'series_series_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class SeriesSeriesDto{
  @JsonKey(name: 'series')
  SeriesDto? series;

  SeriesSeriesDto({this.series});

  factory SeriesSeriesDto.fromJson(Map<String, dynamic> json) => _$SeriesSeriesDtoFromJson(json);

  Map<String, dynamic> toJson()  => _$SeriesSeriesDtoToJson(this);
}