// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stocks_by_series_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StocksBySeriesRequest _$StocksBySeriesRequestFromJson(
        Map<String, dynamic> json) =>
    StocksBySeriesRequest(
      series: json['series'] == null
          ? null
          : SeriesDto.fromJson(json['series'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StocksBySeriesRequestToJson(
        StocksBySeriesRequest instance) =>
    <String, dynamic>{
      'series': instance.series?.toJson(),
    };
