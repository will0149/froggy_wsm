import 'package:intl/intl.dart';

import '../../data/dtos/event_dto.dart';
import '../../generated/l10n.dart';
import 'event_format.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

/// Enlace que abre el detalle del evento en la app (lo recibe el redirect
/// del router).
String eventShareLink(Object id) => 'parkea://events/$id';

/// Texto para compartir: nombre, fecha, lugar, precio y el enlace. El
/// código de un evento privado no se incluye: lo reparte el organizador.
String eventShareText(EventDTO event, S s, String locale) {
  final date = switch (DateTime.tryParse(event.date ?? '')) {
    final date? => DateFormat.MMMEd(locale).add_jm().format(date.toLocal()),
    _ => null,
  };
  final place = [event.location?.place, event.city]
      .whereType<String>()
      .where((part) => part.isNotEmpty)
      .join(', ');
  return [
    event.eventName ?? '',
    if (date != null) '📅 $date',
    if (place.isNotEmpty) '📍 $place',
    '🎟️ ${event.costLabel(s, locale)}',
    '',
    s.shareEventLink(eventShareLink(event.id ?? '')),
  ].join('\n');
}
