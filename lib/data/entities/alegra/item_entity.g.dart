// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemEntity _$ItemEntityFromJson(Map<String, dynamic> json) => ItemEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      reference: json['reference'] as String?,
      inventory: json['inventory'] == null
          ? null
          : InventoryEntity.fromJson(json['inventory'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemEntityToJson(ItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reference': instance.reference,
      'inventory': instance.inventory?.toJson(),
    };
