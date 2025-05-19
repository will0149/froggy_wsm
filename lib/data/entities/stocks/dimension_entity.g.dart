// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dimension_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DimensionEntity _$DimensionEntityFromJson(Map<String, dynamic> json) =>
    DimensionEntity(
      height: (json['height'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      long: (json['long'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DimensionEntityToJson(DimensionEntity instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'long': instance.long,
    };
