// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_base_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientBaseEntity _$ClientBaseEntityFromJson(Map<String, dynamic> json) =>
    ClientBaseEntity(
      body: (json['body'] as List<dynamic>?)
          ?.map((e) => CustomerEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] == null
          ? null
          : StatusEntity.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClientBaseEntityToJson(ClientBaseEntity instance) =>
    <String, dynamic>{
      'body': instance.body?.map((e) => e.toJson()).toList(),
      'status': instance.status?.toJson(),
    };
