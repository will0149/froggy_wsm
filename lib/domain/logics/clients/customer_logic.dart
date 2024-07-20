import 'dart:convert';

import 'package:cct_management/data/entities/base_response_entity.dart';
import 'package:cct_management/data/entities/clients/customer_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/entities/base_data_entity.dart';
import '../../../data/repositories/clients/client_repository.dart';
import '../../../device/utils/logger_config.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/16/24
 */

class CustomerLogic extends ChangeNotifier {
  late final ClientRepository repository;
  bool isLoading = false;

  CustomerLogic() {
    repository = ClientRepository();
  }
  Future<BaseResponseEntity<BaseDataEntity<List<CustomerEntity>?>>>
      getClients() async {
    var result = BaseResponseEntity<BaseDataEntity<List<CustomerEntity>?>>();
    try {
      var serviceResponse = await repository.getCustomers();
      logger.i("$serviceResponse");
      List<CustomerEntity> clients = [];
      if("${serviceResponse['status']['code']}" == "200"){
        clients = (serviceResponse['body'] as List)
        .map((i) => CustomerEntity.fromJson(i))
        .toList();

        logger.i("clients ${clients.length}");
      }
      BaseResponseEntity<BaseDataEntity<List<CustomerEntity>?>>.fromJson(
        serviceResponse,
        (json) => BaseDataEntity<List<CustomerEntity>>.fromJson(
            json as Map<String, dynamic>,
            clients as List<CustomerEntity> Function(Object? clients)
        ));
      notifyListeners();
    } on Exception catch (e) {
      logger.e(e.toString());
      return result;
    }
    return result;
  }
}

final customerLogicProvider = Provider<CustomerLogic>((ref) => CustomerLogic(),);