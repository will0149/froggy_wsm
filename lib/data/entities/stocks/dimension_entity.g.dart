// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dimension_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DimensionEntity _$DimensionEntityFromJson(Map<String, dynamic> json) =>
    DimensionEntity(
      height: const IntConverter().fromJson(json['height']),
      width: const IntConverter().fromJson(json['width']),
      long: const IntConverter().fromJson(json['long']),
    );

Map<String, dynamic> _$DimensionEntityToJson(DimensionEntity instance) =>
    <String, dynamic>{
      'height': _$JsonConverterToJson<dynamic, int>(
          instance.height, const IntConverter().toJson),
      'width': _$JsonConverterToJson<dynamic, int>(
          instance.width, const IntConverter().toJson),
      'long': _$JsonConverterToJson<dynamic, int>(
          instance.long, const IntConverter().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
