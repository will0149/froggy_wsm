// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientEntity _$ClientEntityFromJson(Map<String, dynamic> json) => ClientEntity(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      barcode: json['barcode'] as String?,
      deleted: json['deleted'] as bool?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ClientEntityToJson(ClientEntity instance) =>
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
