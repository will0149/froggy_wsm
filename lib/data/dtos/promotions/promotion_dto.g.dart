// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionDTO _$PromotionDTOFromJson(Map<String, dynamic> json) => PromotionDTO(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      eventId: (json['event'] as num?)?.toInt(),
      startsAt: json['starts_at'] as String?,
      endsAt: json['ends_at'] as String?,
    );

Map<String, dynamic> _$PromotionDTOToJson(PromotionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'event': instance.eventId,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
    };
