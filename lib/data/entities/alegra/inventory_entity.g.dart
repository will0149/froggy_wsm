// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryEntity _$InventoryEntityFromJson(Map<String, dynamic> json) =>
    InventoryEntity(
      availableQuantity: (json['availableQuantity'] as num?)?.toInt(),
      initialQuantityDate: json['initialQuantityDate'] as String?,
    );

Map<String, dynamic> _$InventoryEntityToJson(InventoryEntity instance) =>
    <String, dynamic>{
      'availableQuantity': instance.availableQuantity,
      'initialQuantityDate': instance.initialQuantityDate,
    };
