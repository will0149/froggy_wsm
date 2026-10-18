import 'package:json_annotation/json_annotation.dart';

import 'amount_dto.dart';
import 'event_image_dto.dart';
import 'location_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/01/22
part 'event_dto.g.dart';

/// Acepta el formato del API (`id` int, `price`, `currency`, `place`) y el
/// de los mocks (`amount`, `location`), que aún usan otras pantallas.
@JsonSerializable(explicitToJson: true)
class EventDTO {
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
  /// FREE, PAID, INVITATION o PRIVATE.
  @JsonKey(name: 'cost_type')
  final String? eventType;
  @JsonKey(name: 'owner')
  final String? eventOwner;
  @JsonKey(name: 'amount', readValue: _readAmount)
  final AmountDTO? amount;
  @JsonKey(name: 'banner_img')
  final String? bannerImageUrl;

  /// Galería del evento (hasta 5), en orden; la primera es la portada.
  @JsonKey(name: 'images', fromJson: _imagesFromJson)
  final List<EventImageDTO>? images;
  @JsonKey(name: 'privacy_type')
  final String? privacyType;
  @JsonKey(name: 'location', readValue: _readLocation)
  final LocationDTO? location;

  /// Valor de `EventCategory`; null si no tiene.
  @JsonKey(name: 'category')
  final String? category;

  /// Dirección, ciudad y país (ISO 3166-1 alfa-2); pueden venir vacíos.
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'country')
  final String? country;

  /// El API las manda como strings decimales; vienen las dos o ninguna.
  @JsonKey(name: 'latitude', fromJson: _coordinateFromJson)
  final double? latitude;
  @JsonKey(name: 'longitude', fromJson: _coordinateFromJson)
  final double? longitude;

  /// null = sin límite de cupo.
  @JsonKey(name: 'capacity')
  final int? capacity;
  @JsonKey(name: 'available_spots')
  final int? availableSpots;

  /// Si el usuario es el organizador; null en respuestas que no lo incluyen.
  @JsonKey(name: 'is_owner')
  final bool? isOwner;

  /// Si el usuario lo guardó; null en respuestas que no lo incluyen.
  @JsonKey(name: 'is_saved')
  final bool? isSaved;

  /// Código de acceso de un evento PRIVATE; solo llega al organizador
  /// (`events/owner/`, `events/update/`).
  @JsonKey(name: 'otp')
  final String? otp;

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
      this.images,
      required this.privacyType,
      required this.location,
      this.category,
      this.address,
      this.city,
      this.country,
      this.latitude,
      this.longitude,
      this.capacity,
      this.availableSpots,
      this.isOwner,
      this.isSaved,
      this.otp});

  factory EventDTO.fromJson(Map<String, dynamic> json)  => _$EventDTOFromJson(json);

  Map<String, dynamic> toJson() => _$EventDTOToJson(this);

  static String? _idFromJson(Object? value) => value?.toString();

  static double? _coordinateFromJson(Object? value) => switch (value) {
        num number => number.toDouble(),
        String text => double.tryParse(text),
        _ => null,
      };

  /// Ordenadas por `position`, sin las que no traen URL.
  static List<EventImageDTO>? _imagesFromJson(List<dynamic>? value) => value
      ?.whereType<Map<String, dynamic>>()
      .map(EventImageDTO.fromJson)
      .where((image) => image.url.isNotEmpty)
      .toList()
    ?..sort((a, b) => a.position.compareTo(b.position));

  /// Imágenes para el detalle; sin galería, el banner si lo tiene.
  List<String> get galleryUrls => switch ((images, bannerImageUrl)) {
        (final images?, _) when images.isNotEmpty => [
            for (final image in images) image.url
          ],
        (_, final banner?) when banner.isNotEmpty => [banner],
        _ => const [],
      };

  bool get hasCoordinates => latitude != null && longitude != null;

  /// Usa `is_owner` del API y, si no llega, compara el organizador con
  /// [username].
  bool isOwnedBy(String? username) =>
      isOwner ?? (username != null && eventOwner == username);

  /// El API manda `price` ("45.0000") y `currency` (ISO 4217) por separado.
  static Object? _readAmount(Map json, String key) =>
      json[key] ??
      (json['price'] == null
          ? null
          : {'price': json['price'], 'currency': json['currency'] ?? 'USD'});

  /// El API manda `place` como texto libre, sin coordenadas.
  static Object? _readLocation(Map json, String key) =>
      json[key] ??
      (json['place'] == null ? null : {'place': json['place']});
}
