import 'package:json_annotation/json_annotation.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 18/02/26
part 'promotion_dto.g.dart';

/// Promoción vigente del carrusel del home (`GET promotions/`).
@JsonSerializable(explicitToJson: true)
class PromotionDTO {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;

  /// URL absoluta, 2:1 (1200×600).
  @JsonKey(name: 'image')
  final String? image;

  /// Evento enlazado (para `event/details/?id=`), o null.
  @JsonKey(name: 'event')
  final int? eventId;
  @JsonKey(name: 'starts_at')
  final String? startsAt;

  /// null = sin fecha de fin.
  @JsonKey(name: 'ends_at')
  final String? endsAt;

  PromotionDTO({
    required this.id,
    this.title,
    this.description,
    this.image,
    this.eventId,
    this.startsAt,
    this.endsAt,
  });

  factory PromotionDTO.fromJson(Map<String, dynamic> json) =>
      _$PromotionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionDTOToJson(this);
}
