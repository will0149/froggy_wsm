// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dimension_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DimensionEntity _$DimensionEntityFromJson(Map<String, dynamic> json) =>
    DimensionEntity(
      height: _$JsonConverterFromJson<String, int>(
          json['height'], const IntConverter().fromJson),
      width: _$JsonConverterFromJson<String, int>(
          json['width'], const IntConverter().fromJson),
      long: _$JsonConverterFromJson<String, int>(
          json['long'], const IntConverter().fromJson),
    );

Map<String, dynamic> _$DimensionEntityToJson(DimensionEntity instance) =>
    <String, dynamic>{
      'height': _$JsonConverterToJson<String, int>(
          instance.height, const IntConverter().toJson),
      'width': _$JsonConverterToJson<String, int>(
          instance.width, const IntConverter().toJson),
      'long': _$JsonConverterToJson<String, int>(
          instance.long, const IntConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
