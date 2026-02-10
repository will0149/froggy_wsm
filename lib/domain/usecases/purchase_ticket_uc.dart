import 'package:parkea/data/dtos/ticket_purchase_dto.dart';
import 'package:parkea/data/repositories/events_repository.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'purchase_ticket_uc.g.dart';

@riverpod
class PurchaseTicketUC extends _$PurchaseTicketUC {
  late final EventRepository repository;

  @override
  Future<Map<String, dynamic>?> build() async {
    repository = EventRepository();
    return null;
  }

  Future<void> submitPurchase(TicketPurchaseDTO request) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await repository.purchaseTicket(request);
      logger.i("Purchase response: $result");
      return result;
    });
  }
}
