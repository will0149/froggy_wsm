import 'package:cct_management/data/entities/clients/customer_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/base_data_entity.dart';
import '../../../data/entities/base_response_entity.dart';
import '../../logics/clients/customer_logic.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/16/24
 */
part 'customer_provider.g.dart';

@riverpod
Future<BaseResponseEntity<BaseDataEntity<List<CustomerEntity>?>>> getCustomers(GetCustomersRef ref) async {
  return ref.read(customerLogicProvider).getClients();
}