// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDTO _$EventDTOFromJson(Map<String, dynamic> json) => EventDTO(
      id: json['id'] as String?,
      eventName: json['name'] as String?,
      shortDescription: json['short_description'] as String?,
      description: json['description'] as String?,
      date: json['event_date'] as String?,
      eventType: json['cost_type'] as String?,
      eventOwner: json['owner'] as String?,
      amount: json['amount'] == null
          ? null
          : AmountDTO.fromJson(json['amount'] as Map<String, dynamic>),
      bannerImageUrl: json['banner_img'] as String?,
      privacyType: json['privacy_type'] as String?,
      location: json['location'] == null
          ? null
          : LocationDTO.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventDTOToJson(EventDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.eventName,
      'short_description': instance.shortDescription,
      'description': instance.description,
      'event_date': instance.date,
      'cost_type': instance.eventType,
      'owner': instance.eventOwner,
      'amount': instance.amount?.toJson(),
      'banner_img': instance.bannerImageUrl,
      'privacy_type': instance.privacyType,
      'location': instance.location?.toJson(),
    };
