// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusEntity _$StatusEntityFromJson(Map<String, dynamic> json) => StatusEntity(
      code: (json['code'] as num?)?.toInt(),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$StatusEntityToJson(StatusEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
    };
