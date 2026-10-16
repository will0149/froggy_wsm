import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/events_repository.dart';
import '../../data/repositories/promotions_repository.dart';
import '../../data/repositories/ticket_repository.dart';
import '../../device/utils/user_location.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

part 'repositories.g.dart';

/// Repositorios que usan los use cases; en los tests se reemplazan con
/// `overrideWithValue`.
@Riverpod(keepAlive: true)
EventRepository eventRepository(Ref ref) => EventRepository();

@Riverpod(keepAlive: true)
TicketRepository ticketRepository(Ref ref) => TicketRepository();

@Riverpod(keepAlive: true)
PromotionsRepository promotionsRepository(Ref ref) => PromotionsRepository();

@Riverpod(keepAlive: true)
UserLocationService userLocationService(Ref ref) =>
    const UserLocationService();
