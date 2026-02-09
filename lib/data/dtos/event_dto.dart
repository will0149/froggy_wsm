import 'amount_dto.dart';
import 'location_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/01/22

class EventDTO {
  final int id;
  final String eventName;
  final String? shortDescription;
  final String description;
  final String date;
  final String eventType;
  final String eventOwner;
  final AmountDTO amount;

  final String? bannerImageUrl;
  final String privacyType;
  final LocationDTO location;

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

  factory EventDTO.fromJson(Map<String, dynamic> json) => EventDTO(
        id: json["id"],
        eventName: json["name"],
        shortDescription: json["short_description"],
        description: json["description"],
        date: json["event_date"],
        eventType: json["cost_type"],
        eventOwner: json["owner"],
        amount: AmountDTO.fromJson(json["amount"]),
        bannerImageUrl: json["banner_img"],
        privacyType: json["privacyType"],
        location: LocationDTO.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": eventName,
        "short_description": shortDescription,
        "description": description,
        "event_date": date,
        "cost_type": eventType,
        "owner": eventOwner,
        "amount": amount,
        "banner_img": bannerImageUrl,
        "privacyType": privacyType,
        "location": location
      };
}
