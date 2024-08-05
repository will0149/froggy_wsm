import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/clients/client_base_entity.dart';
import '../../logics/clients/customer_logic.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/16/24
 */
part 'customer_provider.g.dart';

@riverpod
Future<ClientBaseEntity> getCustomers(GetCustomersRef ref) async {
  return ref.read(customerLogicProvider).getClients();
}