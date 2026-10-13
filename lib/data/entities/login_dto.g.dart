// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDTO _$LoginDTOFromJson(Map<String, dynamic> json) => LoginDTO(
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginDTOToJson(LoginDTO instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
