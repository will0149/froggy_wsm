import 'package:froggy_soft/device/utils/logger_config.dart';
import 'package:froggy_soft/domain/dtos/series_dto.dart';
import 'package:froggy_soft/domain/dtos/series_series_dto.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 05/18/25
 */

class ListSeriesConverter implements JsonConverter<SeriesSeriesDto, Map<String, dynamic>>{
  const ListSeriesConverter();

  @override
  SeriesSeriesDto fromJson(Map<String, dynamic> json) {
    // if (kDebugMode) logger.i("*****************");
    // if (kDebugMode) logger.w(json);
    List<String> series = [];
    json['series'].map((i) {
      series.add(i);
    }).toList();
    return SeriesSeriesDto(series: SeriesDto(series: series));
  }

  @override
  Map<String, dynamic> toJson(SeriesSeriesDto object) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['series'] = object;
    return data;
  }
}