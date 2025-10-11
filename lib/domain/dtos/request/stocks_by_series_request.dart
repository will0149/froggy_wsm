import 'package:json_annotation/json_annotation.dart';

import '../series_dto.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 05/16/25
 */

part 'stocks_by_series_request.g.dart';

@JsonSerializable(explicitToJson: true)
class StocksBySeriesRequest {
  @JsonKey(name: 'series')
  SeriesDto? series;

  StocksBySeriesRequest({this.series});

  factory StocksBySeriesRequest.fromJson(Map<String, dynamic> json) => _$StocksBySeriesRequestFromJson(json);

  Map<String, dynamic> toJson()  => _$StocksBySeriesRequestToJson(this);
}