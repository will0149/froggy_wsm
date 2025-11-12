// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsListResponseEntity _$ItemsListResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ItemsListResponseEntity(
      metadata: json['metadata'] == null
          ? null
          : MetadataEntity.fromJson(json['metadata'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemsListResponseEntityToJson(
        ItemsListResponseEntity instance) =>
    <String, dynamic>{
      'metadata': instance.metadata?.toJson(),
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };
