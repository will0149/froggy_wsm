// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseEntity<T> _$BaseResponseEntityFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => BaseResponseEntity<T>(
  body: _$nullableGenericFromJson(json['body'], fromJsonT),
  status: json['status'] == null
      ? null
      : StatusEntity.fromJson(json['status'] as Map<String, dynamic>),
  insertedCount: (json['insertedCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$BaseResponseEntityToJson<T>(
  BaseResponseEntity<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'body': _$nullableGenericToJson(instance.body, toJsonT),
  'status': instance.status?.toJson(),
  'insertedCount': instance.insertedCount,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
