import 'package:json_annotation/json_annotation.dart';

import 'amount_dto.dart';
import 'location_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/01/22
part 'event_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class EventDTO {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? eventName;
  @JsonKey(name: 'short_description')
  final String? shortDescription;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'event_date')
  final String? date;
  @JsonKey(name: 'cost_type')
  final String? eventType;
  @JsonKey(name: 'owner')
  final String? eventOwner;
  @JsonKey(name: 'amount')
  final AmountDTO? amount;
  @JsonKey(name: 'banner_img')
  final String? bannerImageUrl;
  @JsonKey(name: 'privacy_type')
  final String? privacyType;
  @JsonKey(name: 'location')
  final LocationDTO? location;

  EventDTO(
      {required this.id,
      required this.eventName,
      this.shortDescription,
      required this.description,
      required this.date,
      required this.eventType,
      required this.eventOwner,
      required this.amount,
      this.bannerImageUrl,
      required this.privacyType,
      required this.location});

  factory EventDTO.fromJson(Map<String, dynamic> json)  => _$EventDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventDTOToJson(this);
}
