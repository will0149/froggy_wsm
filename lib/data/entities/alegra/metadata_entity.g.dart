// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataEntity _$MetadataEntityFromJson(Map<String, dynamic> json) =>
    MetadataEntity(
      total: const IntConverter().fromJson(json['total']),
    );

Map<String, dynamic> _$MetadataEntityToJson(MetadataEntity instance) =>
    <String, dynamic>{
      'total': _$JsonConverterToJson<dynamic, int>(
          instance.total, const IntConverter().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
