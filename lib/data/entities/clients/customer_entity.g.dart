// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerEntity _$CustomerEntityFromJson(Map<String, dynamic> json) =>
    CustomerEntity(
      name: json['name'] as String?,
      description: json['description'] as String?,
      barcode: json['barcode'] as String?,
      deleted: json['deleted'] as bool?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$CustomerEntityToJson(CustomerEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'barcode': instance.barcode,
      'deleted': instance.deleted,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
