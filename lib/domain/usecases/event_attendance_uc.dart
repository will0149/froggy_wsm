import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../generated/l10n.dart';
import 'auth/api_error_message.dart';
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
