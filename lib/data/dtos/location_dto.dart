

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/01/22

class LocationDTO {
  final String? latitud;
  final String? longitud;
  final String city;
  final String place;

  LocationDTO(
      {this.latitud, this.longitud, required this.city, required this.place});

  factory LocationDTO.fromJson(Map<String, dynamic> json) => LocationDTO(
      latitud: json["latitud"],
      longitud: json["longitud"],
      city: json["city"],
      place: json["place"]);

  Map<String, dynamic> toJson() =>
      {"latitud": latitud, "longitud": longitud, "city": city, "place": place};
}
