import 'package:json_annotation/json_annotation.dart';

import '../api_path_enums.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/17/26
part 'attendee_dto.g.dart';

/// Inscrito en un evento del organizador: un ticket de
/// `ticket/event/owner/` visto desde su `customer`.
@JsonSerializable(createToJson: false)
class AttendeeDTO {
  @JsonKey(name: 'id')
  final int ticketId;
  @JsonKey(name: 'event', readValue: _readEventId)
  final int? eventId;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'date_purchased')
  final String? datePurchased;
  @JsonKey(name: 'username', readValue: _readCustomer)
  final String username;
  @JsonKey(name: 'first_name', readValue: _readCustomer)
  final String? firstName;
  @JsonKey(name: 'last_name', readValue: _readCustomer)
  final String? lastName;
  @JsonKey(
      name: 'avatar',
      readValue: _readCustomer,
      fromJson: ApiPathsEnums.absoluteUrl)
  final String? avatarUrl;

  AttendeeDTO({
    required this.ticketId,
    required this.username,
    this.eventId,
    this.status,
    this.datePurchased,
    this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  /// Nombre y apellido; el username si no tiene nombre.
  String get displayName {
    final name = '${firstName ?? ''} ${lastName ?? ''}'.trim();
    return name.isEmpty ? username : name;
  }

  String get initial => displayName.isEmpty
      ? '?'
      : String.fromCharCode(displayName.runes.first).toUpperCase();

  /// Los tickets cancelados se borran, pero el API manda el estado igual.
  bool get isActive => status == null || status == 'ACTIVE';

  DateTime? get enrolledAt => DateTime.tryParse(datePurchased ?? '');

  /// `event` llega como objeto completo o solo como id.
  static Object? _readEventId(Map json, String key) => switch (json[key]) {
        {'id': final int id} => id,
        final int id => id,
        _ => null,
      };

  static Object? _readCustomer(Map json, String key) =>
      (json['customer'] as Map?)?[key];

  factory AttendeeDTO.fromJson(Map<String, dynamic> json) =>
      _$AttendeeDTOFromJson(json);
}
