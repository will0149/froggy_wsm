import 'package:json_annotation/json_annotation.dart';

import 'amount_dto.dart';
import 'location_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/01/22
part 'event_dto.g.dart';

/// Acepta el formato del API (`id` int, `cost_type` int, `price`, `place`) y
/// el de los mocks (`amount`, `location`), que aún usan otras pantallas.
@JsonSerializable(explicitToJson: true)
class EventDTO {
  /// Valores de `cost_type` en el API, en orden.
  static const costTypes = ['FREE', 'PAYED', 'INVITATION', 'PRIVATE'];

  @JsonKey(name: 'id', fromJson: _idFromJson)
  final String? id;
  @JsonKey(name: 'name')
  final String? eventName;
  @JsonKey(name: 'short_description')
  final String? shortDescription;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'event_date')
  final String? date;
  /// FREE, PAYED, INVITATION o PRIVATE.
  @JsonKey(name: 'cost_type', fromJson: _costTypeFromJson)
  final String? eventType;
  @JsonKey(name: 'owner')
  final String? eventOwner;
  @JsonKey(name: 'amount', readValue: _readAmount)
  final AmountDTO? amount;
  @JsonKey(name: 'banner_img')
  final String? bannerImageUrl;
  @JsonKey(name: 'privacy_type')
  final String? privacyType;
  @JsonKey(name: 'location', readValue: _readLocation)
  final LocationDTO? location;

  /// 0 MUSIC, 1 CAMPING, 2 ADVENTURE, 3 WORKSHOPS; null en eventos antiguos.
  @JsonKey(name: 'category')
  final int? category;

  /// null = sin límite de cupo.
  @JsonKey(name: 'capacity')
  final int? capacity;
  @JsonKey(name: 'available_spots')
  final int? availableSpots;

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
      required this.location,
      this.category,
      this.capacity,
      this.availableSpots});

  factory EventDTO.fromJson(Map<String, dynamic> json)  => _$EventDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventDTOToJson(this);

  static String? _idFromJson(Object? value) => value?.toString();

  static String? _costTypeFromJson(Object? value) => switch (value) {
        int index when index >= 0 && index < costTypes.length =>
          costTypes[index],
        null => null,
        _ => value.toString(),
      };

  /// El API manda `price` ("45.0000") sin moneda.
  static Object? _readAmount(Map json, String key) =>
      json[key] ??
      (json['price'] == null
          ? null
          : {'price': json['price'], 'currency': 'USD'});

  /// El API manda `place` como texto libre, sin coordenadas.
  static Object? _readLocation(Map json, String key) =>
      json[key] ??
      (json['place'] == null ? null : {'place': json['place']});
}
