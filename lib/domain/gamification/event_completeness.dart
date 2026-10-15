/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26
library;

/// Partes opcionales que hacen que un evento destaque en el feed, en el
/// orden en que se sugieren. Nombre y fecha no cuentan: son obligatorios.
enum EventDetail { banner, shortDescription, description, place, category }

/// Qué tan completo está un evento que se crea o edita.
class EventCompleteness {
  final Set<EventDetail> missing;

  const EventCompleteness(this.missing);

  factory EventCompleteness.of({
    required bool hasBanner,
    required String shortDescription,
    required String description,
    required String place,
    required String? category,
  }) =>
      EventCompleteness({
        if (!hasBanner) EventDetail.banner,
        if (shortDescription.trim().isEmpty) EventDetail.shortDescription,
        if (description.trim().isEmpty) EventDetail.description,
        if (place.trim().isEmpty) EventDetail.place,
        if (category == null) EventDetail.category,
      });

  /// Entre 0 y 1.
  double get value => 1 - missing.length / EventDetail.values.length;

  int get percent => (value * 100).round();

  bool get isComplete => missing.isEmpty;

  /// Lo siguiente que conviene completar; null si ya está completo.
  EventDetail? get next =>
      EventDetail.values.where(missing.contains).firstOrNull;
}
