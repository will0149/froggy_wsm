import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dtos/attendee_dto.dart';
import '../../generated/l10n.dart';
import 'auth/api_error_message.dart';
import 'paged_fetch.dart';
import 'repositories.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

part 'event_attendance_uc.g.dart';

/// Inscritos en el evento [eventId]. Para eventos sin límite de cupo; con
/// cupo se calcula con `capacity - available_spots`.
@riverpod
Future<int> eventTicketCountUC(Ref ref, int eventId) async {
  final result = await ref.read(ticketRepositoryProvider).countByEvent(eventId);
  final body = result['body'];
  if (result['status'] != 200 ||
      body is! Map<String, dynamic> ||
      body['ticket_count'] is! int) {
    throw ApiException.from(result, S.current.errLoadEvent);
  }
  return body['ticket_count'] as int;
}

/// Inscritos en el evento [eventId] del organizador, el más reciente
/// primero. Se filtra también aquí por si el API devuelve tickets de otros
/// eventos o cancelados.
@riverpod
Future<List<AttendeeDTO>> eventAttendeesUC(Ref ref, int eventId) async {
  final repository = ref.read(ticketRepositoryProvider);
  final attendees = await fetchAllPages(
    (page) => repository.fetchEventAttendeesPage(eventId, page),
    AttendeeDTO.fromJson,
    errorMessage: S.current.errLoadAttendees,
  );
  return [
    for (final attendee in attendees)
      if (attendee.isActive && (attendee.eventId ?? eventId) == eventId)
        attendee,
  ]..sort((a, b) => (b.enrolledAt ?? DateTime(0))
      .compareTo(a.enrolledAt ?? DateTime(0)));
}
