// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseEntity _$AuthResponseEntityFromJson(Map<String, dynamic> json) =>
    AuthResponseEntity(
      accessToken: json['accessToken'] as String?,
      id: (json['id'] as num?)?.toInt(),
      fullName: json['full_name'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AuthResponseEntityToJson(AuthResponseEntity instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'id': instance.id,
      'full_name': instance.fullName,
      'roles': instance.roles,
      'permissions': instance.permissions,
    };
