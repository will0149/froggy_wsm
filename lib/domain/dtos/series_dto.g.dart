// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeriesDto _$SeriesDtoFromJson(Map<String, dynamic> json) => SeriesDto(
      series:
          (json['series'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SeriesDtoToJson(SeriesDto instance) => <String, dynamic>{
      'series': instance.series,
    };
