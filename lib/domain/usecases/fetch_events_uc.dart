import 'package:parkea/data/repositories/events_repository.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth/api_error_message.dart';
import '../../generated/l10n.dart';
import 'private_event_access_uc.dart';
import 'repositories.dart';

part 'fetch_events_uc.g.dart';

@riverpod
class FetchEventDetailUC extends _$FetchEventDetailUC {
  EventRepository get repository => ref.read(eventRepositoryProvider);

  @override
  Future<EventDTO> build(int id) async {
    // Un evento PRIVATE solo se ve con su código, salvo para el
    // organizador y los inscritos.
    final code = ref.read(privateEventAccessUCProvider)[id];
    final result = await repository.eventDetails(id.toString(), code: code);
    final body = result['body'];
    if (result['status'] != 200 || body is! Map<String, dynamic>) {
      throw ApiException.from(result, S.current.errLoadEvent);
    }
    return EventDTO.fromJson(body);
  }
}
