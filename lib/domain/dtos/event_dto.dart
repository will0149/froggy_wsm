import 'amount_dto.dart';
import 'location_dto.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/01/22
 */

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
        eventName: json["eventName"],
        shortDescription: json["shortDescription"],
        description: json["description"],
        date: json["date"],
        eventType: json["eventType"],
        eventOwner: json["eventOwner"],
        amount: AmountDTO.fromJson(json["amount"]),
        bannerImageUrl: json["bannerImageUrl"],
        privacyType: json["privacyType"],
        location: LocationDTO.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventName": eventName,
        "shortDescription": shortDescription,
        "description": description,
        "date": date,
        "eventType": eventType,
        "eventOwner": eventOwner,
        "amount": amount,
        "bannerImageUrl": bannerImageUrl,
        "privacyType": privacyType,
        "location": location
      };
}
