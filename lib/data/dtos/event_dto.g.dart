// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventDTO _$EventDTOFromJson(Map<String, dynamic> json) => EventDTO(
      id: EventDTO._idFromJson(json['id']),
      eventName: json['name'] as String?,
      shortDescription: json['short_description'] as String?,
      description: json['description'] as String?,
      date: json['event_date'] as String?,
      eventType: json['cost_type'] as String?,
      eventOwner: json['owner'] as String?,
      amount: EventDTO._readAmount(json, 'amount') == null
          ? null
          : AmountDTO.fromJson(
              EventDTO._readAmount(json, 'amount') as Map<String, dynamic>),
      bannerImageUrl: json['banner_img'] as String?,
      images: EventDTO._imagesFromJson(json['images'] as List?),
      privacyType: json['privacy_type'] as String?,
      location: EventDTO._readLocation(json, 'location') == null
          ? null
          : LocationDTO.fromJson(
              EventDTO._readLocation(json, 'location') as Map<String, dynamic>),
      category: json['category'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      latitude: EventDTO._coordinateFromJson(json['latitude']),
      longitude: EventDTO._coordinateFromJson(json['longitude']),
      capacity: (json['capacity'] as num?)?.toInt(),
      availableSpots: (json['available_spots'] as num?)?.toInt(),
      isOwner: json['is_owner'] as bool?,
      otp: json['otp'] as String?,
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
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'privacy_type': instance.privacyType,
      'location': instance.location?.toJson(),
      'category': instance.category,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'capacity': instance.capacity,
      'available_spots': instance.availableSpots,
      'is_owner': instance.isOwner,
      'otp': instance.otp,
    };
