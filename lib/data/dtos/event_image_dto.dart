import 'package:json_annotation/json_annotation.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

part 'event_image_dto.g.dart';

/// Imagen de la galería de un evento; la de `position` 0 es la portada.
@JsonSerializable()
class EventImageDTO {
  final int id;
  final String url;
  final int position;

  const EventImageDTO(
      {required this.id, required this.url, required this.position});

  factory EventImageDTO.fromJson(Map<String, dynamic> json) =>
      _$EventImageDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventImageDTOToJson(this);
}
