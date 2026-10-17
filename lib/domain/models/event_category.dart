// Made for parkea.
// By User: josedominguez
// Date: 10/16/26

/// Categorías de evento del API (`category`).
enum EventCategory {
  music('MUSIC'),
  camping('CAMPING'),
  adventure('ADVENTURE'),
  workshops('WORKSHOPS'),

  /// Siembra de árboles, ayuda social…: siempre gratis y abierto a todos;
  /// el API rechaza otro `cost_type`.
  volunteering('VOLUNTEERING');

  final String apiValue;

  const EventCategory(this.apiValue);

  /// Solo admite `cost_type` FREE.
  bool get freeOnly => this == volunteering;

  /// null si [value] es null o una categoría que la app no conoce.
  static EventCategory? fromApi(String? value) {
    for (final category in values) {
      if (category.apiValue == value) return category;
    }
    return null;
  }
}
