// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionDTO _$PromotionDTOFromJson(Map<String, dynamic> json) => PromotionDTO(
      id: json['id'] as String?,
      eventId: json['event_id'] as String?,
      eventName: json['event_name'] as String?,
      bannerImg: json['banner_img'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      shortDescription: json['short_description'] as String?,
      discountType: json['discount_type'] as String?,
      discountValue: json['discount_value'] as String?,
      originalPrice: json['original_price'] as String?,
      finalPrice: json['final_price'] as String?,
      currency: json['currency'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      maxUses: (json['max_uses'] as num?)?.toInt(),
      currentUses: (json['current_uses'] as num?)?.toInt(),
      isActive: json['is_active'] as bool?,
      termsConditions: json['terms_conditions'] as String?,
      event: json['event'] == null
          ? null
          : EventDTO.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionDTOToJson(PromotionDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'event_name': instance.eventName,
      'banner_img': instance.bannerImg,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'short_description': instance.shortDescription,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'original_price': instance.originalPrice,
      'final_price': instance.finalPrice,
      'currency': instance.currency,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'max_uses': instance.maxUses,
      'current_uses': instance.currentUses,
      'is_active': instance.isActive,
      'terms_conditions': instance.termsConditions,
      'event': instance.event?.toJson(),
    };
