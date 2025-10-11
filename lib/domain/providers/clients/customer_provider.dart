import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/base_response_entity.dart';
import '../../../data/entities/clients/client_base_entity.dart';
import '../../../data/entities/clients/customer_entity.dart';
import '../../logics/clients/customer_logic.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 06/16/24
 */
part 'customer_provider.g.dart';

@riverpod
Future<BaseResponseEntity<List<CustomerEntity>>> getCustomers(Ref ref) async {
  return ref.read(customerLogicProvider).getClients();
}