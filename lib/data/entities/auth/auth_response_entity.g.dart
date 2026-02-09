// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseEntity _$AuthResponseEntityFromJson(Map<String, dynamic> json) =>
    AuthResponseEntity(
      token: json['token'] as String?,
    )..refreshToken = json['refresh_token'] as String?;

Map<String, dynamic> _$AuthResponseEntityToJson(AuthResponseEntity instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refresh_token': instance.refreshToken,
    };
