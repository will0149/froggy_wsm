import 'package:parkea/data/dtos/user_ticket_dto.dart';
import 'package:parkea/data/repositories/ticket_repository.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_tickets_uc.g.dart';

@riverpod
class FetchUpcomingTicketsUC extends _$FetchUpcomingTicketsUC {
  late final TicketRepository repository = TicketRepository();

  @override
  Future<List<UserTicketDTO>> build() async {
    final result = await repository.fetchUpcomingTickets();
    final List<dynamic> body = result['body'];
    logger.i('Upcoming tickets: $body');
    return body.map((e) => UserTicketDTO.fromJson(e)).toList();
  }
}

@riverpod
class FetchPastTicketsUC extends _$FetchPastTicketsUC {
  late final TicketRepository repository = TicketRepository();

  @override
  Future<List<UserTicketDTO>> build() async {
    final result = await repository.fetchPastTickets();
    final List<dynamic> body = result['body'];
    logger.i('Past tickets: $body');
    return body.map((e) => UserTicketDTO.fromJson(e)).toList();
  }
}
