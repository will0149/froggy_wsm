import 'package:intl/intl.dart';

import '../../data/dtos/event_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

extension EventFormat on EventDTO {
  /// El API manda el precio como "45.0000" y sin moneda (se asume USD).
  String formattedPrice(String locale) => NumberFormat.simpleCurrency(
        locale: locale,
        name: amount?.currency ?? 'USD',
      ).format(double.tryParse(amount?.price ?? '') ?? 0);
}
