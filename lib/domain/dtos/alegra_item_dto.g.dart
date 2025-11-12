// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alegra_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlegraItemDto _$AlegraItemDtoFromJson(Map<String, dynamic> json) =>
    AlegraItemDto(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      reference: json['reference'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      qtyDifference: (json['qty_difference'] as num?)?.toInt(),
      lastCompare: json['last_compare'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$AlegraItemDtoToJson(AlegraItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reference': instance.reference,
      'quantity': instance.quantity,
      'qty_difference': instance.qtyDifference,
      'last_compare': instance.lastCompare,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
