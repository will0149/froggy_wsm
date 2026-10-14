import 'package:json_annotation/json_annotation.dart';

import 'event_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26
part 'ticket_dto.g.dart';

/// Inscripción del usuario a un evento (`ticket/user/all/`). Hay como máximo
/// una por evento; al cancelarla se borra.
@JsonSerializable(explicitToJson: true)
class TicketDTO {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'event')
  final EventDTO event;
  @JsonKey(name: 'date_purchased')
  final String? datePurchased;

  TicketDTO({required this.id, required this.event, this.datePurchased});

  /// Fecha del evento en hora local.
  DateTime? get eventDate => DateTime.tryParse(event.date ?? '')?.toLocal();

  bool get isUpcoming => eventDate?.isAfter(DateTime.now()) ?? false;

  factory TicketDTO.fromJson(Map<String, dynamic> json) =>
      _$TicketDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TicketDTOToJson(this);
}
