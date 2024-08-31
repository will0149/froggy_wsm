// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_series_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesSeriesDto _$SeriesSeriesDtoFromJson(Map<String, dynamic> json) =>
    SeriesSeriesDto(
      series: json['series'] == null
          ? null
          : SeriesDto.fromJson(json['series'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeriesSeriesDtoToJson(SeriesSeriesDto instance) =>
    <String, dynamic>{
      'series': instance.series?.toJson(),
    };
