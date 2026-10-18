// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventImageDTO _$EventImageDTOFromJson(Map<String, dynamic> json) =>
    EventImageDTO(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      position: (json['position'] as num).toInt(),
    );

Map<String, dynamic> _$EventImageDTOToJson(EventImageDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'position': instance.position,
    };
