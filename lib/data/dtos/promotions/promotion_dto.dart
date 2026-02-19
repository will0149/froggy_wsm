import 'package:json_annotation/json_annotation.dart';

import '../event_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 18/02/26
part 'promotion_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class PromotionDTO {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'event_id')
  final String? eventId;
  @JsonKey(name: 'event_name')
  final String? eventName;
  @JsonKey(name: 'banner_img')
  final String? bannerImg;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'short_description')
  final String? shortDescription;
  @JsonKey(name: 'discount_type')
  final String? discountType;
  @JsonKey(name: 'discount_value')
  final String? discountValue;
  @JsonKey(name: 'original_price')
  final String? originalPrice;
  @JsonKey(name: 'final_price')
  final String? finalPrice;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'start_date')
  final String? startDate;
  @JsonKey(name: 'end_date')
  final String? endDate;
  @JsonKey(name: 'max_uses')
  final int? maxUses;
  @JsonKey(name: 'current_uses')
  final int? currentUses;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'terms_conditions')
  final String? termsConditions;
  @JsonKey(name: 'event')
  final EventDTO? event;

  PromotionDTO({
    required this.id,
    this.eventId,
    this.eventName,
    this.bannerImg,
    required this.code,
    required this.name,
    this.description,
    this.shortDescription,
    required this.discountType,
    required this.discountValue,
    this.originalPrice,
    this.finalPrice,
    this.currency,
    this.startDate,
    this.endDate,
    this.maxUses,
    this.currentUses,
    this.isActive,
    this.termsConditions,
    this.event,
  });

  factory PromotionDTO.fromJson(Map<String, dynamic> json) =>
      _$PromotionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionDTOToJson(this);
}
